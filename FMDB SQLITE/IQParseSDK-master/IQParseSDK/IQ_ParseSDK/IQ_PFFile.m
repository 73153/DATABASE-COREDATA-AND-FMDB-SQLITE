//
//  IQ_PFFile.m
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

#import "IQ_PFFile.h"
#import "IQPFHTTPService.h"
#import "IQURLConnection.h"
#import <Foundation/NSData.h>
#import <Foundation/NSDictionary.h>

NSString *const kParseFileContentTypeImage  =   @"image/jpeg";
NSString *const kParseFileContentTypeText   =   @"text/plain";


@implementation IQ_PFFile
{
	NSData *_data;
    NSString *_contentType;
    
    NSMutableSet *connectionSet;
}

-(instancetype)initWithfileName:(NSString *)name data:(NSData *)data contentType:(NSString *)contentType
{
    self = [self init];
    if (self)
    {
        connectionSet = [[NSMutableSet alloc] init];
        
        _data = data;
        _contentType = contentType;
        _name = name;
        
        if ([name length] == 0)
        {
            if ([contentType isEqualToString:kParseFileContentTypeImage])       _name = @"image.jpg";
            else if ([contentType isEqualToString:kParseFileContentTypeText])   _name = @"text.txt";
            else                                                                _name = @"file";
        }
    }
    
    return self;
}

-(NSDictionary*)coreSerializedAttribute
{
    return @{ kParse__TypeKey: kParseFileKey, kParseNameKey: _name};
}

-(void)serializeAttributes:(NSDictionary*)result
{
    _url = [result objectForKey:kParseUrlKey];
    _name = [result objectForKey:kParseNameKey];
}

//+ (instancetype)fileWithData:(NSData *)data;
//+ (instancetype)fileWithName:(NSString *)name data:(NSData *)data;
//+ (instancetype)fileWithName:(NSString *)name contentsAtPath:(NSString *)path;

+ (instancetype)fileWithName:(NSString *)name data:(NSData *)data contentType:(NSString *)contentType
{
    return [[self alloc] initWithfileName:name data:data contentType:contentType];
}

+ (instancetype)fileWithData:(NSData *)data contentType:(NSString *)contentType
{
    return [[self alloc] initWithfileName:nil data:data contentType:contentType];
}

- (BOOL)save
{
    return [self save:nil];
}

- (BOOL)save:(NSError **)error
{
    NSDictionary *result = [[IQPFHTTPService service] saveFileData:_data fileName:self.name contentType:_contentType error:error];
    
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
    [self saveInBackgroundWithBlock:block progressBlock:NULL];
}

- (void)saveInBackgroundWithBlock:(IQ_PFBooleanResultBlock)block progressBlock:(IQ_PFProgressBlock)progressBlock
{
    __block IQURLConnection *connection = [[IQPFHTTPService service] saveFileData:_data fileName:self.name contentType:_contentType uploadProgressBlock:^(CGFloat progress) {
        
        if (progressBlock)
        {
            progressBlock(progress*100);
        }
        
    } completionHandler:^(NSDictionary *result, NSError *error) {

        if (connection) [connectionSet removeObject:connection];
        
        if (result)
        {
            [self serializeAttributes:result];
        }
        
        block(result!=nil, error);
    }];
    
    if (connection) [connectionSet addObject:connection];
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

    } progressBlock:NULL];
}

-(BOOL)isDataAvailable
{
    return (_data!=nil);
}

- (NSData *)getData
{
    return [self getData:nil];
}

//- (NSInputStream *)getDataStream;

- (NSData *)getData:(NSError **)error
{
    if (_data == nil)
    {
        _data = [[IQPFHTTPService service] getDataWithFileUrl:[NSURL URLWithString:_url] error:error];
    }

    return _data;
}

//- (NSInputStream *)getDataStream:(NSError **)error;

- (void)getDataInBackgroundWithBlock:(IQ_PFDataResultBlock)block
{
    [self getDataInBackgroundWithBlock:block progressBlock:NULL];
}

//- (void)getDataStreamInBackgroundWithBlock:(IQ_PFDataStreamResultBlock)block;

- (void)getDataInBackgroundWithBlock:(IQ_PFDataResultBlock)resultBlock progressBlock:(IQ_PFProgressBlock)progressBlock
{
    if (_data)
    {
        resultBlock(_data,nil);
    }
    else
    {
        __block IQURLConnection *connection = [[IQPFHTTPService service] getDataWithFileUrl:[NSURL URLWithString:_url] downloadProgressBlock:^(CGFloat progress) {
            
            if (progressBlock)
            {
                progressBlock(progress*100);
            }
            
        } completionHandler:^(NSData *result, NSError *error) {
            
            if (connection) [connectionSet removeObject:connection];
            
            if (result)
            {
                _data = result;
            }
            
            resultBlock(result, error);
        }];
        
        if (connection) [connectionSet addObject:connection];
    }
}

//- (void)getDataStreamInBackgroundWithBlock:(IQ_PFDataStreamResultBlock)resultBlock progressBlock:(IQ_PFProgressBlock)progressBlock;

- (void)getDataInBackgroundWithTarget:(id)target selector:(SEL)selector
{
    [self getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {

        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[target methodSignatureForSelector:selector]];
        invocation.target = target;
        invocation.selector = selector;
        [invocation setArgument:&data atIndex:2];
        [invocation setArgument:&error atIndex:3];
        [invocation invoke];
        
    } progressBlock:NULL];
}

- (void)cancel
{
    while ([connectionSet count])
    {
        IQURLConnection *connection = [connectionSet anyObject];
        [connection cancel];
        [connectionSet removeObject:connection];
    }
}


@end
