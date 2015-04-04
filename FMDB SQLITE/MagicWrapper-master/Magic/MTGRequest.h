#import <Foundation/Foundation.h>
#import "MTGResponse.h"

@interface MTGRequest : NSObject

@property (nonatomic, strong, readonly) NSString *path;
@property (nonatomic, strong, readonly) NSDictionary *parameters;
@property (nonatomic, readonly) MTGResponseSerializer responseSerializer;

@end
