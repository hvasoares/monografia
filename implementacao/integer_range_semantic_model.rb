class IntegerRangeSemanticModel
	def initialize array_integers
		@range = array_integers.first.to_i..array_integers.last.to_i
	end

	def sample
		@range.to_a[rand(@range.to_a.size)]
	end

	def applies_to? integer
		@range.member?(integer)
	end

end
