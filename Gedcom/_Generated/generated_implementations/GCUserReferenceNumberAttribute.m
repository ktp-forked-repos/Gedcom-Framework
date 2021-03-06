/*
 This file was autogenerated by tags.py 
 */

#import "GCUserReferenceNumberAttribute.h"

#import "GCTagAccessAdditions.h"
#import "GCObject_internal.h"
#import "Gedcom_internal.h"

@implementation GCUserReferenceNumberAttribute {
	GCTypeDescriptionAttribute *_typeDescription;
}

// Methods:
/// @name Initializing

/** Initializes and returns a userReferenceNumber.

 
 @return A new userReferenceNumber.
*/
+(instancetype)userReferenceNumber
{
	return [[self alloc] init];
}
/// @name Initializing

/** Initializes and returns a userReferenceNumber.

 @param value The value as a GCValue object.
 @return A new userReferenceNumber.
*/
+(instancetype)userReferenceNumberWithValue:(GCValue *)value
{
	return [[self alloc] initWithValue:value];
}
/// @name Initializing

/** Initializes and returns a userReferenceNumber.

 @param value The value as an NSString.
 @return A new userReferenceNumber.
*/
+(instancetype)userReferenceNumberWithGedcomStringValue:(NSString *)value
{
	return [[self alloc] initWithGedcomStringValue:value];
}
- (instancetype)init
{
	self = [super init];
	
	if (self) {
		// initialize ivars, if any:

	}
	
	return self;
}


// Properties:

- (id)typeDescription
{
	return _typeDescription;
}
	
- (void)setTypeDescription:(id)obj
{
	if (!_isBuildingFromGedcom) {
		NSUndoManager *uM = [self valueForKey:@"undoManager"];
		@synchronized (uM) {
			[uM beginUndoGrouping];
			[(GCUserReferenceNumberAttribute *)[uM prepareWithInvocationTarget:self] setTypeDescription:_typeDescription];
			[uM setActionName:[NSString stringWithFormat:GCLocalizedString(@"Undo %@", @"Misc"), self.localizedType]];
			[uM endUndoGrouping];
		}
	}
	
	if (_typeDescription) {
		[(id)_typeDescription setValue:nil forKey:@"describedObject"];
	}
	
	[[obj valueForKeyPath:@"describedObject.mutableProperties"] removeObject:obj];
	
	[obj setValue:self forKey:@"describedObject"];
	
	_typeDescription = obj;
}


@end
