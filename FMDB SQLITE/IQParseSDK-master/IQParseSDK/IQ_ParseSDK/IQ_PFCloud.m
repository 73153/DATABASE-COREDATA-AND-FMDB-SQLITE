//
//  IQ_PFCloud.m
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

#import "IQ_PFCloud.h"
#import "IQPFHTTPService.h"

@implementation IQ_PFCloud

+ (id)callFunction:(NSString *)function withParameters:(NSDictionary *)parameters
{
    return [self callFunction:function withParameters:parameters error:nil];
}

+ (id)callFunction:(NSString *)function withParameters:(NSDictionary *)parameters error:(NSError **)error
{
    NSData *result = [[IQPFHTTPService service] callFunction:function withParameters:parameters error:error];

    NSDictionary *jsonResponse;
    NSString *string;
    
    if ((jsonResponse = [NSJSONSerialization JSONObjectWithData:result options:0 error:0]))
    {
        return jsonResponse;
    }
    else if ((string = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding]))
    {
        return string;
    }
    else
    {
        return result;
    }
}

+ (void)callFunctionInBackground:(NSString *)function withParameters:(NSDictionary *)parameters block:(IQ_PFIdResultBlock)block
{
    [[IQPFHTTPService service] callFunction:function withParameters:parameters completionHandler:^(NSData *result, NSError *error) {
        
        NSDictionary *jsonResponse;
        NSString *string;
        
        if ((jsonResponse = [NSJSONSerialization JSONObjectWithData:result options:0 error:0]))
        {
            if (block)  block(jsonResponse, error);
        }
        else if ((string = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding]))
        {
            if (block)  block(string, error);
        }
        else
        {
            if (block)  block(result,error);
        }
    }];
}

+ (void)callFunctionInBackground:(NSString *)function withParameters:(NSDictionary *)parameters target:(id)target selector:(SEL)selector
{
    [self callFunctionInBackground:function withParameters:parameters block:^(id object, NSError *error) {

        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[target methodSignatureForSelector:selector]];
        invocation.target = target;
        invocation.selector = selector;
        [invocation setArgument:&object atIndex:2];
        [invocation setArgument:&error atIndex:3];
        [invocation invoke];
    }];
}

@end
