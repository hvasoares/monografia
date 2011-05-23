require 'facade'
require 'integer_range_semantic_model'
describe 'declaring ecp classes with ecp module' do
	before :each do
		@ecp_facade = CucumberFTC::ECP::Facade.new(
			CucumberFTC::ECP::VariableDefinitions.new(
				CucumberFTC::ECP::ClassDefinition.new
			)
		)
		@semantic_model = CucumberFTC::ECP::IntegerRangeSemanticModel
		@ecp_facade.register_class(@semantic_model)
	end

	it 'should register a class' do
		@ecp_facade.register_class(@semantic_model)
		@ecp_facade.register_variable("variable_name","integer from 10 to 1000")
	end


	it 'should raise an error if register a class without a SemanticModel' do
		lambda{
			@ecp_facade.register_class(
				Object
			)	
		}.should raise_error(ArgumentError)
	end

	it 'should raise an error if there isn\'t a regex that match the class name of a variable' do
		lambda{
			@ecp_facade.register_variable('var','noregex')
		}.should raise_error(
			CucumberFTC::ECP::NoRegexForClassName
		)
	end

	it 'should register invalid input variables' do
		@ecp_facade.declare_invalid_variable('variable name','integer from 2 to 1000')
	end

end
