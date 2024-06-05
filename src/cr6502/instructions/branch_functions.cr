class CPU
  private def bpl(m_value : UInt8)
    if get_flag(Flags::Negative) == false
      u_m_value = (m_value - 128).to_i8

      page_difference = (@program_counter.to_i - @program_counter.to_i//255*255 + u_m_value.to_i)
      @instruction_cycles += page_difference > 255 || page_difference < 0 ? 2 : 1
      @program_counter += u_m_value.to_i16
    end
  end

  private def bvc(m_value : UInt8)
    if get_flag(Flags::Overflow) == false
      u_m_value = (m_value - 128).to_i8

      page_difference = (@program_counter.to_i - @program_counter.to_i//255*255 + u_m_value.to_i)
      @instruction_cycles += page_difference > 255 || page_difference < 0 ? 2 : 1
      @program_counter += u_m_value.to_i16
    end
  end

  private def bcc(m_value : Int)
    if get_flag(Flags::Carry) == false
      u_m_value = (m_value - 128).to_i8

      page_difference = (@program_counter.to_i - @program_counter.to_i//255*255 + u_m_value.to_i)
      @instruction_cycles += page_difference > 255 || page_difference < 0 ? 2 : 1
      @program_counter += u_m_value.to_i16
    end
  end

  private def bne(m_value : Int)
    if get_flag(Flags::Zero) == false
      u_m_value = (m_value - 128).to_i8

      page_difference = (@program_counter.to_i - @program_counter.to_i//255*255 + u_m_value.to_i)
      @instruction_cycles += page_difference > 255 || page_difference < 0 ? 2 : 1
      @program_counter += u_m_value.to_i16
    end
  end

  private def bmi(m_value : UInt8)
    if get_flag(Flags::Negative) == true
      u_m_value = (m_value - 128).to_i8

      page_difference = (@program_counter.to_i - @program_counter.to_i//255*255 + u_m_value.to_i)
      @instruction_cycles += page_difference > 255 || page_difference < 0 ? 2 : 1
      @program_counter += u_m_value.to_i16
    end
  end

  private def bvs(m_value : Int)
    if get_flag(Flags::Overflow) == true
      u_m_value = (m_value - 128).to_i8

      page_difference = (@program_counter.to_i - @program_counter.to_i//255*255 + u_m_value.to_i)
      @instruction_cycles += page_difference > 255 || page_difference < 0 ? 2 : 1
      @program_counter += u_m_value.to_i16
    end
  end

  private def bcs(m_value : Int)
    if get_flag(Flags::Carry) == true
      u_m_value = (m_value - 128).to_i8

      page_difference = (@program_counter.to_i - @program_counter.to_i//255*255 + u_m_value.to_i)
      @instruction_cycles += page_difference > 255 || page_difference < 0 ? 2 : 1
      @program_counter += u_m_value.to_i16
    end
  end

  private def beq(m_value : Int)
    if get_flag(Flags::Zero) == true
      u_m_value = (m_value - 128).to_i8

      page_difference = (@program_counter.to_i - @program_counter.to_i//255*255 + u_m_value.to_i)
      @instruction_cycles += page_difference > 255 || page_difference < 0 ? 2 : 1
      @program_counter += u_m_value.to_i16
    end
  end
end
