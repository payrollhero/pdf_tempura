# PdfTempura

A gem for overlaying text and other fields onto PDF templates using Prawn.

## Installation

Add this line to your application's Gemfile:

    gem 'pdf_tempura'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pdf_tempura

## Usage

### Building your overlayed PDF template

Inherit from `PdfTempura::Document` to start off your pdf.

#### Specifying the template

Specify your template using:

```ruby
  template "/some/path/to/template.pdf"
```

#### Specifying pages

The `page` method can be used to specify a page. It takes number to specify the page, and a block where you specify your fields.

```ruby
page 1 do
  # fields ...
end
```

#### Specifying fields

Fields should be specified inside pages using the `page` method. Fields can be specified by using one of the following fields methods.

##### Text fields

You can specify a text field using the `text_field` method. It requires a name, an array of coordinates (x and y), and an array of dimensions (width and height).
Coordinates and dimensions are numbers referencing PDF units, starting from bottom left.

```ruby
text_field(name, coordinates, dimensions, options)
```

It also takes an options hash where you can set the following options:

- **default_value**: A string value. The default value for the field. Default is nil.
- **font_size**: A number in pixels (i.e. 13), or auto to change the font to fit the field size. Default is 10px.
- **font_name**: The name of the font to use. Default: "Helvetica"
- **italic**: True or false. Makes the text italic when set to true. Default to false.
- **bold**: True or false. Makes the text bold when set to true. Default is false.
- **alignment**: "left", "center" or "right". Aligns the text in the boundaries of the field. Default is "left".
- **multi_line**: True or false. Forces the text to wrap to the next line when it hits the boundaries of the field. Default is false.
- **padding**: An array of 4 numbers, representing top, right, bottom, left. It adds padding in pdf units inside the field.

```ruby
page 1 do
  text_field :country, [10, 20], [200, 400], { default_value: "USA", font_size: 13, bold: true, alignment: left, multi_line:true }
end
```

##### Checkbox fields
You can specify a checkbox field using the `checkbox_field` method. It requires a name, an array of coordinates (x and y), and an array of dimensions (width and height).
Coordinates and dimensions are numbers referencing PDF units, starting from bottom left.

```ruby
checkbox_field(name, coordinates, dimensions, options)
```

It also takes an options hash where you can set the following options:

- **default_value**: True or false. The default value for the checkbox. Default is false.

```ruby
page 1 do
  checkbox_field :send_me_snacks, [10, 20], [20, 20], { default_value: true }
end
```

#### Specifying reusable groups

If you have the same fields on multiple pages, you can use the `group` method to DRY your template.

```ruby
group :employee_details do
  field :first_name, [10, 20], [100, 30]
  field :surname, [120, 20], [200, 30], { bold: true }
  field :company, [330, 20], [300, 30], { alignment: right }
end
```

Then you can use the `include_group` method to add that group to pages.

```ruby
page 1 do
  include_group :employee_details
  field :address, [10, 20], [500, 60]
  ...
end

page 2 do
  include_group :employee_details
  field :emergency_contact, [10, 20], [500, 60]
  ...
end
```

### Rendering your PDF

#### Loading field data

You can load the field data by creating a new instance of your overlayed template and passing a data hash.
The data hash should be a hash of hashes, the keys at the first level matching the page numbers and groups of your template,
and the keys inside the nested hashes matching the names of the fields in those pages.

```ruby
data_hash = {
  :employee_details => {
    :first_name => "Stan",
    :surname => "Smith",
    :company => "CIA"
  },
  1 => {
    :address => "The Pentagon, Washington, DC"
  },
  2 => {
    :emergency_contact => "Francine Smith"
  }
}

my_pdf = MyPdf.new(data_hash)
```

You can override group values by including the key in a specific page's data hash. Keys can be either strings or symbols. 

#### Rendering your overlayed PDF

After loading the field data, you can then render the PDF using the `render` method. The render method takes a block,
and provides the opened pdf file as an argument.  The pdf file will be closed when the block terminates and the value of the block
will be returned.

```ruby
mypdf.render do |pdf|
  # save PDF to file
  File.new("/path/to/file". "w+") do |file|
    file.write(pdf.read)
  end
end
```

### Debug mode

You can set your template to debug mode to help you position your fields using the `debug` method. The debug options are:

- **grid**: This will overlay a grid on the document, each box representing a 10x10 unit area.
- **outlines**: This will outline each field with a black border.

```ruby
class MyPdf < PdfTempura::Document

  template "/some/path/to/template.pdf"

  debug :grid, :outlines

  ...

end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
