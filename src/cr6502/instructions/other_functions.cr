class CPU
   def brk
    @program_counter += 1
    @stack_pointer -= 1
    poke(@stack_pointer.to_i + 0x100, @program_counter)
    @stack_pointer -= 1
    poke(@stack_pointer.to_i + 0x100, @flags | 0x10_u8)
    @stack_pointer -= 1
    @program_counter = peek(BRK_LOCATION, true).to_u16
  end

   def nop
  end
end
