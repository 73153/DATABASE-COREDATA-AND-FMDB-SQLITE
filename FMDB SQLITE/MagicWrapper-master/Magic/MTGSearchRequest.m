#import "MTGSearchRequest.h"

NSString *const MTGSearchName = @"name";
NSString *const MTGSearchDescription = @"description";
NSString *const MTGSearchFlavor = @"flavor";
NSString *const MTGSearchColor = @"color";
NSString *const MTGSearchManaCost = @"manacost";
NSString *const MTGSearchConvertedManaCost = @"convertedmanacost";
NSString *const MTGSearchType = @"type";
NSString *const MTGSearchSubtype = @"subtype";
NSString *const MTGSearchPower = @"power";
NSString *const MTGSearchToughness = @"toughness";
NSString *const MTGSearchLoyalty = @"loyalty";
NSString *const MTGSearchRarity = @"rarity";
NSString *const MTGSearchArtist = @"artist";
NSString *const MTGSearchSetID = @"setId";

@interface MTGSearchRequest ()
@property (nonatomic, strong) NSDictionary *query;
@end

@implementation MTGSearchRequest

#pragma mark - Initialization

- (instancetype)initWithQuery:(NSDictionary *)query
{
    self = [super init];
    
    if (self) {
        self.query = query;
        self.pagination = NSMakeRange(NSNotFound, 0);
    }
    
    return self;
}

#pragma mark - Request

- (NSString *)path
{
    return @"/search";
}

- (NSDictionary *)parameters
{
    NSMutableArray *queryArray = [NSMutableArray array];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSArray *keys = [self.query.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    for (NSString *key in keys) {
        id value = self.query[key];
        
        NSString *format = [value isKindOfClass:[NSNumber class]] ? @"%@ eq %@" : @"%@ m '%@'";
        [queryArray addObject:[NSString stringWithFormat:format, key, value]];
    }
    
    if (queryArray.count) {
        NSString *queryString = [queryArray componentsJoinedByString:@" and "];
        [params addEntriesFromDictionary:@{@"q" : queryString}];
    }
    
    if (self.pagination.location != NSNotFound) {
        [params addEntriesFromDictionary:@{@"start" : @(self.pagination.location),
                                           @"limit" : @(self.pagination.length)}];
    }
    
    return params;
}

- (MTGResponseSerializer)responseSerializer
{
    return MTGResponseSerializerCards;
}

@end
