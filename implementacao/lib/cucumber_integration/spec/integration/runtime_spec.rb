require 'main'
require 'configuration'
require 'runtime'
require 'tree_walker'
require 'rubygems'
require 'cucumber/runtime'
require 'cucumber/cli/configuration'
require 'cucumber'

include CucumberFTC::CucumberIntegration
describe Main do
	before :each do
		@argv = [File.dirname(__FILE__)+'/features/']
		@configuration = Configuration.new(Cucumber::Cli::Configuration.new)
		@runtime = Runtime.new(Cucumber::Runtime.new,@configuration)
		@configuration.runtime =@runtime
	end

	it 'should run the features' do
		Main.new(@runtime,@configuration).run(@argv)
	end
end
