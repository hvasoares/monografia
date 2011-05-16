require 'spec_helper'
require 'facade'

describe CucumberFTC::ECP::Facade do

	it_should_require_the_right_argument_in_constructor(
		:argument_types => CucumberFTC::ECP::VariableDefinitions,
		:class => CucumberFTC::ECP::Facade
	)


	context 'after succesful construction' do
		before :each do 
			@var_defs =mock(
				CucumberFTC::ECP::VariableDefinitions
			)
			@var_defs.stub!(:is_a?).with(
				CucumberFTC::ECP::VariableDefinitions
			).and_return(true)

			@instance = CucumberFTC::ECP::Facade.new(@var_defs)
			@semantic_model_class = mock(
				'semantic_model',
				:super_class => CucumberFTC::ECP::SemanticModel
			)
		end

		it 'should register a class and its semantic model' do
			@var_defs.should_receive(
				:register_semantic_model
			).with(
				@semantic_model_class
			)

			@instance.register_class(@semantic_model_class)
		end

		it 'should declare variables' do
			@var_defs.should_receive(:declare).with(:var_name)
			@var_defs.should_receive(:with_description).with(
				'description'
			)
			@instance.register_variable :var_name,'description'
		end

		it 'should declare invalid inputs for variables' do
			@var_defs.should_receive(:declare_invalid_input).with(:var_name)
			@var_defs.should_receive(:with_description).with(
				'description'
			)

			@instance.declare_invalid_variable(:var_name,'description')
		end

		context 'when variables are declared' do
			before :each do
				@var_defs.stub!(:declare)
				@var_defs.stub!(:with_description)
				@var_defs.stub!(:declare_invalid_input)
				@var_defs.stub!(:is_a?).and_return(true)

				@instance.register_variable(
					:var_name,
					'description'
				)
				@instance.declare_invalid_variable(
					:var_name,
					'description'
				)
			end

			it 'should generate an hash with variable name and its 
				combinations' do
				generator = mock(TestCaseGenerator)
				TestCaseGenerator.should_receive(
					:new
				).with(
					@var_defs
				).and_return(generator)

				generator.should_receive(:generate).and_return(
					:test_cases
				)
				
				@instance.generate_tests.should == :test_cases
			end

			it 'should generate all valid inputs' do
				@var_defs.should_receive(:get_all_valid_inputs).and_return(:inputs)
				@instance.get_all_valid_inputs.should == :inputs
			end
		end

	end

end
