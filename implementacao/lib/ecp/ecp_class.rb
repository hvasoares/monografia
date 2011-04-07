require File.dirname(__FILE__)+'/cucumber_ftc'
require File.dirname(__FILE__)+'/semantic_model'
class CucumberFTC::ECP::EcpClass
	def initialize name,semantic_model
		@semantic_model = semantic_model
	end

	def owns? obj
		@semantic_model.applies_to?(obj)
	end
end
