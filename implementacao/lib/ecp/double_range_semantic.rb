require 'module_def'
require File.dirname(__FILE__)+'/semantic_model'

class CucumberFTC::ECP::DoubleRangeSemantic < CucumberFTC::ECP::SemanticModel
	INTERVAL = 0.1
	def self.regex 
		/float from (\d+\.\d+) to (\d+\.\d+)/
	end

	def initialize lower_bound, upper_bound
		@lower_bound, @upper_bound = lower_bound.to_f,upper_bound.to_f
	end

	def samples
		Array.new(5) do |i| 
			@lower_bound + rand(quantity)*INTERVAL
		end
	end

	def quantity
		diff = @upper_bound - @lower_bound
		quantity = diff/INTERVAL
	end

	def applies_to? obj
		obj.is_a?(Float) and object_is_in_the_range?(obj) 
	end

	def object_is_in_the_range? obj
		obj > @lower_bound and obj<@upper_bound
	end
end
