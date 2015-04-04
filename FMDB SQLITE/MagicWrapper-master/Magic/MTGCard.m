#import "MTGCard.h"
#import "NSDictionary+MagicWrapper.h"

static NSString *const kMTGCardLowResURL = @"http://api.mtgdb.info/content/card_images/%@.jpeg";
static NSString *const kMTGCardHighResURL = @"http://api.mtgdb.info/content/hi_res_card_images/%@.jpg";

@interface MTGCard ()
@property (strong, nonatomic) NSDictionary *dictionary;
@property (nonatomic, readwrite) BOOL token;
@property (nonatomic, readwrite) BOOL promo;
@property (nonatomic, readwrite) NSInteger identifier;
@property (nonatomic, readwrite) NSInteger relatedCardId;
@property (nonatomic, readwrite) NSInteger setNumber;
@property (nonatomic, readwrite) NSInteger convertedManaCost;
@property (nonatomic, readwrite) NSInteger power;
@property (nonatomic, readwrite) NSInteger toughness;
@property (nonatomic, readwrite) NSInteger loyalty;
@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong, readwrite) NSString *searchName;
@property (nonatomic, strong, readwrite) NSString *text;
@property (nonatomic, strong, readwrite) NSString *flavor;
@property (nonatomic, strong, readwrite) NSString *manaCost;
@property (nonatomic, strong, readwrite) NSString *cardSetName;
@property (nonatomic, strong, readwrite) NSString *type;
@property (nonatomic, strong, readwrite) NSString *subType;
@property (nonatomic, strong, readwrite) NSString *rarity;
@property (nonatomic, strong, readwrite) NSString *artist;
@property (nonatomic, strong, readwrite) NSString *cardSetId;
@property (nonatomic, strong, readwrite) NSString *releasedAt;
@property (nonatomic, strong, readwrite) NSArray *colors;
@property (nonatomic, strong, readwrite) NSURL *lowResURL;
@property (nonatomic, strong, readwrite) NSURL *highResURL;
@end

@implementation MTGCard

#pragma mark - Initialization

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self) {
        self.dictionary = dictionary;
        self.token = [[dictionary mtg_objectForKey:@"token"] boolValue];
        self.promo = [[dictionary mtg_objectForKey:@"promo"] boolValue];
        self.identifier = [[dictionary mtg_objectForKey:@"id"] integerValue];
        self.relatedCardId = [[dictionary mtg_objectForKey:@"relatedCardId"] integerValue];
        self.setNumber = [[dictionary mtg_objectForKey:@"setNumber"] integerValue];
        self.convertedManaCost = [[dictionary mtg_objectForKey:@"convertedManaCost"] integerValue];
        self.power = [[dictionary mtg_objectForKey:@"power"] integerValue];
        self.toughness = [[dictionary mtg_objectForKey:@"toughness"] integerValue];
        self.loyalty = [[dictionary mtg_objectForKey:@"loyalty"] integerValue];
        self.name = [dictionary mtg_objectForKey:@"name"];
        self.searchName = [dictionary mtg_objectForKey:@"searchName"];
        self.text = [dictionary mtg_objectForKey:@"description"];
        self.flavor = [dictionary mtg_objectForKey:@"flavor"];
        self.manaCost = [dictionary mtg_objectForKey:@"manaCost"];
        self.cardSetName = [dictionary mtg_objectForKey:@"cardSetName"];
        self.type = [dictionary mtg_objectForKey:@"type"];
        self.subType = [dictionary mtg_objectForKey:@"subType"];
        self.rarity = [dictionary mtg_objectForKey:@"rarity"];
        self.artist = [dictionary mtg_objectForKey:@"artist"];
        self.cardSetId = [dictionary mtg_objectForKey:@"cardSetId"];
        self.colors = [dictionary mtg_objectForKey:@"colors"];
        self.releasedAt = [dictionary mtg_objectForKey:@"releasedAt"];
    }
    
    return self;
}

- (NSURL *)lowResURL
{
    return [NSURL URLWithString:[NSString stringWithFormat:kMTGCardLowResURL, @(self.identifier)]];
}

- (NSURL *)highResURL
{
    return [NSURL URLWithString:[NSString stringWithFormat:kMTGCardHighResURL, @(self.identifier)]];
}

- (NSString *)description
{
    NSMutableString *description = [NSMutableString string];
    
    [description appendFormat:@"<MTGCard: %p", self];
    [description appendFormat:@", name: %@", self.name];
    [description appendFormat:@", id: %@", @(self.identifier)];
    [description appendFormat:@", type: %@", self.type];
    [description appendFormat:@", mana cost: %@", @(self.convertedManaCost)];
    [description appendFormat:@", set id: %@", self.cardSetId];
    [description appendFormat:@">"];
    
    return description.copy;
}

#pragma mark - Equality & Identity

- (BOOL)isEqual:(id)object
{
    if (object == self) return YES;
    if (!object || ![object isKindOfClass:[self class]]) return NO;
    return [self isEqualCard:object];
}

- (BOOL)isEqualCard:(MTGCard *)card
{
    return (self.identifier == card.identifier);
}

- (NSUInteger)hash
{
    return [self.name hash] ^ [self.cardSetId hash];
}

@end
