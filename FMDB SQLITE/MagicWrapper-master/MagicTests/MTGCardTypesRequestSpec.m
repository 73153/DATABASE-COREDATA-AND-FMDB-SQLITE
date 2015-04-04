#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "MTGCardTypesRequest.h"

SpecBegin(MTGCardTypesRequest)

describe(@"MTGCardTypesRequest", ^{
    __block MTGCardTypesRequest *request;

    beforeEach(^{
        request = [[MTGCardTypesRequest alloc] init];
    });
    
    it(@"does not blow up", ^{
        expect(request).notTo.beNil();
    });
    
    it(@"has the correct path", ^{
        expect(request.path).to.equal(@"/cards/types");
    });
    
    it(@"has the correct path", ^{
        expect(request.parameters).to.beNil();
    });
});

SpecEnd
