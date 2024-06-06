class CPU
  # Jump
  #
  # JMP loads the program counter with the absolute address, or the address stored at the memory location of the indirect address. Program execution proceeds from the new program counter value.
  def jmp(m_value : UInt16)
    @program_counter = m_value
  end

  # Jump Saving Return
  #
  # JSR pushes the address-1 of the next operation to the stack before transferring the value of the argument to the program counter. JSR behaves just like a JMP, but saves the return address to the stack first, thus creating a subroutine.
  #
  # Subroutines are normally terminated by an `CPU#rts` instruction.
  def jsr(address : UInt16)
    t = @program_counter - 1
    @stack_pointer -= 1
    poke(@stack_pointer.to_i + 0x100, t)
    @stack_pointer -= 1
    @program_counter = address.to_u16
  end

  # Return to Saved
  #
  # RTS pulls the top two bytes off the stack (low byte first) and transfers them to the program counter. The program counter is incremented by one and then execution proceeds from there.
  #
  # RTS is typically used in combination with a `CPU#jsr` which saves the return address-1 to the stack.
  def rts
    @stack_pointer += 1
    @program_counter = peek(@stack_pointer, true).to_u16 + 1
    @stack_pointer += 1
  end

  # Return from Interrupt
  #
  # RTI retrieves the Processor Status byte and Program Counter from the stack in that order. Interrupts push the program counter first and then the processor status.
  #
  # Unlike RTS, the return address on the stack is the actual address rather than the address-1.
  def rti
    @stack_pointer += 1
    @flags = peek(@stack_pointer.to_i + 0x100).to_u8
    @stack_pointer += 1
    @program_counter = peek(@stack_pointer.to_i + 0x100, true).to_u16
    @stack_pointer += 1
  end
end
