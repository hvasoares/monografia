require 'module_def'
require 'runtime'
require 'configuration'
class CucumberFTC::CucumberIntegration::Main
	def initialize runtime, configuration
		arguments_must_be(
			runtime=> CucumberFTC::CucumberIntegration::Runtime,
			configuration => CucumberFTC::CucumberIntegration::Configuration
			)
		@configuration = configuration
		@runtime = runtime
	end

	def run argv
		@configuration.parse!(argv)
		@runtime.run!	
	end
end
