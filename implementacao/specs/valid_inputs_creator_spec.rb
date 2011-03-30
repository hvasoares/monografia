require 'valid_inputs_creator'
describe ValidInputsCreator do
	it 'should create with a set of ecp_class' do
		ValidInputsCreator.new(
			[mock(EcpClass),mock(EcpClass)]
		)
	end

	context 'when it is created' do
		before :each do
			@class_1 = mock(EcpClass,:sample=>:sample1)
			@class_2 = mock(EcpClass,:sample=>:sample2)
			@class_3 = mock(EcpClass,:sample=>:sample3)

			@instance = ValidInputsCreator.new({
				"a" => [@class_1,@class_3],
				"b" => @class_2
			})
		end

		it 'should create a combination of tests' do
			@instance.generate.include?(
				{"a"=>:sample1,"b"=>:sample2}
			).should be_true
		end
	end
end
