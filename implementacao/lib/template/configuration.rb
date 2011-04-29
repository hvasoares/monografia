require 'module_def'
require 'feature'
include CucumberFTC::Template
class CucumberFTC::Template::Configuration
	def feature destination
		Feature.new(
			File.dirname(__FILE__) + '/feature_template.erb',
			destination
		)
	end
end
