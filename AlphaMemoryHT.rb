class AlphaMemoryHT

	def initialize
		@ids = {}
		@attrs = {}
		@values = {}
		@am = []
	end

	def add_alpha_memory(condition)
		c_id = condition.id
		c_attr = condition.attr
		c_value = condition.value
		am_position = @am.length
		@am << condition

		if !@ids.has_key?(c_id)
			@ids[c_id] = [am_position]
		else
			@ids[c_id] << am_position
		end

		if !@attrs.has_key?(c_attr)
			@attrs[c_attr] = [am_position]
		else
			@attrs[c_attr] << am_position
		end

		if !@values.has_key?(c_value)
			@values[c_value] = [am_position]
		else
			@values[c_value] << am_position
		end
	end

	def get_alpha_memory(c_id, c_attr, c_value)
		am_elements = []

		puts "MATCHING: #{c_id} #{c_attr} #{c_value}"
		
		am_elements = get_alpha_memory_structure(@ids, c_id)
		am_elements &= get_alpha_memory_structure(@attrs, c_attr)
		am_elements &= get_alpha_memory_structure(@values, c_value)

		return am_elements.empty? ? nil : am_elements.first
	end

	def get_alpha_memory_structure(ht, field)
		ht[field].nil? ? [] : ht[field]
	end

end