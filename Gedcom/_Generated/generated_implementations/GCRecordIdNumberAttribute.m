/*
 This file was autogenerated by tags.py 
 */

#import "GCRecordIdNumberAttribute.h"

#import "GCTagAccessAdditions.h"
#import "GCObject_internal.h"
#import "Gedcom_internal.h"

@implementation GCRecordIdNumberAttribute {

}

// Methods:
/// @name Initializing

/** Initializes and returns a recordIdNumber.

 
 @return A new recordIdNumber.
*/
+(instancetype)recordIdNumber
{
	return [[self alloc] init];
}
/// @name Initializing

/** Initializes and returns a recordIdNumber.

 @param value The value as a GCValue object.
 @return A new recordIdNumber.
*/
+(instancetype)recordIdNumberWithValue:(GCValue *)value
{
	return [[self alloc] initWithValue:value];
}
/// @name Initializing

/** Initializes and returns a recordIdNumber.

 @param value The value as an NSString.
 @return A new recordIdNumber.
*/
+(instancetype)recordIdNumberWithGedcomStringValue:(NSString *)value
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
