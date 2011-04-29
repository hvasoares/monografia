require 'module_def'
require 'configuration'
require 'runtime'
require 'main'
class CucumberFTC::CucumberIntegration::Facade
	
	def main
		@configuration = Configuration.new(
			Cucumber::Cli::Configuration.new
		)
		runtime = Runtime.new(Cucumber::Runtime.new,@configuration)
		@configuration.runtime =runtime

		return Main.new(runtime,@configuration)
	end

	def features
		tree_walker.features
	end

	def scenarios_for feature
		tree_walker.scenarios_for(feature)
	end

	def steps_for scenario
		tree_walker.steps_for(scenario)
	end

	def inputs_declaration_for scenario
		tree_walker.inputs_declaration_for scenario
	end


	private
	def tree_walker
		@configuration.tree_walker
	end

end
