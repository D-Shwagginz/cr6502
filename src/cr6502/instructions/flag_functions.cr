class CPU
  private def clc
    set_flag(Flags::Carry, false)
  end

  private def sec
    set_flag(Flags::Carry, true)
  end

  private def cli
    set_flag(Flags::InterruptDisable, false)
  end

  private def sei
    set_flag(Flags::InterruptDisable, true)
  end

  private def cld
    set_flag(Flags::DecimalMode, false)
  end

  private def sed
    set_flag(Flags::DecimalMode, true)
  end

  private def clv
    set_flag(Flags::Overflow, false)
  end
end
