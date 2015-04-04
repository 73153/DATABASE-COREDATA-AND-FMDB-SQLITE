//
//  IQPFHTTPService.m
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


#import "IQPFHTTPService.h"
#import "IQURLConnection.h"

@implementation IQPFHTTPService

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setLogEnabled:YES];
        [self setParameterType:IQRequestParameterTypeApplicationJSON];
        [self setServerURL:@"https://api.parse.com/1/"];
        
        [self setDefaultContentType:kIQContentTypeApplicationJson];
    }
    return self;
}

#pragma mark -
#pragma mark - Objects

-(IQURLConnection*)objectsWithParseClass:(NSString*)parseClassName urlParameter:(NSDictionary*)urlParameter completionHandler:(IQDictionaryCompletionBlock)completion
{
    return [self objectsWithParseClass:parseClassName urlParameter:urlParameter objectId:nil completionHandler:completion];
}

-(IQURLConnection*)objectsWithParseClass:(NSString*)parseClassName urlParameter:(NSDictionary*)urlParameter objectId:(NSString*)objectId completionHandler:(IQDictionaryCompletionBlock)completion
{
    NSMutableString *path = [[NSMutableString alloc] initWithFormat:@"classes/%@",parseClassName];
    
    if (objectId)   [path appendFormat:@"/%@",objectId];
    
    return [self requestWithPath:path httpMethod:kIQHTTPMethodGET parameter:urlParameter completionHandler:completion];
}

-(NSDictionary*)objectsWithParseClass:(NSString*)parseClassName urlParameter:(NSDictionary*)urlParameter error:(NSError**)error
{
    return [self objectsWithParseClass:parseClassName urlParameter:urlParameter objectId:nil error:error];
}

-(NSDictionary*)objectsWithParseClass:(NSString*)parseClassName urlParameter:(NSDictionary*)urlParameter objectId:(NSString*)objectId error:(NSError**)error
{
    NSMutableString *path = [[NSMutableString alloc] initWithFormat:@"classes/%@",parseClassName];
    
    if (objectId)   [path appendFormat:@"/%@",objectId];
    
    return [self synchronousRequestWithPath:path httpMethod:kIQHTTPMethodGET parameter:urlParameter error:error];
}

-(IQURLConnection*)createObjectWithParseClass:(NSString*)parseClassName attributes:(NSDictionary*)attributes completionHandler:(IQDictionaryCompletionBlock)completion
{
    NSString *path = [NSString stringWithFormat:@"classes/%@",parseClassName];
    
    return [self requestWithPath:path httpMethod:kIQHTTPMethodPOST parameter:attributes completionHandler:completion];
}

-(NSDictionary*)createObjectWithParseClass:(NSString*)parseClassName attributes:(NSDictionary*)attributes error:(NSError**)error
{
    NSString *path = [NSString stringWithFormat:@"classes/%@",parseClassName];
    
    return [self synchronousRequestWithPath:path httpMethod:kIQHTTPMethodPOST parameter:attributes error:error];
}

-(IQURLConnection*)updateObjectWithParseClass:(NSString*)parseClassName objectId:(NSString*)objectId attributes:(NSDictionary*)attributes completionHandler:(IQDictionaryCompletionBlock)completion
{
    NSString *path = [NSString stringWithFormat:@"classes/%@/%@",parseClassName,objectId];
    
    return [self requestWithPath:path httpMethod:kIQHTTPMethodPUT parameter:attributes completionHandler:completion];
}

-(NSDictionary*)updateObjectWithParseClass:(NSString*)parseClassName objectId:(NSString*)objectId attributes:(NSDictionary*)attributes error:(NSError**)error
{
    NSString *path = [NSString stringWithFormat:@"classes/%@/%@",parseClassName,objectId];
    
    return [self synchronousRequestWithPath:path httpMethod:kIQHTTPMethodPUT parameter:attributes error:error];
}

-(IQURLConnection*)deleteObjectWithParseClass:(NSString*)parseClassName objectId:(NSString*)objectId completionHandler:(IQDictionaryCompletionBlock)completion
{
    NSMutableString *path = [[NSMutableString alloc] initWithFormat:@"classes/%@",parseClassName];
    
    if (objectId)   [path appendFormat:@"/%@",objectId];
    
    return [self requestWithPath:path httpMethod:kIQHTTPMethodDELETE parameter:nil completionHandler:completion];
}

-(IQURLConnection*)deleteField:(NSString*)fieldName WithParseClass:(NSString*)parseClassName objectId:(NSString*)objectId completionHandler:(IQDictionaryCompletionBlock)completion
{
    NSMutableString *path = [[NSMutableString alloc] initWithFormat:@"classes/%@",parseClassName];
    
    if (objectId)   [path appendFormat:@"/%@",objectId];
    
    NSDictionary *deleteFieldDict = @{fieldName: [[self class] deleteFieldAttribute]};
    
    return [self requestWithPath:path httpMethod:kIQHTTPMethodPUT parameter:deleteFieldDict completionHandler:completion];
}

-(NSDictionary*)deleteObjectWithParseClass:(NSString*)parseClassName objectId:(NSString*)objectId error:(NSError**)error
{
    NSMutableString *path = [[NSMutableString alloc] initWithFormat:@"classes/%@",parseClassName];
    
    if (objectId)   [path appendFormat:@"/%@",objectId];
    
    return [self synchronousRequestWithPath:path httpMethod:kIQHTTPMethodDELETE parameter:nil error:error];
}

-(NSDictionary*)deleteField:(NSString*)fieldName WithParseClass:(NSString*)parseClassName objectId:(NSString*)objectId error:(NSError**)error
{
    NSMutableString *path = [[NSMutableString alloc] initWithFormat:@"classes/%@",parseClassName];
    
    if (objectId)   [path appendFormat:@"/%@",objectId];
    
    NSDictionary *deleteFieldDict = @{fieldName: [[self class] deleteFieldAttribute]};
    
    return [self synchronousRequestWithPath:path httpMethod:kIQHTTPMethodPUT parameter:deleteFieldDict error:error];
}

-(IQURLConnection*)performBatchOperations:(NSArray*)operations completionHandler:(IQDictionaryCompletionBlock)completion
{
    NSDictionary *dictRequests = @{kParseRequestsKey: operations};
    
    return [self requestWithPath:@"batch" httpMethod:kIQHTTPMethodPOST parameter:dictRequests completionHandler:completion];
}


#pragma mark -
#pragma mark - Queries

-(IQURLConnection*)queryWithParseClass:(NSString*)parseClassName query:(NSDictionary*)query completionHandler:(IQDictionaryCompletionBlock)completion
{
    return [self objectsWithParseClass:parseClassName urlParameter:query completionHandler:completion];
}

-(NSDictionary*)queryWithParseClass:(NSString*)parseClassName query:(NSDictionary*)query error:(NSError**)error
{
    return [self objectsWithParseClass:parseClassName urlParameter:query error:error];
}

#pragma mark -
#pragma mark - Users

-(IQURLConnection*)signUpUser:(NSDictionary*)userInfo completionHandler:(IQDictionaryCompletionBlock)completion
{
    return [self requestWithPath:@"users" httpMethod:kIQHTTPMethodPOST parameter:userInfo completionHandler:completion];
}

-(NSDictionary*)signUpUser:(NSDictionary*)userInfo error:(NSError**)error
{
    return [self synchronousRequestWithPath:@"users" httpMethod:kIQHTTPMethodPOST parameter:userInfo error:error];
}

-(IQURLConnection*)loginUser:(NSDictionary*)userInfo completionHandler:(IQDictionaryCompletionBlock)completion
{
    return [self requestWithPath:@"login" httpMethod:kIQHTTPMethodGET parameter:userInfo completionHandler:completion];
}

-(NSDictionary*)loginUser:(NSDictionary*)userInfo error:(NSError**)error
{
    return [self synchronousRequestWithPath:@"login" httpMethod:kIQHTTPMethodGET parameter:userInfo error:error];
}

-(IQURLConnection*)requestPasswordReset:(NSDictionary*)emailInfo completionHandler:(IQDictionaryCompletionBlock)completion
{
    return [self requestWithPath:@"requestPasswordReset" httpMethod:kIQHTTPMethodPOST parameter:emailInfo completionHandler:completion];
}

-(NSDictionary*)requestPasswordReset:(NSDictionary*)emailInfo error:(NSError**)error
{
    return [self synchronousRequestWithPath:@"requestPasswordReset" httpMethod:kIQHTTPMethodPOST parameter:emailInfo error:error];
}

-(IQURLConnection*)validateAccessToken:(NSDictionary*)accessTokenInfo completionHandler:(IQDictionaryCompletionBlock)completion
{
    [self addDefaultHeaderValue:[accessTokenInfo objectForKey:kParse_X_Parse_Session_Token] forHeaderField:kParse_X_Parse_Session_Token];
    IQURLConnection * connection = [self requestWithPath:@"users/me" httpMethod:kIQHTTPMethodGET parameter:accessTokenInfo completionHandler:completion];
    [self addDefaultHeaderValue:nil forHeaderField:kParse_X_Parse_Session_Token];
    
    return connection;
}

-(NSDictionary*)validateAccessToken:(NSDictionary*)accessTokenInfo error:(NSError**)error
{
    [self addDefaultHeaderValue:[accessTokenInfo objectForKey:kParse_X_Parse_Session_Token] forHeaderField:kParse_X_Parse_Session_Token];
    NSDictionary *dict = [self synchronousRequestWithPath:@"users/me" httpMethod:kIQHTTPMethodGET parameter:accessTokenInfo error:error];
    [self addDefaultHeaderValue:nil forHeaderField:kParse_X_Parse_Session_Token];
    
    return dict;
}

-(IQURLConnection*)updateUser:(NSDictionary*)userInfo objectId:(NSString*)objectId completionHandler:(IQDictionaryCompletionBlock)completion
{
    NSString *path = [NSString stringWithFormat:@"users/%@",objectId];
    
    return [self requestWithPath:path httpMethod:kIQHTTPMethodPUT parameter:userInfo completionHandler:completion];
}

-(NSDictionary*)updateUser:(NSDictionary*)userInfo objectId:(NSString*)objectId error:(NSError**)error
{
    NSString *path = [NSString stringWithFormat:@"users/%@",objectId];
    
    return [self synchronousRequestWithPath:path httpMethod:kIQHTTPMethodPUT parameter:userInfo error:error];
}

-(IQURLConnection*)deleteUserWithObjectId:(NSString*)objectId completionHandler:(IQDictionaryCompletionBlock)completion
{
    NSString *path = [NSString stringWithFormat:@"users/%@",objectId];
    
    return [self requestWithPath:path httpMethod:kIQHTTPMethodDELETE parameter:nil completionHandler:completion];
}

-(NSDictionary*)deleteUserWithObjectId:(NSString*)objectId error:(NSError**)error
{
    NSString *path = [NSString stringWithFormat:@"users/%@",objectId];
    
    return [self synchronousRequestWithPath:path httpMethod:kIQHTTPMethodDELETE parameter:nil error:error];
}


#pragma mark -
#pragma mark - Cloud Code

-(IQURLConnection*)callFunction:(NSString*)function withParameters:(NSDictionary *)parameters completionHandler:(IQDataCompletionBlock)completion
{
    NSString *path = [NSString stringWithFormat:@"functions/%@",function];
    
    return [self requestWithPath:path httpMethod:kIQHTTPMethodPOST parameter:parameters dataCompletionHandler:completion];
}

-(NSData*)callFunction:(NSString*)function withParameters:(NSDictionary *)parameters error:(NSError**)error
{
    NSString *path = [NSString stringWithFormat:@"functions/%@",function];
    
    return [self synchronousDataRequestWithPath:path httpMethod:kIQHTTPMethodPOST parameter:parameters error:error];
}

#pragma mark -
#pragma mark - Files

-(IQURLConnection*)saveFileData:(NSData*)data fileName:(NSString*)fileName contentType:(NSString*)contentType uploadProgressBlock:(IQProgressBlock)uploadProgress completionHandler:(IQDictionaryCompletionBlock)completion
{
    NSString *path = [NSString stringWithFormat:@"files/%@",fileName];
    
    IQURLConnection *connection = [self requestWithPath:path httpMethod:kIQHTTPMethodPOST contentType:contentType httpBody:data completionHandler:completion];
    connection.uploadProgressBlock = uploadProgress;
    
    return connection;
}

-(IQURLConnection*)getDataWithFileUrl:(NSURL*)url downloadProgressBlock:(IQProgressBlock)downloadProgress completionHandler:(IQDataCompletionBlock)completion
{
    IQURLConnection *connection = [self requestWithURL:url httpMethod:kIQHTTPMethodGET contentType:Nil httpBody:nil dataCompletionHandler:completion];
    connection.downloadProgressBlock = downloadProgress;
    
    return connection;
}

-(NSDictionary*)saveFileData:(NSData*)data fileName:(NSString*)fileName contentType:(NSString*)contentType error:(NSError**)error
{
    NSString *path = [NSString stringWithFormat:@"files/%@",fileName];
    
    return [self synchronousRequestWithPath:path httpMethod:kIQHTTPMethodPOST contentType:contentType httpBody:data error:error];
}

-(NSData*)getDataWithFileUrl:(NSURL*)url error:(NSError**)error
{
    return [self synchronousRequestWithURL:url httpMethod:kIQHTTPMethodGET contentType:nil httpBody:nil error:error];
}

#pragma mark -
#pragma mark - Helper

+(NSDictionary*)deleteFieldAttribute
{
    return @{kParse__OpKey:@"Delete"};
}




@end

