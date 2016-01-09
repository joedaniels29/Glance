#import "TTweet.h"
#import "TUser.h"

@implementation TTweet

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return [[NSDictionary mtl_identityPropertyMapWithModel:self]
            mtl_dictionaryByAddingEntriesFromDictionary:
                    @{
                      @"oid":@"id"
                    }];
}


- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;

    // Store a value that needs to be determined locally upon initialization.
    //_retrievedAt = [NSDate date]

    return self;
}
@end