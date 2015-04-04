#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "MTGSearchRequest.h"

@interface MTGSearchRequest (Test)
@property (strong, nonatomic) NSDictionary *query;
@end

SpecBegin(MTGSearchRequest)

describe(@"MTGSearchRequest", ^{
    __block MTGSearchRequest *request;
    __block NSDictionary *query;
    
    beforeEach(^{
        query = @{MTGSearchName : @"Unicorn",
                  MTGSearchManaCost : @3,
                  MTGSearchPower : @"infinity"};
        
        request = [[MTGSearchRequest alloc] initWithQuery:query];
    });
    
    it(@"does not blow up", ^{
        expect(request).notTo.beNil();
    });
    
    it(@"has NSNotFound as default pagination", ^{
        expect(request.pagination.location).equal(NSNotFound);
    });
    
    it(@"holds the original query dictionary", ^{
        expect(request.query).equal(query);
    });
    
    it(@"has the correct path", ^{
        expect(request.path).to.equal(@"/search");
    });
    
    it(@"has the correct response serialzation", ^{
        expect(request.responseSerializer).to.equal(MTGResponseSerializerCards);
    });
    
    context(@"#parameters", ^{
        context(@"w/o pagination", ^{
            __block NSDictionary *expectedDict;
            
            beforeEach(^{
                expectedDict = @{@"q" : @"manacost eq 3 and name m 'Unicorn' and power m 'infinity'"};
            });
            
            it(@"returns path w/ correct search query (in alphabetical order)", ^{
                expect(request.parameters).to.equal(expectedDict);
            });
        });
        
        context(@"w/ pagination", ^{
            __block NSDictionary *expectedDict;
            
            beforeEach(^{
                expectedDict = @{@"q" : @"manacost eq 3 and name m 'Unicorn' and power m 'infinity'",
                                 @"start" : @1,
                                 @"limit" : @10};
                
                request.pagination = NSMakeRange(1, 10);
            });
            
            it(@"should return a dictionary w/ the start and limit for pagination", ^{
                expect(request.parameters).to.equal(expectedDict);
            });
        });
    });
});

SpecEnd
