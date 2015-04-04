//
//  IQ_PFGeoPoint.m
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

#import "IQ_PFGeoPoint.h"
#import "IQPFHTTPServiceConstants.h"

@implementation IQ_PFGeoPoint

+ (IQ_PFGeoPoint *)geoPoint
{
    return [self geoPointWithLatitude:0 longitude:0];
}

+ (IQ_PFGeoPoint *)geoPointWithLocation:(CLLocation *)location
{
    return [self geoPointWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
}

+ (IQ_PFGeoPoint *)geoPointWithLatitude:(double)latitude longitude:(double)longitude
{
    IQ_PFGeoPoint *geoPoint = [[self alloc] init];
    geoPoint.latitude = latitude;
    geoPoint.longitude = longitude;

    return geoPoint;
}

-(NSDictionary*)coreSerializedAttribute
{
    return @{kParse__TypeKey: kParseGeoPointKey, kParseLatitudeKey: @(self.latitude), kParseLongitudeKey: @(self.longitude)};
}

//+ (void)geoPointForCurrentLocationInBackground:(void(^)(IQ_PFGeoPoint *geoPoint, NSError *error))geoPointHandler

//- (double)distanceInRadiansTo:(IQ_PFGeoPoint*)point

- (double)distanceInMilesTo:(IQ_PFGeoPoint*)point
{
    CLLocation *myLocation = [[CLLocation alloc] initWithLatitude:self.latitude longitude:self.longitude];
    CLLocation *otherLocation = [[CLLocation alloc] initWithLatitude:point.latitude longitude:point.longitude];
    
    return [myLocation distanceFromLocation:otherLocation]/1609.34;
}

- (double)distanceInKilometersTo:(IQ_PFGeoPoint*)point
{
    CLLocation *myLocation = [[CLLocation alloc] initWithLatitude:self.latitude longitude:self.longitude];
    CLLocation *otherLocation = [[CLLocation alloc] initWithLatitude:point.latitude longitude:point.longitude];
    
    return [myLocation distanceFromLocation:otherLocation]/1000.0;
}



@end
