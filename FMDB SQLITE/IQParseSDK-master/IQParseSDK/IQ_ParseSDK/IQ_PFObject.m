//
//  IQ_PFObject.m
// https://github.com/hackiftekhar/IQParseSDK
// Copyright (c) 2013-14 Iftekhar Qurashi.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "IQ_PFObject.h"
#import "IQPFHTTPService.h"
#import "IQ_PFFile.h"
#import "IQ_PFRelation.h"

#import "IQ_Base64.h"

#import <Foundation/NSDate.h>
#import <Foundation/NSThread.h>
#import <Foundation/NSDictionary.h>
#import <Foundation/NSDateFormatter.h>
#import <Foundation/NSTimeZone.h>

@interface IQ_PFFile ()

-(NSDictionary*)coreSerializedAttribute;
-(void)serializeAttributes:(NSDictionary*)result;

@end


@interface IQ_PFObject()

@end

@implementation IQ_PFObject
{
    NSMutableDictionary *displayAttributes;
    NSMutableDictionary *needUpdateAttributes;
    
    NSMutableSet *connectionSet;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        connectionSet = [[NSMutableSet alloc] init];

        displayAttributes       = [[NSMutableDictionary alloc] init];
        needUpdateAttributes    = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(NSDictionary*)coreSerializedAttribute
{
    return @{ kParse__TypeKey: kParsePointerKey, kParseClassNameKey: self.parseClassName, kParseObjectIdKey: self.objectId};
}

-(NSDictionary*)deserializedAttributes
{
    NSMutableDictionary *deserializedAttributes = [[NSMutableDictionary alloc] init];
    
    for (NSString *key in [needUpdateAttributes allKeys])
    {
        id object = [needUpdateAttributes objectForKey:key];
        
        //Handle NSDate
        if ([object isKindOfClass:[NSDate class]])
        {
            object = [[self class] dateAttributeWithDate:object];
        }
        //Handle NSData
        else if ([object isKindOfClass:[NSData class]])
        {
            object = [object base64EncodedString];
        }
        //Handle IQ_PFFile
        else if ([object isKindOfClass:[IQ_PFFile class]])
        {
            object = [object coreSerializedAttribute];
        }
        //Handle IQ_PFObject Pointers
        else if ([object isKindOfClass:[IQ_PFObject class]])
        {
            object = [object coreSerializedAttribute];
        }
        //Handle IQ_PFGeoPoint Pointers
        else if ([object isKindOfClass:[IQ_PFGeoPoint class]])
        {
            object = [object coreSerializedAttribute];
        }
        //Handle IQ_PFRelation Pointers
        else if ([object isKindOfClass:[IQ_PFRelation class]])
        {
            object = [object coreSerializedAttribute];
        }
    
        if (object)     [deserializedAttributes setObject:object forKey:key];
    }
    
    return deserializedAttributes;
}

-(void)serializeAttributes:(NSDictionary*)result
{
    if (result)
    {
        if ([result objectForKey:kParseCreatedAtKey])
            _createdAt  =   [[[self class] parseSDKDateFormatter] dateFromString:[result objectForKey:kParseCreatedAtKey]];
        
        if ([result objectForKey:kParseUpdatedAtKey])
            _updatedAt  =   [[[self class] parseSDKDateFormatter] dateFromString:[result objectForKey:kParseUpdatedAtKey]];
        
        if ([result objectForKey:kParseObjectIdKey])
            _objectId   =   [result objectForKey:kParseObjectIdKey];
        
        
        for (NSString *key in [result allKeys])
        {
            id object = [result objectForKey:key];

            if ([object isKindOfClass:[NSDictionary class]])
            {
                //Handle NSDate
                if ([[object objectForKey:kParse__TypeKey] isEqualToString:kParseDateKey])
                {
                    object = [[self class] parseSDKDateFromString:[object objectForKey:kParseISOKey]];
                }
                //Handle NSData
                else if ([[object objectForKey:kParse__TypeKey] isEqualToString:kParseBytesKey])
                {
                    object = [[object objectForKey:kParseBase64Key] base64DecodedData];
                }
                //Handle IQ_PFFile
                else if ([[object objectForKey:kParse__TypeKey] isEqualToString:kParseFileKey])
                {
                    object = [[IQ_PFFile alloc] init];
                    [object serializeAttributes:[result objectForKey:key]];
                }
                //Handle IQ_PFObject Pointers
                else if ([[object objectForKey:kParse__TypeKey] isEqualToString:kParsePointerKey])
                {
                    object = [IQ_PFObject objectWithoutDataWithClassName:[object objectForKey:kParseClassNameKey] objectId:[object objectForKey:kParseObjectIdKey]];
                }
                //Handle IQ_PFGeoPoint Pointers
                else if ([[object objectForKey:kParse__TypeKey] isEqualToString:kParseGeoPointKey])
                {
                    object = [IQ_PFGeoPoint geoPointWithLatitude:[[object objectForKey:kParseLatitudeKey] doubleValue] longitude:[[object objectForKey:kParseLongitudeKey] doubleValue]];
                }
                //Handle IQ_PFRelation Pointers
                else if ([[object objectForKey:kParse__TypeKey] isEqualToString:kParseRelationKey])
                {
                    IQ_PFRelation *relation = [[IQ_PFRelation alloc] init];
                    relation.targetClass = [object objectForKey:kParseClassNameKey];
                    object = relation;
                }
            }

            if (object)     [displayAttributes setObject:object forKey:key];
        }
    }
}

+ (IQ_PFObject *)objectWithClassName:(NSString *)className
{
    return [[self alloc] initWithClassName:className dictionary:nil];
}

+ (instancetype)objectWithoutDataWithClassName:(NSString *)className objectId:(NSString *)objectId
{
    IQ_PFObject *object = [[self alloc] initWithClassName:className];
    object.objectId = objectId;
    return object;
}

+ (instancetype)objectWithClassName:(NSString *)className dictionary:(NSDictionary *)dictionary
{
    return [[self alloc] initWithClassName:className dictionary:dictionary];
}

- (instancetype)initWithClassName:(NSString *)newClassName
{
    self = [self init];
    
    if (self)
    {
        _parseClassName = newClassName;
    }
    
    return self;
}

- (instancetype)initWithClassName:(NSString *)newClassName dictionary:(NSDictionary *)dictionary
{
    self = [self initWithClassName:newClassName];
    
    if (self)
    {
        [self serializeAttributes:dictionary];
        [needUpdateAttributes   addEntriesFromDictionary:dictionary];
    }
    
    return self;
}

- (NSArray *)allKeys
{
    return [displayAttributes allKeys];
}

- (id)objectForKey:(NSString *)key
{
    return [displayAttributes objectForKey:key];
}

- (void)setObject:(id)object forKey:(NSString *)key
{
    if (object != nil)
    {
        [displayAttributes      setObject:object forKey:key];
        [needUpdateAttributes   setObject:object forKey:key];
    }
    else
    {
        [self removeObjectForKey:key];
    }
}

- (void)removeObjectForKey:(NSString *)key
{
    [displayAttributes      removeObjectForKey:key];
    [needUpdateAttributes   removeObjectForKey:key];
}

//- (IQ_PFRelation *)relationForKey:(NSString *)key;

- (void)addObject:(id)object forKey:(NSString *)key
{
    //Update display attributes
    {
        NSArray *displayArray = [displayAttributes objectForKey:key];
        if (displayArray == nil)    displayArray = [[NSArray alloc] init];
        [displayAttributes setObject:[displayArray arrayByAddingObject:object] forKey:key];
    }

    id value = [needUpdateAttributes objectForKey:key];
    if (value == nil)
    {
        [needUpdateAttributes setObject:[[self class] addAttributeWithArray:@[object]] forKey:key];
    }
    else if ([value isKindOfClass:[NSArray class]])
    {
        [needUpdateAttributes setObject:[[self class] addAttributeWithArray:@[object]] forKey:key];
    }
    else if ([value objectForKey:kParse__OpKey])
    {
        NSDictionary *dict = [value objectForKey:kParse__OpKey];
        
        NSArray *newAttributedArray = [[dict objectForKey:kParseObjectsKey] arrayByAddingObject:object];
        
        [needUpdateAttributes setObject:[[self class] addAttributeWithArray:newAttributedArray] forKey:key];
    }
}

- (void)addObjectsFromArray:(NSArray *)objects forKey:(NSString *)key
{
    //Update display attributes
    {
        NSArray *displayArray = [displayAttributes objectForKey:key];
        if (displayArray == nil)    displayArray = [[NSArray alloc] init];
        [displayAttributes setObject:[displayArray arrayByAddingObjectsFromArray:objects] forKey:key];
    }

    id value = [needUpdateAttributes objectForKey:key];
    if (value == nil)
    {
        [needUpdateAttributes setObject:[[self class] addAttributeWithArray:objects] forKey:key];
    }
    else if ([value isKindOfClass:[NSArray class]])
    {
        [needUpdateAttributes setObject:[[self class] addAttributeWithArray:objects] forKey:key];
    }
    else if ([value objectForKey:kParse__OpKey])
    {
        NSDictionary *dict = [value objectForKey:kParse__OpKey];
        
        NSArray *newAttributedArray = [[dict objectForKey:kParseObjectsKey] arrayByAddingObjectsFromArray:objects];
        
        [needUpdateAttributes setObject:[[self class] addAttributeWithArray:newAttributedArray] forKey:key];
    }
}

- (void)addUniqueObject:(id)object forKey:(NSString *)key
{
    //Update display attributes
    {
        NSArray *displayArray = [displayAttributes objectForKey:key];
        if (displayArray == nil)    displayArray = [[NSArray alloc] init];
        if ([displayArray containsObject:object] == NO)
        {
            [displayAttributes setObject:[displayArray arrayByAddingObject:object] forKey:key];
        }
    }

    id value = [needUpdateAttributes objectForKey:key];
    if (value == nil)
    {
        [needUpdateAttributes setObject:[[self class] addUniqueAttributeWithArray:@[object]] forKey:key];
    }
    else if ([value isKindOfClass:[NSArray class]])
    {
        [needUpdateAttributes setObject:[[self class] addUniqueAttributeWithArray:@[object]] forKey:key];
    }
    else if ([value objectForKey:kParse__OpKey])
    {
        NSDictionary *dict = [value objectForKey:kParse__OpKey];
        
        NSArray *attributedArray = [dict objectForKey:kParseObjectsKey];
        
        if ([attributedArray containsObject:object] == NO)
        {
            [needUpdateAttributes setObject:[[self class] addUniqueAttributeWithArray:[attributedArray arrayByAddingObject:object]] forKey:key];
        }
    }
}

- (void)addUniqueObjectsFromArray:(NSArray *)objects forKey:(NSString *)key
{
    //Update display attributes
    {
        NSArray *displayArray = [displayAttributes objectForKey:key];

        NSMutableOrderedSet *orderedDisplaySet = [[NSMutableOrderedSet alloc] initWithArray:displayArray];
        [orderedDisplaySet addObjectsFromArray:objects];
        [displayAttributes setObject:[orderedDisplaySet array] forKey:key];
    }

    id value = [needUpdateAttributes objectForKey:key];
    if (value == nil)
    {
        [needUpdateAttributes setObject:[[self class] addUniqueAttributeWithArray:objects] forKey:key];
    }
    else if ([value isKindOfClass:[NSArray class]])
    {
        [needUpdateAttributes setObject:[[self class] addUniqueAttributeWithArray:objects] forKey:key];
    }
    else if ([value objectForKey:kParse__OpKey])
    {
        NSDictionary *dict = [value objectForKey:kParse__OpKey];
        NSMutableOrderedSet *orderedAttributedSet = [[NSMutableOrderedSet alloc] initWithArray:[dict objectForKey:kParseObjectsKey]];
        [orderedAttributedSet addObjectsFromArray:objects];
        [needUpdateAttributes setObject:[[self class] addUniqueAttributeWithArray:[orderedAttributedSet array]] forKey:key];
    }
}

- (void)removeObject:(id)object forKey:(NSString *)key
{
    //Update display attributes
    {
        NSMutableArray *newArray = [[displayAttributes objectForKey:key] mutableCopy];
        [newArray removeObject:object];
        [displayAttributes setObject:newArray forKey:key];
    }

    id value = [needUpdateAttributes objectForKey:key];
    
    if ([value isKindOfClass:[NSArray class]])
    {
        NSMutableArray *newArray = [value mutableCopy];
        [newArray removeObject:object];
        [needUpdateAttributes setObject:newArray forKey:key];
    }
    else if ([value objectForKey:kParse__OpKey])
    {
        NSMutableDictionary *dict = [[value objectForKey:kParse__OpKey] mutableCopy];
        
        NSMutableArray *newAttributedArray = [[dict objectForKey:kParseObjectsKey] mutableCopy];
        [newAttributedArray removeObject:object];
        
        if ([newAttributedArray count])
        {
            [dict setObject:newAttributedArray forKey:kParseObjectsKey];
            [needUpdateAttributes setObject:dict forKey:key];
        }
        else
        {
            [needUpdateAttributes removeObjectForKey:key];
        }
    }
}

- (void)removeObjectsInArray:(NSArray *)objects forKey:(NSString *)key
{
    //Update display attributes
    {
        NSMutableArray *newArray = [[displayAttributes objectForKey:key] mutableCopy];
        [newArray removeObjectsInArray:objects];
        [displayAttributes setObject:newArray forKey:key];
    }
    
    id value = [needUpdateAttributes objectForKey:key];
    
    if ([value isKindOfClass:[NSArray class]])
    {
        NSMutableArray *newArray = [value mutableCopy];
        [newArray removeObjectsInArray:objects];
        [needUpdateAttributes setObject:newArray forKey:key];
    }
    else if ([value objectForKey:kParse__OpKey])
    {
        NSMutableDictionary *dict = [[value objectForKey:kParse__OpKey] mutableCopy];
        
        NSMutableArray *newAttributedArray = [[dict objectForKey:kParseObjectsKey] mutableCopy];
        [newAttributedArray removeObjectsInArray:objects];
        
        if ([newAttributedArray count])
        {
            [dict setObject:newAttributedArray forKey:kParseObjectsKey];
            [needUpdateAttributes setObject:dict forKey:key];
        }
        else
        {
            [needUpdateAttributes removeObjectForKey:key];
        }
    }
}

- (void)incrementKey:(NSString *)key
{
    [displayAttributes setObject:[[self class] incrementAttribute] forKey:key];
}

- (void)incrementKey:(NSString *)key byAmount:(NSNumber *)amount
{
    [displayAttributes setObject:[[self class] incrementAttributeByAmount:amount] forKey:key];
}

- (BOOL)save
{
    return [self save:nil];
}

- (BOOL)save:(NSError **)error
{
    NSDictionary *result;
    
    if (self.objectId)
    {
        result = [[IQPFHTTPService service] updateObjectWithParseClass:self.parseClassName objectId:self.objectId attributes:[self deserializedAttributes] error:error];
    }
    else
    {
        result = [[IQPFHTTPService service] createObjectWithParseClass:self.parseClassName attributes:[self deserializedAttributes] error:error];
    }
    
    
    if (result)
    {
        [self serializeAttributes:result];
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)saveInBackground
{
    [self saveInBackgroundWithBlock:NULL];
}

- (void)saveInBackgroundWithBlock:(IQ_PFBooleanResultBlock)block
{
    if (self.objectId)
    {
        __block IQURLConnection *connection = [[IQPFHTTPService service] updateObjectWithParseClass:self.parseClassName objectId:self.objectId attributes:[self deserializedAttributes] completionHandler:^(NSDictionary *result, NSError *error) {
            
            if (connection) [connectionSet removeObject:connection];

            if (result)
            {
                [self serializeAttributes:result];
            }

            if (block)
            {
                block((result!= nil),error);
            }
        }];
        
        if (connection) [connectionSet addObject:connection];
    }
    else
    {
        __block IQURLConnection *connection = [[IQPFHTTPService service] createObjectWithParseClass:self.parseClassName attributes:[self deserializedAttributes] completionHandler:^(NSDictionary *result, NSError *error) {

            if (connection) [connectionSet removeObject:connection];

            if (result)
            {
                [self serializeAttributes:result];
            }
            
            if (block)
            {
                block((result!= nil),error);
            }
        }];
        
        if (connection) [connectionSet addObject:connection];
    }
}

- (void)saveInBackgroundWithTarget:(id)target selector:(SEL)selector
{
    [self saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[target methodSignatureForSelector:selector]];
        invocation.target = target;
        invocation.selector = selector;
        [invocation setArgument:&(succeeded) atIndex:2];
        [invocation setArgument:&error atIndex:3];
        [invocation invoke];

    }];
}


//- (void)saveEventually;
//- (void)saveEventually:(IQ_PFBooleanResultBlock)callback;

//+ (BOOL)saveAll:(NSArray *)objects;
//+ (BOOL)saveAll:(NSArray *)objects error:(NSError **)error;
//+ (void)saveAllInBackground:(NSArray *)objects;
//+ (void)saveAllInBackground:(NSArray *)objects block:(IQ_PFBooleanResultBlock)block;
//+ (void)saveAllInBackground:(NSArray *)objects target:(id)target selector:(SEL)selector;

//+ (BOOL)deleteAll:(NSArray *)objects;
//+ (BOOL)deleteAll:(NSArray *)objects error:(NSError **)error;
//+ (void)deleteAllInBackground:(NSArray *)objects;
//+ (void)deleteAllInBackground:(NSArray *)objects block:(IQ_PFBooleanResultBlock)block;
//+ (void)deleteAllInBackground:(NSArray *)objects target:(id)target selector:(SEL)selector;

//- (BOOL)isDataAvailable;
- (void)refresh
{
    [self refresh:nil];
}

- (void)refresh:(NSError **)error
{
    NSDictionary *result = [[IQPFHTTPService service] objectsWithParseClass:self.parseClassName urlParameter:nil objectId:self.objectId error:error];

    if (result)
    {
        [self serializeAttributes:result];
    }
}

- (void)refreshInBackgroundWithBlock:(IQ_PFObjectResultBlock)block
{
    __block IQURLConnection *connection = [[IQPFHTTPService service] objectsWithParseClass:self.parseClassName urlParameter:nil objectId:self.objectId completionHandler:^(NSDictionary *result, NSError *error) {

        if (connection) [connectionSet removeObject:connection];

        if (result)
        {
            [self serializeAttributes:result];
        }

        if (block)
        {
            block((result!= nil)?self:nil,error);
        }
        
        if (connection) [connectionSet addObject:connection];
    }];
}

- (void)refreshInBackgroundWithTarget:(id)target selector:(SEL)selector
{
    [self refreshInBackgroundWithBlock:^(IQ_PFObject *object, NSError *error) {

        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[target methodSignatureForSelector:selector]];
        invocation.target = target;
        invocation.selector = selector;
        [invocation setArgument:&object atIndex:2];
        [invocation setArgument:&error atIndex:3];
        [invocation invoke];

    }];
}

//- (void)fetch:(NSError **)error;
//- (IQ_PFObject *)fetchIfNeeded;
//- (IQ_PFObject *)fetchIfNeeded:(NSError **)error;
//- (void)fetchInBackgroundWithBlock:(IQ_PFObjectResultBlock)block;
//- (void)fetchInBackgroundWithTarget:(id)target selector:(SEL)selector;
//- (void)fetchIfNeededInBackgroundWithBlock:(IQ_PFObjectResultBlock)block;
//- (void)fetchIfNeededInBackgroundWithTarget:(id)target selector:(SEL)selector;

//+ (void)fetchAll:(NSArray *)objects;
//+ (void)fetchAll:(NSArray *)objects error:(NSError **)error;
//+ (void)fetchAllIfNeeded:(NSArray *)objects;
//+ (void)fetchAllIfNeeded:(NSArray *)objects error:(NSError **)error;
//+ (void)fetchAllInBackground:(NSArray *)objects block:(IQ_PFArrayResultBlock)block;
//+ (void)fetchAllInBackground:(NSArray *)objects target:(id)target selector:(SEL)selector;
//+ (void)fetchAllIfNeededInBackground:(NSArray *)objects block:(IQ_PFArrayResultBlock)block;
//+ (void)fetchAllIfNeededInBackground:(NSArray *)objects target:(id)target selector:(SEL)selector;

- (BOOL)delete
{
    return [self delete:nil];
}

- (BOOL)delete:(NSError **)error
{
    NSDictionary *result = [[IQPFHTTPService service] deleteObjectWithParseClass:self.parseClassName objectId:self.objectId error:error];
    
    if (result)
    {
        self.objectId = nil;
        _parseClassName = nil;
        [displayAttributes removeAllObjects];
        [needUpdateAttributes removeAllObjects];
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)deleteInBackground
{
    [self deleteInBackgroundWithBlock:NULL];
}

- (void)deleteInBackgroundWithBlock:(IQ_PFBooleanResultBlock)block
{
    __block IQURLConnection *connection = [[IQPFHTTPService service] deleteObjectWithParseClass:self.parseClassName objectId:self.objectId completionHandler:^(NSDictionary *result, NSError *error) {

        if (connection) [connectionSet removeObject:connection];

        if (result)
        {
            self.objectId = nil;
            _parseClassName = nil;
            [displayAttributes removeAllObjects];
            [needUpdateAttributes removeAllObjects];
        }
        
        if (block)
        {
            block((result!= nil),error);
        }
    }];
    
    if (connection) [connectionSet addObject:connection];
}

- (void)deleteInBackgroundWithTarget:(id)target selector:(SEL)selector
{
    [self deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[target methodSignatureForSelector:selector]];
        invocation.target = target;
        invocation.selector = selector;
        [invocation setArgument:&(succeeded) atIndex:2];
        [invocation setArgument:&error atIndex:3];
        [invocation invoke];
        
    }];
}

//- (void)deleteEventually;

//- (BOOL)isDirty;
//- (BOOL)isDirtyForKey:(NSString *)key;


//Private methods

+ (NSDateFormatter *)parseSDKDateFormatter
{
	NSMutableDictionary *dictionary = [[NSThread currentThread] threadDictionary];
	NSDateFormatter *formatter = dictionary[@"iso"];
    
	if (!formatter)
    {
		formatter = [[NSDateFormatter alloc] init];
		formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
		formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
		dictionary[@"iso"] = formatter;
	}
	return formatter;
}

+(NSString*)parseSDKStringFromDate:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [self parseSDKDateFormatter];
    
    return [dateFormatter stringFromDate:date];
}

+(NSDate*)parseSDKDateFromString:(NSString*)dateString
{
    NSDateFormatter *dateFormatter = [self parseSDKDateFormatter];
    
    return [dateFormatter dateFromString:dateString];
}

+(NSDictionary*)dateAttributeWithDate:(NSDate*)date
{
    return @{kParse__TypeKey: kParseDateKey,kParseISOKey:[self parseSDKStringFromDate:date]};
}

//Increment/Decrement Number Attribute
+(NSDictionary *)incrementAttribute
{
    return [self incrementAttributeByAmount:@1];
}

+(NSDictionary *)incrementAttributeByAmount:(NSNumber*)amount
{
    return @{kParse__OpKey:@"Increment",@"amount":amount};
}

+(NSDictionary*)addAttributeWithArray:(NSArray*)array
{
    return @{kParse__OpKey:@"Add",      kParseObjectsKey:array};
}

+(NSDictionary*)addUniqueAttributeWithArray:(NSArray*)array
{
    return @{kParse__OpKey:@"AddUnique",kParseObjectsKey:array};
}

+(NSDictionary*)removeAttributeWithArray:(NSArray*)array
{
    return @{kParse__OpKey:@"Remove",   kParseObjectsKey:array};
}

//Batch operation creation
+(NSDictionary*)batchOperationWithMethod:(NSString*)method path:(NSString*)path body:(NSDictionary*)body
{
    return @{kParseMethodKey: method, kParsePathKey: path, kParseBodyKey:body};
}



@end
