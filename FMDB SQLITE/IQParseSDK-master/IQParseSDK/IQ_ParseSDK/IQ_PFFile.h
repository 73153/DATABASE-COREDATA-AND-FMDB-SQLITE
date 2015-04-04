//
//  IQ_PFFile.h
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

#import <Foundation/NSObject.h>
#import "IQ_PFConstants.h"

extern NSString *const kParseFileContentTypeImage;
extern NSString *const kParseFileContentTypeText;

@class NSData;

@interface IQ_PFFile : NSObject

//+ (instancetype)fileWithData:(NSData *)data;
//+ (instancetype)fileWithName:(NSString *)name data:(NSData *)data;
//+ (instancetype)fileWithName:(NSString *)name contentsAtPath:(NSString *)path;
+ (instancetype)fileWithName:(NSString *)name data:(NSData *)data contentType:(NSString *)contentType;
+ (instancetype)fileWithData:(NSData *)data contentType:(NSString *)contentType;

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *url;

//@property (nonatomic, assign, readonly) BOOL isDirty;

- (BOOL)save;
- (BOOL)save:(NSError **)error;
- (void)saveInBackground;
- (void)saveInBackgroundWithBlock:(IQ_PFBooleanResultBlock)block;
- (void)saveInBackgroundWithBlock:(IQ_PFBooleanResultBlock)block progressBlock:(IQ_PFProgressBlock)progressBlock;
- (void)saveInBackgroundWithTarget:(id)target selector:(SEL)selector;

@property (assign, readonly) BOOL isDataAvailable;

- (NSData *)getData;
//- (NSInputStream *)getDataStream;
- (NSData *)getData:(NSError **)error;
//- (NSInputStream *)getDataStream:(NSError **)error;
- (void)getDataInBackgroundWithBlock:(IQ_PFDataResultBlock)block;
//- (void)getDataStreamInBackgroundWithBlock:(IQ_PFDataStreamResultBlock)block;
- (void)getDataInBackgroundWithBlock:(IQ_PFDataResultBlock)resultBlock progressBlock:(IQ_PFProgressBlock)progressBlock;
//- (void)getDataStreamInBackgroundWithBlock:(IQ_PFDataStreamResultBlock)resultBlock progressBlock:(IQ_PFProgressBlock)progressBlock;
- (void)getDataInBackgroundWithTarget:(id)target selector:(SEL)selector;

- (void)cancel;

@end
