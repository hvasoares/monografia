require 'string_set'

describe CucumberFTC::ECP::LinearModels::StringSet do
	before :each do
		@range = 5..7
		@instance = CucumberFTC::ECP::LinearModels::StringSet.new(@range)
	end

	it 'should generate valid inputs with especified size' do
		@instance.samples.each{|sample|
			@range.include?(sample.size).should be_true
			sample.is_a?(String).should  be_true
		}
	end

	it 'shoul generate invalid string inputs' do
		@instance.invalid_samples.each{|sample|
			@range.include?(sample.size).should be_false
			sample.is_a?(String).should be_true
		}
	end

	it 'should check if model applies to an element' do
		['12345','1234567','123456'].each{|valid|
			@instance.applies_to?(valid).should be_true
		}

		['12', '12345678',:invalid].each{|invalid|
			@instance.applies_to?(invalid).should be_false
		}
	end
end
