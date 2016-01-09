#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@class TUser;

@interface TTweet : MTLModel <MTLJSONSerializing>
@property (nonatomic, nullable, strong) TUser * user;
//@property (nonatomic, copy, readonly) NSString *coordinates;
@property (readonly, nonatomic, assign, getter = wasTruncated) BOOL truncated;
@property (nonatomic, copy, readonly) NSString *created_at;
@property (readonly, nonatomic, assign, getter = isFavorited) BOOL favorited;
@property (nonatomic, copy, readonly) NSString *id_str;
//@property (nonatomic, copy, readonly) NSString *in_reply_to_user_id_str;


@property (nonatomic, nullable, copy, readonly) NSString * text;
//@property (nonatomic, nullable, copy, readonly) NSString * contributors;
@property (nonatomic, nullable, copy, readonly) NSNumber * oid;
@property (nonatomic, nullable, copy, readonly) NSString * in_reply_to_status_id_str;
//@property (nonatomic, nullable, copy, readonly) NSDictionary * geo;
@property (nonatomic, nullable, copy, readonly) NSNumber * retweet_count;
@property (nonatomic, nullable, copy, readonly) NSNumber * in_reply_to_user_id;
//@property (nonatomic, nullable, copy, readonly) NSString * place;
//@property (nonatomic, nullable, copy, readonly) NSString * source;
@property (readonly, nonatomic, assign, getter = wasRetweeted) BOOL retweeted;


@property (nonatomic, nullable, copy, readonly) NSString * in_reply_to_screen_name;
//in_reply_to_status_id
//currently ignoring
//coordinates



@end