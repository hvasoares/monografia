require 'and_semantic_model'
include CucumberFTC::ECP
describe CucumberFTC::ECP::AndSemanticModel do
	before :each do
		@semantic_mock_1 = create_semantic
		@semantic_mock_2 = create_semantic
		@semantic_mock_3 = create_semantic

		@instance = CucumberFTC::ECP::AndSemanticModel.new(
			@semantic_mock_1,
			@semantic_mock_2,
			@semantic_mock_3
		)
	end

	def create_semantic
		result = mock(SemanticModel)
		result.stub!(:is_a?).with(SemanticModel).and_return(true)
		return result
	end


	it 'should applies an obj if the obj applies to every semantic model' do
		[
			@semantic_mock_1,
			@semantic_mock_2,
			@semantic_mock_3
		].each{|semantic|
			semantic.should_receive(:applies_to?).with(
				:obj
			).and_return(true)
		}
		@instance.applies_to?(:obj).should be_true
	end

	it 'should not applies if one of the semantics not applies the obj' do
		@semantic_mock_1.should_receive(:applies_to?).with(
			:obj
		).and_return(true)
		@semantic_mock_2.should_receive(:applies_to?).with(
			:obj
		).and_return(false)
		@semantic_mock_3.should_not_receive(:applies_to?)
		
		@instance.applies_to?(:obj).should be_false
	end
	
	it 'should get the intersection of semantic models samples' do
		{
			@semantic_mock_1 => [1,2,3,4,5,6,7],
			@semantic_mock_2 => [-1,-2,5,6,100,1000],
			@semantic_mock_3 => [5,6,-100,2000]
		}.each{|semantic,sample|
			semantic.should_receive(:samples).and_return(sample)
		}

		@instance.samples.should == [5,6]
	end
end
