class CPU
   def clc
    set_flag(Flags::Carry, false)
  end

   def sec
    set_flag(Flags::Carry, true)
  end

   def cli
    set_flag(Flags::InterruptDisable, false)
  end

   def sei
    set_flag(Flags::InterruptDisable, true)
  end

   def cld
    set_flag(Flags::DecimalMode, false)
  end

   def sed
    set_flag(Flags::DecimalMode, true)
  end

   def clv
    set_flag(Flags::Overflow, false)
  end
end
