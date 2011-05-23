require File.dirname(__FILE__) + "/module_def"
require File.dirname(__FILE__)+'/linear_semantic_model'

class CucumberFTC::ECP::LinearModels::StringSet <  CucumberFTC::ECP::LinearModels::LinearSemanticModel

	def initialize range
		@range = range
	end

	def samples
		[
			string_with_size(@range.first),
			string_with_size(@range.last),
			string_with_size(@range.first()+1),
			string_with_size(@range.last()-1),
			random_string
		]
	end

	def string_with_size size
		if size <= 0 then
			return ""
		end
		Array.new(size){|i| 'a'}.join
	end

	def random_string
		diff = @range.last - 2 - @range.first
		string_with_size(@range.first + 1 + rand(diff))
	end

	def invalid_samples
		[@range.last + 1 , @range.first - 1 ].map{|size|
			string_with_size(size)
		}	
	end

	def applies_to? element
		if element.to_s != element then
			return false
		end
		
		@range.member?(element.size)
	end
end
