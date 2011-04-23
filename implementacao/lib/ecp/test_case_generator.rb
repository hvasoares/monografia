require 'cucumber_ftc'
require 'variable_definitions'

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
			return inputs.first.map{|input|
				input.sample
			}
		end
		for input in inputs.first
			inputs_tail = inputs[1..inputs.index(inputs.last)]
			set.push(
				generate_elements(
					input.sample,
					inputs_tail
				)
			)

		end

		return set.flatten(1)
	end

	def generate_elements head,tail
		result = []
		for new_tails in cartesian_product_from(tail)
			result.push(
				[head,new_tails].flatten()
			)
		end

		return result
	end

end
