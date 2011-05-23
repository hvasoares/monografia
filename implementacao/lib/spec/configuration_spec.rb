require 'configuration'

describe CucumberFTC::Configuration do
	before :each do
		@expected_tags = ['ecp','bva','1wise']
		@integration = mock(
			CucumberFTC::CucumberIntegration::Facade
		)
	end

	it 'should configure the application' do
		CucumberFTC::CucumberIntegration::Facade.should_receive(
			:new
		).and_return(@integration)

	end
end
