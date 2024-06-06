class CPU
  # These instructions are implied mode, have a length of one byte and require two machine cycles.

  # Transfer A to X
  def tax
    @x_index = @accumulator
    set_flag(Flags::Negative, @x_index.bit(7) == 1)
    set_flag(Flags::Zero, @x_index == 0)
  end

  #	Tranfer X to A
  def txa
    @accumulator = @x_index
    set_flag(Flags::Negative, @accumulator.bit(7) == 1)
    set_flag(Flags::Zero, @accumulator == 0)
  end

  # Decrement X
  def dex
    @x_index -= 1
    set_flag(Flags::Zero, @x_index == 0)
    set_flag(Flags::Negative, @x_index.bit(7) == 1)
  end

  # Increment X
  def inx
    @x_index += 1
    set_flag(Flags::Zero, @x_index == 0)
    set_flag(Flags::Negative, @x_index.bit(7) == 1)
  end

  #	Transfer A to Y
  def tay
    @y_index = @accumulator
    set_flag(Flags::Negative, @y_index.bit(7) == 1)
    set_flag(Flags::Zero, @y_index == 0)
  end

  #	Transfer Y to A
  def tya
    @accumulator = @y_index
    set_flag(Flags::Negative, @accumulator.bit(7) == 1)
    set_flag(Flags::Zero, @accumulator == 0)
  end

  # Decrement Y
  def dey
    @y_index -= 1
    set_flag(Flags::Zero, @y_index == 0)
    set_flag(Flags::Negative, @y_index.bit(7) == 1)
  end

  # Increment Y
  def iny
    @y_index += 1
    set_flag(Flags::Zero, @y_index == 0)
    set_flag(Flags::Negative, @y_index.bit(7) == 1)
  end
end
