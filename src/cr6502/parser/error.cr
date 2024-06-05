class CPU
  class ASMException < Exception
  end

  class LineParsingException < ASMException
  end

  class ScannerException < ASMException
  end
end
