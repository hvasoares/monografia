require File.dirname(__FILE__)+'/module_def'

require 'cucumber_integration/facade'
require 'template/configuration'
require 'ecp/configuration'

require 'cucumber'

class CucumberFTC::Configuration
	def build argv
		integration = CucumberFTC::CucumberIntegration::Facade.new
		ecp = CucumberFTC::ECP::Configuration.new
		template = CucumberFTC::Template::Configuration.new
		integration.main.run(argv)

		puts "Creating the generated files"

		integration.features.each do |feature|
			puts "Generating for feature " + feature
			
			file = template.feature('./features/'+ feature.gsub(" ","_")+'.ftc.feature')

			integration.scenarios_for(feature).each do |scenario|
				variables = ecp.facade
				file.add_scenario(scenario)
				integration.inputs_declaration_for(scenario).each do |input|
					variables.register_variable input[0],input[1]
				end
				file.add_examples_header *(
					integration.inputs_declaration_for(scenario).map{|input| input[0]}
				)

				tests = variables.generate_tests
				
				puts tests.join

				file.add_examples tests

				integration.steps_for(scenario).each do |step|
					file.add_step(step[:keyword], step[:name])
				end
			end

			file.feature_text
		end
	end
end
