//
//  IQPFHTTPServiceConstants.m
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


#import "IQPFHTTPServiceConstants.h"

NSString *const kParse_X_Parse_Application_Id   =   @"X-Parse-Application-Id";
NSString *const kParse_X_Parse_REST_API_Key     =   @"X-Parse-REST-API-Key";
NSString *const kParse_X_Parse_Session_Token    =   @"X-Parse-Session-Token";


NSString *const kParseObjectIdKey               =   @"objectId";

NSString *const kParseRequestsKey               =   @"requests";

NSString *const kParseMethodKey                 =   @"method";
NSString *const kParsePathKey                   =   @"path";
NSString *const kParseBodyKey                   =   @"body";

NSString *const kParse__OpKey                   =   @"__op";

NSString *const kParseObjectsKey                =   @"objects";

NSString *const kParseCreatedAtKey              =   @"createdAt";
NSString *const kParseUpdatedAtKey              =   @"updatedAt";

NSString *const kParseResultsKey                =   @"results";
NSString *const kParseCountKey                  =   @"count";
NSString *const kParseLimitKey                  =   @"limit";
NSString *const kParseSkipKey                   =   @"skip";
NSString *const kParseWhereKey                  =   @"where";
NSString *const kParseOrderKey                  =   @"order";

NSString *const kParseLessThanKey               =   @"$lt";
NSString *const kParseLessThanOrEqualKey        =   @"$lte";
NSString *const kParseGreaterThanKey            =   @"$gt";
NSString *const kParseGreaterThanOrEqualKey     =   @"$gte";
NSString *const kParseNotEqualKey               =   @"$ne";
NSString *const kParseContainedInKey            =   @"$in";
NSString *const kParseNotContainedInKey         =   @"$nin";
NSString *const kParseExistsKey                 =   @"$exists";
NSString *const kParseSelectKey                 =   @"$select";
NSString *const kParseDontSelectKey             =   @"$dontSelect";
NSString *const kParseAllKey                    =   @"$all";

NSString *const kParseQueryKey                  =   @"$query";
NSString *const kParseKeyKey                    =   @"key";

NSString *const kParseUsernameKey               =   @"username";
NSString *const kParsePasswordKey               =   @"password";
NSString *const kParseEmailKey                  =   @"email";
NSString *const kParseSessionTokenKey           =   @"sessionToken";

NSString *const kParse__TypeKey                 =   @"__type";
NSString *const kParseFileKey                   =   @"File";
NSString *const kParseDateKey                   =   @"Date";
NSString *const kParseBytesKey                  =   @"Bytes";
NSString *const kParsePointerKey                =   @"Pointer";
NSString *const kParseRelationKey               =   @"Relation";

NSString *const kParseUrlKey                    =   @"url";
NSString *const kParseNameKey                   =   @"name";
NSString *const kParseISOKey                    =   @"iso";
NSString *const kParseBase64Key                 =   @"base64";
NSString *const kParseClassNameKey              =   @"className";

NSString *const kParseAddRelationKey            =   @"AddRelation";
NSString *const kParseRemoveRelationKey         =   @"RemoveRelation";
NSString *const kParseBatchKey                  =   @"Batch";
NSString *const kParseOpsKey                    =   @"ops";
NSString *const kParseGeoPointKey               =   @"GeoPoint";
NSString *const kParseLatitudeKey               =   @"latitude";
NSString *const kParseLongitudeKey              =   @"longitude";

NSString *const kParseMaxDistanceInMilesKey     =   @"$maxDistanceInMiles";
NSString *const kParseMaxDistanceInKilometersKey=   @"$maxDistanceInKilometers";
NSString *const kParseMaxDistanceInRadiansKey   =   @"$maxDistanceInRadians";
NSString *const kParseBoxKey                    =   @"$box";
NSString *const kParseWithinKey                 =   @"$within";

