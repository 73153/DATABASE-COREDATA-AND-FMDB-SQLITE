#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MTGResponseSerializer) {
    MTGResponseSerializerCard = 1,
    MTGResponseSerializerCards,
    MTGResponseSerializerSet,
    MTGResponseSerializerSets
};

@class MTGRequest;

@interface MTGResponse : NSObject

- (instancetype)initWithResponseObject:(id)responseObject;
- (void)serializeResponseForRequest:(MTGRequest *)request
                            success:(void (^)(MTGRequest *request, id object))success;

@end
