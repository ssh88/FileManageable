
Pod::Spec.new do |s|
  s.name             = 'FileManageable'
  s.version          = '0.1.0'
  s.summary          = 'Swift protocol to allow any conforming object to manage files with ease'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
FileManageable gives conforming objects access to various convenience functions to manage files, such:
- as checking if a file or folder exists
- deleting files
- creating folders in directories
- Getting the path for a given file or folder
- Listing all the files in a directory
- Getting the file extensions of files
- Getting the size of a file or directory
                       DESC

  s.homepage         = 'https://github.com/ssh88/FileManageable'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Shabeer Hussain' => 'shabeershussain@gmail.com' }
  s.source           = { :git => 'https://github.com/ssh88/FileManageable.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/sshdeveloper'

  s.ios.deployment_target = '8.0'
  s.source_files = 'FileManageable/Classes/**/*'

  # s.resource_bundles = {
  #   'FileManageable' => ['FileManageable/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
