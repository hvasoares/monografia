require 'spec_helper'
require 'runtime'

include CucumberFTC::CucumberIntegration
describe Runtime do
	it_should_require_the_right_argument_in_constructor(
		:argument_types =>[
			Cucumber::Runtime,
			CucumberFTC::CucumberIntegration::Configuration
		],
		:class => CucumberFTC::CucumberIntegration::Runtime
	)

	before :each do
		@configuration = create_mock_for_class(Configuration)
		@inner_runtime = create_mock_for_class(
			Cucumber::Runtime
		)
		@instance = Runtime.new(@inner_runtime,@configuration)
	end

	it 'should pass any non implemented method to inner_runtime' do
		@inner_runtime.should_receive(
			:method_name
		).with(1,2,3).and_return(:result)

		@instance.method_name(1,2,3).should == :result
	end

	it 'should run an runtime' do
		@inner_runtime.should_receive(:configure).with(
			@configuration
		)
		@inner_runtime.should_receive(:run!)
		@instance.run!
	end
end
