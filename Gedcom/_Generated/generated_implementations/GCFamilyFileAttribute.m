/*
 This file was autogenerated by tags.py 
 */

#import "GCFamilyFileAttribute.h"

#import "GCTagAccessAdditions.h"
#import "GCObject_internal.h"
#import "Gedcom_internal.h"

@implementation GCFamilyFileAttribute {

}

// Methods:
/// @name Initializing

/** Initializes and returns a familyFile.

 
 @return A new familyFile.
*/
+(instancetype)familyFile
{
	return [[self alloc] init];
}
/// @name Initializing

/** Initializes and returns a familyFile.

 @param value The value as a GCValue object.
 @return A new familyFile.
*/
+(instancetype)familyFileWithValue:(GCValue *)value
{
	return [[self alloc] initWithValue:value];
}
/// @name Initializing

/** Initializes and returns a familyFile.

 @param value The value as an NSString.
 @return A new familyFile.
*/
+(instancetype)familyFileWithGedcomStringValue:(NSString *)value
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


@end
