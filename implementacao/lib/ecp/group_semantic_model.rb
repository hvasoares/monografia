require 'module_def'
require File.dirname(__FILE__)+'/semantic_model'

class CucumberFTC::ECP::GroupSemanticModel < CucumberFTC::ECP::SemanticModel
	REGEX =/(.+),(.+)/
	def self.regex	
		REGEX
	end
	
	def initialize tail, head
		@elements = others_elements(tail + ',' + head)
	end

	def others_elements tail
		matches = REGEX.match(tail)
		return tail if matches.nil?
		return [matches[2],others_elements(matches[1])].flatten
	end

	def applies_to? obj
		@elements.include?(obj)
	end

	def samples
		sample_size = @elements.size > 5 ? @elements.size : 5
		Array.new(sample_size) do|i|
			@elements[rand(sample_size)]
		end
	end
end
