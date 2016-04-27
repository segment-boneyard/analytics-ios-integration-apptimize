SpecBegin(InitialSpecs);

describe(@"factory", ^{
    it(@"creates integration with settings", ^{
        SEGApptimizeIntegration *integration = [[SEGApptimizeIntegrationFactory instance] createWithSettings:@{
        } forAnalytics:nil];

        expect(integration.settings).to.equal(@{});
    });
});

SpecEnd
