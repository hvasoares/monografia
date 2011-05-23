require 'linear_semantic_model' 

describe CucumberFTC::ECP::LinearModels::LinearSemanticModel do
	before :each do
		@linear_set = mock('linear set')
		@instance = CucumberFTC::ECP::LinearModels::LinearSemanticModel.new(@linear_set)
	end

	it 'should get the valid inputs' do
		@linear_set.should_receive(:first).and_return(:first_elem)
		@linear_set.should_receive(:middle).and_return(:middle_elem)
		@linear_set.should_receive(:last).and_return(:last_elem)

		@instance.samples.should == [:first_elem,:middle_elem,:last_elem]
	end

	it 'should get the invalid inputs' do
		@linear_set.should_receive(:invalids).and_return(:invalids)
		@instance.invalid_samples.should == :invalids
	end
end
