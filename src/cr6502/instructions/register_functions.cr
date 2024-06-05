class CPU
  private def tax
    @x_index = @accumulator
    set_flag(Flags::Negative, @x_index.bit(7) == 1)
    set_flag(Flags::Zero, @x_index == 0)
  end

  private def txa
    @accumulator = @x_index
    set_flag(Flags::Negative, @accumulator.bit(7) == 1)
    set_flag(Flags::Zero, @accumulator == 0)
  end

  private def dex
    @x_index -= 1
    set_flag(Flags::Zero, @x_index == 0)
    set_flag(Flags::Negative, @x_index.bit(7) == 1)
  end

  private def inx(address : Int)
    @x_index += 1
    set_flag(Flags::Zero, @x_index == 0)
    set_flag(Flags::Negative, @x_index.bit(7) == 1)
  end

  private def tay
    @y_index = @accumulator
    set_flag(Flags::Negative, @y_index.bit(7) == 1)
    set_flag(Flags::Zero, @y_index == 0)
  end

  private def tya
    @accumulator = @y_index
    set_flag(Flags::Negative, @accumulator.bit(7) == 1)
    set_flag(Flags::Zero, @accumulator == 0)
  end

  private def dey
    @y_index -= 1
    set_flag(Flags::Zero, @y_index == 0)
    set_flag(Flags::Negative, @y_index.bit(7) == 1)
  end

  private def iny
    @y_index += 1
    set_flag(Flags::Zero, @y_index == 0)
    set_flag(Flags::Negative, @y_index.bit(7) == 1)
  end
end
