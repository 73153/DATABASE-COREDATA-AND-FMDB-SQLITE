//
//  IQ_Parse.h
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

#import <Foundation/Foundation.h>

#import "IQ_PFACL.h"
#import "IQ_PFCloud.h"
#import "IQ_PFConstants.h"
#import "IQ_PFFile.h"
#import "IQ_PFGeoPoint.h"
#import "IQ_PFImageView.h"
#import "IQ_PFObject.h"
#import "IQ_PFQuery.h"
#import "IQ_PFRelation.h"
#import "IQ_PFRole.h"
#import "IQ_PFUser.h"

@interface IQ_Parse : NSObject

+ (void)setApplicationId:(NSString *)applicationId restAPIKey:(NSString *)restAPIKey;
+ (NSString *)getApplicationId;
+ (NSString *)getRestAPIKey;

//+ (void)offlineMessagesEnabled:(BOOL)enabled;
//+ (void)errorMessagesEnabled:(BOOL)enabled;

@end
