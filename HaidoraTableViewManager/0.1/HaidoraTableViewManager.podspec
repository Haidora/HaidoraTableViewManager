Pod::Spec.new do |s|
  s.name         = "HaidoraTableViewManager"
  s.version      = "0.1"
  s.summary      = "a wrapper for UITableViewDatasource and UITableViewDelegate."

  s.description  = <<-DESC
                   You can only write a little code for UITableViewDatasource and UITableViewDelegate
                   DESC

  s.homepage     = "https://github.com/Haidora/HaidoraTableViewManager"
  s.license      = { :type => "BSD", :file => "LICENSE" }
  s.author       = { "mrdaios" => "mrdaios@gmail.com" }
  s.platform     = :ios, "6.0"

  s.source       = { :git => "https://github.com/Haidora/HaidoraTableViewManager.git", :branch => "developer" }
  s.source_files = 'Source/*.{h,m}'
  s.frameworks = 'Foundation','UIKit'
  s.requires_arc = true

end
