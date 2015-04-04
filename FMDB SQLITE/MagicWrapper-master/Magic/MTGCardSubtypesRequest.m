#import "MTGCardSubtypesRequest.h"

@implementation MTGCardSubtypesRequest

#pragma mark - Request

- (NSString *)path
{
    return @"/cards/subtypes";
}

@end
