/*
 This file was autogenerated by tags.py 
 */

#import "GCMultimediaEntity.h"

#import "GCObject_internal.h"

#import "GCBinaryObjectAttribute.h"
#import "GCChangeInfoAttribute.h"
#import "GCMultimediaFormatAttribute.h"
#import "GCNoteEmbeddedAttribute.h"
#import "GCNoteReferenceRelationship.h"
#import "GCRecordIdNumberAttribute.h"
#import "GCTitleAttribute.h"
#import "GCUserReferenceNumberAttribute.h"

@implementation GCMultimediaEntity {
	GCMultimediaFormatAttribute *_multimediaFormat;
	GCTitleAttribute *_title;
	NSMutableArray *_noteReferences;
	NSMutableArray *_noteEmbeddeds;
	GCBinaryObjectAttribute *_binaryObject;
	NSMutableArray *_userReferenceNumbers;
	GCRecordIdNumberAttribute *_recordIdNumber;
	GCChangeInfoAttribute *_changeInfo;
}

// Methods:
/** Initializes and returns a multimedia.

 @param context The context in which to create the entity.
 @return A new multimedia.
*/
+(GCMultimediaEntity *)multimediaInContext:(GCContext *)context
{
	return [[self alloc] initInContext:context];
}
- (id)initInContext:(GCContext *)context
{
	self = [super _initWithType:@"multimedia" inContext:context];
	
	if (self) {
		// initialize ivars, if any:
		_noteReferences = [NSMutableArray array];
		_noteEmbeddeds = [NSMutableArray array];
		_userReferenceNumbers = [NSMutableArray array];
	}
	
	return self;
}


// Properties:

- (void)setMultimediaFormat:(id)obj
{
    NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
    
    NSString *formatString = [frameworkBundle localizedStringForKey:@"Undo %@"
															  value:@"Undo %@"
															  table:@"Misc"];
    
    NSString *typeName = [frameworkBundle localizedStringForKey:self.type
															  value:self.type
															  table:@"Misc"];
    
	[(GCMultimediaEntity *)[self.undoManager prepareWithInvocationTarget:self] setMultimediaFormat:_multimediaFormat];
	[self.undoManager setActionName:[NSString stringWithFormat:formatString, typeName]];
	
	if (_multimediaFormat) {
		[obj setValue:nil forKey:@"describedObject"];
	}
	
	if ([obj valueForKey:@"describedObject"]) {
		[((GCObject *)[obj valueForKey:@"describedObject"]).mutableProperties removeObject:obj];
	}
	
	[obj setValue:self forKey:@"describedObject"];
	
	_multimediaFormat = (id)obj;
}

- (GCMultimediaFormatAttribute *)multimediaFormat
{
	return _multimediaFormat;
}


- (void)setTitle:(id)obj
{
    NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
    
    NSString *formatString = [frameworkBundle localizedStringForKey:@"Undo %@"
															  value:@"Undo %@"
															  table:@"Misc"];
    
    NSString *typeName = [frameworkBundle localizedStringForKey:self.type
															  value:self.type
															  table:@"Misc"];
    
	[(GCMultimediaEntity *)[self.undoManager prepareWithInvocationTarget:self] setTitle:_title];
	[self.undoManager setActionName:[NSString stringWithFormat:formatString, typeName]];
	
	if (_title) {
		[obj setValue:nil forKey:@"describedObject"];
	}
	
	if ([obj valueForKey:@"describedObject"]) {
		[((GCObject *)[obj valueForKey:@"describedObject"]).mutableProperties removeObject:obj];
	}
	
	[obj setValue:self forKey:@"describedObject"];
	
	_title = (id)obj;
}

- (GCTitleAttribute *)title
{
	return _title;
}

@dynamic notes;

- (NSMutableArray *)mutableNoteReferences {
    return [self mutableArrayValueForKey:@"noteReferences"];
}

- (NSUInteger)countOfNoteReferences {
	return [_noteReferences count];
}

- (id)objectInNoteReferencesAtIndex:(NSUInteger)index {
    return [_noteReferences objectAtIndex:index];
}
 
- (void)insertObject:(id)obj inNoteReferencesAtIndex:(NSUInteger)index {
	NSParameterAssert([obj isKindOfClass:[GCNoteReferenceRelationship class]]);
	
    NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
    
    NSString *formatString = [frameworkBundle localizedStringForKey:@"Undo %@"
															  value:@"Undo %@"
															  table:@"Misc"];
    
    NSString *typeName = [frameworkBundle localizedStringForKey:self.type
													      value:self.type
														  table:@"Misc"];
    
	[(GCMultimediaEntity *)[self.undoManager prepareWithInvocationTarget:self] removeObjectFromNoteReferencesAtIndex:index];
	[self.undoManager setActionName:[NSString stringWithFormat:formatString, typeName]];
	
	if ([obj valueForKey:@"describedObject"] == self) {
		return;
	}
	
	if ([obj valueForKey:@"describedObject"]) {
		[((GCObject *)[obj valueForKey:@"describedObject"]).mutableProperties removeObject:obj];
	}
	
	[obj setValue:self forKey:@"describedObject"];
	
    [_noteReferences insertObject:obj atIndex:index];
}

- (void)removeObjectFromNoteReferencesAtIndex:(NSUInteger)index {
    NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
    
    NSString *formatString = [frameworkBundle localizedStringForKey:@"Undo %@"
															  value:@"Undo %@"
															  table:@"Misc"];
    
    NSString *typeName = [frameworkBundle localizedStringForKey:self.type
															  value:self.type
															  table:@"Misc"];
    
	[(GCMultimediaEntity *)[self.undoManager prepareWithInvocationTarget:self] insertObject:_noteReferences[index] inNoteReferencesAtIndex:index];
	[self.undoManager setActionName:[NSString stringWithFormat:formatString, typeName]];
	
	[((GCObject *)_noteReferences[index]) setValue:nil forKey:@"describedObject"];
	
    [_noteReferences removeObjectAtIndex:index];
}
	

- (NSMutableArray *)mutableNoteEmbeddeds {
    return [self mutableArrayValueForKey:@"noteEmbeddeds"];
}

- (NSUInteger)countOfNoteEmbeddeds {
	return [_noteEmbeddeds count];
}

- (id)objectInNoteEmbeddedsAtIndex:(NSUInteger)index {
    return [_noteEmbeddeds objectAtIndex:index];
}
 
- (void)insertObject:(id)obj inNoteEmbeddedsAtIndex:(NSUInteger)index {
	NSParameterAssert([obj isKindOfClass:[GCNoteEmbeddedAttribute class]]);
	
    NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
    
    NSString *formatString = [frameworkBundle localizedStringForKey:@"Undo %@"
															  value:@"Undo %@"
															  table:@"Misc"];
    
    NSString *typeName = [frameworkBundle localizedStringForKey:self.type
													      value:self.type
														  table:@"Misc"];
    
	[(GCMultimediaEntity *)[self.undoManager prepareWithInvocationTarget:self] removeObjectFromNoteEmbeddedsAtIndex:index];
	[self.undoManager setActionName:[NSString stringWithFormat:formatString, typeName]];
	
	if ([obj valueForKey:@"describedObject"] == self) {
		return;
	}
	
	if ([obj valueForKey:@"describedObject"]) {
		[((GCObject *)[obj valueForKey:@"describedObject"]).mutableProperties removeObject:obj];
	}
	
	[obj setValue:self forKey:@"describedObject"];
	
    [_noteEmbeddeds insertObject:obj atIndex:index];
}

- (void)removeObjectFromNoteEmbeddedsAtIndex:(NSUInteger)index {
    NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
    
    NSString *formatString = [frameworkBundle localizedStringForKey:@"Undo %@"
															  value:@"Undo %@"
															  table:@"Misc"];
    
    NSString *typeName = [frameworkBundle localizedStringForKey:self.type
															  value:self.type
															  table:@"Misc"];
    
	[(GCMultimediaEntity *)[self.undoManager prepareWithInvocationTarget:self] insertObject:_noteEmbeddeds[index] inNoteEmbeddedsAtIndex:index];
	[self.undoManager setActionName:[NSString stringWithFormat:formatString, typeName]];
	
	[((GCObject *)_noteEmbeddeds[index]) setValue:nil forKey:@"describedObject"];
	
    [_noteEmbeddeds removeObjectAtIndex:index];
}
	

- (void)setBinaryObject:(id)obj
{
    NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
    
    NSString *formatString = [frameworkBundle localizedStringForKey:@"Undo %@"
															  value:@"Undo %@"
															  table:@"Misc"];
    
    NSString *typeName = [frameworkBundle localizedStringForKey:self.type
															  value:self.type
															  table:@"Misc"];
    
	[(GCMultimediaEntity *)[self.undoManager prepareWithInvocationTarget:self] setBinaryObject:_binaryObject];
	[self.undoManager setActionName:[NSString stringWithFormat:formatString, typeName]];
	
	if (_binaryObject) {
		[obj setValue:nil forKey:@"describedObject"];
	}
	
	if ([obj valueForKey:@"describedObject"]) {
		[((GCObject *)[obj valueForKey:@"describedObject"]).mutableProperties removeObject:obj];
	}
	
	[obj setValue:self forKey:@"describedObject"];
	
	_binaryObject = (id)obj;
}

- (GCBinaryObjectAttribute *)binaryObject
{
	return _binaryObject;
}


- (NSMutableArray *)mutableUserReferenceNumbers {
    return [self mutableArrayValueForKey:@"userReferenceNumbers"];
}

- (NSUInteger)countOfUserReferenceNumbers {
	return [_userReferenceNumbers count];
}

- (id)objectInUserReferenceNumbersAtIndex:(NSUInteger)index {
    return [_userReferenceNumbers objectAtIndex:index];
}
 
- (void)insertObject:(id)obj inUserReferenceNumbersAtIndex:(NSUInteger)index {
	NSParameterAssert([obj isKindOfClass:[GCUserReferenceNumberAttribute class]]);
	
    NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
    
    NSString *formatString = [frameworkBundle localizedStringForKey:@"Undo %@"
															  value:@"Undo %@"
															  table:@"Misc"];
    
    NSString *typeName = [frameworkBundle localizedStringForKey:self.type
													      value:self.type
														  table:@"Misc"];
    
	[(GCMultimediaEntity *)[self.undoManager prepareWithInvocationTarget:self] removeObjectFromUserReferenceNumbersAtIndex:index];
	[self.undoManager setActionName:[NSString stringWithFormat:formatString, typeName]];
	
	if ([obj valueForKey:@"describedObject"] == self) {
		return;
	}
	
	if ([obj valueForKey:@"describedObject"]) {
		[((GCObject *)[obj valueForKey:@"describedObject"]).mutableProperties removeObject:obj];
	}
	
	[obj setValue:self forKey:@"describedObject"];
	
    [_userReferenceNumbers insertObject:obj atIndex:index];
}

- (void)removeObjectFromUserReferenceNumbersAtIndex:(NSUInteger)index {
    NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
    
    NSString *formatString = [frameworkBundle localizedStringForKey:@"Undo %@"
															  value:@"Undo %@"
															  table:@"Misc"];
    
    NSString *typeName = [frameworkBundle localizedStringForKey:self.type
															  value:self.type
															  table:@"Misc"];
    
	[(GCMultimediaEntity *)[self.undoManager prepareWithInvocationTarget:self] insertObject:_userReferenceNumbers[index] inUserReferenceNumbersAtIndex:index];
	[self.undoManager setActionName:[NSString stringWithFormat:formatString, typeName]];
	
	[((GCObject *)_userReferenceNumbers[index]) setValue:nil forKey:@"describedObject"];
	
    [_userReferenceNumbers removeObjectAtIndex:index];
}
	

- (void)setRecordIdNumber:(id)obj
{
    NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
    
    NSString *formatString = [frameworkBundle localizedStringForKey:@"Undo %@"
															  value:@"Undo %@"
															  table:@"Misc"];
    
    NSString *typeName = [frameworkBundle localizedStringForKey:self.type
															  value:self.type
															  table:@"Misc"];
    
	[(GCMultimediaEntity *)[self.undoManager prepareWithInvocationTarget:self] setRecordIdNumber:_recordIdNumber];
	[self.undoManager setActionName:[NSString stringWithFormat:formatString, typeName]];
	
	if (_recordIdNumber) {
		[obj setValue:nil forKey:@"describedObject"];
	}
	
	if ([obj valueForKey:@"describedObject"]) {
		[((GCObject *)[obj valueForKey:@"describedObject"]).mutableProperties removeObject:obj];
	}
	
	[obj setValue:self forKey:@"describedObject"];
	
	_recordIdNumber = (id)obj;
}

- (GCRecordIdNumberAttribute *)recordIdNumber
{
	return _recordIdNumber;
}


- (void)setChangeInfo:(id)obj
{
    NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
    
    NSString *formatString = [frameworkBundle localizedStringForKey:@"Undo %@"
															  value:@"Undo %@"
															  table:@"Misc"];
    
    NSString *typeName = [frameworkBundle localizedStringForKey:self.type
															  value:self.type
															  table:@"Misc"];
    
	[(GCMultimediaEntity *)[self.undoManager prepareWithInvocationTarget:self] setChangeInfo:_changeInfo];
	[self.undoManager setActionName:[NSString stringWithFormat:formatString, typeName]];
	
	if (_changeInfo) {
		[obj setValue:nil forKey:@"describedObject"];
	}
	
	if ([obj valueForKey:@"describedObject"]) {
		[((GCObject *)[obj valueForKey:@"describedObject"]).mutableProperties removeObject:obj];
	}
	
	[obj setValue:self forKey:@"describedObject"];
	
	_changeInfo = (id)obj;
}

- (GCChangeInfoAttribute *)changeInfo
{
	return _changeInfo;
}


@end

