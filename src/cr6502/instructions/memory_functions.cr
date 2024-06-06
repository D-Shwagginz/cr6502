class CPU
  # Load Accumulator
  def lda(m_value : UInt8)
    @accumulator = m_value
    set_flag(Flags::Negative, @accumulator.bit(7) == 1)
    set_flag(Flags::Zero, @accumulator == 0)
  end

  # Load X Register
  def ldx(m_value : UInt8)
    @x_index = m_value
    set_flag(Flags::Negative, @x_index.bit(7) == 1)
    set_flag(Flags::Zero, @x_index == 0)
  end

  # Load Y Register
  def ldy(m_value : UInt8)
    @y_index = m_value
    set_flag(Flags::Negative, @y_index.bit(7) == 1)
    set_flag(Flags::Zero, @y_index == 0)
  end

  # Decrement Memory
  def dec(m_value : UInt8, m : UInt16 | UInt8)
    poke(m, (m_value - 1) & 0xff)
    set_flag(Flags::Negative, m_value.bit(7) == 1)
    set_flag(Flags::Zero, m_value == 0)
  end

  # Store Accumulator
  def sta(m : UInt16 | UInt8)
    poke(m, @accumulator)
  end

  # Store X Register
  def stx(m : UInt16 | UInt8)
    poke(m, @x_index)
  end

  # Store Y Register
  def sty(m : UInt16 | UInt8)
    poke(m, @y_index)
  end

  # Increment Memory
  def inc(m_value : UInt8, m : UInt16 | UInt8)
    poke(m, (m_value + 1) & 0xff)
    set_flag(Flags::Negative, m_value.bit(7) == 1)
    set_flag(Flags::Zero, m_value == 0)
  end
end
