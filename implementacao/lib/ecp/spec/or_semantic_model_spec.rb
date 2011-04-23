	require 'or_semantic_model'
	include CucumberFTC::ECP
	describe CucumberFTC::ECP::OrSemanticModel do
	
	context 'when initialized' do
		before :each do
			@semantic_1 = create_semantic_mock
			@semantic_2 = create_semantic_mock
			@semantic_3 = create_semantic_mock

			@instance = CucumberFTC::ECP::OrSemanticModel.new(
				@semantic_1,
				@semantic_2,
				@semantic_3
			)
		end

		def create_semantic_mock
			result = mock(SemanticModel)
			result.stub!(:is_a?).with(SemanticModel).and_return(
				true
			)
			return result
		end

		it 'should applies_to? an obj if only one semantic model applies to the obj' do
			@semantic_1.should_receive(:applies_to?).with(
				:obj
			).and_return(false)
			@semantic_2.should_receive(:applies_to?).with(
				:obj
			).and_return(true)
			@semantic_3.should_not_receive(:applies_to?).with(:obj)

			@instance.applies_to?(:obj).should be_true
		end

		it 'should return false in applies to if all semantics returns false' do
			[@semantic_1,@semantic_2,@semantic_3].each{|semantic|
				semantic.should_receive(
					:applies_to?
				).and_return(false)
			}

			@instance.applies_to?(:obj).should be_false
		end

		it 'should return all samples of semantics as its samples' do
			{
				@semantic_1 => [1,3,5],
				@semantic_2 => [20,21,22],
				@semantic_3 => [50,51,52]
			}.each{|semantic,samples|
				semantic.should_receive(:samples).and_return(
					samples
				)
			}

			@instance.samples.should == [1,3,5,20,21,22,50,51,52]
		end
	end
end
