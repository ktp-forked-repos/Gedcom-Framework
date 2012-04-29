//
//  GCRelationnship.m
//  Gedcom
//
//  Created by Mikkel Eide Eriksen on 27/03/12.
//  Copyright (c) 2012 Mikkel Eide Eriksen. All rights reserved.
//

#import "GCRelationship.h"

#import "GCNode.h"
#import "GCTag.h"
#import "GCContext.h"

@implementation GCRelationship {
	GCEntity *_target;
}

#pragma mark Convenience constructors

+ (id)relationshipForObject:(GCObject *)object withGedcomNode:(GCNode *)node
{
    GCTag *tag = [[object gedTag] subTagWithCode:[node gedTag]];
    
    GCRelationship *relationship = [[self alloc] initWithType:[tag name]];
    
    for (GCNode *subNode in [node subNodes]) {
        [relationship addPropertyWithGedcomNode:subNode];
    }
    
    [object addProperty:relationship];
    
	[[object context] registerXref:[node gedValue] forBlock:^(NSString *xref) {
		GCEntity *target = [[object context] entityForXref:xref];
		//NSLog(@"Set %@ => %@ on %@", xref, target, relationship);
		[relationship setTarget:target];
	}];
    
    return relationship;
}

+ (id)relationshipWithType:(NSString *)type
{
	return [[self alloc] initWithType:type];
}

#pragma mark Gedcom access

- (GCNode *)gedcomNode
{
    return [[GCNode alloc] initWithTag:[[self gedTag] code]
								 value:[[self context] xrefForEntity:_target]
								  xref:nil
							  subNodes:[self subNodes]];
}

#pragma mark Comparison

- (NSComparisonResult)compare:(id)other
{
    NSComparisonResult result = [super compare:other];
    
    if (result != NSOrderedSame) {
        return result;
    }
    
    if ([self target] != [(GCRelationship *)other target]) {
        return [[self target] compare:[(GCRelationship *)other target]];
    }
    
    return NSOrderedSame;
}

#pragma mark Objective-C properties

- (GCEntity *)target
{
    return _target;
}

- (void)setTarget:(GCEntity *)target
{
    NSParameterAssert([self describedObject]);
    
    if ([[self gedTag] reverseRelationshipTag]) {
        //remove previous reverse relationship before changing target.
        for (GCRelationship *relationship in [_target relationships]) {
            if ([[relationship target] isEqual:[self describedObject]]) {
                [_target removeProperty:relationship];
            }
        }
        if (target != nil) {
            //set up new reverse relationship
            BOOL relationshipExists = NO;
            for (GCRelationship *relationship in [target relationships]) {
                if ([[relationship target] isEqual:[self describedObject]]) {
                    //NSLog(@"relationship: %@", relationship);
                    relationshipExists = YES;
                }
            }
            if (!relationshipExists) {
                [target addRelationshipWithType:[[[self gedTag] reverseRelationshipTag] name] 
                                         target:(GCEntity *)[self describedObject]];
            }
        }
    }
    
    _target = target;
}

@end

@implementation GCRelationship (GCConvenienceMethods)

+ (id)relationshipWithType:(NSString *)type target:(GCEntity *)target
{
    GCRelationship *relationship = [[self alloc] initWithType:type];
    
    [relationship setTarget:target];
	
    return relationship;
}

@end