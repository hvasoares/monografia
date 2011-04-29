require 'facade' 

	include CucumberFTC::CucumberIntegration
describe CucumberFTC::CucumberIntegration::Facade do
	before :each do
		@instance = CucumberFTC::CucumberIntegration::Facade.new 

		@configuration = mock(Configuration)
	end

	it 'should construct a main class' do
		construct_main
	end

	def construct_main
		Cucumber::Cli::Configuration.should_receive(
			:new
		).and_return(:cucumber_config)

		Configuration.should_receive(:new).with(
			:cucumber_config
		).and_return(@configuration)

		Cucumber::Runtime.should_receive(:new).and_return(
			:cucumber_runtime
		)

		Runtime.should_receive(:new).with(
			:cucumber_runtime,
			@configuration
		).and_return(:runtime)

		@configuration.should_receive(:runtime=).with(:runtime)

		Main.should_receive(:new).with(
			:runtime,@configuration
		).and_return(:main)

		@instance.main.should == :main

	end

	it 'should pass feature name to treewalker' do
		construct_main

		run_tree_walker

		@instance.features.should == :features

		test_treewalker_proxying_one_arg_method(
			:method => :scenarios_for
		)

		test_treewalker_proxying_one_arg_method(
			:method => :steps_for
		)

		test_treewalker_proxying_one_arg_method(
			:method => :inputs_declaration_for
		)
	end

	def run_tree_walker
		tree_walker = 	mock('tree_walker',
			:features => :features
		)

		@configuration.should_receive(:tree_walker).and_return(
			tree_walker
		)
		return tree_walker
	end

	def test_treewalker_proxying_one_arg_method opts={}

		run_tree_walker.should_receive(
			opts[:method]
		).with(:args).and_return(:return_value)

		@instance.method(
			opts[:method]
		).call(:args).should == :return_value
	end

end
