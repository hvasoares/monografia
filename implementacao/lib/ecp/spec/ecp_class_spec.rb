require 'ecp_class'
include CucumberFTC::ECP
describe CucumberFTC::ECP::EcpClass do
	before :each do
		@semantic_model = mock(SemanticModel)
		@instance = CucumberFTC::ECP::EcpClass.new(
			'var name',
			@semantic_model	
		)
	end

	it 'should test if an obj is owned by the class' do
		@semantic_model.should_receive(
		:applies_to?).with(:obj).and_return(true)
		@instance.owns?(:obj).should be_true
	end

	it 'should get an sample of class' do
		possible_samples = [:s1,:s2,:s3]
		@semantic_model.should_receive(:samples).and_return(
			possible_samples
		)

		possible_samples.include?(
			@instance.sample
		)
	end
end
