require File.dirname(__FILE__)+'/module_def'
class CucumberFTC::ECP::MoreThanOneClassOwnsAObjectException < Exception
	def initialize obj,classes_name
		super("The #{obj} is owned by: #{classes_name.join(',')}")
	end
end
