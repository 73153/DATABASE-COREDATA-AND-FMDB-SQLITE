#import "MTGRequest.h"

extern NSString *const MTGSearchName;
extern NSString *const MTGSearchDescription;
extern NSString *const MTGSearchFlavor;
extern NSString *const MTGSearchColor;
extern NSString *const MTGSearchManaCost;
extern NSString *const MTGSearchConvertedManaCost;
extern NSString *const MTGSearchType;
extern NSString *const MTGSearchSubtype;
extern NSString *const MTGSearchPower;
extern NSString *const MTGSearchToughness;
extern NSString *const MTGSearchLoyalty;
extern NSString *const MTGSearchRarity;
extern NSString *const MTGSearchArtist;
extern NSString *const MTGSearchSetID;

@interface MTGSearchRequest : MTGRequest

@property (nonatomic) NSRange pagination;

- (instancetype)initWithQuery:(NSDictionary *)query;

@end
