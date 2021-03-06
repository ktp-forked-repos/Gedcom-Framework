/*
 This file was autogenerated by tags.py 
 */

#import "GCSourceEmbeddedAttribute.h"

#import "GCTagAccessAdditions.h"
#import "GCObject_internal.h"
#import "Gedcom_internal.h"

@implementation GCSourceEmbeddedAttribute {
	NSMutableArray *_texts;
	NSMutableArray *_noteReferences;
	NSMutableArray *_noteEmbeddeds;
}

// Methods:
/// @name Initializing

/** Initializes and returns a sourceEmbedded.

 
 @return A new sourceEmbedded.
*/
+(instancetype)sourceEmbedded
{
	return [[self alloc] init];
}
/// @name Initializing

/** Initializes and returns a sourceEmbedded.

 @param value The value as a GCValue object.
 @return A new sourceEmbedded.
*/
+(instancetype)sourceEmbeddedWithValue:(GCValue *)value
{
	return [[self alloc] initWithValue:value];
}
/// @name Initializing

/** Initializes and returns a sourceEmbedded.

 @param value The value as an NSString.
 @return A new sourceEmbedded.
*/
+(instancetype)sourceEmbeddedWithGedcomStringValue:(NSString *)value
{
	return [[self alloc] initWithGedcomStringValue:value];
}
- (instancetype)init
{
	self = [super init];
	
	if (self) {
		// initialize ivars, if any:
		_texts = [NSMutableArray array];
		_noteReferences = [NSMutableArray array];
		_noteEmbeddeds = [NSMutableArray array];
	}
	
	return self;
}


// Properties:
@synthesize texts = _texts;

@dynamic mutableTexts;
- (NSMutableArray *)mutableTexts
{
	return [self mutableArrayValueForKey:@"texts"];
}

- (id)objectInTextsAtIndex:(NSUInteger)idx
{
	return [_texts objectAtIndex:idx];
}

- (NSUInteger)countOfTexts
{
	return [_texts count];
}

- (void)insertObject:(id)obj inTextsAtIndex:(NSUInteger)idx
{
	if ([obj valueForKey:@"describedObject"] == self) {
		return;
	}
	
	if (!_isBuildingFromGedcom) {
		NSUndoManager *uM = [self valueForKey:@"undoManager"];
		@synchronized (uM) {
			[uM beginUndoGrouping];
			[(GCSourceEmbeddedAttribute *)[uM prepareWithInvocationTarget:self] removeObjectFromTextsAtIndex:idx];
			[uM setActionName:[NSString stringWithFormat:GCLocalizedString(@"Undo %@", @"Misc"), self.localizedType]];
			[uM endUndoGrouping];
		}
	}
	
	if ([obj valueForKey:@"describedObject"]) {
		[[obj valueForKeyPath:@"describedObject.mutableProperties"] removeObject:obj];
	}
	
	[obj setValue:self forKey:@"describedObject"];
	
	[_texts insertObject:obj atIndex:idx];
}

- (void)removeObjectFromTextsAtIndex:(NSUInteger)idx
{
	if (!_isBuildingFromGedcom) {
		NSUndoManager *uM = [self valueForKey:@"undoManager"];
		@synchronized (uM) {
			[uM beginUndoGrouping];
			[(GCSourceEmbeddedAttribute *)[uM prepareWithInvocationTarget:self] insertObject:_texts[idx] inTextsAtIndex:idx];
			[uM setActionName:[NSString stringWithFormat:GCLocalizedString(@"Undo %@", @"Misc"), self.localizedType]];
			[uM endUndoGrouping];
		}
	}
	
	[_texts[idx] setValue:nil forKey:@"describedObject"];
	
	[_texts removeObjectAtIndex:idx];
}

@dynamic notes;
@synthesize noteReferences = _noteReferences;

@dynamic mutableNoteReferences;
- (NSMutableArray *)mutableNoteReferences
{
	return [self mutableArrayValueForKey:@"noteReferences"];
}

- (id)objectInNoteReferencesAtIndex:(NSUInteger)idx
{
	return [_noteReferences objectAtIndex:idx];
}

- (NSUInteger)countOfNoteReferences
{
	return [_noteReferences count];
}

- (void)insertObject:(id)obj inNoteReferencesAtIndex:(NSUInteger)idx
{
	if ([obj valueForKey:@"describedObject"] == self) {
		return;
	}
	
	if (!_isBuildingFromGedcom) {
		NSUndoManager *uM = [self valueForKey:@"undoManager"];
		@synchronized (uM) {
			[uM beginUndoGrouping];
			[(GCSourceEmbeddedAttribute *)[uM prepareWithInvocationTarget:self] removeObjectFromNoteReferencesAtIndex:idx];
			[uM setActionName:[NSString stringWithFormat:GCLocalizedString(@"Undo %@", @"Misc"), self.localizedType]];
			[uM endUndoGrouping];
		}
	}
	
	if ([obj valueForKey:@"describedObject"]) {
		[[obj valueForKeyPath:@"describedObject.mutableProperties"] removeObject:obj];
	}
	
	[obj setValue:self forKey:@"describedObject"];
	
	[_noteReferences insertObject:obj atIndex:idx];
}

- (void)removeObjectFromNoteReferencesAtIndex:(NSUInteger)idx
{
	if (!_isBuildingFromGedcom) {
		NSUndoManager *uM = [self valueForKey:@"undoManager"];
		@synchronized (uM) {
			[uM beginUndoGrouping];
			[(GCSourceEmbeddedAttribute *)[uM prepareWithInvocationTarget:self] insertObject:_noteReferences[idx] inNoteReferencesAtIndex:idx];
			[uM setActionName:[NSString stringWithFormat:GCLocalizedString(@"Undo %@", @"Misc"), self.localizedType]];
			[uM endUndoGrouping];
		}
	}
	
	[_noteReferences[idx] setValue:nil forKey:@"describedObject"];
	
	[_noteReferences removeObjectAtIndex:idx];
}

@synthesize noteEmbeddeds = _noteEmbeddeds;

@dynamic mutableNoteEmbeddeds;
- (NSMutableArray *)mutableNoteEmbeddeds
{
	return [self mutableArrayValueForKey:@"noteEmbeddeds"];
}

- (id)objectInNoteEmbeddedsAtIndex:(NSUInteger)idx
{
	return [_noteEmbeddeds objectAtIndex:idx];
}

- (NSUInteger)countOfNoteEmbeddeds
{
	return [_noteEmbeddeds count];
}

- (void)insertObject:(id)obj inNoteEmbeddedsAtIndex:(NSUInteger)idx
{
	if ([obj valueForKey:@"describedObject"] == self) {
		return;
	}
	
	if (!_isBuildingFromGedcom) {
		NSUndoManager *uM = [self valueForKey:@"undoManager"];
		@synchronized (uM) {
			[uM beginUndoGrouping];
			[(GCSourceEmbeddedAttribute *)[uM prepareWithInvocationTarget:self] removeObjectFromNoteEmbeddedsAtIndex:idx];
			[uM setActionName:[NSString stringWithFormat:GCLocalizedString(@"Undo %@", @"Misc"), self.localizedType]];
			[uM endUndoGrouping];
		}
	}
	
	if ([obj valueForKey:@"describedObject"]) {
		[[obj valueForKeyPath:@"describedObject.mutableProperties"] removeObject:obj];
	}
	
	[obj setValue:self forKey:@"describedObject"];
	
	[_noteEmbeddeds insertObject:obj atIndex:idx];
}

- (void)removeObjectFromNoteEmbeddedsAtIndex:(NSUInteger)idx
{
	if (!_isBuildingFromGedcom) {
		NSUndoManager *uM = [self valueForKey:@"undoManager"];
		@synchronized (uM) {
			[uM beginUndoGrouping];
			[(GCSourceEmbeddedAttribute *)[uM prepareWithInvocationTarget:self] insertObject:_noteEmbeddeds[idx] inNoteEmbeddedsAtIndex:idx];
			[uM setActionName:[NSString stringWithFormat:GCLocalizedString(@"Undo %@", @"Misc"), self.localizedType]];
			[uM endUndoGrouping];
		}
	}
	
	[_noteEmbeddeds[idx] setValue:nil forKey:@"describedObject"];
	
	[_noteEmbeddeds removeObjectAtIndex:idx];
}


@end
