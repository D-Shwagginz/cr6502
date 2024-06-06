class CPU
  # Parses the address mode of the current line of code
  macro parse_address_mode
    current_index += 1
    if scanner.tokens[current_index].type == TokenType::A
      address_mode = AddressModes::Accumulator
    elsif scanner.tokens[current_index].type == TokenType::Hash
      address_mode = AddressModes::Immediate
      current_index += 1
      parse_address
    elsif scanner.tokens[current_index].type == TokenType::Integer
      parse_address
      if address.bit_length <= 8
        if scanner.tokens[current_index+1].type == TokenType::Comma && scanner.tokens[current_index+2].type == TokenType::X
          current_index += 2
          address_mode = AddressModes::ZeroPageX
        elsif scanner.tokens[current_index+1].type == TokenType::Comma && scanner.tokens[current_index+2].type == TokenType::Y
          current_index += 2
          address_mode = AddressModes::ZeroPageY
        elsif scanner.tokens[current_index+1].type == TokenType::EOF
          address_mode = AddressModes::ZeroPage
        end
      elsif address.bit_length <= 16
        if scanner.tokens[current_index+1].type == TokenType::Comma && scanner.tokens[current_index+2].type == TokenType::X
          current_index += 2
          address_mode = AddressModes::AbsoluteX
        elsif scanner.tokens[current_index+1].type == TokenType::Comma && scanner.tokens[current_index+2].type == TokenType::Y
          current_index += 2
          address_mode = AddressModes::AbsoluteY
        elsif scanner.tokens[current_index+1].type == TokenType::EOF
          address_mode = AddressModes::Absolute
        end
      else
        raise ScannerException.new("Invalid command \"#{line}\" on line ##{line_number}")
      end
    elsif scanner.tokens[current_index].type == TokenType::LeftParen
      current_index +=1
      parse_address
      if scanner.tokens[current_index+1].type == TokenType::RightParen && scanner.tokens[current_index+2].type == TokenType::EOF
        address_mode = AddressModes::Indirect
      elsif address.bit_length <= 8
        if scanner.tokens[current_index+1].type == TokenType::Comma && scanner.tokens[current_index+2].type == TokenType::X && scanner.tokens[current_index+3].type == TokenType::RightParen && scanner.tokens[current_index+4].type == TokenType::EOF
          current_index += 2
          address_mode = AddressModes::IndirectX
        elsif scanner.tokens[current_index+1].type == TokenType::RightParen && scanner.tokens[current_index+2].type == TokenType::Comma && scanner.tokens[current_index+3].type == TokenType::Y && scanner.tokens[current_index+4].type == TokenType::EOF
          address_mode = AddressModes::IndirectY
        else
          raise ScannerException.new("Invalid command \"#{line}\" on line ##{line_number}")
        end
      else
        raise ScannerException.new("Invalid command \"#{line}\" on line ##{line_number}")
      end
    else
      raise ScannerException.new("Invalid command \"#{line}\" on line ##{line_number}")
    end
  end

  # Parses the address of the line of code
  macro parse_address
    if scanner.tokens[current_index].type == TokenType::Dollar
      current_index += 1
      address = scanner.tokens[current_index].literal.as(Int32)
      address = (address <= 255 ? address.to_u8 : address.to_u16)
    elsif scanner.tokens[current_index].type == TokenType::Percent
      current_index += 1
      address = scanner.tokens[current_index].literal.as(Int32)
      address = (address <= 255 ? address.to_u8 : address.to_u16)
    else
        address = scanner.tokens[current_index].literal.as(Int32)
        address = (address <= 255 ? address.to_u8 : address.to_u16)
    end
  end

  # Loads 6502 assembly instructions
  #
  # Works with labels `label:`
  #
  # the `resvec:` label will set the value at `RES_LOCATION` to the label's memory location
  #
  # the `brkvec:` label will set the value at `BRK_LOCATION` to the label's memory location
  def load_asm(code : String)
    code.each_line.with_index do |line, line_number|
      current_index = 0

      # Scan Labels
      scanner = Scanner.new(line, line_number, @labels)
      scanner.scan_tokens

      until current_index == scanner.tokens.size - 1
        if scanner.tokens[current_index].type == TokenType::Label
          label_name = scanner.tokens[current_index].lexeme.rchop
          if label_name == "resvec"
            poke(RES_LOCATION, @program_counter)
          elsif label_name == "brkvec"
            poke(BRK_LOCATION, @program_counter)
          else
            label_i = @labels.index { |l| l[0] == label_name }
            if label_i
              @labels[label_i] = {label_name, (@program_counter <= 255 ? @program_counter.to_u8 : @program_counter.to_u16)}
            else
              @labels << {label_name, (@program_counter <= 255 ? @program_counter.to_u8 : @program_counter.to_u16)}
            end
          end
        end

        current_index += 1
      end
      current_index = 0
      scanner = Scanner.new(line, line_number, @labels)
      scanner.scan_tokens

      until current_index == scanner.tokens.size - 1
        address_mode = nil
        address : Int32 | UInt16 | UInt8 = -1

        case scanner.tokens[current_index].type
        # -------------------------- #
        # -- BITWISE INSTRUCTIONS -- #
        # -------------------------- #

        when TokenType::AND
          parse_address_mode
          case address_mode
          when AddressModes::Immediate; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "ANDi" }[1])
          when AddressModes::ZeroPage ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "ANDzpg" }[1])
          when AddressModes::ZeroPageX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "ANDzpgx" }[1])
          when AddressModes::Absolute ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "ANDabs" }[1])
          when AddressModes::AbsoluteX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "ANDabsx" }[1])
          when AddressModes::AbsoluteY; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "ANDabsy" }[1])
          when AddressModes::IndirectX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "ANDindx" }[1])
          when AddressModes::IndirectY; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "ANDindy" }[1])
          end
        when TokenType::EOR
          parse_address_mode
          case address_mode
          when AddressModes::Immediate; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "EORi" }[1])
          when AddressModes::ZeroPage ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "EORzpg" }[1])
          when AddressModes::ZeroPageX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "EORzpgx" }[1])
          when AddressModes::Absolute ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "EORabs" }[1])
          when AddressModes::AbsoluteX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "EORabsx" }[1])
          when AddressModes::AbsoluteY; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "EORabsy" }[1])
          when AddressModes::IndirectX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "EORindx" }[1])
          when AddressModes::IndirectY; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "EORindy" }[1])
          end
        when TokenType::ORA
          parse_address_mode
          case address_mode
          when AddressModes::Immediate; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "ORAi" }[1])
          when AddressModes::ZeroPage ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "ORAzpg" }[1])
          when AddressModes::ZeroPageX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "ORAzpgx" }[1])
          when AddressModes::Absolute ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "ORAabs" }[1])
          when AddressModes::AbsoluteX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "ORAabsx" }[1])
          when AddressModes::AbsoluteY; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "ORAabsy" }[1])
          when AddressModes::IndirectX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "ORAindx" }[1])
          when AddressModes::IndirectY; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "ORAindy" }[1])
          end
        when TokenType::ASL
          parse_address_mode
          case address_mode
          when AddressModes::Accumulator; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "ASLa" }[1])
          when AddressModes::ZeroPage   ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "ASLzpg" }[1])
          when AddressModes::ZeroPageX  ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "ASLzpgx" }[1])
          when AddressModes::Absolute   ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "ASLabs" }[1])
          when AddressModes::AbsoluteX  ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "ASLabsx" }[1])
          end
        when TokenType::LSR
          parse_address_mode
          case address_mode
          when AddressModes::Accumulator; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "LSRa" }[1])
          when AddressModes::ZeroPage   ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "LSRzpg" }[1])
          when AddressModes::ZeroPageX  ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "LSRzpgx" }[1])
          when AddressModes::Absolute   ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "LSRabs" }[1])
          when AddressModes::AbsoluteX  ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "LSRabsx" }[1])
          end
        when TokenType::ROL
          parse_address_mode
          case address_mode
          when AddressModes::Accumulator; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "ROLa" }[1])
          when AddressModes::ZeroPage   ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "ROLzpg" }[1])
          when AddressModes::ZeroPageX  ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "ROLzpgx" }[1])
          when AddressModes::Absolute   ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "ROLabs" }[1])
          when AddressModes::AbsoluteX  ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "ROLabsx" }[1])
          end
        when TokenType::ROR
          parse_address_mode
          case address_mode
          when AddressModes::Accumulator; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "RORa" }[1])
          when AddressModes::ZeroPage   ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "RORzpg" }[1])
          when AddressModes::ZeroPageX  ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "RORzpgx" }[1])
          when AddressModes::Absolute   ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "RORabs" }[1])
          when AddressModes::AbsoluteX  ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "RORabsx" }[1])
          end
          # ------------------------- #
          # -- BRANCH INSTRUCTIONS -- #
          # ------------------------- #

        when TokenType::BPL
          current_index += 1
          parse_address
          add_instruction(INSTRUCTIONS.find! { |i| i[0] == "BPL" }[1])
        when TokenType::BVC
          current_index += 1
          parse_address
          add_instruction(INSTRUCTIONS.find! { |i| i[0] == "BVC" }[1])
        when TokenType::BCC
          current_index += 1
          parse_address
          add_instruction(INSTRUCTIONS.find! { |i| i[0] == "BCC" }[1])
        when TokenType::BNE
          current_index += 1
          parse_address
          add_instruction(INSTRUCTIONS.find! { |i| i[0] == "BNE" }[1])
        when TokenType::BMI
          current_index += 1
          parse_address
          add_instruction(INSTRUCTIONS.find! { |i| i[0] == "BMI" }[1])
        when TokenType::BVS
          current_index += 1
          parse_address
          add_instruction(INSTRUCTIONS.find! { |i| i[0] == "BVS" }[1])
        when TokenType::BCS
          current_index += 1
          parse_address
          add_instruction(INSTRUCTIONS.find! { |i| i[0] == "BCS" }[1])
        when TokenType::BEQ
          current_index += 1
          parse_address
          add_instruction(INSTRUCTIONS.find! { |i| i[0] == "BEQ" }[1])
          # -------------------------- #
          # -- COMPARE INSTRUCTIONS -- #
          # -------------------------- #

        when TokenType::CMP
          parse_address_mode
          case address_mode
          when AddressModes::Immediate; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "CMPi" }[1])
          when AddressModes::ZeroPage ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "CMPzpg" }[1])
          when AddressModes::ZeroPageX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "CMPzpgx" }[1])
          when AddressModes::Absolute ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "CMPabs" }[1])
          when AddressModes::AbsoluteX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "CMPabsx" }[1])
          when AddressModes::AbsoluteY; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "CMPabsy" }[1])
          when AddressModes::IndirectX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "CMPindx" }[1])
          when AddressModes::IndirectY; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "CMPindy" }[1])
          end
        when TokenType::CPX
          parse_address_mode
          case address_mode
          when AddressModes::Immediate; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "CPXi" }[1])
          when AddressModes::ZeroPage ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "CPXzpg" }[1])
          when AddressModes::Absolute ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "CPXabs" }[1])
          end
        when TokenType::CPY
          parse_address_mode
          case address_mode
          when AddressModes::Immediate; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "CPYi" }[1])
          when AddressModes::ZeroPage ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "CPYzpg" }[1])
          when AddressModes::Absolute ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "CPYabs" }[1])
          end
        when TokenType::BIT
          parse_address_mode
          case address_mode
          when AddressModes::ZeroPage; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "BITzpg" }[1])
          when AddressModes::Absolute; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "BITabs" }[1])
          end
          # ----------------------- #
          # -- FLAG INSTRUCTIONS -- #
          # ----------------------- #

        when TokenType::CLC; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "CLC" }[1])
        when TokenType::SEC; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "SEC" }[1])
        when TokenType::CLI; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "CLI" }[1])
        when TokenType::SEI; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "SEI" }[1])
        when TokenType::CLD; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "CLD" }[1])
        when TokenType::SED; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "SED" }[1])
        when TokenType::CLV; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "CLV" }[1])
          # ----------------------- #
          # -- JUMP INSTRUCTIONS -- #
          # ----------------------- #

        when TokenType::JMP
          parse_address_mode
          case address_mode
          when AddressModes::Absolute; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "JMPabs" }[1])
          when AddressModes::Indirect; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "JMPind" }[1])
          end
        when TokenType::JSR
          current_index += 1
          parse_address
          add_instruction(INSTRUCTIONS.find! { |i| i[0] == "JSR" }[1])
        when TokenType::RTS; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "RTS" }[1])
        when TokenType::RTI; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "RTI" }[1])
          # ----------------------- #
          # -- MATH INSTRUCTIONS -- #
          # ----------------------- #

        when TokenType::ADC
          parse_address_mode
          case address_mode
          when AddressModes::Immediate; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "ADCi" }[1])
          when AddressModes::ZeroPage ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "ADCzpg" }[1])
          when AddressModes::ZeroPageX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "ADCzpgx" }[1])
          when AddressModes::Absolute ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "ADCabs" }[1])
          when AddressModes::AbsoluteX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "ADCabsx" }[1])
          when AddressModes::AbsoluteY; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "ADCabsy" }[1])
          when AddressModes::IndirectX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "ADCindx" }[1])
          when AddressModes::IndirectY; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "ADCindy" }[1])
          end
        when TokenType::SBC
          parse_address_mode
          case address_mode
          when AddressModes::Immediate; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "SBCi" }[1])
          when AddressModes::ZeroPage ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "SBCzpg" }[1])
          when AddressModes::ZeroPageX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "SBCzpgx" }[1])
          when AddressModes::Absolute ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "SBCabs" }[1])
          when AddressModes::AbsoluteX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "SBCabsx" }[1])
          when AddressModes::AbsoluteY; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "SBCabsy" }[1])
          when AddressModes::IndirectX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "SBCindx" }[1])
          when AddressModes::IndirectY; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "SBCindy" }[1])
          end
          # ------------------------- #
          # -- MEMORY INSTRUCTIONS -- #
          # ------------------------- #

        when TokenType::LDA
          parse_address_mode
          case address_mode
          when AddressModes::Immediate; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "LDAi" }[1])
          when AddressModes::ZeroPage ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "LDAzpg" }[1])
          when AddressModes::ZeroPageX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "LDAzpgx" }[1])
          when AddressModes::Absolute ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "LDAabs" }[1])
          when AddressModes::AbsoluteX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "LDAabsx" }[1])
          when AddressModes::AbsoluteY; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "LDAabsy" }[1])
          when AddressModes::IndirectX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "LDAindx" }[1])
          when AddressModes::IndirectY; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "LDAindy" }[1])
          end
        when TokenType::LDX
          parse_address_mode
          case address_mode
          when AddressModes::Immediate; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "LDXi" }[1])
          when AddressModes::ZeroPage ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "LDXzpg" }[1])
          when AddressModes::ZeroPageY; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "LDXzpgy" }[1])
          when AddressModes::Absolute ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "LDXabs" }[1])
          when AddressModes::AbsoluteY; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "LDXabsy" }[1])
          end
        when TokenType::LDY
          parse_address_mode
          case address_mode
          when AddressModes::Immediate; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "LDYi" }[1])
          when AddressModes::ZeroPage ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "LDYzpg" }[1])
          when AddressModes::ZeroPageX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "LDYzpgx" }[1])
          when AddressModes::Absolute ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "LDYabs" }[1])
          when AddressModes::AbsoluteX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "LDYabsx" }[1])
          end
        when TokenType::DEC
          parse_address_mode
          case address_mode
          when AddressModes::ZeroPage ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "DECzpg" }[1])
          when AddressModes::ZeroPageX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "DECzpgx" }[1])
          when AddressModes::Absolute ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "DECabs" }[1])
          when AddressModes::AbsoluteX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "DECabsx" }[1])
          end
        when TokenType::STA
          parse_address_mode
          case address_mode
          when AddressModes::ZeroPage ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "STAzpg" }[1])
          when AddressModes::ZeroPageX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "STAzpgx" }[1])
          when AddressModes::Absolute ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "STAabs" }[1])
          when AddressModes::AbsoluteX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "STAabsx" }[1])
          when AddressModes::AbsoluteY; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "STAabsy" }[1])
          when AddressModes::IndirectX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "STAindx" }[1])
          when AddressModes::IndirectY; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "STAindy" }[1])
          end
        when TokenType::STX
          parse_address_mode
          case address_mode
          when AddressModes::ZeroPage ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "STXzpg" }[1])
          when AddressModes::ZeroPageY; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "STXzpgy" }[1])
          when AddressModes::Absolute ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "STXabs" }[1])
          end
        when TokenType::STY
          parse_address_mode
          case address_mode
          when AddressModes::ZeroPage ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "STYzpg" }[1])
          when AddressModes::ZeroPageX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "STYzpgx" }[1])
          when AddressModes::Absolute ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "STYabs" }[1])
          end
        when TokenType::INC
          parse_address_mode
          case address_mode
          when AddressModes::ZeroPage ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "INCzpg" }[1])
          when AddressModes::ZeroPageX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "INCzpgx" }[1])
          when AddressModes::Absolute ; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "INCabs" }[1])
          when AddressModes::AbsoluteX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "INCabsx" }[1])
          end
          # --------------------------- #
          # -- REGISTER INSTRUCTIONS -- #
          # --------------------------- #

        when TokenType::TAX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "TAX" }[1])
        when TokenType::TXA; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "TXA" }[1])
        when TokenType::DEX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "DEX" }[1])
        when TokenType::INX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "INX" }[1])
        when TokenType::TAY; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "TAY" }[1])
        when TokenType::TYA; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "TYA" }[1])
        when TokenType::DEY; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "DEY" }[1])
        when TokenType::INY; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "INY" }[1])
          # ------------------------ #
          # -- STACK INSTRUCTIONS -- #
          # ------------------------ #

        when TokenType::PHA; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "PHA" }[1])
        when TokenType::PHP; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "PHP" }[1])
        when TokenType::TSX; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "TSX" }[1])
        when TokenType::PLA; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "PLA" }[1])
        when TokenType::PLP; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "PLP" }[1])
        when TokenType::TXS; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "TXS" }[1])
          # ------------------------ #
          # -- OTHER INSTRUCTIONS -- #
          # ------------------------ #

        when TokenType::BRK; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "BRK" }[1])
        when TokenType::NOP; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "NOP" }[1])
          # ------------------------- #
          # -- CUSTOM INSTRUCTIONS -- #
          # ------------------------- #

        when TokenType::PRT
          parse_address_mode
          if address <= 255
            add_instruction(INSTRUCTIONS.find! { |i| i[0] == "PRTzpg" }[1])
          else
            add_instruction(INSTRUCTIONS.find! { |i| i[0] == "PRTabs" }[1])
          end
        when TokenType::LOG; add_instruction(INSTRUCTIONS.find! { |i| i[0] == "LOG" }[1])
        when TokenType::Label
        else
          raise ScannerException.new("Invalid command \"#{line}\" on line ##{line_number}")
        end

        if address >= 0
          if address <= 255
            poke(@program_counter, address.to_u8)
            @program_counter += 1
          else
            poke(@program_counter, address.to_u16)
            @program_counter += 2
          end
        end

        current_index += 1
      end
    end

    @program_counter = peek(RES_LOCATION, true).to_u16
  end
end
