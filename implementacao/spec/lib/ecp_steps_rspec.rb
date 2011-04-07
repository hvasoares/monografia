require 'cucumber'

describe 'ecp_steps' do
	before :all do
	@class_definition_step =  <<EOF
Given I had the following ecp classes:
| class		| definition		 |	is valid?| applies_to |
| number	| integer from 0 to 1    |	valid	 |  a,b	      |
| invalid	| strings		 |	invalid	 |  a,b	      |
EOF

	@step_mother = Cucumber::StepMother.new
	@step_mother.load_code_file(
	 File.dirname(__FILE__)+'/../../lib/ecp_steps.rb'
	)

	@step_mother.load_programming_language('rb')
	
	end

	
	it 'should create a class a integer class definition'  do
	 
		EcpClassesDefinitions.should_receive(:new)


	end
end
