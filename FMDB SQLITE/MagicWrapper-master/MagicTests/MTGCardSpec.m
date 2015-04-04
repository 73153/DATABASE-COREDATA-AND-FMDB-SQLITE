#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "MTGCard.h"
#import "MTGCardsFixture.h"

@interface MTGCard ()
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end

SpecBegin(MTGCard)

describe(@"MTGCard", ^{
    __block MTGCard *card;
    __block NSArray *cards;
    
    beforeEach(^{
        cards = [MTGCardsFixture cardsFixture];
    });
    
    describe(@"properties", ^{
        context(@"fake card", ^{
            beforeEach(^{
                card = [[MTGCard alloc] initWithDictionary:cards.firstObject];
            });
            
            it(@"has the correct promo", ^{
                expect(card.promo).to.beFalsy();
            });
            
            it(@"has the correct subType", ^{
                expect(card.subType).to.beNil();
            });
            
            it(@"has the correct token", ^{
                expect(card.token).to.beTruthy();
            });
        });
        
        context(@"real card", ^{
            beforeEach(^{
                card = [[MTGCard alloc] initWithDictionary:cards.lastObject];
            });
            
            it(@"has the correct low res URL", ^{
                NSURL *expectedURL = [NSURL URLWithString:@"http://api.mtgdb.info/content/card_images/386466.jpeg"];
                expect(card.lowResURL).to.equal(expectedURL);
            });
            
            it(@"has the correct high res URL", ^{
                NSURL *expectedURL = [NSURL URLWithString:@"http://api.mtgdb.info/content/hi_res_card_images/386466.jpg"];
                expect(card.highResURL).to.equal(expectedURL);
            });
            
            it(@"has the correct name", ^{
                expect(card.artist).to.equal(@"Chris Rahn");
            });
            
            it(@"has the correct cardSetID", ^{
                expect(card.cardSetId).to.equal(@"KTK");
            });
            
            it(@"has the correct colors", ^{
                expect(card.colors).to.equal(@[@"white"]);
            });
            
            it(@"has the correct colors", ^{
                expect(card.convertedManaCost).to.equal(4);
            });
            
            it(@"has the correct text/description", ^{
                expect(card.text).to.equal(@"Outlast {White} ({White}, {Tap}: Put a +1/+1 counter on this creature. Outlast only as a sorcery.)\n\nEach creature you control with a +1/+1 counter on it has lifelink.");
            });
            
            it(@"has the correct flavor", ^{
                expect(card.flavor).to.equal(@"\"Wherever I walk, the ancestors walk too.\"");
            });
            
            it(@"has the correct identifier/id", ^{
                expect(card.identifier).to.equal(386466);
            });
            
            it(@"has the correct loyalty", ^{
                expect(card.loyalty).to.equal(0);
            });
            
            it(@"has the correct manaCost", ^{
                expect(card.manaCost).to.equal(@"3W");
            });
            
            it(@"has the correct name", ^{
                expect(card.name).to.equal(@"Abzan Battle Priest");
            });
            
            it(@"has the correct power", ^{
                expect(card.power).to.equal(3);
            });
            
            it(@"has the correct promo", ^{
                expect(card.promo).to.beFalsy();
            });
            
            it(@"has the correct rarity", ^{
                expect(card.rarity).to.equal(@"Uncommon");
            });
            
            it(@"has the correct relatedCardId", ^{
                expect(card.relatedCardId).to.equal(0);
            });
            
            it(@"has the correct releasedAt", ^{
                expect(card.releasedAt).to.equal(@"2014-09-26");
            });
            
            it(@"has the correct searchName", ^{
                expect(card.searchName).to.equal(@"abzanbattlepriest");
            });
            
            it(@"has the correct setNumber", ^{
                expect(card.setNumber).to.equal(1);
            });
            
            it(@"has the correct subType", ^{
                expect(card.subType).to.equal(@"Human Cleric");
            });
            
            it(@"has the correct token", ^{
                expect(card.token).to.beFalsy();
            });
            
            it(@"has the correct toughness", ^{
                expect(card.toughness).to.equal(2);
            });
            
            it(@"has the correct type", ^{
                expect(card.type).to.equal(@"Creature");
            });
        });
    });
    
    describe(@"isEqual:", ^{
        __block MTGCard *card1, *card2, *card3;
        
        beforeEach(^{
            card1 = [[MTGCard alloc] initWithDictionary:cards.firstObject];
            card2 = [[MTGCard alloc] initWithDictionary:cards.lastObject];
            card3 = [[MTGCard alloc] initWithDictionary:cards.lastObject];
        });
        
        it(@"returns FALSE when comparing cards 1 and 2", ^{
            expect([card1 isEqual:card2]).to.beFalsy();
        });
        
        it(@"returns TRUE when comparing cards 2 and 3", ^{
            expect([card2 isEqual:card3]).to.beTruthy();
        });
    });
});

SpecEnd
