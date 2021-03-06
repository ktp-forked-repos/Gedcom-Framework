/*
 This file was autogenerated by tags.py 
 */

#import "GCAdoptedIntoFamilyRelationship.h"

#import "GCTagAccessAdditions.h"
#import "GCObject_internal.h"
#import "Gedcom_internal.h"

@implementation GCAdoptedIntoFamilyRelationship {
	GCAdoptedByWhichParentAttribute *_adoptedByWhichParent;
}

// Methods:
/// @name Initializing

/** Initializes and returns a adoptedIntoFamily.

 
 @return A new adoptedIntoFamily.
*/
+(instancetype)adoptedIntoFamily
{
	return [[self alloc] init];
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

- (id)adoptedByWhichParent
{
	return _adoptedByWhichParent;
}
	
- (void)setAdoptedByWhichParent:(id)obj
{
	if (!_isBuildingFromGedcom) {
		NSUndoManager *uM = [self valueForKey:@"undoManager"];
		@synchronized (uM) {
			[uM beginUndoGrouping];
			[(GCAdoptedIntoFamilyRelationship *)[uM prepareWithInvocationTarget:self] setAdoptedByWhichParent:_adoptedByWhichParent];
			[uM setActionName:[NSString stringWithFormat:GCLocalizedString(@"Undo %@", @"Misc"), self.localizedType]];
			[uM endUndoGrouping];
		}
	}
	
	if (_adoptedByWhichParent) {
		[(id)_adoptedByWhichParent setValue:nil forKey:@"describedObject"];
	}
	
	[[obj valueForKeyPath:@"describedObject.mutableProperties"] removeObject:obj];
	
	[obj setValue:self forKey:@"describedObject"];
	
	_adoptedByWhichParent = obj;
}


@end
