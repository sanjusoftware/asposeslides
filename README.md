# Asposeslides

Aspose slides is a gem that helps you use the aspose slides for JAVA (http://docs.aspose.com:8082/docs/display/slidesjava/Product+Overview) library from within your ruby/rails project. This library has been tested with aspose.slides-14.9.0

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

* Create a file aspose.yml under app/config folder. This file specifies the path to your aspose slides for Java path. Put the following lines in that file:
```yaml
development:
  jar_dir: /path/to/your/asposeslides/jars/directory
test:
  jar_dir: /path/to/your/asposeslides/jars/directory
```
* Next you need to initialize the aspose library. Aspose is a paid library and therefor you need to buy the appropriate license and provide the path to the licensed java library to initialize the gem.
* Create a file called aspose.rb under the initializer app/config/initializers folder. Put the following lines in the file
```ruby
Asposeslides.configure_aspose_slides YAML.load(File.read('config/aspose.yml'))[Rails.env]
```
* Now is the time to include the required files for working with the powerpoint presentations. Following is an example of merging 2 presentations into one:
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

Lets understand the above code
1. The first line makes sure that the aspose slides is loaded and available
2. Include the files that are required to access the aspose slides
3. Initialize the libraries. The aspose JAVA classes are loaded from the path provided in the aspose.yml file
4. Next we have to start with initializing files that need to be merged. In this example, the dest_ppt, src_ppt1, src_ppt2 needs to be merged.
5. The merge_ppts method, takes the dest_ppt and the src_ppts (1 and 2) and merge them together to generate a new ppt file. The src ppts can be provided with various options.

##### Options for merge_ppts
* dest_ppt : this is the ppt in which you want merge other ppts
* The second option is an array of src_ppt hashes. The hash is as follows
```ruby
{:ppt => src_ppt1, :position => 2, :replace => true}
```
* :ppt parameter represents the ppt that needs to be merged with dest_ppt.
* :position parameter represents the index of the dest_ppt at which the slides form src_ppt needs to be inserted
* :replace parameter (default false) indicates if you want to replace the slide in dest_ppt at the given position or not.

## TODO
* Extend the gem for other slide operations like add, delete, reorder etc

## Contributing

1. Fork it ( https://github.com/sanjusoftware/asposeslides/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
