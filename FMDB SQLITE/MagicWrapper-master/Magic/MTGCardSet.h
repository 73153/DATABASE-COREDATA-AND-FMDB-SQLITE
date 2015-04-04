#import <Foundation/Foundation.h>

@interface MTGCardSet : NSObject

@property (nonatomic, readonly) NSInteger common;
@property (nonatomic, readonly) NSInteger uncommon;
@property (nonatomic, readonly) NSInteger rare;
@property (nonatomic, readonly) NSInteger mythicRare;
@property (nonatomic, readonly) NSInteger basicLand;
@property (nonatomic, readonly) NSInteger total;
@property (nonatomic, strong, readonly) NSString *identifier;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *type;
@property (nonatomic, strong, readonly) NSString *block;
@property (nonatomic, strong, readonly) NSString *shortDescription;
@property (nonatomic, strong, readonly) NSString *releasedAt;
@property (nonatomic, strong, readonly) NSArray *cardIDs;

@end
