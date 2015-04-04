#import "MTGCardTypesRequest.h"

@implementation MTGCardTypesRequest

#pragma mark - Request

- (NSString *)path
{
    return @"/cards/types";
}

@end
