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

	context 'when variables are declared' do
		before :each do
			valid_classes_to(
				:var1,
				'integer from 20 to 300',
				'integer from 500 to 600'
			)
			valid_classes_to(
				:var2,
				'integer from 40 to 50',
				'integer from 60 to 100' 
			)
			
			invalid_classes_to(
				:var1,
				'integer from 0 to 39',
				'integer from 51 to 69'
			)

			invalid_classes_to(
				:var2,
				'integer from 0 to 19',
				'integer from 301 to 499'
			)
		end

		def valid_classes_to var,*valid_semantic_models
			valid_semantic_models.each{|semantic|
				@ecp_facade.register_variable(var,semantic)
			}
		end

		def invalid_classes_to var,*semantic_models
			semantic_models.each{|semantic|
				@ecp_facade.declare_invalid_variable(var,semantic)
			}
		end

		it 'should generate a hash containing the ecp test cases' do
			all_vars_combinations_must_have_same_size(@ecp_facade.generate_tests)
		end

		def all_vars_combinations_must_have_same_size hash_with_cases
			all_sizes = hash_with_cases.map{|test_case| test_case.size}
			all_sizes.uniq.should be_true
		end

	end
end
