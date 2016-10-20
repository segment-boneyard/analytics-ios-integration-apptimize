SpecBegin(InitialSpecs);

#define MINIMAL_VALID_SETTINGS @{@"appkey":@"TEST_APP_KEY"}

describe(@"factory", ^{
    it(@"creates integration with settings", ^{
        SEGApptimizeIntegration *integration = [[SEGApptimizeIntegrationFactory instance]
                                                createWithSettings:MINIMAL_VALID_SETTINGS
                                                forAnalytics:nil];

        expect(integration.settings).to.equal(MINIMAL_VALID_SETTINGS);
        expect(integration.analytics).to.equal(nil);
        expect(integration.apptimizeClass).notTo.equal(nil);
    });
});

describe(@"integration", ^{
    __block Class mockApptimize;
    __block SEGApptimizeIntegration *integration;

    beforeEach(^{
        mockApptimize = mockClass([Apptimize class]);
        integration = [[SEGApptimizeIntegration alloc]
                       initWithSettings:MINIMAL_VALID_SETTINGS
                       analytics:nil
                       apptimize:mockApptimize];
    });

    it(@"track", ^{
        SEGTrackPayload *payload = [[SEGTrackPayload alloc] initWithEvent:@"foo" properties:@{} context:@{} integrations:@{}];
        [integration track:payload];
        [verify(mockApptimize) SEG_track:@"foo" attributes:@{}];
    });

    it(@"identify", ^{
        SEGIdentifyPayload *payload = [[SEGIdentifyPayload alloc] initWithUserId:@"foo" anonymousId:@"bar" traits:@{} context:@{} integrations:@{}];
        [integration identify:payload];
        [verify(mockApptimize) setUserAttributeString:payload.userId forKey:@"user_id"];
        [verify(mockApptimize) SEG_setUserAttributesFromDictionary:@{}];
    });

    it(@"reset", ^{
        [integration reset];
        [verify(mockApptimize) SEG_resetUserData];
    });
});

SpecEnd
