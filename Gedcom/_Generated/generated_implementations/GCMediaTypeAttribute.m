/*
 This file was autogenerated by tags.py 
 */

#import "GCMediaTypeAttribute.h"

#import "GCTagAccessAdditions.h"
#import "GCObject_internal.h"
#import "Gedcom_internal.h"

@implementation GCMediaTypeAttribute {

}

// Methods:
/// @name Initializing

/** Initializes and returns a mediaType.

 
 @return A new mediaType.
*/
+(instancetype)mediaType
{
	return [[self alloc] init];
}
/// @name Initializing

/** Initializes and returns a mediaType.

 @param value The value as a GCValue object.
 @return A new mediaType.
*/
+(instancetype)mediaTypeWithValue:(GCValue *)value
{
	return [[self alloc] initWithValue:value];
}
/// @name Initializing

/** Initializes and returns a mediaType.

 @param value The value as an NSString.
 @return A new mediaType.
*/
+(instancetype)mediaTypeWithGedcomStringValue:(NSString *)value
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
