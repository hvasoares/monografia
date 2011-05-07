require 'group_semantic_model' 

describe CucumberFTC::ECP::GroupSemanticModel do
	before :each do
		@elems = Array.new(5) do |i|
			'elem' + i.to_s
		end

		@instance = CucumberFTC::ECP::GroupSemanticModel.new(
			'elem0,elem1,elem2,elem3','elem4'
		)
	end


	it 'regex should case with elem1,elem2,elem3' do
		CucumberFTC::ECP::GroupSemanticModel.regex.should == /(.+),(.+)/
	end

	it 'should appliest to all elements' do
		@elems.each do|elem|
			@instance.applies_to?(elem).should be_true
		end
	end

	it 'should has samples' do
		@instance.samples.each{|s|
			@elems.include?(s).should == true
		}
	end

end

