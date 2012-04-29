//
//  GCObject.h
//  Gedcom
//
//  Created by Mikkel Eide Eriksen on 24/03/12.
//  Copyright (c) 2012 Mikkel Eide Eriksen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCObject.h"

/**
 
 Entities are objects such as an individual or a family.
 
 */
@interface GCEntity : GCObject

#pragma mark Initialization

/// @name Creating and initializing entities

/** Initializes and returns a entity with the specified type and context.
 
 @param type A string which must correspond to a valid root object.
 @param context The context of the entity.
 @return A new entity.
 */
- (id)initWithType:(NSString *)type inContext:(GCContext *)context;

#pragma mark Convenience constructors

/** Returns an entity whose properties reflect the GCNode in the given GCContext.
 
 @param node A GCNode. Its tag code must correspond to a valid root object.
 @param context The context of the entity.
 @return A new entity.
 */
+ (id)entityWithGedcomNode:(GCNode *)node inContext:(GCContext *)context;

/** Returns an entity with the specified type in the given GCContext.
 
 @param type A string which must correspond to a valid root object.
 @param context The context of the entity.
 @return A new entity.
 */
+ (id)entityWithType:(NSString *)type inContext:(GCContext *)context;

#pragma mark Objective-C properties

/// @name Accessing properties

/// The last time the entity was modified.
@property (readonly) NSDate *lastModified;

@end
