require 'spec_helper'
require 'variable_definitions'

include CucumberFTC::ECP
describe CucumberFTC::ECP::VariableDefinitions do
	it_should_require_the_right_argument_in_constructor(
		:argument_types => CucumberFTC::ECP::ClassDefinition,
		:class=>CucumberFTC::ECP::VariableDefinitions
	)

	context 'when is created' do
		before :each do
			@class_defs = mock('defs')
			@class_defs.stub!(:is_a?).with(
				CucumberFTC::ECP::ClassDefinition
			).and_return(true)
			@instance = CucumberFTC::ECP::VariableDefinitions.new(@class_defs)
		end

		it 'should register the possible classes which an variable can be member' do
			@class_defs.should_receive(:register_semantic_model).with(
				:semantic_model
			)


			@instance.register_semantic_model(:semantic_model)
		end

		it 'should register a variable' do
			@class_defs.should_receive(:description_match_any_semantic_model?).with('description').and_return(true)
			ecp_class = mock('ecpclass',:name=>'var name')
			ecp_class.should_receive(:sample).twice.and_return(:sample)
			@class_defs.should_receive(:define_class).with(
				'var name',
				'description'
			).and_return(ecp_class)
			@instance.declare('var name').with_description('description')
			@instance.get_vars.should == ['var name']
			@instance.get_valid_inputs_for('var name').should == [
				:sample
			]

			@instance.get_all_valid_inputs.should == [
				[:sample]
			]
		end

		it 'should throw an error if no regex match the variable description' do
			@class_defs.should_receive(:description_match_any_semantic_model?).with('description').and_return(false)
			lambda{
				@instance.declare('var name').with_description('description')
			}.should raise_error(NoRegexForClassName)
		end

		it 'should declare invalid input for variables' do
			@class_defs.should_receive(:description_match_any_semantic_model?).with('description').and_return(true)
			@class_defs.should_receive(:define_class).with(
				'var name',
				'description'
			).and_return(
				mock('var',:name=>'var name')
			)
			@instance.declare('var name').with_description("description")
			@instance.get_vars.should == ['var name']
		end
	end

end
