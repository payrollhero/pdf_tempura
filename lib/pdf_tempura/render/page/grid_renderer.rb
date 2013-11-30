module PdfTempura
  module Render
    class Page::GridRenderer

      def render(pdf)

        x = 0
        y = 0
        pdf.stroke_color = "000000"
        pdf.fill_color = "000000"
        pdf.line_width = 0.5
        pdf.transparent(0.125) do
          while x <= pdf.bounds.width
            pdf.stroke do
              pdf.line([x, 0], [x, pdf.bounds.height])
              pdf.draw_text x.to_s, at: [x+3, 3], size: 6
            end
            x += 25
          end
          while y <= pdf.bounds.height
            pdf.stroke do
              pdf.line([0, y], [pdf.bounds.width, y])
              pdf.draw_text y.to_s, at: [3, y+3], size: 6
            end
            y += 25
          end
        end

      end

    end
  end
end
