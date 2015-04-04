#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "MTGCardSubtypesRequest.h"

SpecBegin(MTGCardSubtypesRequest)

describe(@"MTGCardSubtypesRequest", ^{
    __block MTGCardSubtypesRequest *request;

    beforeEach(^{
        request = [[MTGCardSubtypesRequest alloc] init];
    });
    
    it(@"does not blow up", ^{
        expect(request).notTo.beNil();
    });
    
    it(@"has the correct path", ^{
        expect(request.path).to.equal(@"/cards/subtypes");
    });
    
    it(@"has the correct path", ^{
        expect(request.parameters).to.beNil();
    });
});

SpecEnd
