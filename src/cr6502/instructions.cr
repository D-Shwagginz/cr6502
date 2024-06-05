class CPU
  # Accumulator = a
  # Immediate = i
  # Zero Page = zpg
  # Zero Page,X = zpgx
  # Zero Page,Y = zpgy
  # Absolute = abs
  # Absolute,X = absx
  # Absolute,Y = absy
  # Indirect = ind
  # Indirect,X = indx
  # Indirect,Y = indy

  INSTRUCTIONS = [
    {"BRK", 0x00_u8, 7},
    {"ORAindx", 0x01_u8, 6},
    {"ORAzpg", 0x05_u8, 3},
    {"ASLzpg", 0x06_u8, 5},
    {"PHP", 0x08_u8, 3},
    {"ORAi", 0x09_u8, 2},
    {"ASLa", 0x0a_u8, 2},
    {"ORAabs", 0x0d_u8, 4},
    {"ASLabs", 0x0e_u8, 6},
    {"BPL", 0x10_u8, 2},
    {"ORAindy", 0x11_u8, 5},
    {"ORAzpgx", 0x15_u8, 3},
    {"ASLzpgx", 0x16_u8, 6},
    {"CLC", 0x18_u8, 2},
    {"ORAabsy", 0x19_u8, 4},
    {"ORAabsx", 0x1d_u8, 4},
    {"ASLabsx", 0x1e_u8, 7},
    {"JSR", 0x20_u8, 6},
    {"ANDindx", 0x21_u8, 6},
    {"BITzpg", 0x24_u8, 3},
    {"ANDzpg", 0x25_u8, 2},
    {"ROLzpg", 0x26_u8, 5},
    {"PLP", 0x28_u8, 4},
    {"ANDi", 0x29_u8, 2},
    {"ROLa", 0x2a_u8, 2},
    {"BITabs", 0x2c_u8, 4},
    {"ANDabs", 0x2d_u8, 4},
    {"ROLabs", 0x2e_u8, 6},
    {"BMI", 0x30_u8, 2},
    {"ANDindy", 0x31_u8, 5},
    {"ANDzpgx", 0x35_u8, 3},
    {"ROLzpgx", 0x36_u8, 6},
    {"SEC", 0x38_u8, 2},
    {"ANDabsy", 0x39_u8, 4},
    {"ANDabsx", 0x3d_u8, 4},
    {"ROLabsx", 0x3e_u8, 7},
    {"RTI", 0x40_u8, 6},
    {"EORindx", 0x41_u8, 6},
    {"EORzpg", 0x45_u8, 3},
    {"LSRzpg", 0x46_u8, 5},
    {"PHA", 0x48_u8, 3},
    {"EORi", 0x49_u8, 2},
    {"LSRa", 0x4a_u8, 2},
    {"JMPabs", 0x4c_u8, 3},
    {"EORabs", 0x4d_u8, 4},
    {"LSRabs", 0x4e_u8, 6},
    {"BVC", 0x50_u8, 2},
    {"EORindy", 0x51_u8, 5},
    {"EORzpgx", 0x55_u8, 4},
    {"LSRzpgx", 0x56_u8, 6},
    {"CLI", 0x58_u8, 2},
    {"EORabsy", 0x59_u8, 4},
    {"EORabsx", 0x5d_u8, 4},
    {"LSRabs", 0x5e_u8, 7},
    {"RTS", 0x60_u8, 6},
    {"ADCindx", 0x61_u8, 6},
    {"ADCzpg", 0x65_u8, 3},
    {"RORzpg", 0x66_u8, 5},
    {"PLA", 0x68_u8, 4},
    {"ADCi", 0x69_u8, 2},
    {"RORa", 0x6a_u8, 2},
    {"JMPind", 0x6c_u8, 5},
    {"ADCabs", 0x6d_u8, 4},
    {"RORabs", 0x6e_u8, 6},
    {"BVS", 0x70_u8, 2},
    {"ADCindy", 0x71_u8, 5},
    {"ADCzpgx", 0x75_u8, 4},
    {"RORzpgx", 0x76_u8, 6},
    {"SEI", 0x78_u8, 2},
    {"ADCabsy", 0x79_u8, 4},
    {"ADCabsx", 0x7d_u8, 4},
    {"RORabsx", 0x7e_u8, 7},
    {"STAindx", 0x81_u8, 6},
    {"STYzpg", 0x84_u8, 3},
    {"STAzpg", 0x85_u8, 3},
    {"STXzpg", 0x86_u8, 3},
    {"DEY", 0x88_u8, 2},
    {"TXA", 0x8a_u8, 2},
    {"STYabs", 0x8c_u8, 4},
    {"STAabs", 0x8d_u8, 4},
    {"STXabs", 0x8e_u8, 4},
    {"BCC", 0x90_u8, 2},
    {"STAindy", 0x91_u8, 6},
    {"STYzpgx", 0x94_u8, 4},
    {"STAzpgx", 0x95_u8, 4},
    {"STXzpgy", 0x96_u8, 4},
    {"TYA", 0x98_u8, 2},
    {"STAabsy", 0x99_u8, 5},
    {"TXS", 0x9a_u8, 2},
    {"STAabsx", 0x9d_u8, 5},
    {"LDYi", 0xa0_u8, 2},
    {"LDAindx", 0xa1_u8, 6},
    {"LDXi", 0xa2_u8, 2},
    {"LDYzpg", 0xa4_u8, 3},
    {"LDAzpg", 0xa5_u8, 3},
    {"LDXzpg", 0xa6_u8, 3},
    {"TAY", 0xa8_u8, 2},
    {"LDAi", 0xa9_u8, 2},
    {"TAX", 0xaa_u8, 2},
    {"LDYabs", 0xac_u8, 4},
    {"LDAabs", 0xad_u8, 4},
    {"LDXabs", 0xae_u8, 4},
    {"BCS", 0xb0_u8, 2},
    {"LDAindy", 0xb1_u8, 5},
    {"LDYzpgx", 0xb4_u8, 4},
    {"LDAzpgx", 0xb5_u8, 4},
    {"LDXzpgy", 0xb6_u8, 4},
    {"CLV", 0xb8_u8, 2},
    {"LDAabsy", 0xb9_u8, 4},
    {"TSX", 0xba_u8, 2},
    {"LDYabsx", 0xbc_u8, 4},
    {"LDAabsx", 0xbd_u8, 4},
    {"LDXabsy", 0xbe_u8, 4},
    {"CPYi", 0xc0_u8, 2},
    {"CMPindx", 0xc1_u8, 6},
    {"CPYzpg", 0xc4_u8, 3},
    {"CMPzpg", 0xc5_u8, 3},
    {"DECzpg", 0xc6_u8, 5},
    {"INY", 0xc8_u8, 2},
    {"CMPi", 0xc9_u8, 2},
    {"DEX", 0xca_u8, 2},
    {"CPYabs", 0xcc_u8, 4},
    {"CMPabs", 0xcd_u8, 4},
    {"DECabs", 0xce_u8, 6},
    {"BNE", 0xd0_u8, 2},
    {"CMPindy", 0xd1_u8, 5},
    {"CMPzpgx", 0xd5_u8, 4},
    {"DECzpgx", 0xd6_u8, 6},
    {"CLD", 0xd8_u8, 2},
    {"CMPabsy", 0xd9_u8, 4},
    {"CMPabsx", 0xdd_u8, 4},
    {"DECabsx", 0xde_u8, 7},
    {"CPXi", 0xe0_u8, 2},
    {"SBCindx", 0xe1_u8, 6},
    {"CPXzpg", 0xe4_u8, 3},
    {"SBCzpg", 0xe5_u8, 3},
    {"INCzpg", 0xe6_u8, 5},
    {"INX", 0xe8_u8, 2},
    {"SBCi", 0xe9_u8, 2},
    {"NOP", 0xea_u8, 2},
    {"CPXabs", 0xec_u8, 4},
    {"SBCabs", 0xed_u8, 4},
    {"INCabs", 0xee_u8, 6},
    {"BEQ", 0xf0_u8, 2},
    {"SBCindy", 0xf1_u8, 5},
    {"SBCzpgx", 0xf5_u8, 4},
    {"INCzpgx", 0xf6_u8, 6},
    {"SED", 0xf8_u8, 2},
    {"SBCabsy", 0xf9_u8, 4},
    {"SBCabsx", 0xfd_u8, 4},
    {"INCabsx", 0xfe_u8, 7},
  ]

  private def run_instruction
    instruction = peek(@program_counter)
    @program_counter += 1_u16

    INSTRUCTIONS.each do |i|
      if i[1] == instruction
        @instruction_cycles = i[2]
        case i[0]
        when "BRK"    ; brk
        when "ORAindx"; ora(peek(@program_counter).to_i, AddressModes::IndirectX)
        when "ORAzpg" ; ora(peek(@program_counter).to_i, AddressModes::ZeroPage)
        when "ASLzpg" ; asl(peek(@program_counter).to_i, AddressModes::ZeroPage)
        when "PHP"    ; php(peek(@program_counter).to_i)
        when "ORAi"   ; ora(peek(@program_counter).to_i, AddressModes::Immediate)
        when "ASLa"   ; asl(peek(@program_counter).to_i, AddressModes::Accumulator)
        when "ORAabs" ; ora(peek(@program_counter).to_i, AddressModes::Absolute)
        when "BPL"    ; bpl(peek(@program_counter).to_i)
        when "ORAindy"; ora(peek(@program_counter).to_i, AddressModes::IndirectY)
        when "ORAzpgx"; ora(peek(@program_counter).to_i, AddressModes::ZeroPageX)
        when "ASLzpgx"; asl(peek(@program_counter).to_i, AddressModes::ZeroPageX)
        when "CLC"    ; clc(peek(@program_counter).to_i)
        when "ORAabsy"; ora(peek(@program_counter).to_i, AddressModes::AbsoluteY)
        when "ORAabsx"; ora(peek(@program_counter).to_i, AddressModes::AbsoluteX)
        when "ASLabsx"; asl(peek(@program_counter).to_i, AddressModes::AbsoluteX)
        when "JSR"    ; jsr(peek(@program_counter).to_i)
        when "ANDindx"; and(peek(@program_counter).to_i, AddressModes::IndirectX)
        when "BITzpg" ; bit(peek(@program_counter).to_i, AddressModes::ZeroPage)
        when "ANDzpg" ; and(peek(@program_counter).to_i, AddressModes::ZeroPage)
        when "ROLzpg" ; rol(peek(@program_counter).to_i, AddressModes::ZeroPage)
        when "PLP"    ; plp(peek(@program_counter).to_i)
        when "ANDi"   ; and(peek(@program_counter).to_i, AddressModes::Immediate)
        when "ROLa"   ; rol(peek(@program_counter).to_i, AddressModes::Accumulator)
        when "BITabs" ; bit(peek(@program_counter).to_i, AddressModes::Absolute)
        when "ANDabs" ; and(peek(@program_counter).to_i, AddressModes::Absolute)
        when "ROLabs" ; rol(peek(@program_counter).to_i, AddressModes::Absolute)
        when "BMI"    ; bmi(peek(@program_counter).to_i)
        when "ANDindy"; and(peek(@program_counter).to_i, AddressModes::IndirectY)
        when "ANDzpgx"; and(peek(@program_counter).to_i, AddressModes::ZeroPageX)
        when "ROLzpgx"; rol(peek(@program_counter).to_i, AddressModes::ZeroPageX)
        when "SEC"    ; sec(peek(@program_counter).to_i)
        when "ANDabsy"; and(peek(@program_counter).to_i, AddressModes::AbsoluteY)
        when "ANDabsx"; and(peek(@program_counter).to_i, AddressModes::AbsoluteX)
        when "ROLabsx"; rol(peek(@program_counter).to_i, AddressModes::AbsoluteX)
        when "RTI"    ; rti(peek(@program_counter).to_i)
        when "EORindx"; eor(peek(@program_counter).to_i, AddressModes::IndirectX)
        when "EORzpg" ; eor(peek(@program_counter).to_i, AddressModes::ZeroPage)
        when "LSRzpg" ; lsr(peek(@program_counter).to_i, AddressModes::ZeroPage)
        when "PHA"    ; pha(peek(@program_counter).to_i)
        when "EORi"   ; eor(peek(@program_counter).to_i, AddressModes::Immediate)
        when "LSRa"   ; lsr(peek(@program_counter).to_i, AddressModes::Accumulator)
        when "JMPabs" ; jmp(peek(@program_counter).to_i, AddressModes::Absolute)
        when "EORabs" ; eor(peek(@program_counter).to_i, AddressModes::Absolute)
        when "LSRabs" ; lsr(peek(@program_counter).to_i, AddressModes::Absolute)
        when "BVC"    ; bvc(peek(@program_counter).to_i)
        when "EORindy"; eor(peek(@program_counter).to_i, AddressModes::IndirectY)
        when "EORzpgx"; eor(peek(@program_counter).to_i, AddressModes::ZeroPageX)
        when "LSRzpgx"; lsr(peek(@program_counter).to_i, AddressModes::ZeroPageX)
        when "CLI"    ; cli(peek(@program_counter).to_i)
        when "EORabsy"; eor(peek(@program_counter).to_i, AddressModes::AbsoluteY)
        when "EORabsx"; eor(peek(@program_counter).to_i, AddressModes::AbsoluteX)
        when "LSRabsx"; lsr(peek(@program_counter).to_i, AddressModes::AbsoluteX)
        when "RTS"    ; rts(peek(@program_counter).to_i)
        when "ADCindx"; adc(peek(@program_counter).to_i, AddressModes::IndirectX)
        when "ADCzpg" ; adc(peek(@program_counter).to_i, AddressModes::ZeroPage)
        when "RORzpg" ; ror(peek(@program_counter).to_i, AddressModes::ZeroPage)
        when "PLA"    ; pla(peek(@program_counter).to_i)
        when "ADCi"   ; adc(peek(@program_counter).to_i, AddressModes::Immediate)
        when "RORa"   ; ror(peek(@program_counter).to_i, AddressModes::Accumulator)
        when "JMPind" ; jmp(peek(@program_counter).to_i, AddressModes::Indirect)
        when "ADCabs" ; adc(peek(@program_counter).to_i, AddressModes::Absolute)
        when "RORabs" ; ror(peek(@program_counter).to_i, AddressModes::Absolute)
        when "BVS"    ; bvs(peek(@program_counter).to_i)
        when "ADCindy"; adc(peek(@program_counter).to_i, AddressModes::IndirectY)
        when "ADCzpgx"; adc(peek(@program_counter).to_i, AddressModes::ZeroPageX)
        when "RORzpgx"; ror(peek(@program_counter).to_i, AddressModes::ZeroPageX)
        when "SEI"    ; sei(peek(@program_counter).to_i)
        when "ADCabsy"; adc(peek(@program_counter).to_i, AddressModes::AbsoluteY)
        when "ADCabsx"; adc(peek(@program_counter).to_i, AddressModes::AbsoluteX)
        when "RORabsx"; ror(peek(@program_counter).to_i, AddressModes::AbsoluteX)
        when "STAindx"; sta(peek(@program_counter).to_i, AddressModes::IndirectX)
        when "STYzpg" ; sty(peek(@program_counter).to_i, AddressModes::ZeroPage)
        when "STAzpg" ; sta(peek(@program_counter).to_i, AddressModes::ZeroPage)
        when "STXzpg" ; stx(peek(@program_counter).to_i, AddressModes::ZeroPage)
        when "DEY"    ; dey(peek(@program_counter).to_i)
        when "TXA"    ; txa(peek(@program_counter).to_i)
        when "STYabs" ; sty(peek(@program_counter).to_i, AddressModes::Absolute)
        when "STAabs" ; sta(peek(@program_counter).to_i, AddressModes::Absolute)
        when "STXabs" ; stx(peek(@program_counter).to_i, AddressModes::Absolute)
        when "BCC"    ; bcc(peek(@program_counter).to_i)
        when "STAindy"; sta(peek(@program_counter).to_i, AddressModes::IndirectY)
        when "STYzpgx"; sty(peek(@program_counter).to_i, AddressModes::ZeroPageX)
        when "STAzpgx"; sta(peek(@program_counter).to_i, AddressModes::ZeroPageX)
        when "STXzpgy"; stx(peek(@program_counter).to_i, AddressModes::ZeroPageY)
        when "TYA"    ; tya(peek(@program_counter).to_i)
        when "STAabsy"; sta(peek(@program_counter).to_i, AddressModes::AbsoluteY)
        when "TXS"    ; txs(peek(@program_counter).to_i)
        when "STAabsx"; sta(peek(@program_counter).to_i, AddressModes::AbsoluteX)
        when "LDYi"   ; ldy(peek(@program_counter).to_i, AddressModes::Immediate)
        when "LDAindx"; lda(peek(@program_counter).to_i, AddressModes::IndirectX)
        when "LDXi"   ; ldx(peek(@program_counter).to_i, AddressModes::Immediate)
        when "LDYzpg" ; ldy(peek(@program_counter).to_i, AddressModes::ZeroPage)
        when "LDAzpg" ; lda(peek(@program_counter).to_i, AddressModes::ZeroPage)
        when "LDXzpg" ; ldx(peek(@program_counter).to_i, AddressModes::ZeroPage)
        when "TAY"    ; tay(peek(@program_counter).to_i)
        when "LDAi"   ; lda(peek(@program_counter).to_i, AddressModes::Immediate)
        when "TAX"    ; tax(peek(@program_counter).to_i)
        when "LDYabs" ; ldy(peek(@program_counter).to_i, AddressModes::Absolute)
        when "LDAabs" ; lda(peek(@program_counter).to_i, AddressModes::Absolute)
        when "LDXabs" ; ldx(peek(@program_counter).to_i, AddressModes::Absolute)
        when "BCS"    ; bcs(peek(@program_counter).to_i)
        when "LDAindy"; lda(peek(@program_counter).to_i, AddressModes::IndirectY)
        when "LDYzpgx"; ldy(peek(@program_counter).to_i, AddressModes::ZeroPageX)
        when "LDAzpgx"; lda(peek(@program_counter).to_i, AddressModes::ZeroPageX)
        when "LDXzpgy"; ldy(peek(@program_counter).to_i, AddressModes::ZeroPageY)
        when "CLV"    ; clv(peek(@program_counter).to_i)
        when "LDAabsy"; lda(peek(@program_counter).to_i, AddressModes::AbsoluteY)
        when "TSX"    ; tsx(peek(@program_counter).to_i)
        when "LDYabsx"; ldy(peek(@program_counter).to_i, AddressModes::AbsoluteX)
        when "LDAabsx"; lda(peek(@program_counter).to_i, AddressModes::AbsoluteX)
        when "LDXabsy"; ldx(peek(@program_counter).to_i, AddressModes::AbsoluteY)
        when "CPYi"   ; cpy(peek(@program_counter).to_i, AddressModes::Immediate)
        when "CMPindx"; cmp(peek(@program_counter).to_i, AddressModes::IndirectX)
        when "CPYzpg" ; cpy(peek(@program_counter).to_i, AddressModes::ZeroPage)
        when "CMPzpg" ; cmp(peek(@program_counter).to_i, AddressModes::ZeroPage)
        when "DECzpg" ; dec(peek(@program_counter).to_i, AddressModes::ZeroPage)
        when "INY"    ; iny(peek(@program_counter).to_i)
        when "CMPi"   ; cmp(peek(@program_counter).to_i, AddressModes::Immediate)
        when "DEX"    ; dex(peek(@program_counter).to_i)
        when "CPYabs" ; cpy(peek(@program_counter).to_i, AddressModes::Absolute)
        when "CMPabs" ; cmp(peek(@program_counter).to_i, AddressModes::Absolute)
        when "DECabs" ; dec(peek(@program_counter).to_i, AddressModes::Absolute)
        when "BNE"    ; bne(peek(@program_counter).to_i)
        when "CMPindy"; cmp(peek(@program_counter).to_i, AddressModes::IndirectY)
        when "CMPzpgx"; cmp(peek(@program_counter).to_i, AddressModes::ZeroPageX)
        when "DECzpgx"; dec(peek(@program_counter).to_i, AddressModes::ZeroPageX)
        when "CLD"    ; cld(peek(@program_counter).to_i)
        when "CMPabsy"; cmp(peek(@program_counter).to_i, AddressModes::AbsoluteY)
        when "CMPabsx"; cmp(peek(@program_counter).to_i, AddressModes::AbsoluteX)
        when "DECabsx"; dec(peek(@program_counter).to_i, AddressModes::AbsoluteX)
        when "CPXi"   ; cpx(peek(@program_counter).to_i, AddressModes::Immediate)
        when "SBCindx"; sbc(peek(@program_counter).to_i, AddressModes::IndirectX)
        when "CPXzpg" ; cpx(peek(@program_counter).to_i, AddressModes::ZeroPage)
        when "SBCzpg" ; sbc(peek(@program_counter).to_i, AddressModes::ZeroPage)
        when "INCzpg" ; inc(peek(@program_counter).to_i, AddressModes::ZeroPage)
        when "INX"    ; inx(peek(@program_counter).to_i)
        when "SBCi"   ; sbc(peek(@program_counter).to_i, AddressModes::Immediate)
        when "NOP"
        when "CPXabs" ; cpx(peek(@program_counter).to_i, AddressModes::Absolute)
        when "SBCabs" ; sbc(peek(@program_counter).to_i, AddressModes::Absolute)
        when "INCabs" ; inc(peek(@program_counter).to_i, AddressModes::Absolute)
        when "BEQ"    ; beq(peek(@program_counter).to_i)
        when "SBCindy"; sbc(peek(@program_counter).to_i, AddressModes::IndirectY)
        when "SBCzpgx"; sbc(peek(@program_counter).to_i, AddressModes::ZeroPageX)
        when "INCzpgx"; inc(peek(@program_counter).to_i, AddressModes::ZeroPageX)
        when "SED"    ; sed(peek(@program_counter).to_i)
        when "SBCabsy"; sbc(peek(@program_counter).to_i, AddressModes::AbsoluteY)
        when "SBCabsx"; sbc(peek(@program_counter).to_i, AddressModes::AbsoluteX)
        when "INCabsx"; inc(peek(@program_counter).to_i, AddressModes::AbsoluteX)
        end
      end
    end
  end

  private def add_instruction(hex : UInt8 | UInt16)
    poke(@program_counter, hex)
    @program_counter += hex.is_a?(UInt8) ? 1 : 2
  end

  private def brk
    @program_counter += 1
    @stack_pointer -= 1
    poke(@stack_pointer.to_i + 0x100, @program_counter)
    @stack_pointer -= 1
    poke(@stack_pointer.to_i + 0x100, @flags | 0x10_u8)
    @stack_pointer -= 1
    @program_counter = peek(BRK_LOCATION, true).to_u16
  end

  private def ora(address : Int, address_mode : AddressModes)
    case address_mode
    when AddressModes::IndirectX                       ; @accumulator = @accumulator | peek(get_indx(address))
    when AddressModes::ZeroPage, AddressModes::Absolute; @accumulator = @accumulator | peek(address)
    when AddressModes::Immediate                       ; @accumulator = @accumulator | address
    when AddressModes::IndirectY
      @instruction_cycles += (@program_counter - @program_counter//255*255 + get_indy(address)) > 255 ? 1 : 0
      @accumulator = @accumulator | peek(get_indy(address))
    when AddressModes::ZeroPageX; @accumulator = @accumulator | peek((address + @x_index) & 0xff)
    when AddressModes::AbsoluteY
      @instruction_cycles += (@program_counter - @program_counter//255*255 + ((address + @y_index) & 0xffff)) > 255 ? 1 : 0
      @accumulator = @accumulator | peek((address + @y_index) & 0xffff)
    when AddressModes::AbsoluteX
      @instruction_cycles += (@program_counter - @program_counter//255*255 + ((address + @x_index) & 0xffff)) > 255 ? 1 : 0
      @accumulator = @accumulator | peek((address + @x_index) & 0xffff)
    end
    set_flag(Flags::Negative, @accumulator.bit(7) == 1)
    set_flag(Flags::Zero, @accumulator == 0)
  end

  private def asl(address : Int, address_mode : AddressModes)
    case address_mode
    when AddressModes::ZeroPage, AddressModes::Absolute
      set_flag(Flags::Carry, peek(address).bit(7) == 1)
      poke(address, ((peek(address) << 1) & 0xfe))
      set_flag(Flags::Negative, peek(address).bit(7) == 1)
      set_flag(Flags::Zero, peek(address) == 0)
    when AddressModes::Accumulator; b = @accumulator
    set_flag(Flags::Carry, @accumulator.bit(7) == 1)
    @accumulator = ((@accumulator << 1) & 0xfe)
    set_flag(Flags::Negative, @accumulator.bit(7) == 1)
    set_flag(Flags::Zero, @accumulator == 0)
    when AddressModes::ZeroPageX
      set_flag(Flags::Carry, peek((address + @x_index) & 0xff).bit(7) == 1)
      poke((address + @x_index) & 0xff, ((peek((address + @x_index) & 0xff) << 1) & 0xfe))
      set_flag(Flags::Negative, peek((address + @x_index) & 0xff).bit(7) == 1)
      set_flag(Flags::Zero, peek((address + @x_index) & 0xff) == 0)
    when AddressModes::AbsoluteX
      set_flag(Flags::Carry, peek((address + @x_index) & 0xffff).bit(7) == 1)
      poke((address + @x_index) & 0xffff, ((peek((address + @x_index) & 0xffff) << 1) & 0xfe))
      set_flag(Flags::Negative, peek((address + @x_index) & 0xffff).bit(7) == 1)
      set_flag(Flags::Zero, peek((address + @x_index) & 0xffff) == 0)
    end
  end

  private def php(address : Int)
    poke(@stack_pointer.to_i + 0x100, @flags)
    @stack_pointer -= 1
  end

  private def bpl(address : Int)
    if get_flag(Flags::Negative) == false
      address = (address - 128).to_i8

      page_difference = (@program_counter - @program_counter//255*255 + address)
      @instruction_cycles += page_difference > 127 || page_difference < -128 ? 2 : 1
      @program_counter += address.to_i16
    end
  end

  private def clc(address : Int)
    set_flag(Flags::Carry, false)
  end

  private def jsr(address : Int)
    t = @program_counter - 1
    @stack_pointer -= 1
    poke(@stack_pointer.to_i + 0x100, t)
    @stack_pointer -= 1
    @program_counter = address.to_u16
  end

  private def and(address : Int, address_mode : AddressModes)
    case address_mode
    when AddressModes::IndirectX                       ; @accumulator = @accumulator & peek(get_indx(address))
    when AddressModes::ZeroPage, AddressModes::Absolute; @accumulator = @accumulator & peek(address)
    when AddressModes::Immediate                       ; @accumulator = @accumulator & address
    when AddressModes::IndirectY
      @instruction_cycles += (@program_counter - @program_counter//255*255 + get_indy(address)) > 255 ? 1 : 0
      @accumulator = @accumulator & peek(get_indy(address))
    when AddressModes::ZeroPageX; @accumulator = @accumulator & peek((address + @x_index) & 0xff)
    when AddressModes::AbsoluteY
      @instruction_cycles += (@program_counter - @program_counter//255*255 + ((address + @y_index) & 0xffff)) > 255 ? 1 : 0
      @accumulator = @accumulator & peek((address + @y_index) & 0xffff)
    when AddressModes::AbsoluteX
      @instruction_cycles += (@program_counter - @program_counter//255*255 + ((address + @x_index) & 0xffff)) > 255 ? 1 : 0
      @accumulator = @accumulator & peek((address + @x_index) & 0xffff)
    end
    set_flag(Flags::Negative, @accumulator.bit(7) == 1)
    set_flag(Flags::Zero, @accumulator == 0)
  end

  private def bit(address : Int, address_mode : AddressModes)
    t = 0
    case address_mode
    when AddressModes::ZeroPage; t = @accumulator & peek(address)
    when AddressModes::Absolute; t = @accumulator & peek(address)
    end
    set_flag(Flags::Negative, t.bit(7) == 1)
    set_flag(Flags::Overflow, t.bit(6) == 1)
    set_flag(Flags::Zero, t == 0)
  end

  private def rol(address : Int, address_mode : AddressModes)
    case address_mode
    when AddressModes::ZeroPage, AddressModes::Absolute
      t = peek(address).bit(7) == 1
      poke(address, (peek(address) << 1) & 0xfe)
      poke(address, peek(address) | get_flag(Flags::Carry).to_unsafe)
      set_flag(Flags::Carry, t)
      set_flag(Flags::Zero, peek(address) == 0)
      set_flag(Flags::Negative, peek(address).bit(7) == 1)
    when AddressModes::Accumulator
      t = @accumulator.bit(7) == 1
      @accumulator = (@accumulator << 1) & 0xfe
      @accumulator = @accumulator | get_flag(Flags::Carry).to_unsafe
      set_flag(Flags::Carry, t)
      set_flag(Flags::Zero, @accumulator == 0)
      set_flag(Flags::Negative, @accumulator.bit(7) == 1)
    when AddressModes::ZeroPageX
      t = peek((address + @x_index) & 0xff).bit(7) == 1
      poke((address + @x_index) & 0xff, (peek((address + @x_index) & 0xff) << 1) & 0xfe)
      poke((address + @x_index) & 0xff, peek((address + @x_index) & 0xff) | get_flag(Flags::Carry).to_unsafe)
      set_flag(Flags::Carry, t)
      set_flag(Flags::Zero, peek((address + @x_index) & 0xff) == 0)
      set_flag(Flags::Negative, peek((address + @x_index) & 0xff).bit(7) == 1)
    when AddressModes::AbsoluteX
      @instruction_cycles += (@program_counter - @program_counter//255*255 + ((address + @x_index) & 0xffff)) > 255 ? 1 : 0
      t = peek((address + @x_index) & 0xffff).bit(7) == 1
      poke((address + @x_index) & 0xffff, (peek((address + @x_index) & 0xffff) << 1) & 0xfe)
      poke((address + @x_index) & 0xffff, peek((address + @x_index) & 0xffff) | get_flag(Flags::Carry).to_unsafe)
      set_flag(Flags::Carry, t)
      set_flag(Flags::Zero, peek((address + @x_index) & 0xffff) == 0)
      set_flag(Flags::Negative, peek((address + @x_index) & 0xffff).bit(7) == 1)
    end
  end

  private def plp(address : Int)
    @stack_pointer += 1
    @flags = peek(@stack_pointer.to_i + 0x100).to_u8
  end

  private def bmi(address : Int)
    if get_flag(Flags::Negative) == true
      address = (address - 128).to_i8

      page_difference = (@program_counter - @program_counter//255*255 + address)
      @instruction_cycles += page_difference > 127 || page_difference < -128 ? 2 : 1
      @program_counter += address.to_i16
    end
  end

  private def sec(address : Int)
    set_flag(Flags::Carry, true)
  end

  private def rti(address : Int)
    @stack_pointer += 1
    @flags = peek(@stack_pointer.to_i + 0x100).to_u8
    @stack_pointer += 1
    @program_counter = peek(@stack_pointer.to_i + 0x100, true).to_u16
    @stack_pointer += 1
  end

  private def eor(address : Int, address_mode : AddressModes)
    case address_mode
    when AddressModes::IndirectX                       ; @accumulator = @accumulator ^ peek(get_indx(address))
    when AddressModes::ZeroPage, AddressModes::Absolute; @accumulator = @accumulator ^ peek(address)
    when AddressModes::Immediate                       ; @accumulator = @accumulator ^ address
    when AddressModes::IndirectY
      @instruction_cycles += (@program_counter - @program_counter//255*255 + get_indy(address)) > 255 ? 1 : 0
      @accumulator = @accumulator ^ peek(get_indy(address))
    when AddressModes::ZeroPageX; @accumulator = @accumulator ^ peek((address + @x_index) & 0xff)
    when AddressModes::AbsoluteY
      @instruction_cycles += (@program_counter - @program_counter//255*255 + ((address + @y_index) & 0xffff)) > 255 ? 1 : 0
      @accumulator = @accumulator ^ peek((address + @y_index) & 0xffff)
    when AddressModes::AbsoluteX
      @instruction_cycles += (@program_counter - @program_counter//255*255 + ((address + @x_index) & 0xffff)) > 255 ? 1 : 0
      @accumulator = @accumulator ^ peek((address + @x_index) & 0xffff)
    end
    set_flag(Flags::Negative, @accumulator.bit(7) == 1)
    set_flag(Flags::Zero, @accumulator == 0)
  end

  private def lsr(address : Int, address_mode : AddressModes)
    case address_mode
    when AddressModes::ZeroPage, AddressModes::Absolute
      set_flag(Flags::Negative, false)
      set_flag(Flags::Carry, peek(address).bit(0) == 1)
      poke(address, ((peek(address) >> 1) & 0x7f))
      set_flag(Flags::Zero, peek(address) == 0)
    when AddressModes::Accumulator
      set_flag(Flags::Negative, false)
      set_flag(Flags::Carry, @accumulator.bit(0) == 1)
      @accumulator = ((@accumulator >> 1) & 0x7f)
      set_flag(Flags::Zero, @accumulator == 0)
    when AddressModes::ZeroPageX
      set_flag(Flags::Negative, false)
      set_flag(Flags::Carry, peek((address + @x_index) & 0xff).bit(0) == 1)
      poke((address + @x_index) & 0xff, ((peek((address + @x_index) & 0xff) >> 1) & 0x7f))
      set_flag(Flags::Zero, peek((address + @x_index) & 0xff) == 0)
    when AddressModes::AbsoluteX
      set_flag(Flags::Negative, false)
      set_flag(Flags::Carry, peek((address + @x_index) & 0xffff).bit(0) == 1)
      poke((address + @x_index) & 0xffff, ((peek((address + @x_index) & 0xffff) >> 1) & 0x7f))
      set_flag(Flags::Zero, peek((address + @x_index) & 0xffff) == 0)
    end
  end

  private def pha(address : Int)
    poke(@stack_pointer.to_i + 0x100, @accumulator)
    @stack_pointer -= 1
  end

  private def jmp(address : Int, address_mode : AddressModes)
    case address_mode
    when AddressModes::Absolute
      @program_counter = address.to_u16
    when AddressModes::Indirect
      @program_counter = peek(address, true).to_u16
    end
  end

  private def bvc(address : Int)
    if get_flag(Flags::Overflow) == false
      address = (address - 128).to_i8

      page_difference = (@program_counter - @program_counter//255*255 + address)
      @instruction_cycles += page_difference > 127 || page_difference < -128 ? 2 : 1
      @program_counter += address.to_i16
    end
  end

  private def cli(address : Int)
    set_flag(Flags::InterruptDisable, false)
  end

  private def rts(address : Int)
    @stack_pointer += 1
    @program_counter = peek(@stack_pointer, true).to_u16 + 1
    @stack_pointer += 1
  end

  private def adc(address : Int, address_mode : AddressModes)
    m = 0
    case address_mode
    when AddressModes::IndirectX                       ; m = peek(get_indx(address))
    when AddressModes::ZeroPage, AddressModes::Absolute; m = peek(address)
    when AddressModes::Immediate                       ; m = address
    when AddressModes::IndirectY
      @instruction_cycles += (@program_counter - @program_counter//255*255 + get_indy(address)) > 255 ? 1 : 0
      m = peek(get_indy(address))
    when AddressModes::ZeroPageX; m = peek((address + @x_index) & 0xff)
    when AddressModes::AbsoluteY
      @instruction_cycles += (@program_counter - @program_counter//255*255 + ((address + @y_index) & 0xffff)) > 255 ? 1 : 0
      m = peek((address + @y_index) & 0xffff)
    when AddressModes::AbsoluteX
      @instruction_cycles += (@program_counter - @program_counter//255*255 + ((address + @x_index) & 0xffff)) > 255 ? 1 : 0
      m = peek((address + @x_index) & 0xffff)
    end

    t = @accumulator + m + get_flag(Flags::Carry).to_unsafe
    set_flag(Flags::Overflow, @accumulator.bit(7) != t.bit(7))
    set_flag(Flags::Negative, @accumulator.bit(7) == 1)
    set_flag(Flags::Zero, t == 0)

    if get_flag(Flags::DecimalMode)
      t = bcd(@accumulator) + bcd(m.to_u8) + get_flag(Flags::Carry).to_unsafe
      set_flag(Flags::Carry, t > 99)
    else
      set_flag(Flags::Carry, t > 255)
    end

    @accumulator = t & 0xff
  end

  private def ror(address : Int, address_mode : AddressModes)
    case address_mode
    when AddressModes::ZeroPage, AddressModes::Absolute
      t = peek(address).bit(0) == 1
      poke(address, (peek(address) >> 1) & 0x7f)
      x = get_flag(Flags::Carry) ? 0x80 : 0x00
      poke(address, peek(address) | x)
      set_flag(Flags::Carry, t)
      set_flag(Flags::Zero, peek(address) == 0)
      set_flag(Flags::Negative, peek(address).bit(7) == 1)
    when AddressModes::Accumulator
      t = @accumulator.bit(0) == 1
      @accumulator = (@accumulator >> 1) & 0x7f
      x = get_flag(Flags::Carry) ? 0x80 : 0x00
      @accumulator = @accumulator | x
      set_flag(Flags::Carry, t)
      set_flag(Flags::Zero, @accumulator == 0)
      set_flag(Flags::Negative, @accumulator.bit(7) == 1)
    when AddressModes::ZeroPageX
      t = peek((address + @x_index) & 0xff).bit(0) == 1
      poke((address + @x_index) & 0xff, (peek((address + @x_index) & 0xff) >> 1) & 0x7f)
      x = get_flag(Flags::Carry) ? 0x80 : 0x00
      poke((address + @x_index) & 0xff, peek((address + @x_index) & 0xff) | x)
      set_flag(Flags::Carry, t)
      set_flag(Flags::Zero, peek((address + @x_index) & 0xff) == 0)
      set_flag(Flags::Negative, peek((address + @x_index) & 0xff).bit(7) == 1)
    when AddressModes::AbsoluteX
      @instruction_cycles += (@program_counter - @program_counter//255*255 + ((address + @x_index) & 0xffff)) > 255 ? 1 : 0
      t = peek((address + @x_index) & 0xffff).bit(0) == 1
      poke((address + @x_index) & 0xffff, (peek((address + @x_index) & 0xffff) >> 1) & 0x7f)
      x = get_flag(Flags::Carry) ? 0x80 : 0x00
      poke((address + @x_index) & 0xffff, peek((address + @x_index) & 0xffff) | x)
      set_flag(Flags::Carry, t)
      set_flag(Flags::Zero, peek((address + @x_index) & 0xffff) == 0)
      set_flag(Flags::Negative, peek((address + @x_index) & 0xffff).bit(7) == 1)
    end
  end

  private def pla(address : Int)
    @stack_pointer += 1
    @accumulator = peek(@stack_pointer.to_i + 0x100).to_u8
    set_flag(Flags::Negative, @accumulator.bit(7) == 1)
    set_flag(Flags::Zero, @accumulator == 0)
  end

  private def bvs(address : Int)
    if get_flag(Flags::Overflow) == true
      address = (address - 128).to_i8

      page_difference = (@program_counter - @program_counter//255*255 + address)
      @instruction_cycles += page_difference > 127 || page_difference < -128 ? 2 : 1
      @program_counter += address.to_i16
    end
  end

  private def sei(address : Int)
    set_flag(Flags::InterruptDisable, true)
  end

  private def sta(address : Int, address_mode : AddressModes)
    case address_mode
    when AddressModes::IndirectX                       ; poke(get_indx(address), @accumulator)
    when AddressModes::ZeroPage, AddressModes::Absolute; poke(address, @accumulator)
    when AddressModes::IndirectY
      @instruction_cycles += (@program_counter - @program_counter//255*255 + get_indy(address)) > 255 ? 1 : 0
      poke(get_indy(address), @accumulator)
    when AddressModes::ZeroPageX; poke((address + @x_index) & 0xff, @accumulator)
    when AddressModes::AbsoluteY
      @instruction_cycles += (@program_counter - @program_counter//255*255 + ((address + @y_index) & 0xffff)) > 255 ? 1 : 0
      poke((address + @y_index) & 0xffff, @accumulator)
    when AddressModes::AbsoluteX
      @instruction_cycles += (@program_counter - @program_counter//255*255 + ((address + @x_index) & 0xffff)) > 255 ? 1 : 0
      poke((address + @x_index) & 0xffff, @accumulator)
    end
  end

  private def sty(address : Int, address_mode : AddressModes)
    case address_mode
    when AddressModes::ZeroPage, AddressModes::Absolute; poke(address, @y_index)
    when AddressModes::ZeroPageX                       ; poke((address + @x_index) & 0xff, @y_index)
    end
  end

  private def stx(address : Int, address_mode : AddressModes)
    case address_mode
    when AddressModes::ZeroPage, AddressModes::Absolute; poke(address, @x_index)
    when AddressModes::ZeroPageY                       ; poke((address + @y_index) & 0xff, @x_index)
    end
  end

  private def dey(address : Int)
    @y_index -= 1
    set_flag(Flags::Zero, @y_index == 0)
    set_flag(Flags::Negative, @y_index.bit(7) == 1)
  end

  private def txa(address : Int)
    @accumulator = @x_index
    set_flag(Flags::Negative, @accumulator.bit(7) == 1)
    set_flag(Flags::Zero, @accumulator == 0)
  end

  private def bcc(address : Int)
    if get_flag(Flags::Carry) == false
      address = (address - 128).to_i8

      page_difference = (@program_counter - @program_counter//255*255 + address)
      @instruction_cycles += page_difference > 127 || page_difference < -128 ? 2 : 1
      @program_counter += address.to_i16
    end
  end

  private def tya(address : Int)
    @accumulator = @y_index
    set_flag(Flags::Negative, @accumulator.bit(7) == 1)
    set_flag(Flags::Zero, @accumulator == 0)
  end

  private def txs(address : Int)
    @stack_pointer = @x_index
  end

  private def ldy(address : Int, address_mode : AddressModes)
    m = 0
    case address_mode
    when AddressModes::Immediate                       ; m = address
    when AddressModes::ZeroPage, AddressModes::Absolute; m = peek(address)
    when AddressModes::ZeroPageX                       ; m = peek((address + @x_index) & 0xff)
    when AddressModes::AbsoluteX
      @instruction_cycles += (@program_counter - @program_counter//255*255 + ((address + @x_index) & 0xffff)) > 255 ? 1 : 0
      m = peek((address + @x_index) & 0xffff)
    end
    @y_index = m.to_u8
    set_flag(Flags::Negative, @y_index.bit(7) == 1)
    set_flag(Flags::Zero, @y_index == 0)
  end

  private def lda(address : Int, address_mode : AddressModes)
    m = 0
    case address_mode
    when AddressModes::IndirectX                       ; m = peek(get_indx(address))
    when AddressModes::ZeroPage, AddressModes::Absolute; m = peek(address)
    when AddressModes::Immediate                       ; m = address
    when AddressModes::IndirectY
      @instruction_cycles += (@program_counter - @program_counter//255*255 + get_indy(address)) > 255 ? 1 : 0
      m = peek(get_indy(address))
    when AddressModes::ZeroPageX; m = peek((address + @x_index) & 0xff)
    when AddressModes::AbsoluteY
      @instruction_cycles += (@program_counter - @program_counter//255*255 + ((address + @y_index) & 0xffff)) > 255 ? 1 : 0
      m = peek((address + @y_index) & 0xffff)
    when AddressModes::AbsoluteX
      @instruction_cycles += (@program_counter - @program_counter//255*255 + ((address + @x_index) & 0xffff)) > 255 ? 1 : 0
      m = peek((address + @x_index) & 0xffff)
    end
    @accumulator = m.to_u8
    set_flag(Flags::Negative, @accumulator.bit(7) == 1)
    set_flag(Flags::Zero, @accumulator == 0)
  end

  private def ldx(address : Int, address_mode : AddressModes)
    m = 0
    case address_mode
    when AddressModes::Immediate                       ; m = address
    when AddressModes::ZeroPage, AddressModes::Absolute; m = peek(address)
    when AddressModes::ZeroPageY                       ; m = peek((address + @y_index) & 0xff)
    when AddressModes::AbsoluteY
      @instruction_cycles += (@program_counter - @program_counter//255*255 + ((address + @y_index) & 0xffff)) > 255 ? 1 : 0
      m = peek((address + @y_index) & 0xffff)
    end
    @x_index = m.to_u8
    set_flag(Flags::Negative, @x_index.bit(7) == 1)
    set_flag(Flags::Zero, @x_index == 0)
  end

  private def tay(address : Int)
    @y_index = @accumulator
    set_flag(Flags::Negative, @y_index.bit(7) == 1)
    set_flag(Flags::Zero, @y_index == 0)
  end

  private def tax(address : Int)
    @x_index = @accumulator
    set_flag(Flags::Negative, @x_index.bit(7) == 1)
    set_flag(Flags::Zero, @x_index == 0)
  end

  private def bcs(address : Int)
    if get_flag(Flags::Carry) == true
      address = (address - 128).to_i8

      page_difference = (@program_counter - @program_counter//255*255 + address)
      @instruction_cycles += page_difference > 127 || page_difference < -128 ? 2 : 1
      @program_counter += address.to_i16
    end
  end

  private def clv(address : Int)
    set_flag(Flags::Overflow, false)
  end

  private def tsx(address : Int)
    @x_index = @stack_pointer
    set_flag(Flags::Negative, @x_index.bit(7) == 1)
    set_flag(Flags::Zero, @x_index == 0)
  end

  private def cpy(address : Int, address_mode : AddressModes)
    t = 0
    case address_mode
    when AddressModes::Immediate
      t = @y_index - address
      set_flag(Flags::Carry, @y_index >= address)
    when AddressModes::ZeroPage, AddressModes::Absolute
      t = @y_index - peek(address)
      set_flag(Flags::Carry, @y_index >= peek(address))
    end
    set_flag(Flags::Negative, t.bit(7) == 1)
    set_flag(Flags::Zero, t == 0)
  end

  private def cmp(address : Int, address_mode : AddressModes)
    t = 0
    case address_mode
    when AddressModes::IndirectX
      t = @accumulator - peek(get_indx(address))
      set_flag(Flags::Carry, @accumulator >= peek(get_indx(address)))
    when AddressModes::ZeroPage, AddressModes::Absolute
      t = @accumulator - peek(address)
      set_flag(Flags::Carry, @accumulator >= peek(address))
    when AddressModes::Immediate
      t = @accumulator - address
      set_flag(Flags::Carry, @accumulator >= address)
    when AddressModes::IndirectY
      @instruction_cycles += (@program_counter - @program_counter//255*255 + get_indy(address)) > 255 ? 1 : 0
      t = @accumulator - peek(get_indy(address))
      set_flag(Flags::Carry, @accumulator >= peek(get_indy(address)))
    when AddressModes::ZeroPageX
      t = @accumulator - peek((address + @x_index) & 0xff)
      set_flag(Flags::Carry, @accumulator >= peek((address + @x_index) & 0xff))
    when AddressModes::AbsoluteY
      @instruction_cycles += (@program_counter - @program_counter//255*255 + ((address + @y_index) & 0xffff)) > 255 ? 1 : 0
      t = @accumulator - peek((address + @y_index) & 0xffff)
      set_flag(Flags::Carry, @accumulator >= peek((address + @y_index) & 0xffff))
    when AddressModes::AbsoluteX
      @instruction_cycles += (@program_counter - @program_counter//255*255 + ((address + @x_index) & 0xffff)) > 255 ? 1 : 0
      t = @accumulator - peek((address + @x_index) & 0xffff)
      set_flag(Flags::Carry, @accumulator >= peek((address + @x_index) & 0xffff))
    end
    set_flag(Flags::Negative, t.bit(7) == 1)
    set_flag(Flags::Zero, t == 0)
  end

  private def dec(address : Int, address_mode : AddressModes)
    case address_mode
    when AddressModes::ZeroPage, AddressModes::Absolute
      poke(address, (peek(address) - 1) & 0xff)
      set_flag(Flags::Negative, peek(address).bit(7) == 1)
      set_flag(Flags::Zero, peek(address) == 0)
    when AddressModes::ZeroPageX
      poke((address + @x_index) & 0xff, (peek((address + @x_index) & 0xff) - 1) & 0xff)
      set_flag(Flags::Negative, peek((address + @x_index) & 0xff).bit(7) == 1)
      set_flag(Flags::Zero, peek((address + @x_index) & 0xff) == 0)
    when AddressModes::AbsoluteX
      @instruction_cycles += (@program_counter - @program_counter//255*255 + ((address + @x_index) & 0xffff)) > 255 ? 1 : 0
      poke((address + @x_index) & 0xffff, (peek((address + @x_index) & 0xffff) - 1) & 0xff)
      set_flag(Flags::Negative, peek((address + @x_index) & 0xffff).bit(7) == 1)
      set_flag(Flags::Zero, peek((address + @x_index) & 0xffff) == 0)
    end
  end

  private def iny(address : Int)
    @y_index += 1
    set_flag(Flags::Zero, @y_index == 0)
    set_flag(Flags::Negative, @y_index.bit(7) == 1)
  end

  private def dex(address : Int)
    @x_index -= 1
    set_flag(Flags::Zero, @x_index == 0)
    set_flag(Flags::Negative, @x_index.bit(7) == 1)
  end

  private def bne(address : Int)
    if get_flag(Flags::Zero) == false
      address = (address - 128).to_i8

      page_difference = (@program_counter - @program_counter//255*255 + address)
      @instruction_cycles += page_difference > 127 || page_difference < -128 ? 2 : 1
      @program_counter += address.to_i16
    end
  end

  private def cld(address : Int)
    set_flag(Flags::DecimalMode, false)
  end

  private def cpx(address : Int, address_mode : AddressModes)
    t = 0
    case address_mode
    when AddressModes::Immediate
      t = @x_index - address
      set_flag(Flags::Carry, @x_index >= address)
    when AddressModes::ZeroPage, AddressModes::Absolute
      t = @x_index - peek(address)
      set_flag(Flags::Carry, @x_index >= peek(address))
    end
    set_flag(Flags::Negative, t.bit(7) == 1)
    set_flag(Flags::Zero, t == 0)
  end

  private def sbc(address : Int, address_mode : AddressModes)
    m_value = 0
    case address_mode
    when AddressModes::IndirectX                       ; m_value = peek(get_indx(address))
    when AddressModes::ZeroPage, AddressModes::Absolute; m_value = peek(address)
    when AddressModes::Immediate                       ; m_value = address
    when AddressModes::IndirectY
      @instruction_cycles += (@program_counter - @program_counter//255*255 + get_indy(address)) > 255 ? 1 : 0
      m_value = peek(get_indy(address))
    when AddressModes::ZeroPageX; m_value = peek((address + @x_index) & 0xff)
    when AddressModes::AbsoluteY
      @instruction_cycles += (@program_counter - @program_counter//255*255 + ((address + @y_index) & 0xffff)) > 255 ? 1 : 0
      m_value = peek((address + @y_index) & 0xffff)
    when AddressModes::AbsoluteX
      @instruction_cycles += (@program_counter - @program_counter//255*255 + ((address + @x_index) & 0xffff)) > 255 ? 1 : 0
      m_value = peek((address + @x_index) & 0xffff)
    end

    m_value = m_value.to_u8

    if get_flag(Flags::DecimalMode)
      t = bcd(@accumulator) - bcd(m_value) - (get_flag(Flags::Carry) ? 0 : 1)
      set_flag(Flags::Overflow, t > 99 || t < 0)
    else
      t = @accumulator - m_value - (get_flag(Flags::Carry) ? 0 : 1)
      set_flag(Flags::Overflow, t > 127 || t < -128)
    end

    set_flag(Flags::Carry, t >= 0)
    set_flag(Flags::Negative, t.bit(7) == 1)
    set_flag(Flags::Zero, t == 0)
    @accumulator = t & 0xff
  end

  private def inc(address : Int, address_mode : AddressModes)
    m = 0
    case address_mode
    when AddressModes::ZeroPage, AddressModes::Absolute; m = address
    when AddressModes::ZeroPageX                       ; m = (address + @x_index) & 0xff
    when AddressModes::AbsoluteX
      @instruction_cycles += (@program_counter - @program_counter//255*255 + ((address + @x_index) & 0xffff)) > 255 ? 1 : 0
      m = (address + @x_index) & 0xffff
    end

    poke(m, (peek(m) + 1) & 0xff)
    set_flag(Flags::Negative, peek(m).bit(7) == 1)
    set_flag(Flags::Zero, peek(m) == 0)
  end

  private def inx(address : Int)
    @x_index += 1
    set_flag(Flags::Zero, @x_index == 0)
    set_flag(Flags::Negative, @x_index.bit(7) == 1)
  end

  private def beq(address : Int)
    if get_flag(Flags::Zero) == true
      address = (address - 128).to_i8

      page_difference = (@program_counter - @program_counter//255*255 + address)
      @instruction_cycles += page_difference > 127 || page_difference < -128 ? 2 : 1
      @program_counter += address.to_i16
    end
  end

  private def sed(address : Int)
    set_flag(Flags::DecimalMode, true)
  end
end
