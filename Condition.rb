class Condition

	attr_accessor :id, :attr, :value

	def initialize(c_id = 0, c_attr = 0, c_value = 0)
		@id = c_id
		@attr = c_attr
		@value = c_value
	end

end