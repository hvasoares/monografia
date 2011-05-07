require File.dirname(__FILE__)+'/module_def' 
class CucumberFTC::ECP::NoRegexForClassName < Exception
	def initialize unmatched_text
		super("No regex matched the class name '#{unmatched_text}'")
	end
end
