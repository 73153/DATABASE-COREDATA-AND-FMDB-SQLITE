#import "MTGRequest.h"

@interface MTGCardsRequest : MTGRequest

@property (nonatomic) NSRange pagination;

- (instancetype)initWithCardIDs:(NSArray *)cardIDs;
- (instancetype)initWithSetID:(NSString *)setID;

@end
