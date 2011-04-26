require 'spec_helper' 
require 'main'

include CucumberFTC::CucumberIntegration
describe Main do
	it_should_require_the_right_argument_in_constructor(
		:argument_types => [
			CucumberFTC::CucumberIntegration::Configuration,
			CucumberFTC::CucumberIntegration::Runtime
		],
		:class => Main
	)	

	before :each do
		@configuration = create_mock_for_class(Configuration)
		@runtime = create_mock_for_class(Runtime)
		@instance = Main.new(@runtime,@configuration)
	end

	def create_mock_for_class klass
		result = mock(klass)
		result.stub!(:is_a?).with(klass).and_return(true)
		return result
	end

	it 'should run with and argv vector' do
		argv = mock('argv')
		@configuration.should_receive(:parse!).with(argv)
		@runtime.should_receive(:run!)
		@instance.run(argv)
	end
end
