class CPU
  private def adc(m_value : UInt8)
    t = @accumulator + m_value + get_flag(Flags::Carry).to_unsafe
    set_flag(Flags::Overflow, @accumulator.bit(7) != t.bit(7))
    set_flag(Flags::Negative, @accumulator.bit(7) == 1)
    set_flag(Flags::Zero, t == 0)

    if get_flag(Flags::DecimalMode)
      t = bcd(@accumulator) + bcd(m_value.to_u8) + get_flag(Flags::Carry).to_unsafe
      set_flag(Flags::Carry, t > 99)
    else
      set_flag(Flags::Carry, t > 255)
    end

    @accumulator = t & 0xff
  end

  private def sbc(m_value : UInt8)
    if get_flag(Flags::DecimalMode)
      t = bcd(@accumulator) - bcd(m_value) - (get_flag(Flags::Carry) ? 0 : 1)
      set_flag(Flags::Overflow, t > 99 || t < 0)
    else
      t = @accumulator - m_value - (get_flag(Flags::Carry) ? 0 : 1)
      set_flag(Flags::Overflow, t > 127 || t < -128)
    end

    set_flag(Flags::Carry, t >= 0)
    set_flag(Flags::Negative, t.bit(7) == 1)
    set_flag(Flags::Zero, t == 0)
    @accumulator = t & 0xff
  end
end
