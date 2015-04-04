//
//  IQ_PFConstants.h
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

#import <objc/objc.h>

@class NSDictionary, NSError, NSArray, NSString;
@class IQ_PFUser, IQ_PFObject;

//typedef enum {
//    kIQ_PFCachePolicyIgnoreCache = 0,
//    kIQ_PFCachePolicyCacheOnly,
//    kIQ_PFCachePolicyNetworkOnly,
//    kIQ_PFCachePolicyCacheElseNetwork,
//    kIQ_PFCachePolicyNetworkElseCache,
//    kIQ_PFCachePolicyCacheThenNetwork
//} IQ_PFCachePolicy;


typedef void (^IQ_PFBooleanResultBlock)     (BOOL succeeded,        NSError *error);
typedef void (^IQ_PFIntegerResultBlock)     (int number,            NSError *error);
typedef void (^IQ_PFArrayResultBlock)       (NSArray *objects,      NSError *error);
typedef void (^IQ_PFObjectResultBlock)      (IQ_PFObject *object,   NSError *error);
typedef void (^IQ_PFSetResultBlock)         (NSSet *channels,       NSError *error);
typedef void (^IQ_PFUserResultBlock)        (IQ_PFUser *user,       NSError *error);
typedef void (^IQ_PFDataResultBlock)        (NSData *data,          NSError *error);
typedef void (^IQ_PFDataStreamResultBlock)  (NSInputStream *stream, NSError *error);
typedef void (^IQ_PFStringResultBlock)      (NSString *string,      NSError *error);
typedef void (^IQ_PFIdResultBlock)          (id object,             NSError *error);
typedef void (^IQ_PFProgressBlock)          (int percentDone);
