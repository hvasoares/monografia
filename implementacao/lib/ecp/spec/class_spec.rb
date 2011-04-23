require 'ecp_class'
	describe CucumberFTC::ECP::EcpClass do
		it 'should created if a name and semantic model is provided' do
			CucumberFTC::ECP::EcpClass.new('name',mock(CucumberFTC::ECP::SemanticModel))
		end

		context 'when created' do
			before :each do
				@semantic_model = mock(CucumberFTC::ECP::SemanticModel)
				@instancia = CucumberFTC::ECP::EcpClass.new('name',@semantic_model)
		end

		it 'should validate if a obj is owned by the class' do	
			@semantic_model.should_receive(:applies_to?).with(
				:object
			)
			@instancia.owns?(:object)
		end
	end
end
