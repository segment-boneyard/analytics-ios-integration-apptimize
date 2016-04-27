#import <Foundation/Foundation.h>
#import <Analytics/SEGIntegration.h>


@interface SEGApptimizeIntegration : NSObject <SEGIntegration>

@property (nonatomic, readonly) NSDictionary *settings;

- (instancetype)initWithSettings:(NSDictionary *)settings;

@end
