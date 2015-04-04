#import "MTGCardSetsRequest.h"

@interface MTGCardSetsRequest ()
@property (nonatomic, strong) NSArray *cardSets;
@end

@implementation MTGCardSetsRequest

- (instancetype)initWithCardSets:(NSArray *)cardSets
{
    self = [super init];
    
    if (self) {
        self.cardSets = cardSets;
    }
    
    return self;
}

#pragma mark - Request

- (NSString *)path
{
    if (self.cardSets) {
        NSString *sets = [self.cardSets componentsJoinedByString:@","];
        return [NSString stringWithFormat:@"/sets/%@", sets];
    } else {
        return @"/sets";
    }
}

- (MTGResponseSerializer)responseSerializer
{
    return MTGResponseSerializerSets;
}

@end
