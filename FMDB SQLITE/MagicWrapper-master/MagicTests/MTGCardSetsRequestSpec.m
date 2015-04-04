#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "MTGCardSetsRequest.h"

SpecBegin(MTGCardSetsRequest)

describe(@"MTGCardSetsRequest", ^{
    __block MTGCardSetsRequest *request;
    
    context(@"all card sets", ^{
        beforeEach(^{
            request = [[MTGCardSetsRequest alloc] init];
        });
        
        it(@"does not blow up", ^{
            expect(request).notTo.beNil();
        });
        
        it(@"has the correct path", ^{
            expect(request.path).to.equal(@"/sets");
        });
        
        it(@"has the correct path", ^{
            expect(request.parameters).to.beNil();
        });
        
        it(@"has the correct response serialzation", ^{
            expect(request.responseSerializer).to.equal(MTGResponseSerializerSets);
        });
    });

    context(@"given card sets", ^{
        __block NSArray *cardSets;
        
        beforeEach(^{
            cardSets = @[@"1ED", @"4ED"];
            request = [[MTGCardSetsRequest alloc] initWithCardSets:cardSets];
        });
        
        it(@"does not blow up", ^{
            expect(request).notTo.beNil();
        });
        
        it(@"has the correct path", ^{
            expect(request.path).to.equal(@"/sets/1ED,4ED");
        });
        
        it(@"has the correct path", ^{
            expect(request.parameters).to.beNil();
        });
        
        it(@"has the correct response serialzation", ^{
            expect(request.responseSerializer).to.equal(MTGResponseSerializerSets);
        });
    });
});

SpecEnd
