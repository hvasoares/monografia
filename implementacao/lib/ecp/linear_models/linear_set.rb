require 'module_def'

class CucumberFTC::ECP::LinearModels::LinearSet
	def initialize strategy
		@strategy = strategy
	end

	def first
		@strategy.value_at(0)
	end

	def middle 
		fail('should be implemented')
	end

	def last
		fail('should be implemented')
	end

	def invalids
		fail('should be implemented')
	end
end
