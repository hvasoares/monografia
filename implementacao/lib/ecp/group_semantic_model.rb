require 'module_def'

class CucumberFTC::ECP::GroupSemanticModel
	def self.regex	
		/(.+),(.+)/
	end
	
	def initialize tail, head
		@elements = others_elements(tail + ',' + head)
	end

	def others_elements tail
		matches = self::regex.match(tail)
		return tail if macthes.nil?
		return [matches[2],other_elements(m[1])].flatten
	end

	def applies_to? obj
		@elements.include?(obj)
	end
end
