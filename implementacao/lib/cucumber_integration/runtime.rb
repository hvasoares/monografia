require 'module_def'
require 'configuration'
require 'rubygems'
require 'cucumber/runtime'
class CucumberFTC::CucumberIntegration::Runtime
	def initialize inner_runtime, configuration
		arguments_must_be(
			inner_runtime => Cucumber::Runtime,
			configuration => CucumberFTC::CucumberIntegration::Configuration
		)
		@inner_runtime = inner_runtime
		@configuration = configuration
	end

	def run!
		@inner_runtime.configure(@configuration)
		@inner_runtime.run!
	end

	def method_missing method_name, *args, &block
		@inner_runtime.method(method_name).call(*args,&block)
	end
end
