require 'configuration'

include CucumberFTC::ECP
describe CucumberFTC::ECP::Configuration do
	before :each do
		@instance = Configuration.new
	end

	it 'should create and facade' do
		facade = mock(facade)
		VariableDefinitions.should_receive(
			:new
		).with(:class_defs).and_return(:var_defs)

		ClassDefinition.should_receive(
			:new
		).and_return(:class_defs)

		Facade.should_receive(:new).with(
			:var_defs
		).and_return(facade)

		facade.should_receive(:register_class).with(
			CucumberFTC::ECP::IntegerRangeSemanticModel
		)

		@instance.facade
	end
end
