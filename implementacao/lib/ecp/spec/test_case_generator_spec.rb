require 'spec_helper'
require 'test_case_generator'

include CucumberFTC::ECP

describe CucumberFTC::ECP::TestCaseGenerator do
	it_should_require_the_right_argument_in_constructor(
		:argument_types=> VariableDefinitions,
		:class=>CucumberFTC::ECP::TestCaseGenerator
	)

	before :each do
		@var_defs = mock(VariableDefinitions)
		@var_defs.stub!(:is_a?).with(VariableDefinitions).and_return(
			true
		)
		@instance = CucumberFTC::ECP::TestCaseGenerator.new(@var_defs)
	end

	it 'should generate valid inputs test cases' do
		valid_semantic_1 = mock('SemanticModel1')
		valid_semantic_2 = mock('SemanticModel2')
		valid_semantic_3 = mock('SemanticModel3')
		valid_semantic_4 = mock('SemanticModel4')

		@var_defs.should_receive(:get_vars).with(
			no_args()
		).and_return(
			[:var_1,:var_2]
		)

		@var_defs.should_receive(
			:get_valid_inputs_for
		).with(:var_1).and_return(
			[valid_semantic_1,valid_semantic_2]
		)

		@var_defs.should_receive(
			:get_valid_inputs_for
		).with(:var_2).and_return(
			[valid_semantic_3,valid_semantic_4]
		)

		{
			valid_semantic_1 => :sample_1,
			valid_semantic_2 => :sample_2,
			valid_semantic_3 => :sample_3,
			valid_semantic_4 => :sample_4
		}.each{|semantic,sample|
			semantic.stub!(:sample).and_return(sample)
		}	

		@instance.generate.should == [
			[:sample_1,:sample_3],
			[:sample_1,:sample_4],
			[:sample_2,:sample_3],
			[:sample_2,:sample_4]
		]
	end
end
