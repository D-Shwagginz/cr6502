require "./cr6502/**"

cpu = CPU.new(1.0, 0x0600_u16, CPU::RES_LOCATION - 2)
x = 0
cpu.load_asm("

")
cpu.execute
