# PdfTempura

[![Code Climate](https://codeclimate.com/github/payrollhero/pdf_tempura.png)](https://codeclimate.com/github/payrollhero/pdf_tempura)
[![Build Status](https://travis-ci.org/payrollhero/pdf_tempura.png?branch=master)](https://travis-ci.org/payrollhero/pdf_tempura)
[![Dependency Status](https://gemnasium.com/payrollhero/pdf_tempura.png)](https://gemnasium.com/payrollhero/pdf_tempura)


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

The `page` method can be used to specify a page. It takes number to specify the page, 
and a block where you specify your fields.  You may also specify default options for
layout by passing them into the "page" call, they will be inherited into all the following
calls unless overridden by the particular options to the call to text_field or table, etc.

```ruby
page 1, alignment: "left" do
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

Common Options:

- **type**: "text", "checkbox" or "box-list".  Defines the type of the field and draws the appropriate type. A box-list will create a box field for each character of the passed text.  Default is "text".
- **default_value**: The default value for the field. Default is nil.

TextField options:

- **font_size**: A number in pixels (i.e. 13), or auto to change the font to fit the field size. Default is 10px.
- **font_name**: The name of the font to use. Default: "Helvetica"
- **italic**: True or false. Makes the text italic when set to true. Default to false.
- **bold**: True or false. Makes the text bold when set to true. Default is false.
- **alignment**: "left", "center" or "right". Aligns the text in the boundaries of the field. Default is "left".
- **multi_line**: True or false. Forces the text to wrap to the next line when it hits the boundaries of the field. Default is false.
- **padding**: An array of 4 numbers, representing top, right, bottom, left. It adds padding in pdf units inside the field.
- **valign**: Defines vertical alignment of the text in the box, top, center, or bottom.
- **leading**: When multi_line is true, this will add top_margin to each wrapped line of text.

```ruby
page 1 do
  text_field :country, [10, 20], [200, 400], { default_value: "USA", font_size: 13, bold: true, alignment: left, multi_line:true }
end
```


##### Using default options
You may use the with_default_options method to set a context for options for all
further method calls within the block
- **with_default_options**: Sets the default options for all items within the block

```ruby
page 1, alignment: "left" do
  text_field :aligned_left, [10,20], [100,50]
  with_default_options :alignment => "right" do
    text_field :aligned_right, [40,60], [100,50]
  end
end

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

#### Boxed Characters
This is a field which helps you to display a field which needs to be printed
in a boxed fashion.  E.g. [H][E][L][L][O]-[W][O][R][L][D].

```ruby
boxed_characters :name, [10,20], 20, {box_spacing: 1, box_width: 10} do
  characters 4
  space 2
  characters 4
end
```

Boxed Characters options:

- **box_spacing**: Required, amount of space between each individual box
- **box_width**: Required, the width of each individual box
- **other**: You may use any of the options that are also in use with text_field
EXCEPT for alignment, and multi-line.

#### Tables

```ruby
class MyDoc < PdfTempura::Document
  page 1 do
    table :stuff, [500,50], height: 300, number_of_rows: 10, row_height: 25, cell_padding: 1 do
      text_column :pin, 50
      space 5
      checkbox_column :last_name, 100
    end
  end
end
```

The table construct allows the creation of a repeating set of fields.

Table options:

- **height**: Optional, height of the overall table.
- **number_of_rows**: The number of rows in the table, required
- **row_height**: The height of each row
- **cell_padding**: Padding between each cell, optional

The `table` call takes a name, the x,y position of the top-left corner
of the table, the number of rows, either row_height or height (or both), and
cell padding.

Inside the table block, you define columns or spaces.  Columns themselves have
amalgamous names to those you may use in "page" to describe fields.  Use
"text_column" for a column containing text, "checkbox_column" for a cell
containing a checkbox.

Space only takes one parameter, its width.

Column mimicks 'field', except you only specify the width of the column,
the rest is figured out by the table.

##### Assigning Table Data

Table data is assigned through assigning an array of hashes to the key
named after the name of the table.

eg:

```ruby
data = {
 1 => {
   stuff: [
     {:pin => "12 3456789 6", :last_name => "Doe"}
   ]
 }
}
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

### Repeating data
If you would like the template you have specified to be repeated on matching pages
then you need to use the "repeatable" option in your Document class.  If repeatable is set
then if you specify pages 1,2 in your document, and then specify 1,2,3,4 in your data
the produced page will reuse the template's page 1 for page 3 and page 2 for page 4, etc.
```ruby
class MyPdf < PdfTempura::Document

  template "/some/path/to/template.pdf"
  repeatable

  ...

end
data = {1 => ... data for page 1,
        2 => ... data for page 2,
        3 => ... data for page 3,
        4 => ... data for page 4}
```

### FieldSets
A fieldset allows you to group pieces of data under a particular heading.  You
define a fieldset simply by the name of the heading it will be contained under
in the data.  This is to help you organize your data logically.  You may also
specify default options by passing an options hash into the field_set call.

```ruby
class MyPdf < PdfTempura::Document
  ...

  page 1 do
    field_set "customer",font_size: 12 do
      text_field "name",[0,0],[10,20]
      text_field "address", [0,10],[10,20]
    end
  end

end

data = {
  1 => {
    "customer" => { "name" => "John Bazdaritch", "address" => "123 Hollywood Blvd" }
  }
}

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
