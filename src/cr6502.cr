require "./cr6502/**"

cpu = CPU.new(1.79, 0x0600, 0x0603) # CPU::BRK_LOCATION - 2)

cpu.load_asm("
and (0),y
")
cpu.execute
