require File.dirname(__FILE__)+'/module_def'
require File.dirname(__FILE__)+'/semantic_model'
class CucumberFTC::ECP::IntegerRangeSemanticModel < CucumberFTC::ECP::SemanticModel
	def self.regex
		/integer from (\d+) to (\d+)/
	end

	def initialize lower_bound,upper_bound
		@lower_bound, @upper_bound = lower_bound.to_i,upper_bound.to_i
	end

	def samples
		diff =  @upper_bound - @lower_bound
		Array.new(5) do |i|
			@lower_bound + rand(diff)
		end
	end

	def applies_to? integer
		integer.is_a?(Fixnum) and (
			integer > @lower_bound and integer < @upper_bound
		)
	end

end
