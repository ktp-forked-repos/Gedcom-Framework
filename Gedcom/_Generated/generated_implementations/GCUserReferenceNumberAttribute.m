/*
 This file was autogenerated by tags.py 
 */

#import "GCUserReferenceNumberAttribute.h"

#import "GCObject_internal.h"

#import "GCTypeDescriptionAttribute.h"

@implementation GCUserReferenceNumberAttribute {
	GCTypeDescriptionAttribute *_typeDescription;
}

// Methods:
/** Initializes and returns a userReferenceNumber.

 
 @return A new userReferenceNumber.
*/
+(GCUserReferenceNumberAttribute *)userReferenceNumber
{
	return [[self alloc] init];
}
/** Initializes and returns a userReferenceNumber.

 @param value The value as a GCValue object.
 @return A new userReferenceNumber.
*/
+(GCUserReferenceNumberAttribute *)userReferenceNumberWithValue:(GCValue *)value
{
	return [[self alloc] initWithValue:value];
}
/** Initializes and returns a userReferenceNumber.

 @param value The value as an NSString.
 @return A new userReferenceNumber.
*/
+(GCUserReferenceNumberAttribute *)userReferenceNumberWithGedcomStringValue:(NSString *)value
{
	return [[self alloc] initWithGedcomStringValue:value];
}
- (id)init
{
	self = [super _initWithType:@"userReferenceNumber"];
	
	if (self) {
		// initialize ivars, if any:

	}
	
	return self;
}


// Properties:

- (void)setTypeDescription:(id)obj
{
	NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
	
	NSString *formatString = [frameworkBundle localizedStringForKey:@"Undo %@"
															  value:@"Undo %@"
															  table:@"Misc"];
	
	[(GCUserReferenceNumberAttribute *)[self.undoManager prepareWithInvocationTarget:self] setTypeDescription:_typeDescription];
	[self.undoManager setActionName:[NSString stringWithFormat:formatString, self.localizedType]];
	
	if (_typeDescription) {
		[obj setValue:nil forKey:@"describedObject"];
	}
	
	if ([obj valueForKey:@"describedObject"]) {
		[((GCObject *)[obj valueForKey:@"describedObject"]).mutableProperties removeObject:obj];
	}
	
	[obj setValue:self forKey:@"describedObject"];
	
	_typeDescription = (id)obj;
}


@end

