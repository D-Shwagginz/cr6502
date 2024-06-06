class CPU
  # Bitwise AND with Accumulator
  def and(m_value : UInt8)
    @accumulator = @accumulator & m_value
    set_flag(Flags::Negative, @accumulator.bit(7) == 1)
    set_flag(Flags::Zero, @accumulator == 0)
  end

  # Bitwise Exclusive-OR with Accumulator
  def eor(m_value : UInt8)
    @accumulator = @accumulator ^ m_value
    set_flag(Flags::Negative, @accumulator.bit(7) == 1)
    set_flag(Flags::Zero, @accumulator == 0)
  end

  # Bitwise OR with Accumulator
  def ora(m_value : UInt8)
    @accumulator = @accumulator | m_value
    set_flag(Flags::Negative, @accumulator.bit(7) == 1)
    set_flag(Flags::Zero, @accumulator == 0)
  end

  # Arithmetic Shift Left
  #
  # ASL shifts all bits left one position.
  # 0 is shifted into bit 0 and the original bit 7 is shifted into the Carry.
  def asl(m_value : UInt8, m : UInt16 | UInt8, accumulator : Bool = false)
    set_flag(Flags::Carry, m_value.bit(7) == 1)
    if accumulator
      @accumulator = ((@accumulator << 1) & 0xfe)
    else
      poke(m, ((m_value << 1) & 0xfe))
    end
    set_flag(Flags::Negative, m_value.bit(7) == 1)
    set_flag(Flags::Zero, m_value == 0)
  end

  # Logical Shift Right
  #
  # LSR shifts all bits right one position.
  # 0 is shifted into bit 7 and the original bit 0 is shifted into the Carry.
  def lsr(m_value : UInt8, m : UInt16 | UInt8, accumulator : Bool = false)
    set_flag(Flags::Negative, false)
    set_flag(Flags::Carry, m_value.bit(0) == 1)

    if accumulator
      @accumulator = ((m_value >> 1) & 0x7f)
    else
      poke(m, ((m_value >> 1) & 0x7f))
    end

    set_flag(Flags::Zero, m_value == 0)
  end

  # Rotate Left
  #
  # ROL shifts all bits left one position.
  # The Carry is shifted into bit 0 and the original bit 7 is shifted into the Carry.
  def rol(m_value : UInt8, m : UInt16 | UInt8, accumulator : Bool = false)
    t = m_value.bit(7)

    if accumulator
      @accumulator = (@accumulator << 1) & 0xfe
      @accumulator = @accumulator | get_flag(Flags::Carry).to_unsafe
    else
      poke(m, (m_value << 1) & 0xfe)
      poke(m, m_value | get_flag(Flags::Carry).to_unsafe)
    end

    set_flag(Flags::Carry, t == 1)
    set_flag(Flags::Zero, m_value == 0)
    set_flag(Flags::Negative, m_value.bit(7) == 1)
  end

  # Rotate Right
  #
  # ROR shifts all bits right one position.
  # The Carry is shifted into bit 7 and the original bit 0 is shifted into the Carry.
  def ror(m_value : UInt8, m : UInt16 | UInt8, accumulator : Bool = false)
    t = m_value.bit(0) == 1
    @accumulator = (m_value >> 1) & 0x7f
    @accumulator = m_value | (get_flag(Flags::Carry) ? 0x80 : 0x00)
    if accumulator
    else
      poke(m, (m_value >> 1) & 0x7f)
      poke(m, m_value | (get_flag(Flags::Carry) ? 0x80 : 0x00))
    end

    set_flag(Flags::Carry, t)
    set_flag(Flags::Zero, m_value == 0)
    set_flag(Flags::Negative, m_value.bit(7) == 1)
  end
end
