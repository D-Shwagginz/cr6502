require "./cr6502/**"

cpu = CPU.new(1.79, 0x0600, CPU::BRK_LOCATION - 4)

cpu.load_asm("

")

cpu.execute
