require 'spec_helper'
require 'configuration'

include CucumberFTC::CucumberIntegration
describe Configuration do
	it_should_require_the_right_argument_in_constructor(
		:argument_types => [Cucumber::Cli::Configuration],
		:class=>CucumberFTC::CucumberIntegration::Configuration
	)

	before :each do
		@configuration=	create_mock_for_class(
			Cucumber::Cli::Configuration
		)

		@instance = Configuration.new(@configuration)
	end
	
	it 'should build an treewalker with runtime' do
		@instance.runtime = :passed_runtime
		CucumberFTC::CucumberIntegration::TreeWalker.should_receive(
			:new
		).with(:passed_runtime).and_return(:tree_walker)
		@instance.build_tree_walker(:runtime).should == :tree_walker
	end

	it 'should call inner configuration methods if the method isnt implemented' do
		@configuration.should_receive(:method_name).with(1,2,3).and_return(:result)
		@instance.method_name(1,2,3)
	end

end
