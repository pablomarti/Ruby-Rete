require "AlphaMemory.rb"
require "AlphaMemoryHT.rb"
require "Condition.rb"
require "WME.rb"

class Rete

	def initialize
		puts "Starting Rete network..."
		@alpha_memory = AlphaMemory.new
		@alpha_memory_ht = AlphaMemoryHT.new
	end

	def set_productions(conditions)
		conditions.map{ |condition|
			@alpha_memory_ht.add_alpha_memory(condition)
		}
	end

	def add_wme(wme)
		c_id = wme.id
		c_attr = wme.attr
		c_value = wme.value
		all = "*"

		alpha_memories = @alpha_memory_ht.get_alpha_memory(c_id, c_attr, c_value)
		if alpha_memories.nil?
			alpha_memories = @alpha_memory_ht.get_alpha_memory(c_id, c_attr, all)

			if alpha_memories.nil?
				alpha_memories = @alpha_memory_ht.get_alpha_memory(c_id, all, c_value)

				if alpha_memories.nil?
					alpha_memories = @alpha_memory_ht.get_alpha_memory(c_id, all, all)

					if alpha_memories.nil?
						alpha_memories = @alpha_memory_ht.get_alpha_memory(all, c_attr, c_value)

						if alpha_memories.nil?
							alpha_memories = @alpha_memory_ht.get_alpha_memory(all, c_attr, all)

							if alpha_memories.nil?
								alpha_memories = @alpha_memory_ht.get_alpha_memory(all, all, c_value)

								if alpha_memories.nil?
									alpha_memories = @alpha_memory_ht.get_alpha_memory(all, all, all)
								end
							end
						end
					end
				end
			end
		end

		if !alpha_memories.nil?
			alpha_memory_activation(alpha_memories, wme)
		else
			puts "AM not found..."
		end
	end

	def alpha_memory_activation(alpha_memory_node, wme)
		@alpha_memory.items << wme
		@alpha_memory.successors.map{ |child|
			right_activation(child, wme)
		}
		puts "AM: " + alpha_memory_node.inspect
	end

	def right_activation(child, wme)
	end

=begin
	def constant_test_node_activation(node, wme)
		if node.field_to_test != "no_test"
			v = wme[node.field_to_test]
			if v != node.thing_field_must_equal
				return  #Failed test, don't propagate any further
			end
		end

		if !node.output_memory.nil?
			alpha_memory_activation(node.output_memory, wme)
		end

		node.children.map{ |c|
			constant_test_node_activation(c, wme)
		}
	end
=end

end