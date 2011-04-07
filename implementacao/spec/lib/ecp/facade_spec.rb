require 'lib/ecp/facade'

describe CucumberFTC::ECP::Facade do
	it 'should receive an class definition and a variable register as constructor arguments' do
		CucumberFTC::ECP::ClassDefinition.should_receive(:new)
		CucumberFTC::ECP::VariablesDefinition.should_receive(:new)
		CucumberFTC::ECP::Facade.new
	end
	
end
