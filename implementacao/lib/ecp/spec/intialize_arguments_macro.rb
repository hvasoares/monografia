module CucumberFTC
	module RspecUtil
		def self.included(base)
			base.extend(ClassMethod)
		end

		module ClassMethod

			def it_should_require_the_right_argument_in_constructor(
				opts={}
			)
				raise ArgumentError.new(
					':argument_types should be setted'
				) if not opts.has_key?(:argument_types)
				raise ArgumentError.new(
					':class should be setted'
				) if not opts.has_key?(:class)
				instance_eval do
					include CucumberFTC::RspecUtil::ClassMethod
					create_an_example_with_constructor(
						:message=>'should construct with the right set of arguments',
						:class=>opts[:class],
						:argument_sequence =>opts[:argument_types],
						:will_raise_argument_error? => :no
					)
					test_with_every_possible_incorrect_argument_sequence(
						opts[:class],
						opts[:argument_types]
					)
				end
			end

			def create_an_example_with_constructor opts={}
				it opts[:message] do
					lambda_with_constructor = create_lambda_with_constructor_call(
						:class=>opts[:class],
						:argument_sequence=>opts[:argument_sequence]
					)
					case opts[:will_raise_argument_error?]
						when :yes		
							lambda_with_constructor.should raise_error(ArgumentError)
						when :no
							lambda_with_constructor.should_not raise_error(ArgumentError)
						else
							raise ArgumentError.new('The :will_raise_argument_error? should be :yes or :no')
					end
				end
			end

			def create_lambda_with_constructor_call opts={}
				lambda{
					call_new_of(					
						:class=>opts[:class],
						:with_args=>opts[:argument_sequence]
					)
				}
			end

			def test_with_every_possible_incorrect_argument_sequence klass,possible_arguments
				for argument_sequence in possible_incorrect_sequences(possible_arguments)
					expected_class = (object_to_array(possible_arguments) -argument_sequence).first
					create_an_example_with_constructor(
						:message=> "should not construct if a non #{expected_class} member is passed to constructor",
						:class=>klass,
						:argument_sequence=>argument_sequence,
						:will_raise_argument_error? => :yes
					)
				end
			end

			def possible_incorrect_sequences possible_correct_arguments
				object_to_array(possible_correct_arguments).map{|argument|
					replace_an_object_in_the_array(
						:search_for=>argument,
						:original_array=>object_to_array(possible_correct_arguments)
					)
				}
			end

			def replace_an_object_in_the_array opts={}
				Array.new(opts[:original_array].size) {|index|
					return_the_object_if_it_in_the_specified_index_of_array(
						:object=>opts[:search_for],
						:array=>opts[:original_array],
						:expected_index=>index
					)
				}
			end

			def return_the_object_if_it_in_the_specified_index_of_array opts={}
				if opts[:expected_index] == opts[:array].index(opts[:object]) then
					return Object
				end
				return opts[:object]
			end


			def call_new_of opts={}
				opts[:class].method(:new).call(
					*(create_args(opts[:with_args]))
				)
			end

			def create_args argument_types
				object_to_array(argument_types).map{|type|
					create_mock_to(type)
				}
			end

			def object_to_array object
				object.is_a?(Array) ? object : [object]
			end

			def create_mock_to type
				result = mock(type)
				stub_def = result.stub!(:is_a?)
				if type == Object then
					stub_def.and_return(false)
				else
					stub_def.with(type).and_return(true)
				end
				return result
			end
		end
	end
end
