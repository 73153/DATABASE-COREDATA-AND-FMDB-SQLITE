#import "MTGCardSetRequest.h"

@interface MTGCardSetRequest ()
@property (nonatomic, strong) NSString *setID;
@end

@implementation MTGCardSetRequest

#pragma mark - Initialization

- (instancetype)initWithSetID:(NSString *)setID
{
    self = [super init];
    
    if (self) {
        self.setID = setID;
    }
    
    return self;
}

#pragma mark - Request

- (NSString *)path
{
    return [NSString stringWithFormat:@"/sets/%@", self.setID];
}

- (MTGResponseSerializer)responseSerializer
{
    return MTGResponseSerializerSet;
}

@end
