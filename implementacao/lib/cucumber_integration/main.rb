require File.dirname(__FILE__)+'/module_def'
require File.dirname(__FILE__)+'/runtime'
require File.dirname(__FILE__)+'/configuration'
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
