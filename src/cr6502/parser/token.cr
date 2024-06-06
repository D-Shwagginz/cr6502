class CPU
  # The keywords for the tokens, used when parsing
  KEYWORDS = {
    "ADC" => TokenType::ADC,
    "AND" => TokenType::AND,
    "ASL" => TokenType::ASL,
    "BCC" => TokenType::BCC,
    "BCS" => TokenType::BCS,
    "BEQ" => TokenType::BEQ,
    "BIT" => TokenType::BIT,
    "BMI" => TokenType::BMI,
    "BNE" => TokenType::BNE,
    "BPL" => TokenType::BPL,
    "BRK" => TokenType::BRK,
    "BVC" => TokenType::BVC,
    "BVS" => TokenType::BVS,
    "CLC" => TokenType::CLC,
    "CLD" => TokenType::CLD,
    "CLI" => TokenType::CLI,
    "CLV" => TokenType::CLV,
    "CMP" => TokenType::CMP,
    "CPX" => TokenType::CPX,
    "CPY" => TokenType::CPY,
    "DEC" => TokenType::DEC,
    "DEX" => TokenType::DEX,
    "DEY" => TokenType::DEY,
    "EOR" => TokenType::EOR,
    "INC" => TokenType::INC,
    "INX" => TokenType::INX,
    "INY" => TokenType::INY,
    "JMP" => TokenType::JMP,
    "JSR" => TokenType::JSR,
    "LDA" => TokenType::LDA,
    "LDX" => TokenType::LDX,
    "LDY" => TokenType::LDY,
    "LSR" => TokenType::LSR,
    "NOP" => TokenType::NOP,
    "ORA" => TokenType::ORA,
    "PHA" => TokenType::PHA,
    "PHP" => TokenType::PHP,
    "PLA" => TokenType::PLA,
    "PLP" => TokenType::PLP,
    "ROL" => TokenType::ROL,
    "ROR" => TokenType::ROR,
    "RTI" => TokenType::RTI,
    "RTS" => TokenType::RTS,
    "SBC" => TokenType::SBC,
    "SEC" => TokenType::SEC,
    "SED" => TokenType::SED,
    "SEI" => TokenType::SEI,
    "STA" => TokenType::STA,
    "STX" => TokenType::STX,
    "STY" => TokenType::STY,
    "TAX" => TokenType::TAX,
    "TAY" => TokenType::TAY,
    "TSX" => TokenType::TSX,
    "TXA" => TokenType::TXA,
    "TXS" => TokenType::TXS,
    "TYA" => TokenType::TYA,
    # Custom
    "PRT" => TokenType::PRT,
    "LOG" => TokenType::LOG,
    "STP" => TokenType::STP,
  }

  # The types of tokens, used when parsing
  enum TokenType
    LeftParen
    RightParen
    Percent
    Hash
    Dollar
    Comma

    A
    X
    Y

    Integer
    Identifier

    ADC
    AND
    ASL
    BCC
    BCS
    BEQ
    BIT
    BMI
    BNE
    BPL
    BRK
    BVC
    BVS
    CLC
    CLD
    CLI
    CLV
    CMP
    CPX
    CPY
    DEC
    DEX
    DEY
    EOR
    INC
    INX
    INY
    JMP
    JSR
    LDA
    LDX
    LDY
    LSR
    NOP
    ORA
    PHA
    PHP
    PLA
    PLP
    ROL
    ROR
    RTI
    RTS
    SBC
    SEC
    SED
    SEI
    STA
    STX
    STY
    TAX
    TAY
    TSX
    TXA
    TXS
    TYA

    # Custom
    PRT
    LOG
    STP

    Label

    EOF
  end

  # A token, used when parsing
  class Token
    property type : TokenType
    property lexeme : String
    property literal : Int32 | Nil

    def initialize(@type : TokenType, @lexeme : String, @literal : Int32 | Float64 | String | Nil = nil)
    end

    def to_string
      return @type + " " + @lexeme + " " + @literal
    end
  end
end
