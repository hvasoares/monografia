require 'pair_wise'

describe CucumberFTC::Combinatory::PairWise do

	before :each do
		@instance = CucumberFTC::Combinatory::PairWise.new
	end

	it 'should generate test with each pair of inputs' do
		@input1 = [ :a,:b,:c ]
		@input2 = [ 1, 2, 3 ]
		@input3 = [ 'x', 'y', 'z' ]

		tests = @instance.generate_tests([
			@input1,
			@input2,
			@input3
		])

		contains_all_pairs(
			0 => @input1,
			1 => @input2,
			:tests = tests
		)
	end

	def contains_all_pairs opts={}
		tests = opts[:tests]
		
	end
	
end
