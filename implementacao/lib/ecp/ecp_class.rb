require 'cucumber_ftc'
require 'semantic_model'
class CucumberFTC::ECP::EcpClass
	attr_reader :name
	def initialize name,semantic_model
		@semantic_model = semantic_model
	end

	def owns? obj
		@semantic_model.applies_to?(obj)
	end

	def sample
		@semantic_model.samples.shuffle.first
	end
end
