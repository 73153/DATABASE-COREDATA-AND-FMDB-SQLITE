#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "MTGCardSet.h"
#import "MTGSetsFixture.h"

@interface MTGCardSet ()
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end

SpecBegin(MTGCardSet)

describe(@"MTGCardSet", ^{
    __block MTGCardSet *cardSet;
    __block NSArray *cardSets;
    
    beforeEach(^{
        cardSets = [MTGSetsFixture setsFixture];
        cardSet = [[MTGCardSet alloc] initWithDictionary:cardSets.lastObject];
    });
    
    describe(@"properties", ^{
        it(@"has the correct number of basic lands", ^{
            expect(cardSet.basicLand).to.equal(20);
        });
        
        it(@"has the correct block", ^{
            expect(cardSet.block).to.equal(@"Khans of Tarkir");
        });
        
        it(@"has the correct card IDs", ^{
            expect(cardSet.cardIDs).to.equal(@[@386603, @386604]);
            expect(cardSet.cardIDs.count).to.equal(2);
        });
        
        it(@"has the correct number of common cards", ^{
            expect(cardSet.common).to.equal(101);
        });
        
        it(@"has the correct description", ^{
            expect(cardSet.shortDescription).to.equal(@"Tarkir is a world embattled with ambitious warlords and powerful clans that wage eternal war for supremacy of their plane, a conflict that spans over a thousand years. Tarkir is also the home plane of Sarkhan Vol. It was previously inhabited by dragons, all of whom were killed before Sarkhan's period of servitude. The clans each worship one aspect of the extinct dragons.");
        });
        
        it(@"has the correct id/identifier", ^{
            expect(cardSet.identifier).to.equal(@"KTK");
        });
        
        it(@"has the correct number of mythinc rares", ^{
            expect(cardSet.mythicRare).to.equal(15);
        });
        
        it(@"has the correct name", ^{
            expect(cardSet.name).to.equal(@"Khans of Tarkir");
        });
        
        it(@"has the correct number of rares", ^{
            expect(cardSet.rare).to.equal(53);
        });
        
        it(@"has the correct released data", ^{
            expect(cardSet.releasedAt).to.equal(@"2014-09-26");
        });
        
        it(@"has the correct number of total cards", ^{
            expect(cardSet.total).to.equal(269);
        });
        
        it(@"has the correct type", ^{
            expect(cardSet.type).to.equal(@"Expansion");
        });
        
        it(@"has the correct number of uncommon cards", ^{
            expect(cardSet.uncommon).to.equal(80);
        });
    });
    
    describe(@"isEqual:", ^{
        __block MTGCardSet *cardSet1, *cardSet2, *cardSet3;
        
        beforeEach(^{
            cardSet1 = [[MTGCardSet alloc] initWithDictionary:cardSets.firstObject];
            cardSet2 = [[MTGCardSet alloc] initWithDictionary:cardSets.lastObject];
            cardSet3 = [[MTGCardSet alloc] initWithDictionary:cardSets.lastObject];
        });
        
        it(@"returns FALSE when comparing sets 1 and 2", ^{
            expect([cardSet1 isEqual:cardSet2]).to.beFalsy();
        });
        
        it(@"returns TRUE when comparing sets 2 and 3", ^{
            expect([cardSet2 isEqual:cardSet3]).to.beTruthy();
        });
    });
});

SpecEnd
