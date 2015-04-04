//
//  IQHTTPConstants.m
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


#import <Foundation/NSObjCRuntime.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "IQURLConnection.h"
#import "IQHTTPConstants.h"

@class NSString, NSData;

#pragma mark - HTTP Header field constant strings
NSString *const kIQAccept                                   =   @"Accept";
NSString *const kIQAcceptCharset                            =   @"Accept-Charset";
NSString *const kIQAcceptDatetime                           =   @"Accept-Datetime";
NSString *const kIQAcceptEncoding                           =   @"Accept-Encoding";
NSString *const kIQAcceptLanguage                           =   @"Accept-Language";
NSString *const kIQAcceptRanges                             =   @"Accept-Ranges";
NSString *const kIQAuthorization                            =   @"Authorization";
NSString *const kIQCacheControl                             =   @"Cache-Control";
NSString *const kIQConnection                               =   @"Connection";
NSString *const kIQContentEncoding                          =   @"Content-Encoding";
NSString *const kIQContentMD5                               =   @"Content-MD5";
NSString *const kIQContentLanguage                          =   @"Content-Language";
NSString *const kIQContentLength                            =   @"Content-Length";
NSString *const kIQContentLocation                          =   @"Content-Location";
NSString *const kIQContentRange                             =   @"Content-Range";
NSString *const kIQContentType                              =   @"Content-Type";
NSString *const kIQCookie                                   =   @"Cookie";
NSString *const kIQDate                                     =   @"Date";
NSString *const kIQExpires                                  =   @"Expires";
NSString *const kIQHost                                     =   @"Host";
NSString *const kIQKeepAlive                                =   @"Keep-Alive";
NSString *const kIQLastModified                             =   @"Last-Modified";
NSString *const kIQProxyConnection                          =   @"Proxy-Connection";
NSString *const kIQRange                                    =   @"Range";
NSString *const kIQReferer                                  =   @"Referer";
NSString *const kIQServer                                   =   @"Server";
NSString *const kIQSOAPAction                               =   @"SOAPAction";
NSString *const kIQStatus                                   =   @"Status";
NSString *const kIQUserAgent                                =   @"User-Agent";
NSString *const kIQVia                                      =   @"Via";
NSString *const kIQXPoweredBy                               =   @"X-Powered-By";


#pragma mark - HTTP Content-Type constant strings
//For Multipurpose files
NSString *const kIQContentTypeApplicationXWwwFormUrlEncoded =   @"application/x-www-form-urlencoded";
NSString *const kIQContentTypeApplicationJson               =   @"application/json";
NSString *const kIQContentTypeApplicationJavaScript         =   @"application/javascript";
NSString *const kIQContentTypeApplicationPdf                =   @"application/pdf";
NSString *const kIQContentTypeApplicationSoapXml            =   @"application/soap+xml";
NSString *const kIQContentTypeApplicationXml                =   @"application/xml";
NSString *const kIQContentTypeApplicationZip                =   @"application/zip";
//For Audio
NSString *const kIQContentTypeAudioBasic                    =   @"audio/basic";
NSString *const kIQContentTypeAudioMp4                      =   @"audio/mp4";
NSString *const kIQContentTypeAudioMpeg                     =   @"audio/mpeg";
NSString *const kIQContentTypeAudioOgg                      =   @"audio/ogg";
//For image
NSString *const kIQContentTypeImageGif                      =   @"image/gif";
NSString *const kIQContentTypeImageJpeg                     =   @"image/jpeg";
NSString *const kIQContentTypeImagePng                      =   @"image/png";
//For message
NSString *const kIQContentTypeMessageHttp                   =   @"message/http";
//For multipart
NSString *const kIQContentTypeMultipartMixed                =   @"multipart/mixed";
NSString *const kIQContentTypeMultipartAlternative          =   @"multipart/alternative";
NSString *const kIQContentTypeMultipartRelated              =   @"multipart/related";
NSString *const kIQContentTypeMultipartFormData             =   @"multipart/form-data";
NSString *const kIQContentTypeMultipartEncrypted            =   @"multipart/encrypted";
NSString *const kIQContentTypeBoundary                      =   @"boundary";
//For text
NSString *const kIQContentTypeTextCmd                       =   @"text/cmd";
NSString *const kIQContentTypeTextCss                       =   @"text/css";
NSString *const kIQContentTypeTextCsv                       =   @"text/csv";
NSString *const kIQContentTypeTextHtml                      =   @"text/html";
NSString *const kIQContentTypeTextJavaScript                =   @"text/javascript";
NSString *const kIQContentTypeTextPlain                     =   @"text/plain";
NSString *const kIQContentTypeTextVCard                     =   @"text/vcard";
NSString *const kIQContentTypeTextXml                       =   @"text/xml";
//For video
NSString *const kIQContentTypeVideoMpeg                     =   @"video/mpeg";
NSString *const kIQContentTypeVideoMp4                      =   @"video/mp4";
NSString *const kIQContentTypeVideoQuickTime                =   @"video/quicktime";
NSString *const kIQContentTypeVideoWebm                     =   @"video/webm";
NSString *const kIQContentTypeVideoXMatroska                =   @"video/x-matroska";
NSString *const kIQContentTypeVideoXMsWmv                   =   @"video/x-ms-wmv";
NSString *const kIQContentTypeVideoXFlv                     =   @"video/x-flv";
//for charset
NSString *const kIQContentTypeCharsetUtf8                   =   @"charset=utf-8";


#pragma mark - HTTP method constant strings
NSString *const kIQHTTPMethodPOST                           =   @"POST";
NSString *const kIQHTTPMethodGET                            =   @"GET";
NSString *const kIQHTTPMethodPUT                            =   @"PUT";
NSString *const kIQHTTPMethodDELETE                         =   @"DELETE";


void printHTTPRequest(NSURLRequest *request)
{
    if (request.URL == NULL)    NSLog(@"RequestURL is NULL");
    else                        NSLog(@"RequestURL:- %@",request.URL);
    
    NSLog(@"HTTP Method:- %@",request.HTTPMethod);
    
    if (request.allHTTPHeaderFields)
    {
        NSLog(@"HTTPHeaderFields:- %@",request.allHTTPHeaderFields);
    }
    
    if (request.HTTPBody)
    {
        NSString *requestString = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
        
        if (requestString)
        {
            NSLog(@"Request Body:- %@\n\n",requestString);
        }
        else
        {
            NSLog(@"Request Body Length:- %lu\n\n",(unsigned long)[request.HTTPBody length]);
        }
    }
}

void printURLConnection(IQURLConnection *connection)
{
    NSLog(@"URL:- %@",connection.originalRequest.URL);
    NSLog(@"HTTP Method:- %@",connection.originalRequest.HTTPMethod);
    
    if (connection.error)
    {
        NSLog(@"error:- %@\n\n",connection.error);
    }
    
    if (connection.response)
    {
        NSLog(@"Response Header:- %@\n\n",connection.response.allHeaderFields);
    }
    
    if (connection.responseData)
    {
        NSString *responseString = [[NSString alloc] initWithData:connection.responseData encoding:NSUTF8StringEncoding];
        
        if ([responseString length])
        {
            NSLog(@"Response:- %@\n\n",responseString);
        }
        else
        {
            NSLog(@"Response Data Length:- %lu\n\n",(unsigned long)[connection.responseData length]);
        }
    }
}


NSString* httpURLEncodedString(NSDictionary *parameter)
{
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    for (NSString *aKey in [parameter allKeys])
    {
        [values addObject:[NSString stringWithFormat:@"%@=%@",aKey,[parameter objectForKey:aKey]]];
    }
    
    return [values componentsJoinedByString:@"&"];
}

NSData* httpURLEncodedData(NSDictionary *parameter)
{
    return [httpURLEncodedString(parameter) dataUsingEncoding:NSUTF8StringEncoding];
}

NSString* jsonEncodedString(NSDictionary *parameter)
{
    return [[NSString alloc] initWithData:jsonEncodedData(parameter) encoding:NSUTF8StringEncoding];
}

NSData* jsonEncodedData(NSDictionary *parameter)
{
    return [NSJSONSerialization dataWithJSONObject:parameter options:0 error:nil];
}

NSString* MIMETypeForFileAtPath(NSString * filePath)
{
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[filePath pathExtension], NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
    return (__bridge NSString *)MIMEType;
}


// generate boundary string
// adapted from http://developer.apple.com/library/ios/#samplecode/SimpleURLConnections
NSString *generateRandomBoundaryString(void)
{
    CFUUIDRef       uuid;
    CFStringRef     uuidStr;
    NSString *      result;
    
    uuid = CFUUIDCreate(NULL);
    assert(uuid != NULL);
    
    uuidStr = CFUUIDCreateString(NULL, uuid);
    assert(uuidStr != NULL);
    
    result = [NSString stringWithFormat:@"Boundary-%@", uuidStr];
    
    CFRelease(uuidStr);
    CFRelease(uuid);
    
    return result;
}
