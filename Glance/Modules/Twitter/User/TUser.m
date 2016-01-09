#import "TUser.h"


@implementation TUser
+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    //Wed Dec 01 17:08:03 +0000 2010
    [df setDateFormat:@"eee MMM dd HH:mm:ss ZZZZ yyyy"];
    return df;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return [[NSDictionary mtl_identityPropertyMapWithModel:self]
            mtl_dictionaryByAddingEntriesFromDictionary:
                    @{
                            @"oid" : @"id"
                            @"user_protected":@"protected",
                            @"user_description":@"description",
                    }];
}

+ (NSValueTransformer *)profile_image_urlJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter dateFromString:dateString];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter stringFromDate:date];
    }];
}
+ (NSValueTransformer *)created_atJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter dateFromString:dateString];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [self.dateFormatter stringFromDate:date];
    }];
}
+ (NSValueTransformer *)profile_image_url_httpsJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}
+ (NSValueTransformer *)profile_background_image_url_httpsJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}
+ (NSValueTransformer *)profile_background_image_urlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}


- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;

    // Store a value that needs to be determined locally upon initialization.
    //_retrievedAt = [NSDate date];

    return self;
}
@end