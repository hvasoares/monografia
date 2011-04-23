require 'class_definition'

describe CucumberFTC::ECP::ClassDefinition do
	before :each do
		@instance = CucumberFTC::ECP::ClassDefinition.new
		@semantic_model = mock('semantic')
		@semantic_model.stub!(:<).with(
			SemanticModel
		).and_return(true)

		@semantic_model.stub!(:regex).and_return(/exp/)
	end

	it 'should has class definitions' do
		@instance.register_semantic_model(
			@semantic_model
		)
	end

	
	it 'should raise ArgumentError if a no SemanticModel memver is passed to register_semantic_model_method' do
		lambda{
			@instance.register_semantic_model(
				Object
			)
		}.should raise_error(ArgumentError)
	end

	it 'should create a semantic model given an string' do
		semantic_model_obj = mock('semantic obj')
		class_mock = mock("class")

		@instance.register_semantic_model(
			@semantic_model
		)

		CucumberFTC::ECP::EcpClass.should_receive(:new).with(
			'class name',semantic_model_obj
		).and_return(class_mock)

		@semantic_model.should_receive(:new).and_return(
			semantic_model_obj
		)

		@instance.define_class('class name','exp').should == class_mock
	end

	it 'should create a semantic model with the matches from registered regular expression' do
		semantic_model_obj = mock('semantic obj')
		class_mock = mock("class")

		@instance.register_semantic_model(
			@semantic_model
		)

		CucumberFTC::ECP::EcpClass.should_receive(:new).with(
			'class name',semantic_model_obj
		).and_return(class_mock)

		@semantic_model.stub!(:regex).and_return(
			/integer from (\d+) to (\d+)/
		)

		@semantic_model.should_receive(:new).with(
			"10","100"
		).and_return(
			semantic_model_obj
		)

		@instance.define_class(
			'class name','integer from 10 to 100'
		).should == class_mock
	end

	it 'should check if the registered regexes match a given string' do
		@instance.register_semantic_model(@semantic_model)

		@instance.description_match_any_semantic_model?('exp').should be_true

		@instance.description_match_any_semantic_model?('no matchable regex').should == false
	end

end
