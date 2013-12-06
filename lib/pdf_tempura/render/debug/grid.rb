module PdfTempura
  module Render
    module Debug
      class Grid

        def render(pdf)
          set_styling(pdf)
          render_grid(pdf)
        end

        private

        def set_styling(pdf)
          pdf.stroke_color = "000000"
          pdf.fill_color = "000000"
          pdf.line_width = 0.5
        end

        def render_grid(pdf)
          pdf.transparent(0.125) do
            render_vertical_lines(pdf)
            render_horizontal_lines(pdf)
          end
        end

        def render_vertical_lines(pdf)
          line_loop(pdf.bounds.width, 25) do |x|
            vertical_line_with_label pdf, x
          end
        end

        def render_horizontal_lines(pdf)
          line_loop(pdf.bounds.height, 25) do |y|
            horizontal_line_with_label pdf, y
          end
        end

        def line_loop(max, increment)
          (0 .. max).step(increment){ |n| yield(n) }
        end

        def vertical_line_with_label(pdf, x)
          pdf.stroke do
            pdf.line([x, 0], [x, pdf.bounds.height])
            pdf.draw_text x.to_s, at: [x+3, 3], size: 6
          end
        end

        def horizontal_line_with_label(pdf, y)
          pdf.stroke do
            pdf.line([0, y], [pdf.bounds.width, y])
            pdf.draw_text y.to_s, at: [3, y+3], size: 6
          end
        end

      end
    end
  end
end
