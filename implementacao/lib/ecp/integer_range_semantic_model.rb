require File.dirname(__FILE__)+'/module_def'
require File.dirname(__FILE__)+'/semantic_model'
class CucumberFTC::ECP::IntegerRangeSemanticModel < CucumberFTC::ECP::SemanticModel
	def self.regex
		/integer from (\d+) to (\d+)/
	end

	def initialize lower_bound,upper_bound
		@range = lower_bound.to_i..upper_bound.to_i
	end

	def samples
		[
		@range.to_a[rand(@range.to_a.size)]
		]
	end

	def applies_to? integer
		@range.member?(integer)
	end

end
