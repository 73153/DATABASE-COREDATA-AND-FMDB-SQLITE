#import "NSDictionary+MagicWrapper.h"

@implementation NSDictionary (MagicWrapper)

- (id)mtg_objectForKey:(id)key
{
    if ([self objectForKey:key] && ![[self objectForKey:key] isKindOfClass:[NSNull class]]) {
        return [self objectForKey:key];
    } else {
        return nil;
    }
}

@end
