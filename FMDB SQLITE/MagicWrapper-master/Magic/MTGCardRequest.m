#import "MTGCardRequest.h"

@interface MTGCardRequest ()
@property (nonatomic, strong) NSString *cardID;
@end

@implementation MTGCardRequest

#pragma mark - Initialization

- (instancetype)initWithCardID:(NSString *)cardId
{
    self = [super init];
	
    if (self) {
        self.cardID = cardId;
    }
	
    return self;
}

#pragma mark - Request

- (NSString *)path
{
    return [NSString stringWithFormat:@"/cards/%@", self.cardID];
}

- (MTGResponseSerializer)responseSerializer
{
    return MTGResponseSerializerCard;
}

@end
