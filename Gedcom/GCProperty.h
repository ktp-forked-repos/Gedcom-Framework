//
//  GCProperty.h
//  Gedcom
//
//  Created by Mikkel Eide Eriksen on 27/03/12.
//  Copyright (c) 2012 Mikkel Eide Eriksen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCObject.h"

/**
 
 Abstract property. Subclasses are GCAttribute and GCRelationship.
 
 */
@interface GCProperty : GCObject

#pragma mark Initialization

/// @name Creating and initializing properties

/** Initializes and creates a property whose type and properties reflect the GCNode.
 
 Cannot be used to initialize the GCProperty superclass, but must be used on the GCAttribute and GCRelationship subclasses.
 
 @param object The object being described.
 @param node A GCNode. Its tag code must correspond to a valid property on the object.
 @return A new attribute.
 */
- (id)initForObject:(GCObject *)object withGedcomNode:(GCNode *)node;

#pragma mark Convenience constructor

/** Returns a property whose type and properties reflect the GCNode.
 
 Will inspect the node and determine whether to return an attribute or a relationship.
 
 @param object The object being described.
 @param node A GCNode. Its tag code must correspond to a valid property on the object.
 @return A new attribute.
 */
+ (id)propertyForObject:(GCObject *)object withGedcomNode:(GCNode *)node;

#pragma mark Objective-C properties

/// @name Accessing properties

/// The object being described by the receiver.
@property (weak) GCObject *describedObject;

@end
