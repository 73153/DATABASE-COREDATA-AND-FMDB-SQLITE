//
//  IQ_PFUser.h
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

@class IQ_PFQuery;

@interface IQ_PFUser : IQ_PFObject

+ (NSString *)parseClassName;
+ (instancetype)currentUser;

@property (nonatomic, strong) NSString *sessionToken;

//@property (assign, readonly) BOOL isNew;

//- (BOOL)isAuthenticated;
+ (IQ_PFUser *)user;
//+ (void)enableAutomaticUser;

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *email;

- (BOOL)signUp;
- (BOOL)signUp:(NSError **)error;
- (void)signUpInBackground;
- (void)signUpInBackgroundWithBlock:(IQ_PFBooleanResultBlock)block;
- (void)signUpInBackgroundWithTarget:(id)target selector:(SEL)selector;

+ (instancetype)logInWithUsername:(NSString *)username password:(NSString *)password;
+ (instancetype)logInWithUsername:(NSString *)username password:(NSString *)password error:(NSError **)error;
+ (void)logInWithUsernameInBackground:(NSString *)username password:(NSString *)password;
+ (void)logInWithUsernameInBackground:(NSString *)username password:(NSString *)password target:(id)target selector:(SEL)selector;
+ (void)logInWithUsernameInBackground:(NSString *)username password:(NSString *)password block:(IQ_PFUserResultBlock)block;
+ (instancetype)become:(NSString *)sessionToken;
+ (instancetype)become:(NSString *)sessionToken error:(NSError **)error;
+ (void)becomeInBackground:(NSString *)sessionToken;
+ (void)becomeInBackground:(NSString *)sessionToken target:(id)target selector:(SEL)selector;
+ (void)becomeInBackground:(NSString *)sessionToken block:(IQ_PFUserResultBlock)block;

+ (void)logOut;

+ (BOOL)requestPasswordResetForEmail:(NSString *)email;
+ (BOOL)requestPasswordResetForEmail:(NSString *)email error:(NSError **)error;
+ (void)requestPasswordResetForEmailInBackground:(NSString *)email;
+ (void)requestPasswordResetForEmailInBackground:(NSString *)email target:(id)target selector:(SEL)selector;
+ (void)requestPasswordResetForEmailInBackground:(NSString *)email block:(IQ_PFBooleanResultBlock)block;

//+ (IQ_PFQuery *)query;

@end
