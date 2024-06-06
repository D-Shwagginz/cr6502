class CPU
  # Print a 8-bit or 16-bit value. Mainly used with string interpolation
  #
  # Example:
  #
  # ```
  # cpu = CPU.new
  #
  # cpu.load_asm("
  # prt #{cpu.stack_pointer}
  # ")
  #
  # cpu.execute # => puts "Type: UInt8 | Hex: ff | Decimal 255 | Binary: 11111111"
  # ```
  def prt(value_to_print : UInt8 | UInt16)
    puts "Type: #{typeof(value_to_print)} | Hex: 0x#{value_to_print.to_s(
                                                       16, precision: (typeof(value_to_print) == UInt8 ? 2 : 4)
                                                     )} | Decimal: #{value_to_print} | Binary: 0b#{value_to_print.to_s(2)}"
  end

  # Prints out information about the CPU in its current state
  def log
    next_instruction = INSTRUCTIONS.find! { |i| i[1] == peek(@program_counter) }
    bv_instruction = INSTRUCTIONS.find! { |i| i[1] == peek(peek(BRK_LOCATION, true)) }
    puts "
    --- CPU LOG ---
    Accumulator         = #{@accumulator}
    X                   = #{@x_index}
    Y                   = #{@y_index}
    Stack Pointer       = 0x#{@stack_pointer.to_s(16, precision: 2)}   | #{@stack_pointer}
    Program Counter     = 0x#{@program_counter.to_s(16, precision: 4)} | #{@program_counter}

    Flags
    NV-BDIZC
    #{@flags.to_s(2, precision: 8)}

    Clock Cycle         = #{@clock_cycle_mhz}mhz
    Reset Vector        = 0x#{peek(RES_LOCATION, true).to_s(16, precision: 4)} | #{peek(RES_LOCATION, true)}
    Break Vector        = 0x#{peek(BRK_LOCATION, true).to_s(16, precision: 4)} | #{peek(BRK_LOCATION, true)}
    Instruction at BV   = Name: \"#{bv_instruction[0]}\" | Opcode: 0x#{bv_instruction[1].to_s(16, precision: 2)} | Cycle Length: #{bv_instruction[2]}

    Log Location        = 0x#{(@program_counter - 1).to_s(16, precision: 4)} | #{@program_counter - 1}
    Next Instruction    = Name: \"#{next_instruction[0]}\" | Opcode: 0x#{next_instruction[1].to_s(16, precision: 2)} | Cycle Length: #{next_instruction[2]}
    --- CPU LOG ---
    "
  end

  # Stops any active running `CPU#execute`
  # 
  # When used with `CPU#execute(reset: false)`, it can act as a way to pause
  def stp
    @stop_exec = true
  end
end
