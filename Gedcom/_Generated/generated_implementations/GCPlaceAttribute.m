/*
 This file was autogenerated by tags.py 
 */

#import "GCPlaceAttribute.h"

#import "GCObject_internal.h"

#import "GCNoteEmbeddedAttribute.h"
#import "GCNoteReferenceRelationship.h"
#import "GCPlaceFormatAttribute.h"
#import "GCSourceCitationRelationship.h"
#import "GCSourceEmbeddedAttribute.h"

@implementation GCPlaceAttribute {
	GCPlaceFormatAttribute *_placeFormat;
	NSMutableArray *_sourceCitations;
	NSMutableArray *_sourceEmbeddeds;
	NSMutableArray *_noteReferences;
	NSMutableArray *_noteEmbeddeds;
}

// Methods:
/** Initializes and returns a place.

 
 @return A new place.
*/
+(GCPlaceAttribute *)place
{
	return [[self alloc] init];
}
/** Initializes and returns a place.

 @param value The value as a GCValue object.
 @return A new place.
*/
+(GCPlaceAttribute *)placeWithValue:(GCValue *)value
{
	return [[self alloc] initWithValue:value];
}
/** Initializes and returns a place.

 @param value The value as an NSString.
 @return A new place.
*/
+(GCPlaceAttribute *)placeWithGedcomStringValue:(NSString *)value
{
	return [[self alloc] initWithGedcomStringValue:value];
}
- (id)init
{
	self = [super _initWithType:@"place"];
	
	if (self) {
		// initialize ivars, if any:
		_sourceCitations = [NSMutableArray array];
		_sourceEmbeddeds = [NSMutableArray array];
		_noteReferences = [NSMutableArray array];
		_noteEmbeddeds = [NSMutableArray array];
	}
	
	return self;
}


// Properties:

- (void)setPlaceFormat:(id)obj
{
    NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
    
    NSString *formatString = [frameworkBundle localizedStringForKey:@"Undo %@"
															  value:@"Undo %@"
															  table:@"Misc"];
    
    NSString *typeName = [frameworkBundle localizedStringForKey:self.type
															  value:self.type
															  table:@"Misc"];
    
	[(GCPlaceAttribute *)[self.undoManager prepareWithInvocationTarget:self] setPlaceFormat:_placeFormat];
	[self.undoManager setActionName:[NSString stringWithFormat:formatString, typeName]];
	
	if (_placeFormat) {
		[obj setValue:nil forKey:@"describedObject"];
	}
	
	if ([obj valueForKey:@"describedObject"]) {
		[((GCObject *)[obj valueForKey:@"describedObject"]).mutableProperties removeObject:obj];
	}
	
	[obj setValue:self forKey:@"describedObject"];
	
	_placeFormat = (id)obj;
}

- (GCPlaceFormatAttribute *)placeFormat
{
	return _placeFormat;
}

@dynamic sources;

- (NSMutableArray *)mutableSourceCitations {
    return [self mutableArrayValueForKey:@"sourceCitations"];
}

- (NSUInteger)countOfSourceCitations {
	return [_sourceCitations count];
}

- (id)objectInSourceCitationsAtIndex:(NSUInteger)index {
    return [_sourceCitations objectAtIndex:index];
}
 
- (void)insertObject:(id)obj inSourceCitationsAtIndex:(NSUInteger)index {
	NSParameterAssert([obj isKindOfClass:[GCSourceCitationRelationship class]]);
	
    NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
    
    NSString *formatString = [frameworkBundle localizedStringForKey:@"Undo %@"
															  value:@"Undo %@"
															  table:@"Misc"];
    
    NSString *typeName = [frameworkBundle localizedStringForKey:self.type
													      value:self.type
														  table:@"Misc"];
    
	[(GCPlaceAttribute *)[self.undoManager prepareWithInvocationTarget:self] removeObjectFromSourceCitationsAtIndex:index];
	[self.undoManager setActionName:[NSString stringWithFormat:formatString, typeName]];
	
	if ([obj valueForKey:@"describedObject"] == self) {
		return;
	}
	
	if ([obj valueForKey:@"describedObject"]) {
		[((GCObject *)[obj valueForKey:@"describedObject"]).mutableProperties removeObject:obj];
	}
	
	[obj setValue:self forKey:@"describedObject"];
	
    [_sourceCitations insertObject:obj atIndex:index];
}

- (void)removeObjectFromSourceCitationsAtIndex:(NSUInteger)index {
    NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
    
    NSString *formatString = [frameworkBundle localizedStringForKey:@"Undo %@"
															  value:@"Undo %@"
															  table:@"Misc"];
    
    NSString *typeName = [frameworkBundle localizedStringForKey:self.type
															  value:self.type
															  table:@"Misc"];
    
	[(GCPlaceAttribute *)[self.undoManager prepareWithInvocationTarget:self] insertObject:_sourceCitations[index] inSourceCitationsAtIndex:index];
	[self.undoManager setActionName:[NSString stringWithFormat:formatString, typeName]];
	
	[((GCObject *)_sourceCitations[index]) setValue:nil forKey:@"describedObject"];
	
    [_sourceCitations removeObjectAtIndex:index];
}
	

- (NSMutableArray *)mutableSourceEmbeddeds {
    return [self mutableArrayValueForKey:@"sourceEmbeddeds"];
}

- (NSUInteger)countOfSourceEmbeddeds {
	return [_sourceEmbeddeds count];
}

- (id)objectInSourceEmbeddedsAtIndex:(NSUInteger)index {
    return [_sourceEmbeddeds objectAtIndex:index];
}
 
- (void)insertObject:(id)obj inSourceEmbeddedsAtIndex:(NSUInteger)index {
	NSParameterAssert([obj isKindOfClass:[GCSourceEmbeddedAttribute class]]);
	
    NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
    
    NSString *formatString = [frameworkBundle localizedStringForKey:@"Undo %@"
															  value:@"Undo %@"
															  table:@"Misc"];
    
    NSString *typeName = [frameworkBundle localizedStringForKey:self.type
													      value:self.type
														  table:@"Misc"];
    
	[(GCPlaceAttribute *)[self.undoManager prepareWithInvocationTarget:self] removeObjectFromSourceEmbeddedsAtIndex:index];
	[self.undoManager setActionName:[NSString stringWithFormat:formatString, typeName]];
	
	if ([obj valueForKey:@"describedObject"] == self) {
		return;
	}
	
	if ([obj valueForKey:@"describedObject"]) {
		[((GCObject *)[obj valueForKey:@"describedObject"]).mutableProperties removeObject:obj];
	}
	
	[obj setValue:self forKey:@"describedObject"];
	
    [_sourceEmbeddeds insertObject:obj atIndex:index];
}

- (void)removeObjectFromSourceEmbeddedsAtIndex:(NSUInteger)index {
    NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
    
    NSString *formatString = [frameworkBundle localizedStringForKey:@"Undo %@"
															  value:@"Undo %@"
															  table:@"Misc"];
    
    NSString *typeName = [frameworkBundle localizedStringForKey:self.type
															  value:self.type
															  table:@"Misc"];
    
	[(GCPlaceAttribute *)[self.undoManager prepareWithInvocationTarget:self] insertObject:_sourceEmbeddeds[index] inSourceEmbeddedsAtIndex:index];
	[self.undoManager setActionName:[NSString stringWithFormat:formatString, typeName]];
	
	[((GCObject *)_sourceEmbeddeds[index]) setValue:nil forKey:@"describedObject"];
	
    [_sourceEmbeddeds removeObjectAtIndex:index];
}
	
@dynamic notes;

- (NSMutableArray *)mutableNoteReferences {
    return [self mutableArrayValueForKey:@"noteReferences"];
}

- (NSUInteger)countOfNoteReferences {
	return [_noteReferences count];
}

- (id)objectInNoteReferencesAtIndex:(NSUInteger)index {
    return [_noteReferences objectAtIndex:index];
}
 
- (void)insertObject:(id)obj inNoteReferencesAtIndex:(NSUInteger)index {
	NSParameterAssert([obj isKindOfClass:[GCNoteReferenceRelationship class]]);
	
    NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
    
    NSString *formatString = [frameworkBundle localizedStringForKey:@"Undo %@"
															  value:@"Undo %@"
															  table:@"Misc"];
    
    NSString *typeName = [frameworkBundle localizedStringForKey:self.type
													      value:self.type
														  table:@"Misc"];
    
	[(GCPlaceAttribute *)[self.undoManager prepareWithInvocationTarget:self] removeObjectFromNoteReferencesAtIndex:index];
	[self.undoManager setActionName:[NSString stringWithFormat:formatString, typeName]];
	
	if ([obj valueForKey:@"describedObject"] == self) {
		return;
	}
	
	if ([obj valueForKey:@"describedObject"]) {
		[((GCObject *)[obj valueForKey:@"describedObject"]).mutableProperties removeObject:obj];
	}
	
	[obj setValue:self forKey:@"describedObject"];
	
    [_noteReferences insertObject:obj atIndex:index];
}

- (void)removeObjectFromNoteReferencesAtIndex:(NSUInteger)index {
    NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
    
    NSString *formatString = [frameworkBundle localizedStringForKey:@"Undo %@"
															  value:@"Undo %@"
															  table:@"Misc"];
    
    NSString *typeName = [frameworkBundle localizedStringForKey:self.type
															  value:self.type
															  table:@"Misc"];
    
	[(GCPlaceAttribute *)[self.undoManager prepareWithInvocationTarget:self] insertObject:_noteReferences[index] inNoteReferencesAtIndex:index];
	[self.undoManager setActionName:[NSString stringWithFormat:formatString, typeName]];
	
	[((GCObject *)_noteReferences[index]) setValue:nil forKey:@"describedObject"];
	
    [_noteReferences removeObjectAtIndex:index];
}
	

- (NSMutableArray *)mutableNoteEmbeddeds {
    return [self mutableArrayValueForKey:@"noteEmbeddeds"];
}

- (NSUInteger)countOfNoteEmbeddeds {
	return [_noteEmbeddeds count];
}

- (id)objectInNoteEmbeddedsAtIndex:(NSUInteger)index {
    return [_noteEmbeddeds objectAtIndex:index];
}
 
- (void)insertObject:(id)obj inNoteEmbeddedsAtIndex:(NSUInteger)index {
	NSParameterAssert([obj isKindOfClass:[GCNoteEmbeddedAttribute class]]);
	
    NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
    
    NSString *formatString = [frameworkBundle localizedStringForKey:@"Undo %@"
															  value:@"Undo %@"
															  table:@"Misc"];
    
    NSString *typeName = [frameworkBundle localizedStringForKey:self.type
													      value:self.type
														  table:@"Misc"];
    
	[(GCPlaceAttribute *)[self.undoManager prepareWithInvocationTarget:self] removeObjectFromNoteEmbeddedsAtIndex:index];
	[self.undoManager setActionName:[NSString stringWithFormat:formatString, typeName]];
	
	if ([obj valueForKey:@"describedObject"] == self) {
		return;
	}
	
	if ([obj valueForKey:@"describedObject"]) {
		[((GCObject *)[obj valueForKey:@"describedObject"]).mutableProperties removeObject:obj];
	}
	
	[obj setValue:self forKey:@"describedObject"];
	
    [_noteEmbeddeds insertObject:obj atIndex:index];
}

- (void)removeObjectFromNoteEmbeddedsAtIndex:(NSUInteger)index {
    NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
    
    NSString *formatString = [frameworkBundle localizedStringForKey:@"Undo %@"
															  value:@"Undo %@"
															  table:@"Misc"];
    
    NSString *typeName = [frameworkBundle localizedStringForKey:self.type
															  value:self.type
															  table:@"Misc"];
    
	[(GCPlaceAttribute *)[self.undoManager prepareWithInvocationTarget:self] insertObject:_noteEmbeddeds[index] inNoteEmbeddedsAtIndex:index];
	[self.undoManager setActionName:[NSString stringWithFormat:formatString, typeName]];
	
	[((GCObject *)_noteEmbeddeds[index]) setValue:nil forKey:@"describedObject"];
	
    [_noteEmbeddeds removeObjectAtIndex:index];
}
	

@end

