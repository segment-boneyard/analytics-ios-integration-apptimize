#import "SEGApptimizeIntegration.h"

#import <Apptimize/Apptimize.h>
#import <Apptimize/Apptimize+Segment.h>


@implementation SEGApptimizeIntegration

- (instancetype)initWithSettings:(NSDictionary *)settings analytics:(SEGAnalytics *)analytics apptimize:(id)apptimizeClass;
{
    if (self = [super init]) {
        _settings = settings;
        _analytics = analytics;
        _apptimizeClass = apptimizeClass;

        [_apptimizeClass startApptimizeWithApplicationKey:[self.settings objectForKey:@"appkey"]];
        if (![(NSNumber *)[self.settings objectForKey:@"listen"] boolValue]) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(experimentDidGetViewed:)
                                                         name:ApptimizeTestRunNotification
                                                       object:nil];
        }
    }
    return self;
}

- (void)experimentDidGetViewed:(NSNotification *)notification
{
    if (!notification.userInfo[ApptimizeTestFirstRunUserInfoKey]) {
        return;
    }

    // Apptimize doesn't notify with IDs, so we iterate over all experiments to find the matching one.
    NSString *name = notification.userInfo[ApptimizeTestNameUserInfoKey];
    NSString *variant = notification.userInfo[ApptimizeVariantNameUserInfoKey];
    [[_apptimizeClass testInfo] enumerateKeysAndObjectsUsingBlock:^(id key, id<ApptimizeTestInfo> experiment, BOOL *stop) {
        BOOL match = [experiment.testName isEqualToString:name] && [experiment.enrolledVariantName isEqualToString:variant];
        if (!match) {
            return;
        }
        [self.analytics track:@"Experiment Viewed"
                   properties:@{
                       @"experimentId" : [experiment testID],
                       @"experimentName" : [experiment testName],
                       @"variationId" : [experiment enrolledVariantID],
                       @"variationName" : [experiment enrolledVariantName]
                   }];
        *stop = YES;
    }];
}

- (void)identify:(SEGIdentifyPayload *)payload
{
    if (payload.userId != nil) {
        [_apptimizeClass setUserAttributeString:payload.userId forKey:@"user_id"];
    }

    if (payload.traits) {
        [_apptimizeClass SEG_setUserAttributesFromDictionary:payload.traits];
    }
}

- (void)track:(SEGTrackPayload *)payload
{
    [_apptimizeClass SEG_track:payload.event attributes:payload.properties];
}


- (void)reset
{
    [_apptimizeClass SEG_resetUserData];
}

@end
