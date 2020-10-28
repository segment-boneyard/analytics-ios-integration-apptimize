#import <Foundation/Foundation.h>

#if defined(__has_include) && __has_include(<Analytics/SEGAnalytics.h>)
#import <Analytics/SEGIntegration.h>
#import <Analytics/SEGAnalytics.h>
#else
#import <Segment/SEGIntegration.h>
#import <Segment/SEGAnalytics.h>
#endif

@interface SEGApptimizeIntegration : NSObject <SEGIntegration>

@property (nonatomic, readonly) NSDictionary *settings;
@property (nonatomic, readonly) SEGAnalytics *analytics;
@property (nonatomic, strong) Class apptimizeClass;

- (instancetype)initWithSettings:(NSDictionary *)settings analytics:(SEGAnalytics *)analytics apptimize:(id)apptimizeClass;

@end
