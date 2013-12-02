require_relative 'page/validation'

module PdfTempura
  class Page
    include Validation

    def initialize(page_number)
      @number = page_number
      @fields = []

      validate_arguments
    end

    attr_reader :number, :fields

    def ==(other)
      self.number == other.number
    end

    def field(*args)
      fields << Field.new(*args)
    end

    def data
      @data ||= {}
    end

    def data=(data)
      @data = data.extend(Extensions::Hash::StringifyKeys).stringify_keys!
    end

  end
end
