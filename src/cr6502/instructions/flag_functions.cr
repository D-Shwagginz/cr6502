class CPU
  # Clear Carry
  def clc
    set_flag(Flags::Carry, false)
  end

  # Set Carry
  def sec
    set_flag(Flags::Carry, true)
  end

  # Clear Interrupt
  def cli
    set_flag(Flags::InterruptDisable, false)
  end

  # Set Interrupt
  def sei
    set_flag(Flags::InterruptDisable, true)
  end

  # Clear Decimal
  def cld
    set_flag(Flags::DecimalMode, false)
  end

  # Set Decimal
  def sed
    set_flag(Flags::DecimalMode, true)
  end

  # Clear Overflow
  def clv
    set_flag(Flags::Overflow, false)
  end
end
