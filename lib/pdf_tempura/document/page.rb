module PdfTempura
  class Document::Page
    include Document::Validation
    include Document::DefaultCommands

    def initialize(page_number)
      @number = page_number
      @fields = []

      validate!
    end

    attr_reader :number

    validates :number, type: Numeric

    def ==(other)
      self.number == other.number
    end

    def data
      @data ||= {}
    end

    def data=(data)
      @data = data.extend(Extensions::Hash::StringifyKeys).stringify_keys!
    end

  end
end

require_relative "default_commands"