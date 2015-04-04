#import "MTGCardsFixture.h"

@implementation MTGCardsFixture

#pragma mark - Initialization

+ (NSArray *)cardsFixture
{
    return @[
             @{
                 @"artist": @"Neal Caffrey",
                 @"cardSetId": @"WCCU",
                 @"cardSetName": @"White Collar Crimes Unit",
                 @"colors": @[@"white"],
                 @"convertedManaCost": @1,
                 @"description": @"Fixture - Fake card.",
                 @"flavor": @"Classics never go out of style.",
                 @"id": @123,
                 @"loyalty": @0,
                 @"manaCost": @"W",
                 @"name": @"Fake Card",
                 @"power": @0,
                 @"promo": @NO,
                 @"rarity": @"Rare",
                 @"relatedCardId": @0,
                 @"releasedAt": @"2014-09-26",
                 @"searchName": @"fakecard",
                 @"setNumber": @2,
                 @"subType": [NSNull null],
                 @"token": @YES,
                 @"toughness": @0,
                 @"type": @"Artifact"
                 },
             @{
                 @"artist": @"Chris Rahn",
                 @"cardSetId": @"KTK",
                 @"cardSetName": @"Khans of Tarkir",
                 @"colors": @[@"white"],
                 @"convertedManaCost": @4,
                 @"description": @"Outlast {White} ({White}, {Tap}: Put a +1/+1 counter on this creature. Outlast only as a sorcery.)\n\nEach creature you control with a +1/+1 counter on it has lifelink.",
                 @"flavor": @"\"Wherever I walk, the ancestors walk too.\"",
                 @"id": @386466,
                 @"loyalty": @0,
                 @"manaCost": @"3W",
                 @"name": @"Abzan Battle Priest",
                 @"power": @3,
                 @"promo": @NO,
                 @"rarity": @"Uncommon",
                 @"relatedCardId": @0,
                 @"releasedAt": @"2014-09-26",
                 @"searchName": @"abzanbattlepriest",
                 @"setNumber": @1,
                 @"subType": @"Human Cleric",
                 @"token": @NO,
                 @"toughness": @2,
                 @"type": @"Creature"
                 }];
}

@end
