//
//  GCAgeTests.m
//  GCCoreData
//
//  Created by Mikkel Eide Eriksen on 21/02/11.
//  Copyright 2011 Mikkel Eide Eriksen. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

#import "Gedcom.h"

@interface GCAgeTests : SenTestCase
@end


@implementation GCAgeTests

- (void)testAgeKeyword
{
	GCAge *age = [GCAge valueWithGedcomString:@"INFANT"];
	
	STAssertEqualObjects(NSStringFromClass([age class]), @"GCAgeKeyword", nil);
	STAssertEqualObjects([age gedcomString], @"INFANT", nil);
}

- (void)testQualifiedAge
{
	GCAge *age = [GCAge valueWithGedcomString:@"< 10d"];
	
	STAssertEqualObjects(NSStringFromClass([age class]), @"GCSimpleAge", nil);
	STAssertEqualObjects([age gedcomString], @"< 10d", nil);
}

- (void)testUnqualifiedAge
{
	GCAge *age = [GCAge valueWithGedcomString:@"3y 1m 2d"];
	
	STAssertEqualObjects(NSStringFromClass([age class]), @"GCSimpleAge", nil);
	STAssertEqualObjects([age gedcomString], @"3y 1m 2d", nil);
	
    //will only pass if localization isn't changed from English:
    STAssertEqualObjects([age displayString], @"3 years, 1 month, 2 days", nil);
}

- (void)testInvalidAge
{
	GCAge *age = [GCAge valueWithGedcomString:@"Not an age"];
	
	STAssertEqualObjects(NSStringFromClass([age class]), @"GCInvalidAge", nil);
	STAssertEqualObjects([age gedcomString], @"Not an age", nil);
}

- (void)testAgeSort
{
    NSMutableArray *ages = [NSMutableArray array];
    
    GCPlacestring *a = [GCAge valueWithGedcomString:@"INFANT"];
    GCPlacestring *b = [GCAge valueWithGedcomString:@"STILLBORN"];
    GCPlacestring *c = [GCAge valueWithGedcomString:@"0y"];
    GCPlacestring *d = [GCAge valueWithGedcomString:@"> 5y"];
    GCPlacestring *e = [GCAge valueWithGedcomString:@"6y"];
    GCPlacestring *f = [GCAge valueWithGedcomString:@"< 6y"];
    GCPlacestring *g = [GCAge valueWithGedcomString:@"1y"];
    GCPlacestring *h = [GCAge valueWithGedcomString:@"CHILD"];
    
    [ages addObject:a];
    [ages addObject:b];
    [ages addObject:c];
    [ages addObject:d];
    [ages addObject:e];
    [ages addObject:f];
    [ages addObject:g];
    [ages addObject:h];
    
    [ages sortUsingSelector:@selector(compare:)];
    
    NSArray *expectedOrder = [NSArray arrayWithObjects:c, b, g, a, d, f, e, h, nil];
    
    STAssertEqualObjects(ages, expectedOrder, nil);
}

@end
