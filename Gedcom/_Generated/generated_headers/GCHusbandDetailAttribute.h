/*
 This file was autogenerated by tags.py 
 */

#import "GCAttribute.h"

@class GCAgeAttribute;

/**
 
*/
@interface GCHusbandDetailAttribute : GCAttribute

// Methods:
/** Initializes and returns a husbandDetail.

 
 @return A new husbandDetail.
*/
+(GCHusbandDetailAttribute *)husbandDetail;
/** Initializes and returns a husbandDetail.

 @param value The value as a GCValue object.
 @return A new husbandDetail.
*/
+(GCHusbandDetailAttribute *)husbandDetailWithValue:(GCValue *)value;
/** Initializes and returns a husbandDetail.

 @param value The value as an NSString.
 @return A new husbandDetail.
*/
+(GCHusbandDetailAttribute *)husbandDetailWithGedcomStringValue:(NSString *)value;

// Properties:
/// .  NB: required property.
@property (nonatomic) GCAgeAttribute *age;


@end
