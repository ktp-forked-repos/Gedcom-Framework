//
//  GCGender.m
//  Gedcom
//
//  Created by Mikkel Eide Eriksen on 30/04/12.
//  Copyright (c) 2012 Mikkel Eide Eriksen. All rights reserved.
//

#import "GCGender.h"

@implementation GCGender {
    NSString *_gedcomString;
    NSString *_displayString;
}

__strong static NSDictionary *genderStore;

+ (void)initialize
{
    static dispatch_once_t predGender = 0;
    
    dispatch_once(&predGender, ^{
        genderStore = [NSDictionary dictionaryWithObjectsAndKeys:
                       [[GCGender alloc] initWithGedcomString:@"M" displayString:@"Male"], @"M",
                       [[GCGender alloc] initWithGedcomString:@"F" displayString:@"Female"], @"F",
                       [[GCGender alloc] initWithGedcomString:@"U" displayString:@"Unknown"], @"U",
                       nil];
    });
}

- (id)initWithGedcomString:(NSString *)gedcomString displayString:(NSString *)displayString
{
    self = [super init];
    
    if (self) {
        _gedcomString = gedcomString;
        _displayString = displayString;
    }
    
    return self;
}

+ (id)valueWithGedcomString:(NSString *)string
{
    [self initialize];
    
    return [genderStore valueForKey:string];
}

+ (id)maleGender
{
    return [self valueWithGedcomString:@"M"];
}

+ (id)femaleGender
{
    return [self valueWithGedcomString:@"F"];
}

+ (id)unknownGender
{
    return [self valueWithGedcomString:@"U"];
}

- (NSComparisonResult)compare:(id)other
{
    return [[self gedcomString] compare:[other gedcomString]];
}

@synthesize gedcomString = _gedcomString;

- (NSString *)displayString
{
    NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
    
    return [frameworkBundle localizedStringForKey:_displayString value:_displayString table:@"Formatting"];
}

@end
