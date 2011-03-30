require 'integer_range_semantic_model'

describe IntegerRangeSemanticModel do
	before :each do 
		@instance = IntegerRangeSemanticModel.new(["10","1000"])
	end

	it 'should generate a integer as sample' do
		@instance.sample.should be_a(Integer)
	end

	it 'should applies to a integer in the range' do
		@instance.applies_to?(100)
	end
end
