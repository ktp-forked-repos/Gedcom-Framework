/*
 This file was autogenerated by tags.py 
 */

#import "GCRelationship.h"

@class GCNoteEmbeddedAttribute;
@class GCNoteReferenceRelationship;
@class GCPedigreeAttribute;

/**
 
*/
@interface GCChildInFamilyRelationship : GCRelationship

// Methods:
/// @name Initializing

/** Initializes and returns a childInFamily.

 
 @return A new childInFamily.
*/
+(instancetype)childInFamily;

// Properties:
/// . 
@property (nonatomic) GCPedigreeAttribute *pedigree;

/// @name Accessing notes

/// Property for accessing the following properties
@property (nonatomic) NSArray *notes;

/// @name Accessing notes 

///Also contained in notes. . GCNoteReferenceRelationship
@property (nonatomic) NSArray *noteReferences;
/// @name Accessing notes 

///Also contained in notes. . Contains instances of noteReferences
@property (nonatomic) NSMutableArray *mutableNoteReferences;

/// @name Accessing notes 

///Also contained in notes. . GCNoteEmbeddedAttribute
@property (nonatomic) NSArray *noteEmbeddeds;
/// @name Accessing notes 

///Also contained in notes. . Contains instances of noteEmbeddeds
@property (nonatomic) NSMutableArray *mutableNoteEmbeddeds;


@end
