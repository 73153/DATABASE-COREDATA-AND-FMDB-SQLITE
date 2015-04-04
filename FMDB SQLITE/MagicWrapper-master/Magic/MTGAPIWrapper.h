#import <Foundation/Foundation.h>

@class MTGRequest;

@interface MTGAPIWrapper : NSObject

- (void)submitRequest:(MTGRequest *)request
              success:(void (^)(MTGRequest *request, id responseObject))success
              failure:(void (^)(MTGRequest *request, NSError *error))failure;

@end
