module PdfTempura
  module Render
    module Debug::Annotation
      class Base
        include Render::FieldBounds

        def initialize(field)
          @field = field
        end

        def render(pdf)
          set_field_styling(pdf)
          render_boxes(pdf)
          render_text(pdf)
        end

        private

        def set_field_styling(pdf)
          pdf.font_size = 7
          pdf.fill_color = "000066"
          pdf.line_width = 0.5
        end

        def render_text(pdf)
          field_bounds_box(pdf) do
            render_xy(pdf)
            render_label(pdf)
          end
        end

        def render_xy(pdf)
          pdf.text_box "x: #{@field.x} y: #{@field.y} w: #{@field.width} h: #{@field.height}", field_options
        end

        def render_label(pdf)
          pdf.text_box "#{@field.name}", label_options
        end

        def render_boxes(pdf)
          pdf.transparent 0.5 do
            field_bounds_box(pdf) do
              draw_box_border(pdf, "CCCC33")
              fill_box_color(pdf, "CCCC33")
              draw_padding(pdf)
            end
          end
        end

        def draw_box_border(pdf, color)
          pdf.stroke_color = color
          pdf.stroke_bounds
        end

        def fill_box_color(pdf, color)
          pdf.fill_color = color
          pdf.fill{ pdf.rectangle [0,pdf.bounds.height], pdf.bounds.width, pdf.bounds.height }
        end

        def draw_padding(pdf)
          pdf.transparent 0.25 do
            padding_bounds_box(pdf) do
              draw_box_border(pdf, "0000CC")
            end
          end
        end

        def field_options
          raise NotImplementedError, "Implement field_options in your subclass."
        end

        def label_options
          raise NotImplementedError, "Implement label_options in your subclass."
        end

      end
    end
  end
end
