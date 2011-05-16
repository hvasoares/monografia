require File.dirname(__FILE__) + "/module_def"

class CucumberFTC::CombinatoryAnalisys::OneWise
	def generate_tests *input_sets
		@first_time = true
		start_input_counters *input_sets
		@sets = input_sets
		result = []

		while any_vals_appear_zero_times
			result.push(new_test_case)
		end

		return result.uniq
	end

	def start_input_counters *inputs_set
		@appearance_count = Hash.new
		for set in inputs_set
			@appearance_count[set] = init_set_counter(set)
		end
	end

	def init_set_counter set
		result = Hash.new
		for element in set
			result[element] = 0
		end

		return result
	end

	def any_vals_appear_zero_times
		fail if counters.size != total_size_of_inputs
		debug("Counters array is #{counters.join(',')}")
		for count in counters
			if count == 0 then
				return true
			end
		end

		return false
	end

	def counters
		result =[]
		for set in @sets
			result.push(@appearance_count[set].values)
		end

		return result.flatten
	end


	def total_size_of_inputs
		@appearance_count.keys.flatten.size
	end

	def new_test_case
		new_test = []
		for set in ordered_sets
			new_test.push(set.first)
		end

		new_test = order_according_input(new_test)
		debug("new test is #{new_test.join(',')}")
		return 	new_test
	end


	def ordered_sets
		if @first_time then
			@first_time = false
			return @sets.map{|k| Array.new(k)}
		end

		update_counters

		return @sets.map{|k|
			order_set(k)
		}
	end

	def update_counters
		@sets.each{|s|
			@appearance_count[s][order_set(s).first] +=1
		}
	end

	def order_set set
		set.sort{|a,b|
			counter_compare set,a,b
		}
	end

	def counter_compare set, a,b
		@appearance_count[set][a] > @appearance_count[set][b] ? 1 : -1
	end

	def order_according_input test_case
		test_case.sort{|a,b|
			set_position_of(a) <=> set_position_of(b)
		}
	end

	def set_position_of element
		for set in @sets 
			return @sets.index(set) if set.include?(element)
		end
	end
end
