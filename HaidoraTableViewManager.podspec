Pod::Spec.new do |s|
  s.name             = "HaidoraTableViewManager"
  s.version          = "2.0.4"
  s.summary          = "a wrapper for UITableView."
  s.description      = <<-DESC
                      a wrapper for UITableViewDatasource and UITableViewDelegate.
                       DESC
  s.homepage         = "https://github.com/Haidora/HaidoraTableViewManager"
  s.license          = 'MIT'
  s.author           = { "mrdaios" => "mrdaios@gmail.com" }
  s.source           = { :git => "https://github.com/Haidora/HaidoraTableViewManager.git", :tag => s.version.to_s }
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'Pod/Classes/**/*'
#s.resource_bundles = {
#    'HaidoraTableViewManager' => ['Pod/Assets/*.png']
#  }
  s.frameworks = 'UIKit', 'Foundation'
end
