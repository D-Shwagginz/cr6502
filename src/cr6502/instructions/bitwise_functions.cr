class CPU
   def and(m_value : UInt8)
    @accumulator = @accumulator & m_value
    set_flag(Flags::Negative, @accumulator.bit(7) == 1)
    set_flag(Flags::Zero, @accumulator == 0)
  end

   def eor(m_value : UInt8)
    @accumulator = @accumulator ^ m_value
    set_flag(Flags::Negative, @accumulator.bit(7) == 1)
    set_flag(Flags::Zero, @accumulator == 0)
  end

   def ora(m_value : UInt8)
    @accumulator = @accumulator | m_value
    set_flag(Flags::Negative, @accumulator.bit(7) == 1)
    set_flag(Flags::Zero, @accumulator == 0)
  end

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
