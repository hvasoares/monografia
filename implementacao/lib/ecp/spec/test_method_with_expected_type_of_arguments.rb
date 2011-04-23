module CucumberFTC
	module RspecUtil

	module ClassMethod
		class ExpectedArgumentsMacro
			def initialize opts={}
				[:argument_types,:object,:method].each{|arg|
					raise_error_if_not_setted(
						:expected_options=>arg,
						:options=>opts
					)
				}

				@options = opts
			end

			def run
				create_an_example
			end

			def create_an_example
				
			end

			private
			def raise_error_if opts={}
				raise ArgumentError.new(
					":#{opts[:expected_option]} should be setted" 
				) if not opts[:options].has_key?(
					opts[:expected_options]
				)
			end
		end
	end

	end
end

