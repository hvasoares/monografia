require 'feature'
include CucumberFTC::Template
describe CucumberFTC::Template::Feature do
	before :each do
		@instance = Feature.new (:template_path,:destination_path)
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

		File.should_receive(:read).twice.with(:template_path).and_return(:template_text)
		erb = mock(ERB)
		ERB.should_receive(:new).twice.with(:template_text).and_return(erb)
		@instance.should_receive(:binding).twice.and_return(:bindings)
		erb.should_receive(:result).twice.with(:bindings).and_return(:text_result)
	
		file_mock = mock(File)
		File.should_receive(:open).with(:destination_path,'w').and_return(file_mock) 
		file_mock.should_receive(:write).with(:text_result)
		file_mock.should_receive(:close)
		
		@instance.feature_text.should == :text_result
	end
end
