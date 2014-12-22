# Asposeslides

Aspose slides is a gem that helps you use the aspose slides for JAVA (http://docs.aspose.com:8082/docs/display/slidesjava/Product+Overview) library from within your ruby/rails project.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'asposeslides'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install asposeslides

## Usage : Rails app

1. Create a file aspose.yml under app/config folder. This file specifies the path to your aspose slides for Java path. Put the following lines in that file:
```yaml
development:
  jar_dir: /path/to/your/asposeslides/jars/directory
test:
  jar_dir: /path/to/your/asposeslides/jars/directory
```

2. Next you need to initialize the aspose library. Aspose is a paid library and therefor you need to buy the appropriate license and provide the path to the licensed java library to initialize the gem.
3. Create a file called aspose.rb under the initializer app/config/initializers folder. Put the following lines in the file

```ruby
Asposeslides.configure_aspose_slides YAML.load(File.read('config/aspose.yml'))[Rails.env]
```
4. Now is the time to include the required files for working with the powerpoint presentations. Following is an example of merging 2 presentations into one:

```ruby
require 'asposeslides'

include Asposeslides
include Asposeslides::Powerpoint
initialize_aspose

dest_ppt = File.join('dest_template.pptx')
src_ppt1 = File.join('src_template1.pptx')
src_ppt2 = File.join('src_template2.pptx')
merged_ppt = merge_ppts(dest_ppt, [{:ppt => src_ppt1, :position => 2, :replace => true}, {:ppt => src_ppt2, :position => 5, :replace => true}])
merged_ppt.save("merged.pptx",3)
```

## Contributing

1. Fork it ( https://github.com/sanjusoftware/asposeslides/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
