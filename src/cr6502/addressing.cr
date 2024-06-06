class CPU
  # The modes of addressing
  enum AddressModes
    # There are a number of "atomic read/modify/write" instructions which can address EITHER Memory OR the Accumulator (A)
    Accumulator
    # A better name for this mode might be Immediate Value as no "addressing" actually takes place.
    Immediate
    # Much like Absolute Addressing, but can only address the first 256 (0..255) bytes of memory.
    ZeroPage
    # In Zero-Page Addressing the destination address is fixed by the programmer (or assembler) at assembly time.
    # By using the hard-coded address as a base, and `CPU#x_index` as an Index, a more dynamic addressing system can be implemented.
    # With Zero-Page, only the first 256 (0..255) bytes of memory may be addressed. So if the result of Base+`CPU#x_index` is greater than $FF, wrapping will occur.
    ZeroPageX
    # In Zero-Page Addressing the destination address is fixed by the programmer (or assembler) at assembly time.
    # By using the hard-coded address as a base, and `CPU#y_index` as an Index, a more dynamic addressing system can be implemented.
    # With Zero-Page, only the first 256 (0..255) bytes of memory may be addressed. So if the result of Base+`CPU#y_index` is greater than $FF, wrapping will occur.
    ZeroPageY
    # Read a value from a 16-bit address
    # Remember without special external hardware for paging, the 6502 only has a maximum of 64K of address space available - so 16-bits is enough to address ANY byte of memory.
    Absolute
    # In Absolute Addressing the destination address is fixed by the programmer (or assembler) at assembly time.
    # By using the hard-coded address as a base, and `CPU#x_index` as an Index, a more dynamic addressing system can be implemented.
    # If the result of Base+`CPU#x_index` is greater than $FFFF, wrapping will occur.
    AbsoluteX
    # In Absolute Addressing the destination address is fixed by the programmer (or assembler) at assembly time.
    # By using the hard-coded address as a base, and `CPU#y_index` as an Index, a more dynamic addressing system can be implemented.
    # If the result of Base+`CPU#y_index` is greater than $FFFF, wrapping will occur.
    AbsoluteY
    # With this instruction, the 8-but address (location) supplied by the programmer is considered to be a Zero-Page address, that is, an address in the first 256 (0..255) bytes of memory.
    # The content of this Zero-Page address must contain the low 8-bits of a memory address
    # The following byte (the contents of address+1) must contain the upper 8-bits of a memory address
    # Once this memory address has been read from the Zero-Page location (specified by the programmer), this calculated memory address is then examined, and it's contents are returned.
    Indirect
    # This addressing mode is only available with X.
    # Much like Indirect Addressing, but the contents of the index register is added to the Zero-Page address (location)
    # If Base_Location+Index is greater than $FF, wrapping will occur.
    IndirectX
    # This addressing mode is only available with Y.
    # Much like Indexed Addressing, but the contents of the index register is added to the Base_Location after it is read from Zero-Page memory.
    # If Base_Location+Index is greater than $FFFF, wrapping will occur.
    IndirectY
  end

  # Gets the Indirect Address of a given address
  def get_ind(address : Int)
    l = peek(address)
    h = peek(address(address + 1) & 0xff) << 8
    m = h | l
    return m
  end

  # Gets the Indirect X Address of a given address
  def get_indx(address : Int)
    l = peek((address + @x_index) & 0xff)
    h = peek((address + @x_index + 1) & 0xff) << 8
    m = h | l
    return m
  end

  # Gets the Indirect Y Address of a given address
  def get_indy(address : Int)
    l = peek(address)
    h = peek((address.to_i + 1) & 0xff) << 8
    m = ((h | l) + @y_index) & 0xffff
    return m
  end
end
