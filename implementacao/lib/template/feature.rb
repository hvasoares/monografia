require 'module_def'
require 'erb'
class CucumberFTC::Template::Feature 
	attr_writer :feature_name

	def initialize template_file
		@template_file = template_file
	end

	def add_scenario scenario_name
	end

	def add_step keyword, name
	end

	def add_examples_header *headers
	end

	def add_examples examples
	end

	def feature_text
		ERB.new(
			File.read(@template_file)
		).result(binding)
	end
end
