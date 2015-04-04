#import "MTGResponse.h"
#import "MTGRequest.h"
#import "MTGCard.h"
#import "MTGCardSet.h"

@interface MTGResponse ()
@property (nonatomic, strong) id responseObject;
@end

@interface MTGCard ()
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end

@interface MTGCardSet ()
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end

@implementation MTGResponse

#pragma mark - Initialization

- (instancetype)initWithResponseObject:(id)responseObject
{
    self = [super init];
    
    if (self) {
        self.responseObject = responseObject;
    }
    
    return self;
}

- (void)serializeResponseForRequest:(MTGRequest *)request
                            success:(void (^)(MTGRequest *request, id object))success
{
    switch (request.responseSerializer) {
        case MTGResponseSerializerCard: {
            MTGCard *card = [[MTGCard alloc] initWithDictionary:self.responseObject];
            success(request, card);
        } break;
            
        case MTGResponseSerializerCards: {
            NSMutableArray *cards = [NSMutableArray array];
            for (NSDictionary *cardDictionary in self.responseObject) {
                MTGCard *card = [[MTGCard alloc] initWithDictionary:cardDictionary];
                [cards addObject:card];
            }
            success(request, cards.copy);
        } break;
            
        case MTGResponseSerializerSet: {
            MTGCardSet *set = [[MTGCardSet alloc] initWithDictionary:self.responseObject];
            success(request, set);
        } break;
            
        case MTGResponseSerializerSets: {
            NSMutableArray *sets = [NSMutableArray array];
            for (NSDictionary *setDictionary in self.responseObject) {
                MTGCardSet *set = [[MTGCardSet alloc] initWithDictionary:setDictionary];
                [sets addObject:set];
            }
            success(request, sets.copy);
        } break;
            
        default: {
            success(request, self.responseObject);
        } break;
    }
}

@end
