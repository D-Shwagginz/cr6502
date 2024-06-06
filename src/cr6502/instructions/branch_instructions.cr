class CPU
  # All branches are relative mode and have a length of two bytes.
  # Syntax is "Bxx Displacement" or (better) "Bxx Label".
  # Branches are dependant on the status of the flag bits when the opcode is encountered.
  #
  # A branch not taken requires 2 machine cycles.
  # A branch requires 3 cycles if taken, plus 1 cycle if the branch cross a page boundary.

  # Branch on Plus
  def bpl(m_value : UInt8 | UInt16)
    if get_flag(Flags::Negative) == false
      if typeof(m_value) == UInt16
        u_m_value = m_value.to_i - @program_counter
      else
        u_m_value = (m_value.to_i16 - 128).to_i8
      end

      page_difference = (@program_counter.to_i - @program_counter.to_i//255*255 + u_m_value.to_i)
      @instruction_cycles += page_difference > 255 || page_difference < 0 ? 2 : 1
      @program_counter += u_m_value.to_i16
    end
  end

  # Branch on Overflow Clear
  def bvc(m_value : UInt8 | UInt16)
    if get_flag(Flags::Overflow) == false
      if typeof(m_value) == UInt16
        u_m_value = m_value.to_i - @program_counter
      else
        u_m_value = (m_value.to_i16 - 128).to_i8
      end

      page_difference = (@program_counter.to_i - @program_counter.to_i//255*255 + u_m_value.to_i)
      @instruction_cycles += page_difference > 255 || page_difference < 0 ? 2 : 1
      @program_counter += u_m_value.to_i16
    end
  end

  # Branch on Carry Clear
  def bcc(m_value : UInt8 | UInt16)
    if get_flag(Flags::Carry) == false
      if typeof(m_value) == UInt16
        u_m_value = m_value.to_i - @program_counter
      else
        u_m_value = (m_value.to_i16 - 128).to_i8
      end

      page_difference = (@program_counter.to_i - @program_counter.to_i//255*255 + u_m_value.to_i)
      @instruction_cycles += page_difference > 255 || page_difference < 0 ? 2 : 1
      @program_counter += u_m_value.to_i16
    end
  end

  # Branch on Not Equal
  def bne(m_value : UInt8 | UInt16)
    if get_flag(Flags::Zero) == false
      if typeof(m_value) == UInt16
        u_m_value = m_value.to_i - @program_counter
      else
        u_m_value = (m_value.to_i16 - 128).to_i8
      end

      page_difference = (@program_counter.to_i - @program_counter.to_i//255*255 + u_m_value.to_i)
      @instruction_cycles += page_difference > 255 || page_difference < 0 ? 2 : 1
      @program_counter += u_m_value.to_i16
    end
  end

  # Branch on Minus
  def bmi(m_value : UInt8 | UInt16)
    if get_flag(Flags::Negative) == true
      if typeof(m_value) == UInt16
        u_m_value = m_value.to_i - @program_counter
      else
        u_m_value = (m_value.to_i16 - 128).to_i8
      end

      page_difference = (@program_counter.to_i - @program_counter.to_i//255*255 + u_m_value.to_i)
      @instruction_cycles += page_difference > 255 || page_difference < 0 ? 2 : 1
      @program_counter += u_m_value.to_i16
    end
  end

  # Branch on Overflow Set
  def bvs(m_value : UInt8 | UInt16)
    if get_flag(Flags::Overflow) == true
      if typeof(m_value) == UInt16
        u_m_value = m_value.to_i - @program_counter
      else
        u_m_value = (m_value.to_i16 - 128).to_i8
      end

      page_difference = (@program_counter.to_i - @program_counter.to_i//255*255 + u_m_value.to_i)
      @instruction_cycles += page_difference > 255 || page_difference < 0 ? 2 : 1
      @program_counter += u_m_value.to_i16
    end
  end

  # Branch on Carry Set
  def bcs(m_value : UInt8 | UInt16)
    if get_flag(Flags::Carry) == true
      if typeof(m_value) == UInt16
        u_m_value = m_value.to_i - @program_counter
      else
        u_m_value = (m_value.to_i16 - 128).to_i8
      end

      page_difference = (@program_counter.to_i - @program_counter.to_i//255*255 + u_m_value.to_i)
      @instruction_cycles += page_difference > 255 || page_difference < 0 ? 2 : 1
      @program_counter += u_m_value.to_i16
    end
  end

  # Branch on Equal
  def beq(m_value : UInt8 | UInt16)
    if get_flag(Flags::Zero) == true
      if typeof(m_value) == UInt16
        u_m_value = m_value.to_i - @program_counter
      else
        u_m_value = (m_value.to_i16 - 128).to_i8
      end

      page_difference = (@program_counter.to_i - @program_counter.to_i//255*255 + u_m_value.to_i)
      @instruction_cycles += page_difference > 255 || page_difference < 0 ? 2 : 1
      @program_counter += u_m_value.to_i16
    end
  end
end
