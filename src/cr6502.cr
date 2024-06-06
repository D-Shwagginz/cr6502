require "./cr6502/**"

cpu = CPU.new(1.0, 0x0600_u16, CPU::RES_LOCATION - 2)
x = 0xa4_u8
cpu.load_asm("
lda ##{x}
")

cpu.execute

cpu.load_asm("
prt #{cpu.accumulator}
brk
")

cpu.execute # => puts "Type: UInt8 | Hex: 0xa4 | Decimal: 164 | Binary: 0b10100100"
