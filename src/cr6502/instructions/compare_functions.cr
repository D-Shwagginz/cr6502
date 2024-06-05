class CPU
   def cmp(m_value : UInt8)
    t = @accumulator - m_value
    set_flag(Flags::Carry, @accumulator >= m_value)
    set_flag(Flags::Negative, t.bit(7) == 1)
    set_flag(Flags::Zero, t == 0)
  end

   def cpx(m_value : UInt8)
    t = @x_index - m_value
    set_flag(Flags::Carry, @x_index >= m_value)
    set_flag(Flags::Negative, t.bit(7) == 1)
    set_flag(Flags::Zero, t == 0)
  end

   def cpy(m_value : UInt8)
    t = @y_index - m_value
    set_flag(Flags::Carry, @y_index >= m_value)
    set_flag(Flags::Negative, t.bit(7) == 1)
    set_flag(Flags::Zero, t == 0)
  end

   def bit(m_value : UInt8)
    t = @accumulator & m_value
    set_flag(Flags::Negative, t.bit(7) == 1)
    set_flag(Flags::Overflow, t.bit(6) == 1)
    set_flag(Flags::Zero, t == 0)
  end
end
