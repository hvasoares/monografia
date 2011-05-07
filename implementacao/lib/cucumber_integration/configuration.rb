require File.dirname(__FILE__)+'/module_def'
require File.dirname(__FILE__)+'/tree_walker'

require 'rubygems'
require 'cucumber/cli/configuration'
class CucumberFTC::CucumberIntegration::Configuration
	attr_reader :tree_walker
	attr_writer :runtime
	def initialize inner_cfg
		arguments_must_be(
			inner_cfg => Cucumber::Cli::Configuration
		)
		@configuration = inner_cfg
	end

	

	def build_tree_walker runtime
		@tree_walker = CucumberFTC::CucumberIntegration::TreeWalker.new(@runtime)
		return @tree_walker
	end

	def method_missing method_name, *args
		@configuration.method(method_name).call *args
	end
end
