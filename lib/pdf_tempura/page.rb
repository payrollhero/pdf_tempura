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

  end
end
