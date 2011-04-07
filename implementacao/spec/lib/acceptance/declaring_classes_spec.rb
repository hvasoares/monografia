require 'lib/ecp/facade'
require 'lib/ecp/semantic_model'
describe 'declaring ecp classes with ecp module' do
	before :each do
		@ecp_facade = CucumberFTC::ECP::Facade.new
		@semantic_model = CucumberFTC::ECP::SemanticModel.new
	end
	it 'should register a class' do
		@ecp_facade.register_class(/regex/,@semantic_model)
		@ecp_facade.register_variable("variable_name","regex")
	end

	it 'should raise an error if register a class without regex obj' do
		lambda{
			@ecp_facade.register_class(
				Object.new,
				@semantic_model
				)
		}.should raise_error(ArgumentError)
	end

	it 'should raise an error if register a class without a SemanticModel' do
		lambda{
			@ecp_facade.register_class(
				/regex/,
				Object.new
			)	
		}.should raise_error(ArgumentError)
	end

	it 'should raise an error if there isn\'t a regex that match the class name of a variable' do
		@ecp_facade.register_class(/regex/,@semantic_model)
		lambda{
			@ecp_facade.register_variable('var','regex')
		}.should raise_error(
			CucumberFTC::ECP::NoRegexForClassName
		)
	end
end
