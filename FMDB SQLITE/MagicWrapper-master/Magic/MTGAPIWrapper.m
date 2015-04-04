#import <AFNetworking/AFNetworking.h>
#import "MTGAPIWrapper.h"
#import "MTGRequest.h"

static NSString *const kMTGAPIBaseURL = @"http://api.mtgdb.info";

@interface MTGAPIWrapper ()
@property (nonatomic, strong) AFHTTPRequestOperationManager *reqManager;
@end

@implementation MTGAPIWrapper

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.reqManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kMTGAPIBaseURL]];
    }
    
    return self;
}

- (void)submitRequest:(MTGRequest *)request
              success:(void (^)(MTGRequest *request, id responseObject))success
              failure:(void (^)(MTGRequest *request, NSError *error))failure
{
    [self.reqManager GET:request.path
              parameters:request.parameters
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     MTGResponse *response = [[MTGResponse alloc] initWithResponseObject:responseObject];
                     [response serializeResponseForRequest:request
                                                   success:success];
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     failure(request, error);
                 }];
}

@end
