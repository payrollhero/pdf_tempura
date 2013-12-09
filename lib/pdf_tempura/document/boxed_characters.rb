module PdfTempura
  class Document::BoxedCharacters < Document::Field::Base

    attr_reader :box_width, :box_spacing, :groups, :truncate, :text_options, :padding
    alias :truncate? :truncate

    validates :box_width, required: true, type: Numeric
    validates :box_spacing, required: true, type: Numeric
    validates :truncate, boolean: true

    def initialize(name, coordinates, height, options = {}, &block)
      @groups = []

      super name, coordinates, [0, height], options

      instance_eval(&block) if block_given?
    end

    def characters(characters)
      @groups << CharacterGroup.new(characters)
    end

    def space(width)
      @groups << SpaceGroup.new(width)
    end

    def supported_characters
      @groups.map(&:characters).inject(:+)
    end

    def fields
      @fields ||= generate_text_fields
    end

    def width
      groups.inject(0){ |sum,group| sum + group.width(box_width, box_spacing) }
    end

    def dimensions
      [width, @dimensions[1]]
    end

    private

    def generate_text_fields
      fields = []

      groups.inject(self.x) do |x, group|
        group.each_supported_character do
          fields << Document::CharacterField.new(name, [x,y], [box_width,height], text_options)
          x+= box_width + box_spacing
        end

        x + group.spacing - (group.characters > 0 ? box_spacing : 0)
      end

      fields
    end

    def load_options(options)
      @box_width = options["box_width"]
      @box_spacing = options["box_spacing"]
      @truncate = options["truncate"] || false
      @text_options = options.reject { |key,v| ["box_width", "box_spacing", "truncate"].include?(key) }
      @padding = [0,0,0,0]
    end

  end
end

require_relative 'boxed_characters/groups'
