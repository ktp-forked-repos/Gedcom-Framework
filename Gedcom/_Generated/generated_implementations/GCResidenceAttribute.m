/*
 This file was autogenerated by tags.py 
 */

#import "GCResidenceAttribute.h"

@implementation GCResidenceAttribute {
	GCTypeDescriptionAttribute *_typeDescription;
	GCDateAttribute *_date;
	GCPlaceAttribute *_place;
	GCAddressAttribute *_address;
	GCPhoneNumberAttribute *_phoneNumber;
	GCAgeAttribute *_age;
	GCResponsibleAgencyAttribute *_responsibleAgency;
	GCCauseAttribute *_cause;
	NSMutableArray *_sourceCitations;
	NSMutableArray *_sourceEmbeddeds;
	NSMutableArray *_multimediaReferences;
	NSMutableArray *_multimediaEmbeddeds;
	NSMutableArray *_noteReferences;
	NSMutableArray *_noteEmbeddeds;
}

// Methods:
/// @name Initializing

/** Initializes and returns a residence.

 
 @return A new residence.
*/
+(instancetype)residence
{
	return [[self alloc] init];
}
/// @name Initializing

/** Initializes and returns a residence.

 @param value The value as a GCValue object.
 @return A new residence.
*/
+(instancetype)residenceWithValue:(GCValue *)value
{
	return [[self alloc] initWithValue:value];
}
/// @name Initializing

/** Initializes and returns a residence.

 @param value The value as an NSString.
 @return A new residence.
*/
+(instancetype)residenceWithGedcomStringValue:(NSString *)value
{
	return [[self alloc] initWithGedcomStringValue:value];
}
- (instancetype)init
{
	self = [super init];
	
	if (self) {
		// initialize ivars, if any:
		_sourceCitations = [NSMutableArray array];
		_sourceEmbeddeds = [NSMutableArray array];
		_multimediaReferences = [NSMutableArray array];
		_multimediaEmbeddeds = [NSMutableArray array];
		_noteReferences = [NSMutableArray array];
		_noteEmbeddeds = [NSMutableArray array];
	}
	
	return self;
}


// Properties:
@dynamic eventDetails;
@dynamic typeDescription;
@dynamic date;
@dynamic place;
@dynamic address;
@dynamic phoneNumber;
@dynamic age;
@dynamic responsibleAgency;
@dynamic cause;
@dynamic sources;
@synthesize sourceCitations = _sourceCitations;
@dynamic mutableSourceCitations;
- (NSMutableArray *)mutableSourceCitations
{
	return [self mutableArrayValueForKey:@"sourceCitations"];
}

@synthesize sourceEmbeddeds = _sourceEmbeddeds;
@dynamic mutableSourceEmbeddeds;
- (NSMutableArray *)mutableSourceEmbeddeds
{
	return [self mutableArrayValueForKey:@"sourceEmbeddeds"];
}

@dynamic multimedias;
@synthesize multimediaReferences = _multimediaReferences;
@dynamic mutableMultimediaReferences;
- (NSMutableArray *)mutableMultimediaReferences
{
	return [self mutableArrayValueForKey:@"multimediaReferences"];
}

@synthesize multimediaEmbeddeds = _multimediaEmbeddeds;
@dynamic mutableMultimediaEmbeddeds;
- (NSMutableArray *)mutableMultimediaEmbeddeds
{
	return [self mutableArrayValueForKey:@"multimediaEmbeddeds"];
}

@dynamic notes;
@synthesize noteReferences = _noteReferences;
@dynamic mutableNoteReferences;
- (NSMutableArray *)mutableNoteReferences
{
	return [self mutableArrayValueForKey:@"noteReferences"];
}

@synthesize noteEmbeddeds = _noteEmbeddeds;
@dynamic mutableNoteEmbeddeds;
- (NSMutableArray *)mutableNoteEmbeddeds
{
	return [self mutableArrayValueForKey:@"noteEmbeddeds"];
}


@end
