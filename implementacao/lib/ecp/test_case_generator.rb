require File.dirname(__FILE__)+'/module_def'
require File.dirname(__FILE__)+'/variable_definitions'

class CucumberFTC::ECP::TestCaseGenerator

	def initialize possible_variables
		raise ArgumentError.new(
			'the argument MUST be a member of CucumberFTC::ECP::VariablesDefinitionsClass'
		) if not possible_variables.is_a?(
			CucumberFTC::ECP::VariableDefinitions
		)
		@possible_variables = possible_variables
	end

	def generate
		input_set = []
		for var in @possible_variables.get_vars
			input_set.push(
				@possible_variables.get_valid_inputs_for(var)
			)
		end


		return cartesian_product_from(input_set)
	end

	def cartesian_product_from inputs		
		set = [] 
		return [] if inputs.empty?
		if inputs.size == 1 then
			debug("input size is one")	
			return inputs.first.map{|input|
				input.sample
			}
		end

		debug("iterating through inputs, inputs size #{inputs.size}")
		for input in inputs.first
			inputs_tail = inputs.slice(1..(inputs.size-1))
			debug('set is ' + set.join(','))
			debug('input tails size = ' + inputs_tail.size.to_s)
			set.push(
				generate_elements(
					input.sample,
					inputs_tail
				)
			)
			debug('and now is ' + set.join(','))

		end

		return set.flatten(1)
	end

	def generate_elements head,tail
		result = []
		for new_tails in cartesian_product_from(tail)
			debug('result is' + result.join(','))
			result.push(
				[head,new_tails].flatten()
			)
			debug('result is now' + result.join(','))
		end

		return result
	end

end
