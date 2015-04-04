#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "MTGCardRequest.h"

SpecBegin(MTGCardRequest)

describe(@"MTGCardRequest", ^{
    __block MTGCardRequest *request;
    
    beforeEach(^{
        request = [[MTGCardRequest alloc] initWithCardID:@"420"];
    });
    
    it(@"does not blow up", ^{
        expect(request).notTo.beNil();
    });
    
    it(@"has the correct path", ^{
        expect(request.path).to.equal(@"/cards/420");
    });
    
    it(@"has the correct path", ^{
        expect(request.parameters).to.beNil();
    });
});

SpecEnd
