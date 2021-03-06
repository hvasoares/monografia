require File.dirname(__FILE__)+'/module_def'
require File.dirname(__FILE__)+'/ecp_class'
require File.dirname(__FILE__)+'/more_than_one_class_owns_a_object_exception'
class CucumberFTC::ECP::EcpClasses
	def initialize
		@classes = Array.new
	end
	def add_class ecp_class
		@classes.push(ecp_class)
	end

	def check_if_only_one_class_owns obj
		if (get_all_class_that_validates(obj).size == 1)
			return true
		end

		raise CucumberFTC::ECP::MoreThanOneClassOwnsAObjectException.new(
			obj,
			get_all_classes_names_that_validates(obj)
		)

	end

	def get_all_class_that_validates(obj) 
		@classes.select{|classs|
			classs.owns? obj
		}
	end

	def get_all_classes_names_that_validates obj
		get_all_class_that_validates(obj).map{|c|
			c.name
		}
	end
end
