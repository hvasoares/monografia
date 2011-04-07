require File.dirname(__FILE__)+'/cucumber_ftc'
require File.dirname(__FILE__)+'/no_regex_for_class_name'
require File.dirname(__FILE__)+'/variables_definition
class CucumberFTC::ECP::Facade
	def register_class regex, semantic_model
		if not regex.is_a? Regexp then
			raise ArgumentError.new('The fisrt argument MUST be a Regexp instance')
		end

		if not semantic_model.is_a? CucumberFTC::ECP::SemanticModel
			raise ArgumentError.new("The second argument MUST be a SemanticModel instance. You provided a #{semantic_model.class}")
		end
	end

	def register_variable variable, class_name
		
	end
end
