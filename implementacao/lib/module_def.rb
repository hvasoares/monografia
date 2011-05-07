module CucumberFTC
end


class Object
	def arguments_must_be args={}
		args.each{|argument,expected_type|
			if not argument.is_a?(expected_type) then
				raise ArgumentError.new(
					"The argument number #{args.keys.index(argument)} must be member of class #{expected_type} " +
					" passed #{argument.class} instead"
				)
			end
		}
	end

	def debug msg
		puts msg if debugging?
	end

	def debugging?
		return true
	end
end
