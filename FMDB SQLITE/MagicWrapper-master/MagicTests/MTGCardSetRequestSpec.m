#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "MTGCardSetRequest.h"

SpecBegin(MTGCardSetRequest)

describe(@"MTGCardSetRequest", ^{
    __block MTGCardSetRequest *request;
    
    beforeEach(^{
        request = [[MTGCardSetRequest alloc] initWithSetID:@"420"];
    });
    
    it(@"does not blow up", ^{
        expect(request).notTo.beNil();
    });
    
    it(@"has the correct path", ^{
        expect(request.path).to.equal(@"/sets/420");
    });
    
    it(@"has the correct path", ^{
        expect(request.parameters).to.beNil();
    });
    
    it(@"has the correct response serialzation", ^{
        expect(request.responseSerializer).to.equal(MTGResponseSerializerSet);
    });
});

SpecEnd
