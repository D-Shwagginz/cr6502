class CPU
  # Break
  #
  # BRK sets the B flag, and then generates a forced interrupt. The Interrupt flag is ignored and the CPU goes through the normal interrupt process. In the interrupt service routine, the state of the B flag can be used to distinguish a BRK from a standard interrupt.
  #
  # BRK causes a non-maskable interrupt and increments the program counter by one. Therefore an `CPU#rti` will go to the address of the BRK +2 so that BRK may be used to replace a two-byte instruction for debugging and the subsequent RTI will be correct.
  def brk
    @program_counter += 1
    @stack_pointer -= 1
    poke(@stack_pointer.to_i + 0x100, @program_counter)
    @stack_pointer -= 1
    poke(@stack_pointer.to_i + 0x100, @flags | 0x10_u8)
    @stack_pointer -= 1
    @program_counter = peek(BRK_LOCATION, true).to_u16
  end

  # No Operation
  #
  # A NOP takes 2 machine cycles to execute, but it has no effect on any register, memory location, or processor flag. Thus, it takes up time and space but performs no operation.
  #
  # NOP can be used to reserve space for future modifications or to remove existing code without changing the memory locations of code that follows it.
  #
  # NOP can also be used in tightly timed code, to idly take up 2 cycles without having any other side effects.
  def nop
  end
end
