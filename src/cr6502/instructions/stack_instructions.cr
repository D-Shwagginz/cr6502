class CPU
  # These instructions are implied mode, have a length of one byte and require machine cycles as indicated. The "PULL" operations are known as "POP" on most other microprocessors.
  #
  # With the 6502, the stack is always on page $01 ($0100-$01FF) and works top down. i.e., when you push to the stack the stack pointer is decremented. When you pull from the stack the stack pointer is incremented.

  #	Push Accumulator
  def pha
    poke(@stack_pointer.to_i + 0x100, @accumulator)
    @stack_pointer -= 1
  end

  # Push Processor Status (`CPU#flags`)
  def php
    poke(@stack_pointer.to_i + 0x100, @flags)
    @stack_pointer -= 1
  end

  # Transfer Stack Pointer to X
  def tsx
    @x_index = @stack_pointer
    set_flag(Flags::Negative, @x_index.bit(7) == 1)
    set_flag(Flags::Zero, @x_index == 0)
  end

  # Pull Accumulator
  def pla
    @stack_pointer += 1
    @accumulator = peek(@stack_pointer.to_i + 0x100).to_u8
    set_flag(Flags::Negative, @accumulator.bit(7) == 1)
    set_flag(Flags::Zero, @accumulator == 0)
  end

  # Pull Processor Status
  def plp
    @stack_pointer += 1
    @flags = peek(@stack_pointer.to_i + 0x100).to_u8
  end

  #	Transfer X to Stack Pointer
  def txs
    @stack_pointer = @x_index
  end
end
