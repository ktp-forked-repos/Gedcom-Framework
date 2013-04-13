/*
 This file was autogenerated by tags.py 
 */

#import "GCEntity.h"

@class GCChangeInfoAttribute;
@class GCRecordIdNumberAttribute;
@class GCSourceCitationRelationship;
@class GCSourceEmbeddedAttribute;
@class GCUserReferenceNumberAttribute;

/**
 
*/
@interface GCNoteEntity : GCEntity

// Methods:
/** Initializes and returns a note.

 @param context The context in which to create the entity.
 @return A new note.
*/
+(GCNoteEntity *)noteInContext:(GCContext *)context;

// Properties:
/// Property for accessing the following properties
@property (nonatomic) NSArray *sources;

/// Also contained in sources. . GCSourceCitationRelationship
@property (nonatomic) NSArray *sourceCitations;
/// Also contained in sources. . sourceCitations
@property (nonatomic) NSMutableArray *mutableSourceCitations;

/// Also contained in sources. . GCSourceEmbeddedAttribute
@property (nonatomic) NSArray *sourceEmbeddeds;
/// Also contained in sources. . sourceEmbeddeds
@property (nonatomic) NSMutableArray *mutableSourceEmbeddeds;

/// . GCUserReferenceNumberAttribute
@property (nonatomic) NSArray *userReferenceNumbers;
/// . userReferenceNumbers
@property (nonatomic) NSMutableArray *mutableUserReferenceNumbers;

/// . 
@property (nonatomic) GCRecordIdNumberAttribute *recordIdNumber;

/// . 
@property (nonatomic) GCChangeInfoAttribute *changeInfo;


@end
