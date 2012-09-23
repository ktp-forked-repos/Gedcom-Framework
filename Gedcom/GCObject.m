
//
//  GCObject.m
//  Gedcom
//
//  Created by Mikkel Eide Eriksen on 27/03/12.
//  Copyright (c) 2012 Mikkel Eide Eriksen. All rights reserved.
//

#import "GCObject.h"

#import "GCNode.h"

#import "GCContext.h"

#import "GCEntity.h"
#import "GCProperty.h"
#import "GCAttribute.h"
#import "GCRelationship.h"

#import "GCObject_internal.h"
#import "GCContext_internal.h"

#import "ValidationHelpers.h"

@implementation GCObject {
    NSMutableDictionary *_propertyStore;
}

static const NSString *GCColorPreferenceKey = @"GCColorPreferenceKey";

#pragma mark Initialization

__strong static NSMutableDictionary *_validPropertiesByType;
__strong static NSDictionary *_defaultColors;

+ (void)initialize
{
    _validPropertiesByType = [NSMutableDictionary dictionary];
    
    _defaultColors = @{
        GCLevelAttributeName : [NSColor redColor],
        GCXrefAttributeName : [NSColor blueColor],
        GCTagAttributeName : [NSColor darkGrayColor]
    };
}

- (id)init
{
    NSLog(@"You must use -initWithType: to initialize!");
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (id)initWithType:(NSString *)type
{
    if ([self class] == [GCObject class] || [self class] == [GCEntity class] || [self class] == [GCProperty class] || [self class] == [GCAttribute class] || [self class] == [GCRelationship class]) {
        Class objectClass = [GCTag tagNamed:type].objectClass;
        
        NSParameterAssert(objectClass);
        
        return [[objectClass alloc] initWithType:type];
    }
    
    self = [super init];
    
    if (self) {
        _gedTag = [GCTag tagNamed:type];
        _propertyStore = [NSMutableDictionary dictionary];
    }
    
    return self;    
}

#pragma mark GCProperty access

- (NSOrderedSet *)validPropertyTypes
{
    @synchronized(_validPropertiesByType) {
        NSOrderedSet *_validProperties = _validPropertiesByType[self.type];
        
        if (!_validProperties) {
            NSMutableOrderedSet *valid = [NSMutableOrderedSet orderedSetWithCapacity:[_gedTag.validSubTags count]];
            
            for (GCTag *subTag in _gedTag.validSubTags) {
                if ([_gedTag allowedOccurrencesOfSubTag:subTag].max > 1) {
                    [valid addObject:subTag.pluralName];
                } else {
                    [valid addObject:subTag.name];
                }
            }
            
            _validProperties = [valid copy];
            
            _validPropertiesByType[self.type] = _validProperties;
        }
        
        return _validProperties;
    }
}

- (GCAllowedOccurrences)allowedOccurrencesPropertyType:(NSString *)type
{
    return [_gedTag allowedOccurrencesOfSubTag:[GCTag tagNamed:type]];
}

- (NSArray *)propertyTypesInGroup:(NSString *)groupName
{
    NSMutableArray *propertyTypes = [NSMutableArray array];
    
    for (GCTag *tag in [_gedTag subTagsInGroup:groupName]) {
        [propertyTypes addObject:tag.pluralName];
    }
    
    return [propertyTypes count] > 0 ? [propertyTypes copy] : nil;
}

#pragma mark NSKeyValueCoding overrides

- (void)_internalSetValue:(id)value forKey:(NSString *)key {
    NSString *type = [[GCTag tagNamed:key] name];
    
    if ([value isKindOfClass:[GCProperty class]]) {
        [self.allProperties addObject:value];
    } else if ([value isKindOfClass:[GCValue class]]) {
        [self addAttributeWithType:type value:value];
    } else if ([value isKindOfClass:[GCEntity class]]) {
        [self addRelationshipWithType:type target:value];
    } else {
		NSException *exception = [NSException exceptionWithName:@"GCInvalidKVCValueTypeException"
														 reason:[NSString stringWithFormat:@"Invalid value %@ for _internalSetValue:forKey:", value]
													   userInfo:nil];
		@throw exception;
    }
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([self.validPropertyTypes containsObject:key] || [GCTag tagNamed:key].isCustom) {
        if ([self allowedOccurrencesPropertyType:key].max > 1) {
            NSParameterAssert([value respondsToSelector:@selector(countByEnumeratingWithState:objects:count:)]);
            [self setNilValueForKey:key]; //clean first
            for (id item in value) {
                [self _internalSetValue:item forKey:key];
            }
        } else {
            [self _internalSetValue:value forKey:key];
        }
    } else {
        [super setValue:value forKey:key];
    }
}

- (void)setNilValueForKey:(NSString *)key
{
    if ([[self propertyTypesInGroup:key] count] > 0) {
        for (NSString *propertyType in [self propertyTypesInGroup:key]) {
            [self setNilValueForKey:propertyType];
        }
    } else if ([self.validPropertyTypes containsObject:key] || [GCTag tagNamed:key].isCustom) {
        @synchronized(_propertyStore) {
            [_propertyStore removeObjectForKey:key];
        }
    } else {
        [super setNilValueForKey:key];
    }
}

- (id)valueForKey:(NSString *)key
{
    if ([key hasSuffix:@"@primary"]) {
        NSString *cleanKey = [key componentsSeparatedByString:@"@"][0];
        
        if ([[self valueForKey:cleanKey] count] > 0) {
            return [self valueForKey:cleanKey][0];
        } else {
            return nil;
        }
    } else if ([[self propertyTypesInGroup:key] count] > 0) {
        NSMutableArray *values = [NSMutableArray array];
        
        for (NSString *propertyType in [self propertyTypesInGroup:key]) {
            [values addObjectsFromArray:[self valueForKey:propertyType]];
        }
        
        return values;
    } else if ([self.validPropertyTypes containsObject:key] || [GCTag tagNamed:key].isCustom) {
        @synchronized(_propertyStore) {
            return _propertyStore[key];
        }
    } else {
        return [super valueForKey:key];
    }
}

#pragma mark Subscript accessors

- (id)objectForKeyedSubscript:(id)key
{
    return [self valueForKey:key];
}

- (void)setObject:(id)object forKeyedSubscript:(id < NSCopying >)key
{
    return [self setValue:object forKey:(NSString *)key];
}

#pragma mark NSKeyValueObserving overrides

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key
{
    NSMutableSet *keyPaths = [[super keyPathsForValuesAffectingValueForKey:key] mutableCopy];
    
    [keyPaths addObject:@"gedcomString"];
    [keyPaths addObject:@"gedcomNode"];
    [keyPaths addObject:@"allProperties"];
    
    GCTag *tag = [GCTag tagsByName][key];
    
    if ([key isEqualToString:@"properties"]) {
        NSString *cleanName = [[self className] substringFromIndex:2];
        
        if ([cleanName hasSuffix:@"Entity"])
            cleanName = [cleanName substringToIndex:[cleanName length] - 6];
        if ([cleanName hasSuffix:@"Attribute"])
            cleanName = [cleanName substringToIndex:[cleanName length] - 9];
        if ([cleanName hasSuffix:@"Relationship"])
            cleanName = [cleanName substringToIndex:[cleanName length] - 12];
        
        //NSLog(@"cleanName: %@", cleanName);
        
        tag = [GCTag tagNamed:[NSString stringWithFormat:@"%@%@", [[cleanName substringToIndex:1] lowercaseString], [cleanName substringFromIndex:1]]];
    }
    
    if (tag != nil) {
        for (GCTag *subTag in tag.validSubTags) {
            [keyPaths addObject:subTag.name];
            /*
            GCTag *subSubTag = subTag;
            while ([[subSubTag validSubTags] count] > 0) {
                for (GCTag *subSubSubTag in [subSubTag validSubTags]) {
                    
                }
            }*/
        }
    }
    
    [keyPaths removeObject:key];
    
    //NSLog(@"keyPaths on %@: %@ => %@", [self className], key, keyPaths);
    
    return keyPaths;
}

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key
{
    if ([key isEqualToString:@"gedcomNode"] || [key isEqualToString:@"gedcomString"]) {
        return NO;
    } else {
        return [super automaticallyNotifiesObserversForKey:key];
    }
}

#pragma mark GCProperty collection accessors

- (void)setDescribedObjectForProperty:(GCProperty *)property
{
    if (property.describedObject) {
        [property.describedObject.allProperties removeObject:property];
    }
    
    [property setValue:self forKey:@"primitiveDescribedObject"];
}

- (NSUInteger)countOfProperties
{
    @synchronized(_propertyStore) {
        return [[_propertyStore allValues] count];
    }
}

- (NSEnumerator *)enumeratorOfProperties
{
    NSMutableSet *props = [NSMutableSet set];
    
    for (id prop in [_propertyStore allValues]) {
        if ([prop isKindOfClass:[NSArray class]]) {
            [props addObjectsFromArray:prop];
        } else {
            [props addObject:prop];
        }
    }
    
    //NSLog(@"props: %@", props);
    
    return [props objectEnumerator];
}

- (GCProperty *)memberOfProperties:(GCProperty *)property
{
    for (GCProperty *p in [self enumeratorOfProperties]) {
        if ([p isEqual:property]) {
            return p;
        }
    }
    
    return nil;
}

- (void)addPropertiesObject:(GCProperty *)property
{
    NSParameterAssert(property);
    NSParameterAssert([property isKindOfClass:[GCProperty class]]);
    //TODO handle plural names:
    //NSParameterAssert(property.gedTag.isCustom || [self.validPropertyTypes containsObject:property.type]);
    
    [self setDescribedObjectForProperty:property];
    
    //[self willChangeValueForKey:@"gedcomString"];
    
    @synchronized(_propertyStore) {
        if ([self allowedOccurrencesPropertyType:property.type].max > 1) {
            NSString *key = property.gedTag.pluralName;
            
            if (!_propertyStore[key]) {
                _propertyStore[key] = [NSMutableArray array];
            }
            
            [_propertyStore[key] addObject:property];
        } else {
            _propertyStore[property.type] = property;
        }
    }
    
    //[self didChangeValueForKey:@"gedcomString"];
}

- (void)removePropertiesObject:(GCProperty *)property
{
    NSParameterAssert(property);
    NSParameterAssert([property isKindOfClass:[GCProperty class]]);
    NSParameterAssert([property describedObject] == self);
    
    //[self willChangeValueForKey:@"gedcomString"];
    
    @synchronized(_propertyStore) {
        if ([self allowedOccurrencesPropertyType:property.type].max > 1) {
            NSString *key = property.gedTag.pluralName;
            
            if (!_propertyStore[key]) {
                _propertyStore[key] = [NSMutableArray array];
            }
            
            [_propertyStore[key] removeObject:property];
        } else {
            [_propertyStore removeObjectForKey:property.type];
        }
    }
    
    [property setValue:nil forKey:@"primitiveDescribedObject"];
    
    //[self didChangeValueForKey:@"gedcomString"];
}

/* //Optional. Implement if benchmarking indicates that performance is an issue.
 - (void)intersectProperties:(NSSet *)objects
 {
 
 }
 */

#pragma mark @selector trickery

- (BOOL)respondsToSelector:(SEL)aSelector
{
    NSLog(@"respondsToSelector: %@", NSStringFromSelector(aSelector));
    
    return [super respondsToSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
#ifdef DEBUGLEVEL
    NSLog(@"methodSignatureForSelector: %@", NSStringFromSelector(sel));
#endif
	NSString *stringSelector = NSStringFromSelector(sel);
	NSUInteger parameterCount = [[stringSelector componentsSeparatedByString:@":"] count]-1;
    
	// valueForKey:
	if (parameterCount == 0 && ([self.validPropertyTypes containsObject:stringSelector] || [[self propertyTypesInGroup:stringSelector] count] > 0)) {
		return [super methodSignatureForSelector:@selector(valueForKey:)];
    }
    
	// setValue:forKey:
	if (parameterCount == 1 && [stringSelector hasPrefix:@"set"]) {
		NSString *key = [NSString stringWithFormat:@"%@%@",
                  [[stringSelector substringWithRange:NSMakeRange(3, 1)] lowercaseString],
                  [stringSelector substringWithRange:NSMakeRange(4, [stringSelector length]-5)]];
        NSLog(@"key: %@", key);
        
        if ([self.validPropertyTypes containsObject:key] || [[self propertyTypesInGroup:key] count] > 0)
            return [super methodSignatureForSelector:@selector(setValue:forKey:)];
    }
    
	// Discard the call
	return nil;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
	NSString *stringSelector = NSStringFromSelector([invocation selector]);
	NSUInteger parameterCount = [[stringSelector componentsSeparatedByString:@":"] count]-1;
#ifdef DEBUGLEVEL
    NSLog(@"forwardInvocation: %@", invocation);
    NSLog(@"selector: %@", stringSelector);
#endif
    
	// valueForKey:
	if (parameterCount == 0) {
		id value = [self valueForKey:NSStringFromSelector([invocation selector])];
		[invocation setReturnValue:&value];
	}
	// setValue:forKey:
	if (parameterCount == 1) {
		id value;
		[invocation getArgument:&value atIndex:2];
        
		// Get key name by converting setMyValue: to myValue
		id key = [NSString stringWithFormat:@"%@%@",
                  [[stringSelector substringWithRange:NSMakeRange(3, 1)] lowercaseString],
                  [stringSelector substringWithRange:NSMakeRange(4, [stringSelector length]-5)]];
        NSLog(@"key: %@", key);
        
		[self setValue:value forKey:key];
	}
}

#pragma mark Gedcom access

- (NSArray *)orderedProperties
{
    NSMutableArray *orderedProperties = [NSMutableArray array];
    
    @synchronized(_propertyStore) {
        for (NSString *propertyType in self.validPropertyTypes) {
            if ([self allowedOccurrencesPropertyType:propertyType].max > 1) {
                [orderedProperties addObjectsFromArray:[_propertyStore valueForKey:propertyType]];
            } else {
                if ([_propertyStore valueForKey:propertyType]) {
                    [orderedProperties addObject:[_propertyStore valueForKey:propertyType]];
                }
            }
        }
        
        for (NSString *customType in [[_propertyStore allKeys] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",  self.validPropertyTypes]]) {
            [orderedProperties addObjectsFromArray:[_propertyStore valueForKey:customType]];
        }
    }
    
    
	return orderedProperties;
}

- (NSArray *)subNodes
{
    NSMutableArray *subNodes = [NSMutableArray array];
    
    for (GCProperty *property in self.orderedProperties) {
        [subNodes addObject:property.gedcomNode];
    }
    
	return subNodes;
}

#pragma mark Comparison

- (NSComparisonResult)compare:(id)other
{
    //subclasses override to get actual result.
    return NSOrderedSame;
}

#pragma mark Equality

- (BOOL)isEqualTo:(id)other
{
    return [self.gedcomString isEqualToString:[other gedcomString]];
}
/*
 - (BOOL)isEqual:(id)other
 {
 if (other == self) {
 return YES;
 }
 
 return [self.gedcomString isEqualToString:other.gedcomString];
 }
 
 - (NSUInteger)hash
 {
 return [self.gedcomString hash];
 }*/

#pragma mark NSCoding conformance

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [self initWithType:[aDecoder decodeObjectForKey:@"type"]];
    
    if (self) {
        @synchronized(_propertyStore) {
            _propertyStore = [aDecoder decodeObjectForKey:@"propertyStore"];
        }
	}
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.type forKey:@"type"];
    @synchronized(_propertyStore) {
        [aCoder encodeObject:_propertyStore forKey:@"propertyStore"];
    }
}

#pragma mark Description

//COV_NF_START
- (NSString *)description
{
    return [self descriptionWithIndent:0];
}

- (NSString *)descriptionWithIndent:(NSUInteger)level
{
    NSLog(@"You override this method in your subclass!");
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (NSString *)propertyDescriptionWithIndent:(NSUInteger)level
{
    NSMutableString *out = [NSMutableString string];
    for (GCObject *property in self.allProperties) {
        [out appendString:[property descriptionWithIndent:level+1]];
    }
    
    return out;
}
//COV_NF_END

#pragma mark Objective-C properties

- (NSString *)type
{
    return _gedTag.name;
}

- (NSString *)localizedType
{
    return _gedTag.localizedName;
}

- (BOOL)allowsProperties
{
    return ([self.validPropertyTypes count] > 0); //TODO (see cocoa-dev reply)
}

@dynamic rootObject;
@dynamic context;
@dynamic gedcomNode;
@dynamic displayValue;
@dynamic attributedDisplayValue;

- (void)setGedcomNode:(GCNode *)gedcomNode
{
    NSMutableSet *originalProperties = [self.allProperties mutableCopy];
    
    //NSLog(@"originalProperties: %@", originalProperties);
    
    for (GCNode *subNode in [gedcomNode subNodes]) {
        if ([subNode.gedTag isEqualToString:@"CHAN"]) {
            continue; //we ignore the CHAN node, it shouldn't be changed via setGedcomNode:
        }
        
        NSSet *matches = [originalProperties objectsWithOptions:(NSEnumerationConcurrent) passingTest:^BOOL(GCProperty *obj, BOOL *stop) {
            return [obj.gedTag.code isEqualToString:subNode.gedTag];
        }];
        
        if ([matches count] < 1) {
            //NSLog(@"adding new property for %@", subNode);
            [self addPropertyWithGedcomNode:subNode];
        } else {
            //TODO...
            GCProperty *property = [matches anyObject];
            [originalProperties removeObject:property];
            //NSLog(@"modifying property %@ with %@", property, subNode);
            property.gedcomNode = subNode;
        }
    }
    
    //NSLog(@"after adding to propertiesArray: %@", [self propertiesArray]);
    
    //NSLog(@"removing originalProperties: %@", originalProperties);
    
    //remove the left over objects:
    for (GCProperty *property in originalProperties) {
        [self.allProperties removeObject:property];
    }
    
    //NSLog(@"propertiesArray: %@", [self propertiesArray]);
}

- (NSString *)gedcomString
{
    return [self.gedcomNode gedcomString];
}

- (void)setGedcomString:(NSString *)gedcomString
{
    NSArray *nodes = [GCNode arrayOfNodesFromString:gedcomString];
    
    NSParameterAssert([nodes count] == 1);
    
    GCNode *node = [nodes lastObject];
    
    NSParameterAssert([self.gedTag.code isEqualToString:node.gedTag]);
    
    self.gedcomNode = node;
}

- (NSAttributedString *)attributedGedcomString
{
    NSMutableAttributedString *gedcomString = [self.gedcomNode.attributedGedcomString mutableCopy];
    
    NSDictionary *colors = _defaultColors; //[[NSUserDefaults standardUserDefaults] dictionaryForKey:(NSString *)GCColorPreferenceKey];
    
    [gedcomString enumerateAttributesInRange:NSMakeRange(0, [gedcomString length])
                                     options:(kNilOptions) 
                                  usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
                                      if (attrs[GCLevelAttributeName]) {
                                          [gedcomString addAttribute:NSForegroundColorAttributeName value:colors[GCLevelAttributeName] range:range];
                                      } else if (attrs[GCXrefAttributeName]) {
                                          [gedcomString addAttribute:NSForegroundColorAttributeName value:colors[GCXrefAttributeName] range:range];
                                      } else if (attrs[GCTagAttributeName]) {
                                          [gedcomString addAttribute:NSForegroundColorAttributeName value:colors[GCTagAttributeName] range:range];
                                      } else if (attrs[GCLinkAttributeName]) {
                                          NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@://%@/%@",
                                                                                      @"xref",
                                                                                      [self.context name],
                                                                                      attrs[GCLinkAttributeName]]];
                                          
                                          [gedcomString addAttribute:NSLinkAttributeName value:url range:range];
                                      } else if (attrs[GCValueAttributeName]) {
                                          //nothing
                                      }
                                  }];
    
    return gedcomString;
}

- (void)setAttributedGedcomString:(NSAttributedString *)attributedGedcomString
{
    self.gedcomString = [attributedGedcomString string];
}

@end

@implementation GCObject (GCConvenienceMethods)

- (void)addAttributeWithType:(NSString *)type value:(GCValue *)value
{
    [self.allProperties addObject:[GCAttribute attributeWithType:type value:value]];
}

- (void)addRelationshipWithType:(NSString *)type target:(GCEntity *)target
{
    GCRelationship *relationship = [GCRelationship relationshipWithType:type];
    
    [self.allProperties addObject:relationship];
    
    relationship.target = target;
}

- (void)addPropertyWithGedcomNode:(GCNode *)node
{
    GCTag *tag = [self.gedTag subTagWithCode:node.gedTag type:([node valueIsXref] ? @"relationship" : @"attribute")];
    
    if (tag.isCustom) {
        if (![self.context shouldHandleCustomTag:tag forNode:node onObject:self]) {
            return;
        }
    }
    
    if (!tag) {
        // for debugging; TODO remove when tags.json is complete.
        NSLog(@"self.gedTag: %@", self.gedTag);
        NSLog(@"node: %@", node);
        
    }
    
    [tag.objectClass propertyForObject:self withGedcomNode:node];
}

- (void)addPropertiesWithGedcomNodes:(NSArray *)nodes
{
    [nodes enumerateObjectsWithOptions:(NSEnumerationConcurrent) usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self addPropertyWithGedcomNode:obj];
    }];
}

- (NSMutableSet *)allProperties
{
    return [self mutableSetValueForKey:@"properties"];
}

@end

NSString *GCErrorDoman = @"GCErrorDoman";

@implementation GCObject (GCValidationMethods)

static inline BOOL validateValue(GCObject *obj, NSString *key, id value, Class type, NSError **error) {
    if (value == nil) {
        //TODO check if value is required
        return YES;
    } else if (![value isKindOfClass:type]) {
        if (NULL != error) {
            *error = [NSError errorWithDomain:GCErrorDoman
                                         code:GCIncorrectValueTypeError 
                                     userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Value %@ is incorrect type for key %@ (should be %@)", value, key, type], NSAffectedObjectsErrorKey: obj}];
        }
        return NO;
    } else {
        return YES;
    }
}

static inline BOOL validateTarget(GCObject *obj, NSString *key, GCEntity *target, Class type, NSError **error) {
    if (target == nil) {
        if (NULL != error) {
            *error = [NSError errorWithDomain:GCErrorDoman
                                         code:GCTargetMissingError
                                     userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Target is missing for key %@ (should be a %@)",  key, type], NSAffectedObjectsErrorKey: obj}];
        }
        return NO;
    } else if (![target isKindOfClass:type]) {
        if (NULL != error) {
            *error = [NSError errorWithDomain:GCErrorDoman
                                         code:GCIncorrectTargetTypeError 
                                     userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Target %@ is incorrect type for key %@ (should be %@)", target, key, type], NSAffectedObjectsErrorKey: obj}];
        }
        return NO;
    } else {
        return YES;
    }
}

static inline BOOL validateProperty(GCObject *obj, NSString *key, GCProperty *property, GCTag *tag, NSError **outError) {
    BOOL isValid = YES;
    NSError *returnError = nil;
    
    if (!property) {
        return isValid;
    }
    
    if ([tag objectClass] == [GCAttribute class]) {
        NSError *err = nil;
        
        isValid &= validateValue(obj, key, [(GCAttribute *)property value], tag.valueType, &err);
        
        if (err) {
            returnError = combineErrors(returnError, err);
        }
    } else if ([tag objectClass] == [GCRelationship class]) {
        NSError *err = nil;
        
        isValid &= validateTarget(obj, key, [(GCRelationship *)property target], tag.targetType, &err);
        
        if (err) {
            returnError = combineErrors(returnError, err);
        }
    }
    
    NSError *err = nil;
    
    isValid &= [property validateObject:&err];
    
    if (err) {
        returnError = combineErrors(returnError, err);
    }
    
    if (!isValid) {
        *outError = returnError;
    }
    
    return isValid;
}

- (BOOL)validateObject:(NSError **)outError
{
    //NSLog(@"validating: %@", self);
    
    BOOL isValid = YES;
    
    NSError *returnError = nil;
    
    NSSet *propertyKeys = [[NSSet setWithArray:[_propertyStore allKeys]] setByAddingObjectsFromSet:[self.validPropertyTypes set]];
    
    for (NSString *propertyKey in propertyKeys) {
        GCTag *subTag = [GCTag tagNamed:propertyKey];
        
        NSInteger propertyCount = 0;
        
        if ([self allowedOccurrencesPropertyType:propertyKey].max > 1) {
            propertyCount = [[self valueForKey:propertyKey] count];
            for (id property in [self valueForKey:propertyKey]) {
                NSError *err = nil;
                
                isValid &= validateProperty(self, propertyKey, property, subTag, &err);
                
                if (err) {
                    returnError = combineErrors(returnError, err);
                }
            }
        } else {
            propertyCount = [self valueForKey:propertyKey] ? 1 : 0;
            
            NSError *err = nil;
            
            isValid &= validateProperty(self, propertyKey, [self valueForKey:propertyKey], subTag, &err);
            
            if (err) {
                returnError = combineErrors(returnError, err);
            }
        }
        
        GCAllowedOccurrences allowedOccurrences = [self.gedTag allowedOccurrencesOfSubTag:subTag];
        
        if (propertyCount > allowedOccurrences.max) {
            isValid &= NO;
            returnError = combineErrors(returnError, [NSError errorWithDomain:GCErrorDoman
                                                                         code:GCTooManyValuesError
                                                                     userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Too many values for key %@ on %@", propertyKey, self.type], NSAffectedObjectsErrorKey: self}]);
        }
        
        if (propertyCount < allowedOccurrences.min) {
            isValid &= NO;
            returnError = combineErrors(returnError, [NSError errorWithDomain:GCErrorDoman
                                                                         code:GCTooFewValuesError
                                                                     userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Too few values for key %@ on %@", propertyKey, self.type], NSAffectedObjectsErrorKey: self}]);
        }
    }
    
    if (!isValid) {
        *outError = returnError;
    }
    
    return isValid;
}

- (BOOL)validateValue:(id *)ioValue forKey:(NSString *)inKey error:(NSError **)outError
{
    GCTag *subTag = [self.gedTag subTagWithName:inKey];
    
    return validateProperty(self, inKey, *ioValue, subTag, outError);
}

@end