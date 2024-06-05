class CPU
  RES_LOCATION = 0xfffc_u16
  BRK_LOCATION = 0xfffe_u16

  enum Flags
    Negative
    Overflow
    Break
    DecimalMode
    InterruptDisable
    Zero
    Carry
  end

  getter memory : IO::Memory = IO::Memory.new(65536)
  getter accumulator : UInt8 = 0
  getter x_index : UInt8 = 0
  getter y_index : UInt8 = 0
  getter stack_pointer : UInt8 = 255
  getter program_counter : UInt16 = 0
  @previous_program_counter = -1
  getter flags : UInt8 = 0b00100000
  getter clock_cycle_mhz : Float64 = 0
  @instruction_cycles : Int32 = 0

  def initialize(@clock_cycle_mhz : Float = 1.79, reset : UInt16 = 0, brk : UInt16 = 0)
    set_flag(Flags::InterruptDisable, true)

    poke(RES_LOCATION, reset)
    poke(BRK_LOCATION, brk)

    @program_counter = peek(RES_LOCATION, true).to_u16
  end

  def step(end_on_tight_loop : Bool = true)
    if end_on_tight_loop
      if @program_counter != @previous_program_counter
        @previous_program_counter = @program_counter
        run_instruction
      end
    else
      run_instruction
    end
  end

  def execute(end_on_tight_loop : Bool = true)
    @memory.pos = 0xfffc
    @program_counter = @memory.read_bytes(UInt16, IO::ByteFormat::LittleEndian)

    if end_on_tight_loop
      while @program_counter != @previous_program_counter
        sleep(1/@clock_cycle_mhz/1000000 * @instruction_cycles)
        @previous_program_counter = @program_counter
        run_instruction
      end
    else
      while true
        sleep(1/@clock_cycle_mhz/1000000 * @instruction_cycles)
        run_instruction
      end
    end
  end

  private def bcd(byte : UInt8 | Int8)
    tens = byte.bits(4..7)
    ones = byte.bits(0..3)
    return "#{tens}#{ones}".to_u8
  end

  private def poke(mem_location : Int, data : UInt8 | UInt16)
    @memory.pos = mem_location
    @memory.write_bytes(data, IO::ByteFormat::LittleEndian)
  end

  private def peek(mem_location : Int, two_byte : Bool = false)
    @memory.pos = mem_location
    return two_byte ? @memory.read_bytes(UInt16, IO::ByteFormat::LittleEndian) : @memory.read_bytes(UInt8, IO::ByteFormat::LittleEndian)
  end

  private def get_flag(flag : Flags) : Bool
    case flag
    when Flags::Negative
      return true if @flags.bit(7) == 1
    when Flags::Overflow
      return true if @flags.bit(6) == 1
    when Flags::Break
      return true if @flags.bit(4) == 1
    when Flags::DecimalMode
      return true if @flags.bit(3) == 1
    when Flags::InterruptDisable
      return true if @flags.bit(2) == 1
    when Flags::Zero
      return true if @flags.bit(1) == 1
    when Flags::Carry
      return true if @flags.bit(0) == 1
    end

    return false
  end

  private def set_flag(flag : Flags, set : Bool)
    if set
      case flag
      when Flags::Negative
        @flags = @flags | 0b10000000
      when Flags::Overflow
        @flags = @flags | 0b01000000
      when Flags::Break
        @flags = @flags | 0b00010000
      when Flags::DecimalMode
        @flags = @flags | 0b00001000
      when Flags::InterruptDisable
        @flags = @flags | 0b00000100
      when Flags::Zero
        @flags = @flags | 0b00000010
      when Flags::Carry
        @flags = @flags | 0b00000001
      end
    else
      case flag
      when Flags::Negative
        @flags = @flags & 0b01111111
      when Flags::Overflow
        @flags = @flags & 0b10111111
      when Flags::Break
        @flags = @flags & 0b11101111
      when Flags::DecimalMode
        @flags = @flags & 0b11110111
      when Flags::InterruptDisable
        @flags = @flags & 0b11111011
      when Flags::Zero
        @flags = @flags & 0b11111101
      when Flags::Carry
        @flags = @flags & 0b11111110
      end
    end
  end

  # Prints out the current memory.
  def print_memory(start_pos : Int = 0, length : Int = 65536)
    if start_pos > 65535
      raise Exception.new("'start_pos' is greater than 65535 which is the maximum amount of memory")
    elsif start_pos + length > 65536
      raise Exception.new("'length' goes past end of memory. 'start_pos' + 'length' = #{start_pos + length} which is greater than 65536")
    else
      @memory.pos = 0
      slice = Bytes.new(65536)
      @memory.read(slice)
      slice.hexdump[start_pos + start_pos*76, length*76].each_line do |line|
        puts line[4..-1]
      end
    end
  end
end
