class CPU
  enum AddressModes
    Accumulator
    Immediate
    ZeroPage
    ZeroPageX
    ZeroPageY
    Absolute
    AbsoluteX
    AbsoluteY
    Indirect
    IndirectX
    IndirectY
  end

  def get_ind(address : Int)
    l = peek(address)
    h = peek(address(address + 1) & 0xff) << 8
    m = h | l
    return m
  end

  def get_indx(address : Int)
    l = peek((address + @x_index) & 0xff)
    h = peek((address + @x_index + 1) & 0xff) << 8
    m = h | l
    return m
  end

  def get_indy(address : Int)
    l = peek(address)
    h = peek((address.to_i + 1) & 0xff) << 8
    m = ((h | l) + @y_index) & 0xffff
    return m
  end
end
