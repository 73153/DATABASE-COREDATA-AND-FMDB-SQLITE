//
//  IQ_PFUser.m
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

#import "IQ_PFUser.h"
#import "IQPFHTTPService.h"

@interface IQ_PFObject (Subclassing)

-(void)serializeAttributes:(NSDictionary*)result;

@end

@interface IQ_PFUser ()

@property (nonatomic, strong, readwrite) NSDate *updatedAt;
@property (nonatomic, strong, readwrite) NSDate *createdAt;

@end

@implementation IQ_PFUser

@synthesize updatedAt = _updatedAt, createdAt = _createdAt;

+ (NSString *)parseClassName
{
    return @"User";
}

IQ_PFUser *_currentUser;

+ (instancetype)currentUser
{
    return _currentUser;
}

+(void)setCurrentUser:(IQ_PFUser*)currentUser
{
    [[IQPFHTTPService service] addDefaultHeaderValue:[currentUser sessionToken] forHeaderField:kParse_X_Parse_Session_Token];

    _currentUser = currentUser;
}

-(void)serializeAttributes:(NSDictionary *)result
{
    [super serializeAttributes:result];
    
    if ([result objectForKey:kParseSessionTokenKey])
        self.sessionToken   =   [result objectForKey:kParseSessionTokenKey];
}

//@property (assign, readonly) BOOL isNew;

//- (BOOL)isAuthenticated;
+ (IQ_PFUser *)user
{
    return [[self alloc] init];
}

//+ (void)enableAutomaticUser;

- (BOOL)signUp
{
    return [self signUp:nil];
}

- (BOOL)signUp:(NSError **)error
{
    NSDictionary *userInfo = @{kParseUsernameKey: self.username, kParsePasswordKey:self.password};
    NSDictionary *result = [[IQPFHTTPService service] signUpUser:userInfo error:error];
    
    if ([result objectForKey:kParseSessionTokenKey])
    {
        [self serializeAttributes:result];

        return YES;
    }
    else
    {
        return NO;
    }
}

extern NSString *const kParseUsernameKey;
extern NSString *const kParsePasswordKey;

- (void)signUpInBackground
{
    [self signUpInBackgroundWithBlock:NULL];
}

- (void)signUpInBackgroundWithBlock:(IQ_PFBooleanResultBlock)block
{
    NSDictionary *userInfo = @{kParseUsernameKey: self.username, kParsePasswordKey:self.password};

    [[IQPFHTTPService service] signUpUser:userInfo completionHandler:^(NSDictionary *result, NSError *error) {

    }];
}

- (void)signUpInBackgroundWithTarget:(id)target selector:(SEL)selector
{
    [self signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {

        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[target methodSignatureForSelector:selector]];
        invocation.target = target;
        invocation.selector = selector;
        [invocation setArgument:&(succeeded) atIndex:2];
        [invocation setArgument:&error atIndex:3];
        [invocation invoke];

    }];
}

+ (instancetype)logInWithUsername:(NSString *)username password:(NSString *)password
{
    return [self logInWithUsername:username password:password error:nil];
}

+ (instancetype)logInWithUsername:(NSString *)username password:(NSString *)password error:(NSError **)error
{
    NSDictionary *userInfo = @{kParseUsernameKey: username, kParsePasswordKey:password};
    
    NSDictionary *result = [[IQPFHTTPService service] loginUser:userInfo error:error];

    if ([result objectForKey:kParseSessionTokenKey])
    {
        IQ_PFUser *user = [[IQ_PFUser alloc] init];
        [user serializeAttributes:result];
        
        [self setCurrentUser:user];
        
        return user;
    }
    else
    {
        return nil;
    }
}

+ (void)logInWithUsernameInBackground:(NSString *)username password:(NSString *)password
{
    [self logInWithUsernameInBackground:username password:password block:NULL];
}

+ (void)logInWithUsernameInBackground:(NSString *)username password:(NSString *)password target:(id)target selector:(SEL)selector
{
    [self logInWithUsernameInBackground:username password:password block:^(IQ_PFUser *user, NSError *error) {

        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[target methodSignatureForSelector:selector]];
        invocation.target = target;
        invocation.selector = selector;
        [invocation setArgument:&user atIndex:2];
        [invocation setArgument:&error atIndex:3];
        [invocation invoke];

    }];
}

+ (void)logInWithUsernameInBackground:(NSString *)username password:(NSString *)password block:(IQ_PFUserResultBlock)block
{
    NSDictionary *userInfo = @{kParseUsernameKey: username, kParsePasswordKey:password};

    [[IQPFHTTPService service] loginUser:userInfo completionHandler:^(NSDictionary *result, NSError *error) {

        IQ_PFUser *user;
        
        if ([result objectForKey:kParseSessionTokenKey])
        {
            user = [[IQ_PFUser alloc] init];
            [user serializeAttributes:result];

            [self setCurrentUser:user];
        }

        if (block)  block(user,error);
        
    }];
}

+ (instancetype)become:(NSString *)sessionToken
{
    return [self become:sessionToken error:nil];
}

+ (instancetype)become:(NSString *)sessionToken error:(NSError **)error
{
    NSDictionary *result = [[IQPFHTTPService service] validateAccessToken:@{kParse_X_Parse_Session_Token: sessionToken} error:error];
    
    if ([result objectForKey:kParseSessionTokenKey])
    {
        IQ_PFUser *user = [[IQ_PFUser alloc] init];
        [user serializeAttributes:result];
        
        [self setCurrentUser:user];
        return user;
    }
    else
    {
        return nil;
    }
}

+ (void)becomeInBackground:(NSString *)sessionToken
{
    [self becomeInBackground:sessionToken block:NULL];
}

+ (void)becomeInBackground:(NSString *)sessionToken target:(id)target selector:(SEL)selector
{
    [self becomeInBackground:sessionToken block:^(IQ_PFUser *user, NSError *error) {

        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[target methodSignatureForSelector:selector]];
        invocation.target = target;
        invocation.selector = selector;
        [invocation setArgument:&user atIndex:2];
        [invocation setArgument:&error atIndex:3];
        [invocation invoke];

    }];
}

+ (void)becomeInBackground:(NSString *)sessionToken block:(IQ_PFUserResultBlock)block
{
    [[IQPFHTTPService service] validateAccessToken:@{kParse_X_Parse_Session_Token: sessionToken} completionHandler:^(NSDictionary *result, NSError *error) {

        IQ_PFUser *user;
        
        if ([result objectForKey:kParseSessionTokenKey])
        {
            user = [[IQ_PFUser alloc] init];
            [user serializeAttributes:result];
            
            [self setCurrentUser:user];
        }
        
        if (block)  block(user,error);

    }];
}

+ (void)logOut
{
    [self setCurrentUser:nil];
}

+ (BOOL)requestPasswordResetForEmail:(NSString *)email
{
    return [self requestPasswordResetForEmail:email error:nil];
}

+ (BOOL)requestPasswordResetForEmail:(NSString *)email error:(NSError **)error
{
    NSDictionary *dict = @{kParseEmailKey: email};
    
    NSDictionary *result = [[IQPFHTTPService service] requestPasswordReset:dict error:error];
    
    if (result)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (void)requestPasswordResetForEmailInBackground:(NSString *)email
{
    [self requestPasswordResetForEmailInBackground:email block:NULL];
}

+ (void)requestPasswordResetForEmailInBackground:(NSString *)email target:(id)target selector:(SEL)selector
{
    [self requestPasswordResetForEmailInBackground:email block:^(BOOL succeeded, NSError *error) {

        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[target methodSignatureForSelector:selector]];
        invocation.target = target;
        invocation.selector = selector;
        [invocation setArgument:&(succeeded) atIndex:2];
        [invocation setArgument:&error atIndex:3];
        [invocation invoke];

    }];
}

+ (void)requestPasswordResetForEmailInBackground:(NSString *)email block:(IQ_PFBooleanResultBlock)block
{
    NSDictionary *dict = @{kParseEmailKey: email};

    [[IQPFHTTPService service] requestPasswordReset:dict completionHandler:^(NSDictionary *result, NSError *error) {

        if (result)
        {
            if (block)  block(YES,error);
        }
        else
        {
            if (block)  block(NO,error);
        }

    }];
}

//+ (IQ_PFQuery *)query;

@end











