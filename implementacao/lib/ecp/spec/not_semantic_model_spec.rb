require 'spec_helper'
require 'not_semantic_model'

describe CucumberFTC::ECP::NotSemanticModel do
	it_should_require_the_right_argument_in_constructor(
		:argument_types => CucumberFTC::ECP::SemanticModel,
		:class=>CucumberFTC::ECP::NotSemanticModel
	)	

	context 'when initialized' do
		before :each do
			@semantic_mock = mock(SemanticModel)
			@semantic_mock.should_receive(:is_a?).with(
				SemanticModel
			).and_return(true)
			@instance = NotSemanticModel.new(@semantic_mock)
		end

		it 'should deny the semantic model applies_to? when applies_to? method is called' do
			@semantic_mock.should_receive(:applies_to?).with(
				:tested_obj
			).and_return(true)
			
			@instance.applies_to?(:tested_obj).should be_false
		end

	end

end
