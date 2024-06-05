class CPU
   def jmp(m_value : UInt16)
    @program_counter = m_value
  end

   def jsr(address : UInt16)
    t = @program_counter - 1
    @stack_pointer -= 1
    poke(@stack_pointer.to_i + 0x100, t)
    @stack_pointer -= 1
    @program_counter = address.to_u16
  end

   def rts
    @stack_pointer += 1
    @program_counter = peek(@stack_pointer, true).to_u16 + 1
    @stack_pointer += 1
  end

   def rti
    @stack_pointer += 1
    @flags = peek(@stack_pointer.to_i + 0x100).to_u8
    @stack_pointer += 1
    @program_counter = peek(@stack_pointer.to_i + 0x100, true).to_u16
    @stack_pointer += 1
  end
end
