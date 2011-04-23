require 'complex_logic_semantic_model' 
include CucumberFTC::ECP
describe CucumberFTC::ECP::ComplexLogicSemanticModel do
	it 'should receive only SemanticModels in constructor' do
		lambda{
			CucumberFTC::ECP::ComplexLogicSemanticModel.new(
				SemanticModel.new,
				SemanticModel.new
			)
		}.should_not raise_error(ArgumentError)

		lambda{
			CucumberFTC::ECP::ComplexLogicSemanticModel.new(
				SemanticModel.new,
				SemanticModel.new,
				Object.new
			)
		}.should raise_error(ArgumentError)
	end

	it 'should accept more than one semantic models' do
		lambda{
			ComplexLogicSemanticModel.new(
				SemanticModel.new
			)
		}.should raise_error(ArgumentError)
	end

end
