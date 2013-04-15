/*
 This file was autogenerated by tags.py 
 */

#import "GCCopyrightAttribute.h"

#import "GCObject_internal.h"



@implementation GCCopyrightAttribute {

}

// Methods:
/** Initializes and returns a copyright.

 
 @return A new copyright.
*/
+(GCCopyrightAttribute *)copyright
{
	return [[self alloc] init];
}
/** Initializes and returns a copyright.

 @param value The value as a GCValue object.
 @return A new copyright.
*/
+(GCCopyrightAttribute *)copyrightWithValue:(GCValue *)value
{
	return [[self alloc] initWithValue:value];
}
/** Initializes and returns a copyright.

 @param value The value as an NSString.
 @return A new copyright.
*/
+(GCCopyrightAttribute *)copyrightWithGedcomStringValue:(NSString *)value
{
	return [[self alloc] initWithGedcomStringValue:value];
}
- (id)init
{
	self = [super _initWithType:@"copyright"];
	
	if (self) {
		// initialize ivars, if any:

	}
	
	return self;
}


// Properties:


@end

