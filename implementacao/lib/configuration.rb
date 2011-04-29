require 'module_def'

require 'cucumberintegration/facade'
require 'templating/feature'
require 'ecp_class/facade'

module CucumberFTC::Configuration
	def build argv
		integration = CucumberFTC::CucumberIntegrationFacade.new
		ecp = CucumberFTC::ECP::Configuration.new
		template = CucumberFTC::Template::Configuration.new
		integration.main.run(argv)

		integration.features.each do |feature|
			file = template.feature('.features/' feature.gsub(" ","_")+'.ftc.feature')

			integration.scenarios_for(feature).each do |scenario|
				variables = ecp.facade
				file.add_scenario(scenario)
				integration.inputs_declaration_for(scenario).each do |input|
					variables.register_variable input[0],inputs[1]
				end
				file.add_examples_header *(
					integration.inputs_declaration_for(scenario).map{|input| input[0]}
				)

				file.add_examples variables.generate_tests

				integration.steps_for(scenario).each do |step|
					file.add_step(step[:keyword]+ ' ' + step[:name])
				end
			end

			file.feature_text
		end

	end
end
