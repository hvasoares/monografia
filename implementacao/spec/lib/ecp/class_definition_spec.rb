require 'lib/ecp/class_definition'

describe CucumberFTC::ECP::ClassDefinition do
	before :each do
		@instance = CucumberFTC::ECP::ClassDefinition.new
	end

	it 'should has class definitions callbacks defined by regex' do
		semantic_model_class = mock('semantic')
		@instance.register_semantic_model(
			/a regular expression/,
			semantic_model_class
		)
	end

	it 'should create a semantic model given an string' do
		semantic_model_class = mock('semantic_class')
		semantic_model_obj = mock('semantic obj')
		class_mock = mock("class")

		@instance.register_semantic_model(
			/exp/,semantic_model_class
		)

		CucumberFTC::ECP::EcpClass.should_receive(:new).with(
			'class name',semantic_model_obj
		).and_return(class_mock)

		semantic_model_class.should_receive(:new).and_return(
			semantic_model_obj
		)

		@instance.define_class('class name','exp').should == class_mock
	end

	it 'should create a semantic model with the matches from registered regular expression' do
		semantic_model_class = mock('semantic_class')
		semantic_model_obj = mock('semantic obj')
		class_mock = mock("class")

		@instance.register_semantic_model(
			/integer from (\d+) to (\d+)/,semantic_model_class
		)

		CucumberFTC::ECP::EcpClass.should_receive(:new).with(
			'class name',semantic_model_obj
		).and_return(class_mock)

		semantic_model_class.should_receive(:new).with(
			["10","100"]
		).and_return(
			semantic_model_obj
		)

		@instance.define_class(
			'class name','integer from 10 to 100'
		).should == class_mock
	end

end
