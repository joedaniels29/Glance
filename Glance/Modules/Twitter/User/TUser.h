#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface TUser : MTLModel <MTLJSONSerializing>
@property(nonatomic, nullable, copy, readonly) NSString *name;
@property(nonatomic, nullable, copy, readonly) NSString *profile_sidebar_fill_color;
@property(readonly, nonatomic, assign, getter = profileBackgroundTiled) BOOL profile_background_tile;
@property(nonatomic, nullable, copy, readonly) NSString *profile_sidebar_border_color;
@property (nonatomic, nullable, strong) NSDate * profile_image_url;

@property(nonatomic, nullable, strong) NSDate *created_at;
@property(nonatomic, nullable, copy, readonly) NSString *location;
@property(readonly, nonatomic, assign, getter = followRequestIsSent) BOOL follow_request_sent;
@property(nonatomic, nullable, copy, readonly) NSString *id_str;

@property(readonly, nonatomic, assign) BOOL is_translator;
@property(nonatomic, nullable, copy, readonly) NSString *profile_link_color;
//ignore        entities
@property(readonly, nonatomic, assign, getter = isDefaultProfile) BOOL default_profile;
@property(nonatomic, nullable, copy, readonly) NSString *url;
@property(readonly, nonatomic, assign, getter = isContributorsEnabled) BOOL contributors_enabled;
@property(nonatomic, nullable, copy, readonly) NSNumber *favourites_count;
@property(nonatomic, nullable, copy, readonly) NSNumber *utc_offset;

@property(nonatomic, nullable,  strong) NSURL *profile_image_url_https;
@property(nonatomic, nullable, copy, readonly) NSNumber *oid;
@property(nonatomic, nullable, copy, readonly) NSNumber *listed_count;
@property(readonly, nonatomic, assign, getter = profileShouldUseBackgroundImage) BOOL profile_use_background_image;
@property(nonatomic, nullable, copy, readonly) NSString *profile_text_color;
@property(nonatomic, nullable, copy, readonly) NSNumber *followers_count;
@property(nonatomic, nullable, copy, readonly) NSString *lang;
@property(readonly, nonatomic, assign, getter = isProtected) BOOL user_protected;
@property(readonly, nonatomic, assign, getter = isGeoEnabled) BOOL geo_enabled;
@property(readonly, nonatomic, assign, getter = notificationsEnabled) BOOL notifications;
@property(nonatomic, nullable, copy, readonly) NSString *user_description;

@property(nonatomic, nullable, copy, readonly) NSString *profile_background_color;
@property(readonly, nonatomic, assign, getter = isVerified) BOOL verified;
@property(nonatomic, nullable, copy, readonly) NSString *time_zone;

@property(nonatomic, nullable,  strong) NSURL *profile_background_image_url_https;
@property(nonatomic, nullable, copy, readonly) NSNumber *statuses_count;
@property(nonatomic, nullable, strong) NSURL *profile_background_image_url;
@property(readonly, nonatomic, assign, getter = hasDefaultProfileImage) BOOL default_profile_image;
@property(nonatomic, nullable, copy, readonly) NSNumber *friends_count;
@property(readonly, nonatomic, assign, getter = isFollowing) BOOL following;
@property(readonly, nonatomic, assign, getter = shouldShowAllInlineMedia) BOOL show_all_inline_media;

@property(nonatomic, nullable, copy, readonly) NSString *screen_name;
@end