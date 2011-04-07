require 'ecp_class'
describe EcpClass do
	it 'should created if a name and semantic model is provided' do
		EcpClass.new('name',mock(SemanticModel))
	end

	context 'when created' do
		before :each do
			@semantic_model = mock(SemanticModel)
			@instancia = EcpClass.new('name',@semantic_model)
		end

		it 'should validate if a obj is owned by the class' do	
			@semantic_model.should_receive(:applies_to?).with(
				:object
			)
			@instancia.owns?(:object)
		end
	end
end
