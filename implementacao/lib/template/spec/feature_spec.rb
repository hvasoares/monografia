require 'feature'
include CucumberFTC::Template
describe CucumberFTC::Template::Feature do
	before :each do
		@instance = Feature.new (:template_path)
	end

	it 'should create an feature with its generated values ' do
		@instance.feature_name = :name
		@instance.add_scenario(:scenario_name)
		@instance.add_step(:keyword,:name)
		@instance.add_examples_header(:header_one,:header_two)
		@instance.add_examples(
			[
				[ :val00, :val01 ],
				[ :val10, :val11 ]
			]
		)

		File.should_receive(:read).with(:template_path).and_return(:template_text)
		erb = mock(ERB)
		ERB.should_receive(:new).with(:template_text).and_return(erb)
		@instance.should_receive(:binding).and_return(:bindings)
		erb.should_receive(:result).with(:bindings).and_return(:text_result)
		
		
		@instance.feature_text.should == :text_result
	end
end
