//
//  IQHTTPService.h
// https://github.com/hackiftekhar/IQHTTPService
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
#import "IQHTTPConstants.h"

@class IQURLConnection;

@interface IQHTTPService : NSObject

@property(nonatomic, assign, getter = isLogEnabled) BOOL logEnabled;
@property(nonatomic, assign) IQRequestParameterType parameterType;
@property(nonatomic, retain) NSString *defaultContentType;
@property(nonatomic, retain) NSString *serverURL;
@property(nonatomic, retain) NSData *startBodyData;
@property(nonatomic, retain) NSData *endBodyData;

-(NSString*)headerForField:(NSString*)headerField;
-(void)addDefaultHeaderValue:(NSString*)header forHeaderField:(NSString*)headerField;
-(void)removeDefaultHeaderForField:(NSString*)headerField;
-(void)setAuthorizationHeaderWithUsername:(NSString *)username password:(NSString *)password;
-(void)setAuthorizationHeaderWithToken:(NSString *)token;


//Shared Instance
+(instancetype)service;

/************************************************/
#pragma mark -
#pragma mark - Asynchronous Requests

//Simple request
-(IQURLConnection*)requestWithPath:(NSString*)path
                        httpMethod:(NSString*)method
                         parameter:(NSDictionary*)parameter
                 completionHandler:(IQDictionaryCompletionBlock)completionHandler;

-(IQURLConnection*)requestWithPath:(NSString*)path
                        httpMethod:(NSString*)method
                         parameter:(NSDictionary*)parameter
             dataCompletionHandler:(IQDataCompletionBlock)completionHandler;
/************************************************/

//Request with content-Type and body
-(IQURLConnection*)requestWithPath:(NSString*)path
                        httpMethod:(NSString*)method
                       contentType:(NSString*)contentType
                          httpBody:(NSData*)httpBody
                 completionHandler:(IQDictionaryCompletionBlock)completionHandler;

-(IQURLConnection*)requestWithPath:(NSString*)path
                        httpMethod:(NSString*)method
                       contentType:(NSString*)contentType
                          httpBody:(NSData*)httpBody
             dataCompletionHandler:(IQDataCompletionBlock)completionHandler;
/************************************************/

//Request with URL
-(IQURLConnection*)requestWithURL:(NSURL*)url
                       httpMethod:(NSString*)method
                      contentType:(NSString*)contentType
                         httpBody:(NSData*)httpBody
            dataCompletionHandler:(IQDataCompletionBlock)completionHandler;
/************************************************/

//File Upload Request
-(IQURLConnection*)requestWithPath:(NSString*)path
                         parameter:(NSDictionary*)parameter
             dataConstructionBlock:(IQMultipartFormDataConstructionBlock)dataConstructionBlock
               uploadProgressBlock:(IQProgressBlock)uploadProgress
                 completionHandler:(IQDictionaryCompletionBlock)completionHandler;
/************************************************/


#pragma mark -
#pragma mark - Synchronous Requests
//Synchronous request
-(NSDictionary*)synchronousRequestWithPath:(NSString*)path
                                httpMethod:(NSString*)method
                                 parameter:(NSDictionary*)parameter
                                     error:(NSError**)error;

-(NSData*)synchronousDataRequestWithPath:(NSString*)path
                              httpMethod:(NSString*)method
                               parameter:(NSDictionary*)parameter
                                   error:(NSError**)error;

-(NSDictionary*)synchronousRequestWithPath:(NSString*)path
                                httpMethod:(NSString*)method
                               contentType:(NSString*)contentType
                                  httpBody:(NSData*)httpBody
                                     error:(NSError**)error;

-(NSData*)synchronousDataRequestWithPath:(NSString*)path
                              httpMethod:(NSString*)method
                             contentType:(NSString*)contentType
                                httpBody:(NSData*)httpBody
                                   error:(NSError**)error;

-(NSData*)synchronousRequestWithURL:(NSURL*)url
                         httpMethod:(NSString*)method
                        contentType:(NSString*)contentType
                           httpBody:(NSData*)httpBody
                              error:(NSError**)error;
/************************************************/


@end
