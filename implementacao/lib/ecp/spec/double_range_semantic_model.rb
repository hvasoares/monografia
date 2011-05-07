require 'double_range_semantic'

describe CucumberFTC::ECP::DoubleRangeSemantic do
	before :each do 
		@instance = CucumberFTC::ECP::DoubleRangeSemantic.new(
			'0.1','10.45'
		)
	end

	it 'should should recongize an double range declaration' do
		CucumberFTC::ECP::DoubleRangeSemantic.regex.should == /float from (\d+\.\d+) to (\d+\.\d+)/
	end

	it 'should applies to an value that are in the boundaries' do
		@instance.applies_to?(3.0).should be_true
	end

	it 'should generates float as samples' do
		@instance.samples.first.is_a?(Float).should be_true
	end

end

