#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>
#import "MTGResponse.h"
#import "MTGRequest.h"
#import "MTGCard.h"
#import "MTGCardSet.h"
#import "MTGCardsFixture.h"
#import "MTGSetsFixture.h"

@interface MTGCard ()
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end

@interface MTGCardSet ()
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end

SpecBegin(MTGResponse)

describe(@"MTGResponse", ^{
    __block MTGResponse *response;
    __block NSArray *cards;
    __block NSArray *sets;
    __block id mockRequest;
    __block MTGRequest *passedRequest;
    __block id passedObject;
    
    beforeEach(^{
        cards = [MTGCardsFixture cardsFixture];
        sets = [MTGSetsFixture setsFixture];
    });
    
    context(@"MTGResponseSerializerCard", ^{
        beforeEach(^{
            mockRequest = OCMClassMock([MTGRequest class]);
            OCMStub([mockRequest responseSerializer]).andReturn(MTGResponseSerializerCard);
            response = [[MTGResponse alloc] initWithResponseObject:cards.firstObject];
            
            [response serializeResponseForRequest:mockRequest
                                          success:^(MTGRequest *request, id object) {
                                              passedRequest = request;
                                              passedObject = object;
                                          }];
        });
        
        it(@"returns the correct request object", ^{
            expect(passedRequest).to.equal(mockRequest);
        });
        
        it(@"returns the correct card", ^{
            MTGCard *expectedCard = [[MTGCard alloc] initWithDictionary:cards.firstObject];
            expect(passedObject).to.beInstanceOf([MTGCard class]);
            expect(passedObject).to.equal(expectedCard);
        });
    });
    
    context(@"MTGResponseSerializerCards", ^{
        beforeEach(^{
            mockRequest = OCMClassMock([MTGRequest class]);
            OCMStub([mockRequest responseSerializer]).andReturn(MTGResponseSerializerCards);
            response = [[MTGResponse alloc] initWithResponseObject:cards];
            
            [response serializeResponseForRequest:mockRequest
                                          success:^(MTGRequest *request, id object) {
                                              passedRequest = request;
                                              passedObject = object;
                                          }];
        });
        
        it(@"returns the correct request object", ^{
            expect(passedRequest).to.equal(mockRequest);
        });
        
        it(@"returns the correct array of cards", ^{
            MTGCard *expectedCard = [[MTGCard alloc] initWithDictionary:cards.firstObject];
            
            expect(passedObject).to.beKindOf([NSArray class]);
            expect([passedObject count]).to.equal(2);
            
            expect([passedObject firstObject]).to.equal(expectedCard);
        });
    });
    
    context(@"MTGResponseSerializerSet", ^{
        beforeEach(^{
            mockRequest = OCMClassMock([MTGRequest class]);
            OCMStub([mockRequest responseSerializer]).andReturn(MTGResponseSerializerSet);
            response = [[MTGResponse alloc] initWithResponseObject:sets.firstObject];
            
            [response serializeResponseForRequest:mockRequest
                                          success:^(MTGRequest *request, id object) {
                                              passedRequest = request;
                                              passedObject = object;
                                          }];
        });
        
        it(@"returns the correct request object", ^{
            expect(passedRequest).to.equal(mockRequest);
        });
        
        it(@"returns the correct set", ^{
            MTGCardSet *expectedSet = [[MTGCardSet alloc] initWithDictionary:sets.firstObject];
            expect(passedObject).to.beInstanceOf([MTGCardSet class]);
            expect(passedObject).to.equal(expectedSet);
        });
    });
    
    context(@"MTGResponseSerializerSets", ^{
        beforeEach(^{
            mockRequest = OCMClassMock([MTGRequest class]);
            OCMStub([mockRequest responseSerializer]).andReturn(MTGResponseSerializerSets);
            response = [[MTGResponse alloc] initWithResponseObject:sets];
            
            [response serializeResponseForRequest:mockRequest
                                          success:^(MTGRequest *request, id object) {
                                              passedRequest = request;
                                              passedObject = object;
                                          }];
        });
        
        it(@"returns the correct request object", ^{
            expect(passedRequest).to.equal(mockRequest);
        });
        
        it(@"returns the correct array of sets", ^{
            MTGCardSet *expectedSet = [[MTGCardSet alloc] initWithDictionary:sets.firstObject];
            
            expect(passedObject).to.beKindOf([NSArray class]);
            expect([passedObject count]).to.equal(2);
            
            expect([passedObject firstObject]).to.equal(expectedSet);
        });
    });
});

SpecEnd
