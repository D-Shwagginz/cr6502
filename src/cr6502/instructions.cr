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

  # List of instructions sorted by its opcode
  #
  # Format is {"InstructionName", opcode, cycle length, byte length}
  INSTRUCTIONS = [
    {"BRK", 0x00_u8, 7},
    {"ORAindx", 0x01_u8, 6},
    {"ORAzpg", 0x05_u8, 3},
    {"ASLzpg", 0x06_u8, 5},
    {"PHP", 0x08_u8, 3},
    {"ORAi", 0x09_u8, 2, 2},
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

    # -- CUSTOM INSTRUCTIONS -- #
    {"PRTzpg", 0x02_u8, 2},
    {"PRTabs", 0x03_u8, 3},
    {"LOG", 0x04_u8, 10},
    {"STP", 0x07_u8, 2},
    {"BCClabel", 0x0b_u8, 2},
    {"BCSlabel", 0x1b_u8, 2},
    {"BEQlabel", 0x2b_u8, 2},
    {"BMIlabel", 0x3b_u8, 2},
    {"BNElabel", 0x4b_u8, 2},
    {"BPLlabel", 0x5b_u8, 2},
    {"BVClabel", 0x6b_u8, 2},
    {"BVSlabel", 0x7b_u8, 2},
  ]

  # Adds an instruction, given it's opcode, into the current location in memory of the `CPU#program_counter` and increments the `CPU#program_counter` by the byte length of the given hex
  def add_instruction(hex : UInt8 | UInt16)
    poke(@program_counter, hex)
    @program_counter += hex.is_a?(UInt8) ? 1 : 2
  end

  # Runs the current value of `CPU#program_counter`'s location in memory as an instruction
  def run_instruction
    instruction = peek(@program_counter)
    @program_counter += 1_u16

    # Loop through each instruction to find name of current instruction's opcode
    INSTRUCTIONS.each do |i|
      if i[1] == instruction
        @instruction_cycles += i[2]
        address = peek(@program_counter)

        # Add 1 more cycle if address mode is indy and `CPU#get_indy(address)` is not on the same page of memory as the `CPU#program_counter`
        if i[0].includes?("indy")
          @instruction_cycles += (@program_counter - @program_counter//255*255 + get_indy(address)) > 255 ? 1 : 0
        end

        # Add 1 more cycle if address mode is absy and `(address + @y_index) & 0xffff` is not on the same page of memory as the `CPU#program_counter`
        if i[0].includes?("absy")
          @instruction_cycles += (@program_counter - @program_counter//255*255 + ((address + @y_index) & 0xffff)) > 255 ? 1 : 0
          address = peek(@program_counter, true)
          @program_counter += 2
          # Add 1 more cycle if address mode is absx and `(address + @x_index) & 0xffff` is not on the same page of memory as the `CPU#program_counter`
        elsif i[0].includes?("absx")
          @instruction_cycles += (@program_counter - @program_counter//255*255 + ((address + @x_index) & 0xffff)) > 255 ? 1 : 0
          address = peek(@program_counter, true)
          @program_counter += 2
        elsif i[0].includes?("abs") || i[0].includes?("JSR") || i[0].includes?("JMPind") || i[0].includes?("label")
          address = peek(@program_counter, true)
          @program_counter += 2
        elsif i[0].size > 3
          @program_counter += 1
        end

        case i[0]
        when "BRK"    ; brk
        when "ORAindx"; ora(peek(get_indx(address)).to_u8)
        when "ORAzpg" ; ora(peek(address).to_u8)
        when "ASLzpg" ; asl(peek(address).to_u8, address)
        when "PHP"    ; php()
        when "ORAi"   ; ora(address.to_u8)
        when "ASLa"   ; asl(@accumulator, @accumulator, true)
        when "ORAabs" ; ora(peek(address).to_u8)
        when "BPL"    ; bpl(address.to_u8)
        when "ORAindy"; ora(peek(get_indy(address)).to_u8)
        when "ORAzpgx"; ora(peek((address + @x_index) & 0xff).to_u8)
        when "ASLzpgx"; asl(peek((address + @x_index) & 0xff).to_u8, ((address + @x_index) & 0xff))
        when "CLC"    ; clc()
        when "ORAabsy"; ora(peek((address + @y_index) & 0xffff).to_u8)
        when "ORAabsx"; ora(peek((address + @x_index) & 0xffff).to_u8)
        when "ASLabsx"; asl(peek((address + @x_index) & 0xffff).to_u8, ((address + @x_index) & 0xffff))
        when "JSR"    ; jsr(address.to_u16)
        when "ANDindx"; and(peek(get_indx(address)).to_u8)
        when "BITzpg" ; bit(peek(address).to_u8)
        when "ANDzpg" ; and(peek(address).to_u8)
        when "ROLzpg" ; rol(peek(address).to_u8, address)
        when "PLP"    ; plp()
        when "ANDi"   ; and(address.to_u8)
        when "ROLa"   ; rol(@accumulator, @accumulator, true)
        when "BITabs" ; bit(peek(address).to_u8)
        when "ANDabs" ; and(peek(address).to_u8)
        when "ROLabs" ; rol(peek(address).to_u8, address)
        when "BMI"    ; bmi(address.to_u8)
        when "ANDindy"; and(peek(get_indy(address)).to_u8)
        when "ANDzpgx"; and(peek((address + @x_index) & 0xff).to_u8)
        when "ROLzpgx"; rol(peek((address + @x_index) & 0xff).to_u8, (address + @x_index) & 0xff)
        when "SEC"    ; sec()
        when "ANDabsy"; and(peek((address + @y_index) & 0xffff).to_u8)
        when "ANDabsx"; and(peek((address + @x_index) & 0xffff).to_u8)
        when "ROLabsx"; rol(peek((address + @x_index) & 0xffff).to_u8, (address + @x_index) & 0xffff)
        when "RTI"    ; rti()
        when "EORindx"; eor(peek(get_indx(address)).to_u8)
        when "EORzpg" ; eor(peek(address).to_u8)
        when "LSRzpg" ; lsr(peek(address).to_u8, address)
        when "PHA"    ; pha()
        when "EORi"   ; eor(address.to_u8)
        when "LSRa"   ; lsr(@accumulator, @accumulator, true)
        when "JMPabs" ; jmp(address.to_u16)
        when "EORabs" ; eor(peek(address).to_u8)
        when "LSRabs" ; lsr(peek(address).to_u8, address)
        when "BVC"    ; bvc(address.to_u8)
        when "EORindy"; eor(peek(get_indy(address)).to_u8)
        when "EORzpgx"; eor(peek((address + @x_index) & 0xff).to_u8)
        when "LSRzpgx"; lsr(peek((address + @x_index) & 0xff).to_u8, (address + @x_index) & 0xff)
        when "CLI"    ; cli()
        when "EORabsy"; eor(absy = peek((address + @y_index) & 0xffff).to_u8)
        when "EORabsx"; eor(absx = peek((address + @x_index) & 0xffff).to_u8)
        when "LSRabsx"; lsr(peek((address + @x_index) & 0xffff).to_u8, (address + @x_index) & 0xffff)
        when "RTS"    ; rts()
        when "ADCindx"; adc(peek(get_indx(address)).to_u8)
        when "ADCzpg" ; adc(peek(address).to_u8)
        when "RORzpg" ; ror(peek(address).to_u8, address)
        when "PLA"    ; pla()
        when "ADCi"   ; adc(address.to_u8)
        when "RORa"   ; ror(@accumulator, @accumulator, true)
        when "JMPind" ; jmp(peek(address, true).to_u16)
        when "ADCabs" ; adc(peek(address).to_u8)
        when "RORabs" ; ror(peek(address).to_u8, address)
        when "BVS"    ; bvs(address.to_u8)
        when "ADCindy"; adc(peek(get_indy(address)).to_u8)
        when "ADCzpgx"; adc(peek((address + @x_index) & 0xff).to_u8)
        when "RORzpgx"; ror(peek((address + @x_index) & 0xff).to_u8, (address + @x_index) & 0xff)
        when "SEI"    ; sei()
        when "ADCabsy"; adc(peek((address + @y_index) & 0xffff).to_u8)
        when "ADCabsx"; adc(peek((address + @x_index) & 0xffff).to_u8)
        when "RORabsx"; ror(peek((address + @x_index) & 0xffff).to_u8, (address + @x_index) & 0xffff)
        when "STAindx"; sta(get_indx(address))
        when "STYzpg" ; sty(address)
        when "STAzpg" ; sta(address)
        when "STXzpg" ; stx(address)
        when "DEY"    ; dey()
        when "TXA"    ; txa()
        when "STYabs" ; sty(address)
        when "STAabs" ; sta(address)
        when "STXabs" ; stx(address)
        when "BCC"    ; bcc(address.to_u8)
        when "STAindy"; sta(get_indy(address))
        when "STYzpgx"; sty((address + @x_index) & 0xff)
        when "STAzpgx"; sta((address + @x_index) & 0xff)
        when "STXzpgy"; stx((address + @y_index) & 0xff)
        when "TYA"    ; tya()
        when "STAabsy"; sta((address + @y_index) & 0xffff)
        when "TXS"    ; txs()
        when "STAabsx"; sta((address + @x_index) & 0xffff)
        when "LDYi"   ; ldy(address.to_u8)
        when "LDAindx"; lda(peek(get_indx(address)).to_u8)
        when "LDXi"   ; ldx(address.to_u8)
        when "LDYzpg" ; ldy(peek(address).to_u8)
        when "LDAzpg" ; lda(peek(address).to_u8)
        when "LDXzpg" ; ldx(peek(address).to_u8)
        when "TAY"    ; tay()
        when "LDAi"   ; lda(address.to_u8)
        when "TAX"    ; tax()
        when "LDYabs" ; ldy(peek(address).to_u8)
        when "LDAabs" ; lda(peek(address).to_u8)
        when "LDXabs" ; ldx(peek(address).to_u8)
        when "BCS"    ; bcs(address.to_u8)
        when "LDAindy"; lda(peek(get_indy(address)).to_u8)
        when "LDYzpgx"; ldy(peek((address + @x_index) & 0xff).to_u8)
        when "LDAzpgx"; lda(peek((address + @x_index) & 0xff).to_u8)
        when "LDXzpgy"; ldy(peek((address + @y_index) & 0xff).to_u8)
        when "CLV"    ; clv()
        when "LDAabsy"; lda(peek((address + @y_index) & 0xffff).to_u8)
        when "TSX"    ; tsx()
        when "LDYabsx"; ldy(peek((address + @x_index) & 0xffff).to_u8)
        when "LDAabsx"; lda(peek((address + @x_index) & 0xffff).to_u8)
        when "LDXabsy"; ldx(peek((address + @y_index) & 0xffff).to_u8)
        when "CPYi"   ; cpy(address.to_u8)
        when "CMPindx"; cmp(peek(get_indx(address)).to_u8)
        when "CPYzpg" ; cpy(peek(address).to_u8)
        when "CMPzpg" ; cmp(peek(address).to_u8)
        when "DECzpg" ; dec(peek(address).to_u8, address)
        when "INY"    ; iny()
        when "CMPi"   ; cmp(address.to_u8)
        when "DEX"    ; dex()
        when "CPYabs" ; cpy(peek(address).to_u8)
        when "CMPabs" ; cmp(peek(address).to_u8)
        when "DECabs" ; dec(peek(address).to_u8, address)
        when "BNE"    ; bne(address.to_u8)
        when "CMPindy"; cmp(peek(get_indy(address)).to_u8)
        when "CMPzpgx"; cmp(peek((address + @x_index) & 0xff).to_u8)
        when "DECzpgx"; dec(peek((address + @x_index) & 0xff).to_u8, (address + @x_index) & 0xff)
        when "CLD"    ; cld()
        when "CMPabsy"; cmp(peek((address + @y_index) & 0xffff).to_u8)
        when "CMPabsx"; cmp(peek((address + @x_index) & 0xffff).to_u8)
        when "DECabsx"; dec(peek((address + @x_index) & 0xffff).to_u8, (address + @x_index) & 0xffff)
        when "CPXi"   ; cpx(address.to_u8)
        when "SBCindx"; sbc(peek(get_indx(address)).to_u8)
        when "CPXzpg" ; cpx(peek(address).to_u8)
        when "SBCzpg" ; sbc(peek(address).to_u8)
        when "INCzpg" ; inc(peek(address).to_u8, address)
        when "INX"    ; inx()
        when "SBCi"   ; sbc(address.to_u8)
        when "NOP"    ; nop()
        when "CPXabs" ; cpx(peek(address).to_u8)
        when "SBCabs" ; sbc(peek(address).to_u8)
        when "INCabs" ; inc(peek(address).to_u8, address)
        when "BEQ"    ; beq(address.to_u8)
        when "SBCindy"; sbc(peek(get_indy(address)).to_u8)
        when "SBCzpgx"; sbc(peek((address + @x_index) & 0xff).to_u8)
        when "INCzpgx"; inc(peek((address + @x_index) & 0xff).to_u8, (address + @x_index) & 0xff)
        when "SED"    ; sed()
        when "SBCabsy"; sbc(peek((address + @y_index) & 0xffff).to_u8)
        when "SBCabsx"; sbc(peek((address + @x_index) & 0xffff).to_u8)
        when "INCabsx"; inc(peek((address + @x_index) & 0xffff).to_u8, (address + @x_index) & 0xffff)
          # Custom
        when "PRTzpg"  ; prt(address.to_u8)
        when "PRTabs"  ; prt(address.to_u16)
        when "LOG"     ; log()
        when "STP"     ; stp()
        when "BCClabel"; bcc(address.to_u16)
        when "BCSlabel"; bcs(address.to_u16)
        when "BEQlabel"; beq(address.to_u16)
        when "BMIlabel"; bmi(address.to_u16)
        when "BNElabel"; bne(address.to_u16)
        when "BPLlabel"; bpl(address.to_u16)
        when "BVClabel"; bvc(address.to_u16)
        when "BVSlabel"; bvs(address.to_u16)
        end
      end
    end
  end
end
