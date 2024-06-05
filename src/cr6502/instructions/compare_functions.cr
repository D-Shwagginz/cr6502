class CPU
  private def cmp(m_value : UInt8)
    t = @accumulator - m_value
    set_flag(Flags::Carry, @accumulator >= m_value)
    set_flag(Flags::Negative, t.bit(7) == 1)
    set_flag(Flags::Zero, t == 0)
  end

  private def cpx(m_value : UInt8)
    t = @x_index - m_value
    set_flag(Flags::Carry, @x_index >= m_value)
    set_flag(Flags::Negative, t.bit(7) == 1)
    set_flag(Flags::Zero, t == 0)
  end

  private def cpy(m_value : UInt8)
    t = @y_index - m_value
    set_flag(Flags::Carry, @y_index >= m_value)
    set_flag(Flags::Negative, t.bit(7) == 1)
    set_flag(Flags::Zero, t == 0)
  end

  private def bit(m_value : UInt8)
    t = @accumulator & m_value
    set_flag(Flags::Negative, t.bit(7) == 1)
    set_flag(Flags::Overflow, t.bit(6) == 1)
    set_flag(Flags::Zero, t == 0)
  end
end
