require 'ecp_classes'

describe EcpClasses do
	before :each do
		@instance = EcpClasses.new
	end

	it 'should allows class add operations' do
		@instance.add_class(mock(EcpClass))
	end

	it 'should query if a element is owned for more than one class' do
		test_two_class_ownership :more_than_one_class_validates=>false
	end

	def test_two_class_ownership opts={}
		number_of_calls = opts[:more_than_one_class_validates] ? 2 : 1

		{
			mock(EcpClass,:name=>'class1') => true,
			mock(EcpClass,:name=>'class2') =>opts[:more_than_one_class_validates]
		}.each{|mock,should_validate|
			mock.should_receive(:owns?).exactly(
				number_of_calls
			).times.with(:obj).and_return(should_validate)
			@instance.add_class(mock)
		}

		@instance.check_if_only_one_class_owns :obj
	end

	it 'should raise an exception if more than one class owns a obj' do
		lambda{
			test_two_class_ownership(
				:more_than_one_class_validates=>true
			)
		}.should raise_error(
			MoreThanOneClassOwnsAObjectException
		)
	end
end
