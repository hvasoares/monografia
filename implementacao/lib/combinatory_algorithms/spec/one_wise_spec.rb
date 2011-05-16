require 'one_wise'

describe CucumberFTC::CombinatoryAnalisys::OneWise do
	before :each do
		@instance = CucumberFTC::CombinatoryAnalisys::OneWise.new
	end

	it 'should generate a test set wich all inputs appear at least one time' do
		@input1 = [ :a,:b,:c ]
		@input2 = [ 1, 2, 3 ]
		@input3 = ['x','y','z']

		@result = @instance.generate_tests(
			@input1,
			@input2,
			@input3
		)
		
		all_cases_are_differents
		all_cases_have_the_same_size 
		each_case_is_a_combination_of @input1,@input2,@input3
	end

	def all_cases_are_differents
		@result.uniq.size.should == @result.size
	end

	def all_cases_have_the_same_size 
		sizes = @result.map{|test_case|
			test_case.size
		}

		sizes.uniq.size.should == 1
	end

	def each_case_is_a_combination_of input1,input2,input3
		@result.each{ |test_case| 
			{ 
				input1 => test_case[0],
				input2 => test_case[1],
				input3 => test_case[2]
			}.each{|set,elem| 
				if not set.include? elem then
					raise set.join(',') + " doesnt include #{elem}"
				end
			}
		}
	end
end
