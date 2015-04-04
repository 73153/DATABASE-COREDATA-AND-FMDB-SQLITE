//
//  IQHTTPService.m
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


#import "IQHTTPService.h"
#import "IQURLConnection.h"
#import "IQMultipartFormData.h"

@implementation IQHTTPService
{
    NSMutableDictionary *defaultHeaders;
}

@synthesize logEnabled = _logEnabled;

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        defaultHeaders = [[NSMutableDictionary alloc] init];
    }
    return self;
}

+(instancetype)service
{
    static IQHTTPService *sharedService;
    if (sharedService == nil)
    {
        sharedService = [[self alloc] init];
    }
    
    return sharedService;
}

-(BOOL)isLogEnabled
{
	return _logEnabled;
}

-(NSString*)headerForField:(NSString*)headerField
{
    return [defaultHeaders objectForKey:headerField];
}

-(void)addDefaultHeaderValue:(NSString*)header forHeaderField:(NSString*)headerField
{
    if (header)
    {
        [defaultHeaders setObject:header forKey:headerField];
    }
    else
    {
        [self removeDefaultHeaderForField:headerField];
    }
}

-(void)removeDefaultHeaderForField:(NSString*)headerField
{
    [defaultHeaders removeObjectForKey:headerField];
}

-(void)setAuthorizationHeaderWithUsername:(NSString *)username password:(NSString *)password
{
    NSString *base64String = [NSString stringWithFormat:@"%@:%@", username, password];
    
	NSData *authData = [base64String dataUsingEncoding:NSUTF8StringEncoding];
    
    if ([authData respondsToSelector:@selector(base64EncodedStringWithOptions:)])
    {
        base64String = [authData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    }
    else if ([authData respondsToSelector:@selector(base64Encoding)])
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        base64String = [authData base64Encoding];
#pragma clang diagnostic pop
    }
    
    [self addDefaultHeaderValue:[NSString stringWithFormat:@"Basic %@", base64String] forHeaderField:kIQAuthorization];
}

-(void)setAuthorizationHeaderWithToken:(NSString *)token;
{
    [self addDefaultHeaderValue:[NSString stringWithFormat:@"Token token=\"%@\"", token] forHeaderField:kIQAuthorization];
}

#pragma mark -
#pragma mark - Asynchronous Requests

-(IQURLConnection*)requestWithPath:(NSString*)path httpMethod:(NSString*)method parameter:(NSDictionary*)parameter completionHandler:(IQDictionaryCompletionBlock)completionHandler
{
    return [self requestWithPath:path httpMethod:method parameter:parameter dataCompletionHandler:^(NSData *result, NSError *error) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:result options:0 error:nil];
        
        if (completionHandler)
        {
            completionHandler(dict,error);
        }
        
    }];
}

-(IQURLConnection*)requestWithPath:(NSString*)path httpMethod:(NSString*)method parameter:(NSDictionary*)parameter dataCompletionHandler:(IQDataCompletionBlock)completionHandler
{
    NSURL *url = nil;
    NSData *httpBody = nil;
    
    if ([method isEqualToString:kIQHTTPMethodGET])
    {
        NSMutableString *parameterString = [[NSMutableString alloc] init];
        if ([path hasSuffix:@"?"] == NO && [parameter count])
            [parameterString appendString:@"?"];
        
        [parameterString appendString:httpURLEncodedString(parameter)];
        
        url = [NSURL URLWithString:[[NSString stringWithFormat:@"%@%@%@",self.serverURL,path,parameterString] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    }
    else if ([method isEqualToString:kIQHTTPMethodPOST] || [method isEqualToString:kIQHTTPMethodPUT] || [method isEqualToString:kIQHTTPMethodDELETE])
    {
        url = [NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",self.serverURL,path] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
        
        NSData *originalData;
        
        if (self.parameterType == IQRequestParameterTypeApplicationJSON)
        {
            if (parameter)  originalData = [NSJSONSerialization dataWithJSONObject:parameter options:0 error:nil];
        }
        else if (self.parameterType == IQRequestParameterTypeApplicationXWwwFormUrlEncoded)
        {
            if (parameter)
            {
                originalData = httpURLEncodedData(parameter);
            }
        }
        
        if ([originalData length])
        {
            NSMutableData *editedData = [[NSMutableData alloc] init];
            
            if (self.startBodyData) [editedData appendData:self.startBodyData];
            if (originalData)       [editedData appendData:originalData];
            if (self.endBodyData)   [editedData appendData:self.endBodyData];
            
            httpBody = editedData;
        }
    }
    
    return [self requestWithURL:url httpMethod:method contentType:self.defaultContentType httpBody:httpBody dataCompletionHandler:completionHandler];
}


-(IQURLConnection*)requestWithPath:(NSString*)path httpMethod:(NSString*)method contentType:(NSString*)contentType httpBody:(NSData*)httpBody completionHandler:(IQDictionaryCompletionBlock)completionHandler
{
    return [self requestWithPath:path httpMethod:method contentType:contentType httpBody:httpBody dataCompletionHandler:^(NSData *result, NSError *error) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:result options:0 error:nil];
        
        if (completionHandler)
        {
            completionHandler(dict,error);
        }
    }];
}

-(IQURLConnection*)requestWithPath:(NSString*)path httpMethod:(NSString*)method contentType:(NSString*)contentType httpBody:(NSData*)httpBody dataCompletionHandler:(IQDataCompletionBlock)completionHandler
{
    return [self requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",self.serverURL,path] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]] httpMethod:method contentType:contentType httpBody:httpBody dataCompletionHandler:completionHandler];
}


-(IQURLConnection*)requestWithURL:(NSURL*)url httpMethod:(NSString*)method contentType:(NSString*)contentType httpBody:(NSData*)httpBody dataCompletionHandler:(IQDataCompletionBlock)completionHandler
{
    NSMutableURLRequest *request = [IQHTTPService requestWithURL:url httpMethod:method contentType:contentType body:httpBody];
    
    //Adding headers
    {
        [request setAllHTTPHeaderFields:defaultHeaders];
    }
    
    if (_logEnabled)
	{
        printHTTPRequest(request);
	}
    
    __block IQURLConnection *connection = [IQURLConnection sendAsynchronousRequest:request responseBlock:NULL uploadProgressBlock:NULL downloadProgressBlock:NULL completionHandler:^(NSData *result, NSError *error) {
        
        if (_logEnabled)
        {
            printURLConnection(connection);
        }
        
        if (completionHandler != NULL)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(result, error);
            });
        }
    }];
    
    return connection;
}

-(IQURLConnection*)requestWithPath:(NSString*)path parameter:(NSDictionary*)parameter dataConstructionBlock:(IQMultipartFormDataConstructionBlock)dataConstructionBlock uploadProgressBlock:(IQProgressBlock)uploadProgress completionHandler:(IQDictionaryCompletionBlock)completionHandler
{
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",self.serverURL,path] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:kIQHTTPMethodPOST];
    
    //Adding headers
    {
        [request setAllHTTPHeaderFields:defaultHeaders];
    }
    
    NSString *boundary = generateRandomBoundaryString();
    
    //Set Content-Type
    {
        NSString *contentType =[NSString stringWithFormat:@"%@; %@=%@",kIQContentTypeMultipartFormData, kIQContentTypeBoundary, boundary];
        [request setValue:contentType forHTTPHeaderField:kIQContentType];
    }
    
    //Set HTTPBody
    {
        NSMutableData *httpBody = [NSMutableData data];
        
        __block NSMutableString *parameterAttributes = [[NSMutableString alloc] init];
        
        //Append Key-Value
        [parameter enumerateKeysAndObjectsUsingBlock:^(NSString *parameterKey, NSString *parameterValue, BOOL *stop)
         {
             [parameterAttributes appendFormat:@"--%@\r\n", boundary];
             [parameterAttributes appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", parameterKey];
             [parameterAttributes appendFormat:@"%@\r\n", parameterValue];
         }];
        
        [httpBody appendData:[parameterAttributes dataUsingEncoding:NSUTF8StringEncoding]];
        
        if (dataConstructionBlock)
        {
            BOOL *shouldStop = malloc(sizeof(BOOL));
            *shouldStop = NO;
            
            //Index to notify on block
            NSInteger index = 0;
            
            while (*shouldStop == NO)
            {
                IQMultipartFormData *formData = dataConstructionBlock(index, shouldStop);
                
                if (formData == nil)
                {
                    *shouldStop = YES;
                }
                else
                {
                    index++;
                    
                    NSMutableString *attributes = [[NSMutableString alloc] initWithFormat:@"--%@\r\n", boundary];
                    
                    [attributes appendString:@"Content-Disposition: form-data"];
                    
                    if (formData.name)      [attributes appendFormat:@"; name=\"%@\"",formData.name];
                    if (formData.fileName)  [attributes appendFormat:@"; filename=\"%@\"\r\n",formData.fileName];
                    
                    [attributes appendFormat:@"%@: %@\r\n\r\n", kIQContentType, formData.mimeType];
                    
                    [httpBody appendData:[attributes dataUsingEncoding:NSUTF8StringEncoding]];
                    [httpBody appendData:formData.data];
                    [httpBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                }
            }
        }
        
        //Closing boundary
        [httpBody appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        request.HTTPBody = httpBody;
        
        [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[httpBody length]] forHTTPHeaderField:@"Content-Length"];
    }
    
    if (_logEnabled)
	{
        printHTTPRequest(request);
	}
    
    __block IQURLConnection *connection = [IQURLConnection sendAsynchronousRequest:request responseBlock:NULL uploadProgressBlock:uploadProgress downloadProgressBlock:NULL completionHandler:^(NSData *result, NSError *error) {
        
        if (_logEnabled)
        {
            printURLConnection(connection);
        }
        
        if (completionHandler != NULL)
        {
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:result options:0 error:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(response, error);
            });
        }
    }];
    
    return connection;
}


#pragma mark -
#pragma mark - Synchronous Requests

-(NSDictionary*)synchronousRequestWithPath:(NSString*)path httpMethod:(NSString*)method parameter:(NSDictionary*)parameter error:(NSError**)error
{
    NSData *data = [self synchronousDataRequestWithPath:path httpMethod:method parameter:parameter error:error];
    
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}

-(NSData*)synchronousDataRequestWithPath:(NSString*)path httpMethod:(NSString*)method parameter:(NSDictionary*)parameter error:(NSError**)error
{
    NSURL *url = nil;
    NSData *httpBody = nil;
    
    if ([method isEqualToString:kIQHTTPMethodGET])
    {
        NSMutableString *parameterString = [[NSMutableString alloc] init];
        if ([path hasSuffix:@"?"] == NO && [parameter count])
            [parameterString appendString:@"?"];
        
        [parameterString appendString:httpURLEncodedString(parameter)];
        
        url = [NSURL URLWithString:[[NSString stringWithFormat:@"%@%@%@",self.serverURL,path,parameterString] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    }
    else if ([method isEqualToString:kIQHTTPMethodPOST] || [method isEqualToString:kIQHTTPMethodPUT] || [method isEqualToString:kIQHTTPMethodDELETE])
    {
        url = [NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",self.serverURL,path] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
        
        NSData *originalData;
        
        if (self.parameterType == IQRequestParameterTypeApplicationJSON)
        {
            if (parameter)  originalData = [NSJSONSerialization dataWithJSONObject:parameter options:0 error:nil];
        }
        else if (self.parameterType == IQRequestParameterTypeApplicationXWwwFormUrlEncoded)
        {
            if (parameter)
            {
                originalData = httpURLEncodedData(parameter);
            }
        }
        
        if ([originalData length])
        {
            NSMutableData *editedData = [[NSMutableData alloc] init];
            
            if (self.startBodyData) [editedData appendData:self.startBodyData];
            if (originalData)       [editedData appendData:originalData];
            if (self.endBodyData)   [editedData appendData:self.endBodyData];
            
            httpBody = editedData;
        }
    }
    
    return [self synchronousRequestWithURL:url httpMethod:method contentType:self.defaultContentType httpBody:httpBody error:error];
}

-(NSDictionary*)synchronousRequestWithPath:(NSString*)path httpMethod:(NSString*)method contentType:(NSString*)contentType httpBody:(NSData*)httpBody error:(NSError**)error
{
    NSData *data = [self synchronousDataRequestWithPath:path httpMethod:method contentType:contentType httpBody:httpBody error:error];
    
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}

-(NSData*)synchronousDataRequestWithPath:(NSString*)path httpMethod:(NSString*)method contentType:(NSString*)contentType httpBody:(NSData*)httpBody error:(NSError**)error
{
    return [self synchronousRequestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@%@",self.serverURL,path] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]] httpMethod:method contentType:contentType httpBody:httpBody error:error];
}

-(NSData*)synchronousRequestWithURL:(NSURL*)url httpMethod:(NSString*)method contentType:(NSString*)contentType httpBody:(NSData*)httpBody error:(NSError**)error
{
    NSMutableURLRequest *request = [IQHTTPService requestWithURL:url httpMethod:method contentType:contentType body:httpBody];
    
    //Adding headers
    {
        [request setAllHTTPHeaderFields:defaultHeaders];
    }
    
    if (_logEnabled)
	{
        printHTTPRequest(request);
	}
    
    return [IQURLConnection sendSynchronousRequest:request returningResponse:NULL error:error];
}

#pragma mark -
#pragma mark - Private Helper methods

+(NSMutableURLRequest*)requestWithURL:(NSURL*)url httpMethod:(NSString*)httpMethod contentType:(NSString*)contentType body:(NSData*)body
{
    if (url != nil)
    {
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:300];
        
        if ([httpMethod length])    [request setHTTPMethod:httpMethod];
        if ([contentType length])   [request addValue:contentType forHTTPHeaderField:kIQContentType];
        if ([body length])
        {
            [request setHTTPBody:body];
            [request addValue:[NSString stringWithFormat:@"%lu",(unsigned long)[body length]] forHTTPHeaderField:kIQContentLength];
        }
        return request;
    }
    else
    {
        return nil;
    }
}

@end


