require 'integer_set'

describe CucumberFTC::ECP::LinearModels::IntegerSet do
	before :each do
		@lower = 10
		@upper = 20
		@range = @lower..@upper
		@instance = CucumberFTC::ECP::LinearModels::IntegerSet.new(
			@range
		)
	end

	it 'should generate samples that belongs to range' do
		@instance.samples.each{|sample|
			@range.include?(sample).should be_true
		}
	end

	it 'should generate invalid samples that not belongs to range' do
		@instance.invalid_samples.each{|sample|
			@range.include?(sample).should be_false
		}
	end

	it 'should a integer should appliest to the model' do
		@instance.applies_to?(10).should be_true
		@instance.applies_to?(9).should be_false
	end
end
