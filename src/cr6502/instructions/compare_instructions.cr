class CPU
  # Compare Accumulator
  #
  # Compare sets processor flags as if a subtraction had been carried out.
  #
  # If the accumulator and the compared value are equal, the result of the subtraction is zero and the Zero (Z) flag is set. If the accumulator is equal or greater than the compared value, the Carry (C) flag is set.
  def cmp(m_value : UInt8)
    t = @accumulator - m_value
    set_flag(Flags::Carry, @accumulator >= m_value)
    set_flag(Flags::Negative, t.bit(7) == 1)
    set_flag(Flags::Zero, t == 0)
  end

  # Compare X Register
  #
  # Operation and flag results are identical to equivalent mode accumulator `CPU#cmp` operations.
  def cpx(m_value : UInt8)
    t = @x_index - m_value
    set_flag(Flags::Carry, @x_index >= m_value)
    set_flag(Flags::Negative, t.bit(7) == 1)
    set_flag(Flags::Zero, t == 0)
  end

  # Compare Y Register
  #
  # Operation and flag results are identical to equivalent mode accumulator `CPU#cmp` operations.
  def cpy(m_value : UInt8)
    t = @y_index - m_value
    set_flag(Flags::Carry, @y_index >= m_value)
    set_flag(Flags::Negative, t.bit(7) == 1)
    set_flag(Flags::Zero, t == 0)
  end

  # Test Bits
  #
  # BIT sets the Z flag as though the value in the address tested were ANDed with the accumulator.
  #
  # The N and V flags are set equal to bits 7 and 6 respectively of the value in the tested address.
  def bit(m_value : UInt8)
    t = @accumulator & m_value
    set_flag(Flags::Negative, t.bit(7) == 1)
    set_flag(Flags::Overflow, t.bit(6) == 1)
    set_flag(Flags::Zero, t == 0)
  end
end
