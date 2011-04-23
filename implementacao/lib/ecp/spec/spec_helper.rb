require 'rubygems'
require 'intialize_arguments_macro'

Spec::Runner.configure do |config|
	config.include(CucumberFTC::RspecUtil)
end
