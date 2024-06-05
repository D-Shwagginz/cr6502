class CPU
   def pha
    poke(@stack_pointer.to_i + 0x100, @accumulator)
    @stack_pointer -= 1
  end

   def php
    poke(@stack_pointer.to_i + 0x100, @flags)
    @stack_pointer -= 1
  end

   def tsx
    @x_index = @stack_pointer
    set_flag(Flags::Negative, @x_index.bit(7) == 1)
    set_flag(Flags::Zero, @x_index == 0)
  end

   def pla
    @stack_pointer += 1
    @accumulator = peek(@stack_pointer.to_i + 0x100).to_u8
    set_flag(Flags::Negative, @accumulator.bit(7) == 1)
    set_flag(Flags::Zero, @accumulator == 0)
  end

   def plp
    @stack_pointer += 1
    @flags = peek(@stack_pointer.to_i + 0x100).to_u8
  end

   def txs
    @stack_pointer = @x_index
  end
end
