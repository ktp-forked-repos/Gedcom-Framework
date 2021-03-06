/*
 This file was autogenerated by tags.py 
 */

#import "GCMarriageSettlementAttribute.h"

#import "GCTagAccessAdditions.h"
#import "GCObject_internal.h"
#import "Gedcom_internal.h"

@implementation GCMarriageSettlementAttribute {

}

// Methods:
/// @name Initializing

/** Initializes and returns a marriageSettlement.

 
 @return A new marriageSettlement.
*/
+(instancetype)marriageSettlement
{
	return [[self alloc] init];
}
/// @name Initializing

/** Initializes and returns a marriageSettlement.

 @param value The value as a GCValue object.
 @return A new marriageSettlement.
*/
+(instancetype)marriageSettlementWithValue:(GCValue *)value
{
	return [[self alloc] initWithValue:value];
}
/// @name Initializing

/** Initializes and returns a marriageSettlement.

 @param value The value as an NSString.
 @return A new marriageSettlement.
*/
+(instancetype)marriageSettlementWithGedcomStringValue:(NSString *)value
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
