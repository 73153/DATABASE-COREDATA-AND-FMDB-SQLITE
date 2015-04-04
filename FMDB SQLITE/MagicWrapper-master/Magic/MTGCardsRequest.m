#import "MTGCardsRequest.h"

@interface MTGCardsRequest ()
@property (nonatomic, strong) NSString *setID;
@property (nonatomic, strong) NSArray *cardIDs;
@end

@implementation MTGCardsRequest

#pragma mark - Initialization

- (instancetype)initWithCardIDs:(NSArray *)cardIDs
{
    self = [super init];
    
    if (self) {
        self.cardIDs = cardIDs;
        self.pagination = NSMakeRange(NSNotFound, 0);
    }
    
    return self;
}

- (instancetype)initWithSetID:(NSString *)setID
{
    self = [super init];
    
    if (self) {
        self.setID = setID;
        self.pagination = NSMakeRange(NSNotFound, 0);
    }
    
    return self;
}

#pragma mark - Request

- (NSString *)path
{
    if (self.cardIDs) {
        NSString *cardIDs = [self.cardIDs componentsJoinedByString:@","];
        return [NSString stringWithFormat:@"/cards/%@", cardIDs];
    } else if (self.setID) {
        return [NSString stringWithFormat:@"/sets/%@/cards", self.setID];
    }
    
    return nil;
}

- (NSDictionary *)parameters
{
    if (self.pagination.location != NSNotFound) {
        return @{ @"start" : @(self.pagination.location),
                  @"end" : @(self.pagination.location + self.pagination.length - 1)};
    }
    
    return nil;
}

- (MTGResponseSerializer)responseSerializer
{
    return MTGResponseSerializerCards;
}

@end
