require File.dirname(__FILE__)+'/module_def'
require File.dirname(__FILE__)+'/semantic_model'
class CucumberFTC::ECP::EcpClass
	attr_reader :name
	def initialize name,semantic_model
		@name = name
		@semantic_model = semantic_model
	end

	def owns? obj
		@semantic_model.applies_to?(obj)
	end

	def sample
		@semantic_model.samples.shuffle.first
	end
end
