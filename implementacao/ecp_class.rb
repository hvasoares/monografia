require 'semantic_model'
class EcpClass
	def initialize name,semantic_model
		@semantic_model = semantic_model
	end

	def owns? obj
		@semantic_model.applies_to?(obj)
	end
end
