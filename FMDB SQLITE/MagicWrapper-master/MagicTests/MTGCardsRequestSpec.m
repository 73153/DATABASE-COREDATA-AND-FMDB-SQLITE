#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "MTGCardsRequest.h"

SpecBegin(MTGCardsRequest)

describe(@"MTGCardsRequest", ^{
    describe(@"#initWithCardIDs:", ^{
        __block MTGCardsRequest *requestCardIDs;
        __block NSArray *cardIDs;
        
        beforeEach(^{
            cardIDs = @[@"123", @"321"];
            requestCardIDs = [[MTGCardsRequest alloc] initWithCardIDs:cardIDs];
        });
        
        it(@"has NSNotFound as default pagination", ^{
            expect(requestCardIDs.pagination.location).equal(NSNotFound);
        });
        
        it(@"return the correct path", ^{
            expect(requestCardIDs.path).to.equal(@"/cards/123,321");
        });
        
        it(@"returns the correct dictionary of parameters", ^{
            expect(requestCardIDs.parameters).to.beNil();
        });
        
        it(@"has the correct response serialzation", ^{
            expect(requestCardIDs.responseSerializer).to.equal(MTGResponseSerializerCards);
        });
    });
    
    describe(@"#initWithSetID:", ^{
        __block MTGCardsRequest *requestSetID;
        __block NSDictionary *expectedDict;
        __block NSString *setID;
        
        beforeEach(^{
            setID = @"KTK";
            expectedDict = @{@"start" : @5, @"end" : @14};
            
            requestSetID = [[MTGCardsRequest alloc] initWithSetID:setID];
            requestSetID.pagination = NSMakeRange(5, 10);
        });
        
        it(@"return the correct path", ^{
            expect(requestSetID.path).to.equal(@"/sets/KTK/cards");
        });
        
        it(@"returns the correct dictionary of parameters", ^{
            expect(requestSetID.parameters).to.equal(expectedDict);
        });
        
        it(@"has the correct response serialzation", ^{
            expect(requestSetID.responseSerializer).to.equal(MTGResponseSerializerCards);
        });
    });
});

SpecEnd
