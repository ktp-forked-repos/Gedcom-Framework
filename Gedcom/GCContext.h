//
//  GCXRefStore.h
//  Gedcom
//
//  Created by Mikkel Eide Eriksen on 28/03/12.
//  Copyright (c) 2012 Mikkel Eide Eriksen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GCContextDelegate.h"

@class GCHeaderEntity;
@class GCEntity;
@class GCSubmissionEntity;
@class GCObject;
@class GCNode;
@class GCTag;

/**
 
 A context provides lookup functionality related to xrefs. Generally, a context encompasses a single file; all entities (that is, individuals, families, etc) in the file will belong to the same context.
 
 */

//TODO: merging contexts etc.

typedef enum : NSUInteger {
    GCUnknownFileEncoding = -1,
    GCASCIIFileEncoding = NSASCIIStringEncoding,
    GCUTF8FileEncoding = NSUTF8StringEncoding,
    GCANSELFileEncoding = kCFStringEncodingANSEL
} GCFileEncoding;

@interface GCContext : NSObject <NSCoding>

/// @name Obtaining a context

/// Creates a new context with an autogenerated name.
+ (id)context;

/** Returns a new context with an autogenerated named initialized with the given array of nodes.
 
 @param nodes An array of GCNodes.
 */
+ (id)contextWithGedcomNodes:(NSArray *)nodes;

+ (id)contextWithContentsOfFile:(NSString *)path usedEncoding:(GCFileEncoding *)enc error:(NSError **)error;

+ (id)contextWithContentsOfURL:(NSURL *)url usedEncoding:(GCFileEncoding *)enc error:(NSError **)error;

- (id)initWithContentsOfFile:(NSString *)path usedEncoding:(GCFileEncoding *)enc error:(NSError **)error;

- (id)initWithContentsOfURL:(NSURL *)url usedEncoding:(GCFileEncoding *)enc error:(NSError **)error;

/// Returns a dictionary containing all current contexts, keyed by name.
+ (NSDictionary *)contextsByName;

#pragma mark Node access
/// @name Parsing nodes

/** Causes the receiver to parse the nodes.
 
 Will throw an exception if the receiver already contains entities.
 
 @param nodes A collection of nodes.
 */
- (void)parseNodes:(NSArray *)nodes;

#pragma mark Objective-C properties

/// The header of the receiver.
@property GCHeaderEntity *header;

/// An optional submission entity.
@property GCSubmissionEntity *submission;

/// An ordered collection of the receiver's families.
@property (readonly) NSMutableArray *families;

/// An ordered collection of the receiver's individuals.
@property (readonly) NSMutableArray *individuals;

/// An ordered collection of the receiver's multimedia objects.
@property (readonly) NSMutableArray *multimediaObjects;

/// An ordered collection of the receiver's notes.
@property (readonly) NSMutableArray *notes;

/// An ordered collection of the receiver's repositories.
@property (readonly) NSMutableArray *repositories;

/// An ordered collection of the receiver's sources.
@property (readonly) NSMutableArray *sources;

/// An ordered collection of the receiver's submitters.
@property (readonly) NSMutableArray *submitters;

/// A collection of all the receiver's entities.
@property (readonly) NSMutableSet *allEntities;

/// @name Gedcom output

/// The receiver as an ordered collection of Gedcom nodes.
@property (readonly) NSArray *gedcomNodes;

/// The receiver as a Gedcom string.
@property (readonly) NSString *gedcomString;

#pragma mark Objective-C properties

/// @name Accessing properties

@property (readonly) GCFileEncoding fileEncoding;

/// The name of the receiver.
@property (readonly) NSString *name;

/// @name Setting the delegate

/// The receiver's delegate. See GCContextDelegate.
@property (weak) id<NSObject, GCContextDelegate> delegate;

@end

@interface GCContext (GCValidationMethods)

/// @name Validating contexts

/** Returns whether the receiver is a valid Gedcom context appropiate for saving to a file.
 
 If the context is invalid, the error pointer will be updated with an NSError describing the problem.
 
 @param error A pointer to an NSError object
 @return `YES` if the context is valid, otherwise `NO`.
 */
- (BOOL)validateContext:(NSError **)error;

@end