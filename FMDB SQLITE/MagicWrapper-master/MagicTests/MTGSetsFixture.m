#import "MTGSetsFixture.h"

@implementation MTGSetsFixture

+ (NSArray *)setsFixture
{
    return @[
             @{
                 @"basicLand": @10,
                 @"block": [NSNull null],
                 @"cardIds": @[@1, @2],
                 @"common": @74,
                 @"description": @"The name Alpha refers to the first print run of the \n  original Magic: The Gathering Limited Edition, the first Magic: The Gathering \n card set. It premiered in a limited release at Origins Game Fair in 1993, with \n a general release that August. Its print run of 2.6 million cards sold out very quickly and was replaced by Limited Edition's Beta print run. Limited Edition cards have no expansion symbol, no copyright date, no trademark symbols, although they do list the art credits at the bottom of the card.",
                 @"id": @"LEA",
                 @"mythicRare": @0,
                 @"name": @"Limited Edition Alpha",
                 @"rare": @116,
                 @"releasedAt": @"1993-08-05",
                 @"total": @295,
                 @"type": @"Core",
                 @"uncommon": @95
                 },
             @{
                 @"basicLand": @20,
                 @"block": @"Khans of Tarkir",
                 @"cardIds": @[@386603, @386604],
                 @"common": @101,
                 @"description": @"Tarkir is a world embattled with ambitious warlords and powerful clans that wage eternal war for supremacy of their plane, a conflict that spans over a thousand years. Tarkir is also the home plane of Sarkhan Vol. It was previously inhabited by dragons, all of whom were killed before Sarkhan's period of servitude. The clans each worship one aspect of the extinct dragons.",
                 @"id": @"KTK",
                 @"mythicRare": @15,
                 @"name": @"Khans of Tarkir",
                 @"rare": @53,
                 @"releasedAt": @"2014-09-26",
                 @"total": @269,
                 @"type": @"Expansion",
                 @"uncommon": @80}
             ];
}

@end
