#import <Foundation/Foundation.h>

@interface MTGCard : NSObject

@property (nonatomic, readonly) BOOL token;
@property (nonatomic, readonly) BOOL promo;
@property (nonatomic, readonly) NSInteger identifier;
@property (nonatomic, readonly) NSInteger relatedCardId;
@property (nonatomic, readonly) NSInteger setNumber;
@property (nonatomic, readonly) NSInteger convertedManaCost;
@property (nonatomic, readonly) NSInteger power;
@property (nonatomic, readonly) NSInteger toughness;
@property (nonatomic, readonly) NSInteger loyalty;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *searchName;
@property (nonatomic, strong, readonly) NSString *text;
@property (nonatomic, strong, readonly) NSString *flavor;
@property (nonatomic, strong, readonly) NSString *manaCost;
@property (nonatomic, strong, readonly) NSString *cardSetName;
@property (nonatomic, strong, readonly) NSString *type;
@property (nonatomic, strong, readonly) NSString *subType;
@property (nonatomic, strong, readonly) NSString *rarity;
@property (nonatomic, strong, readonly) NSString *artist;
@property (nonatomic, strong, readonly) NSString *cardSetId;
@property (nonatomic, strong, readonly) NSString *releasedAt;
@property (nonatomic, strong, readonly) NSArray *colors;
@property (nonatomic, strong, readonly) NSURL *lowResURL;
@property (nonatomic, strong, readonly) NSURL *highResURL;

@end
