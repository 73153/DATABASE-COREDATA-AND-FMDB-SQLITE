//
//  IQPFHTTPService.h
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


#import "IQHTTPService.h"
#import "IQPFHTTPServiceConstants.h"

@interface IQPFHTTPService : IQHTTPService

#pragma mark -
#pragma mark - Objects

//Creating Objects
-(IQURLConnection*)createObjectWithParseClass:(NSString*)parseClassName attributes:(NSDictionary*)attributes completionHandler:(IQDictionaryCompletionBlock)completion;
-(NSDictionary*)createObjectWithParseClass:(NSString*)parseClassName attributes:(NSDictionary*)attributes error:(NSError**)error;

//Retrieving Objects
-(IQURLConnection*)objectsWithParseClass:(NSString*)parseClassName urlParameter:(NSDictionary*)urlParameter completionHandler:(IQDictionaryCompletionBlock)completion;
-(NSDictionary*)objectsWithParseClass:(NSString*)parseClassName urlParameter:(NSDictionary*)urlParameter error:(NSError**)error;
-(IQURLConnection*)objectsWithParseClass:(NSString*)parseClassName urlParameter:(NSDictionary*)urlParameter objectId:(NSString*)objectId completionHandler:(IQDictionaryCompletionBlock)completion;
-(NSDictionary*)objectsWithParseClass:(NSString*)parseClassName urlParameter:(NSDictionary*)urlParameter objectId:(NSString*)objectId error:(NSError**)error;

//Updating Objects
-(IQURLConnection*)updateObjectWithParseClass:(NSString*)parseClassName objectId:(NSString*)objectId attributes:(NSDictionary*)attributes completionHandler:(IQDictionaryCompletionBlock)completion;
-(NSDictionary*)updateObjectWithParseClass:(NSString*)parseClassName objectId:(NSString*)objectId attributes:(NSDictionary*)attributes error:(NSError**)error;

//Deleting Objects
-(IQURLConnection*)deleteObjectWithParseClass:(NSString*)parseClassName objectId:(NSString*)objectId completionHandler:(IQDictionaryCompletionBlock)completion;
-(NSDictionary*)deleteObjectWithParseClass:(NSString*)parseClassName objectId:(NSString*)objectId  error:(NSError**)error;
-(IQURLConnection*)deleteField:(NSString*)fieldName WithParseClass:(NSString*)parseClassName objectId:(NSString*)objectId completionHandler:(IQDictionaryCompletionBlock)completion;
-(NSDictionary*)deleteField:(NSString*)fieldName WithParseClass:(NSString*)parseClassName objectId:(NSString*)objectId error:(NSError**)error;

//Batch Operations
-(IQURLConnection*)performBatchOperations:(NSArray*)operations completionHandler:(IQDictionaryCompletionBlock)completion;

#pragma mark -
#pragma mark - Query

//Query
-(IQURLConnection*)queryWithParseClass:(NSString*)parseClassName query:(NSDictionary*)query completionHandler:(IQDictionaryCompletionBlock)completion;
-(NSDictionary*)queryWithParseClass:(NSString*)parseClassName query:(NSDictionary*)query error:(NSError**)error;

#pragma mark -
#pragma mark - Users

//Signing Up
-(IQURLConnection*)signUpUser:(NSDictionary*)userInfo completionHandler:(IQDictionaryCompletionBlock)completion;
-(NSDictionary*)signUpUser:(NSDictionary*)userInfo error:(NSError**)error;

//Logging In
-(IQURLConnection*)loginUser:(NSDictionary*)userInfo completionHandler:(IQDictionaryCompletionBlock)completion;
-(NSDictionary*)loginUser:(NSDictionary*)userInfo error:(NSError**)error;

//Requesting A Password Reset
-(IQURLConnection*)requestPasswordReset:(NSDictionary*)emailInfo completionHandler:(IQDictionaryCompletionBlock)completion;
-(NSDictionary*)requestPasswordReset:(NSDictionary*)emailInfo error:(NSError**)error;

//Validate AccessToken
-(IQURLConnection*)validateAccessToken:(NSDictionary*)accessTokenInfo completionHandler:(IQDictionaryCompletionBlock)completion;
-(NSDictionary*)validateAccessToken:(NSDictionary*)accessTokenInfo error:(NSError**)error;

//Updating Users
-(IQURLConnection*)updateUser:(NSDictionary*)userInfo objectId:(NSString*)objectId completionHandler:(IQDictionaryCompletionBlock)completion;
-(NSDictionary*)updateUser:(NSDictionary*)userInfo objectId:(NSString*)objectId error:(NSError**)error;

//Deleting Users
-(IQURLConnection*)deleteUserWithObjectId:(NSString*)objectId completionHandler:(IQDictionaryCompletionBlock)completion;
-(NSDictionary*)deleteUserWithObjectId:(NSString*)objectId error:(NSError**)error;

#pragma mark -
#pragma mark - Cloud Code

//Call Parse Function
-(IQURLConnection*)callFunction:(NSString*)function withParameters:(NSDictionary *)parameters completionHandler:(IQDataCompletionBlock)completion;
-(NSData*)callFunction:(NSString*)function withParameters:(NSDictionary *)parameters error:(NSError**)error;

#pragma mark -
#pragma mark - Files

//Save File
-(IQURLConnection*)saveFileData:(NSData*)data fileName:(NSString*)fileName contentType:(NSString*)contentType uploadProgressBlock:(IQProgressBlock)uploadProgress completionHandler:(IQDictionaryCompletionBlock)completion;
-(NSDictionary*)saveFileData:(NSData*)data fileName:(NSString*)fileName contentType:(NSString*)contentType error:(NSError**)error;

//Get File
-(IQURLConnection*)getDataWithFileUrl:(NSURL*)url downloadProgressBlock:(IQProgressBlock)downloadProgress completionHandler:(IQDataCompletionBlock)completion;
-(NSData*)getDataWithFileUrl:(NSURL*)url error:(NSError**)error;


@end








