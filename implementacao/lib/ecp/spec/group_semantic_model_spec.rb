require 'group_semantic_model' 

describe CucumberFTC::ECP::GroupSemanticModel do

	it 'regex should case with elem1,elem2,elem3' do
		'elem1 , elem2, elem3' =~
		CucumberFTC::ECP::GroupSemanticModel.regex
	end

end
