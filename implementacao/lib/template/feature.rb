require File.dirname(__FILE__)+'/module_def'
require 'erb'
class CucumberFTC::Template::Feature 
	attr_writer :feature_name

	def initialize template_file,destination
		@template_file = template_file
		@destination = destination
		@scenarios = Array.new
		@steps = Hash.new
		@examples = Hash.new
		@examples_header = Hash.new
	end

	def add_scenario scenario_name
		@scenarios.push scenario_name
		@last_added_scenario = scenario_name
		@steps[@last_added_scenario] = Array.new
	end

	def add_step keyword, name
		@steps[@last_added_scenario].push "#{keyword} #{name}"
	end

	def add_examples_header *headers
		@examples_header[@last_added_scenario] =headers.uniq
	end

	def add_examples examples
		debug("examples is" )
		for example in examples 
			debug('==='+example.join(','))
		end
		@examples[@last_added_scenario] = examples
	end

	def feature_text
		destino = File.open(@destination,'w')
		destino.write(constructed_text)
		destino.close
		return constructed_text
	end

	def constructed_text
		ERB.new(
			File.read(@template_file)
		).result(binding)
	end
end
