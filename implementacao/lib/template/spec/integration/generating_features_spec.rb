require'feature'

describe 'generating features' do
	before :all do
		PATH = File.dirname(__FILE__)
	end

	before :each do
		
		@generated_feature = "/tmp/generated_feature.#{Time.new.to_i}.feature"
		@instance = CucumberFTC::Template::Feature.new(
			PATH + "/../../feature_template.erb",
			@generated_feature
		)
	end

	it 'should generate a feature with provided examples' do 
		@instance.feature_name = 'Feature_name'

		@instance.add_scenario('an scenario name')
		@instance.add_step('Given', 'step one')
		@instance.add_examples_header('var1','var2')
		@instance.add_examples(
			[
				[1,2],
				[3,4],
				[5,6]
			]
		)

		same_tokens?(
			@instance.feature_text,
<<EOF
Feature: Feature_name

Scenario Outline: an scenario name
	Given step one

	Examples:
		| var1 | var2 |
		| 1    | 2   |
		| 3    | 4   |
		| 5    | 6   |
EOF
		)
	end
	
	def same_tokens? string1, string2
		tokenize(string1).should == tokenize(string2)
	end

	def tokenize string
		string.gsub(/\n+/," ").split(" ")
		
	end
end
