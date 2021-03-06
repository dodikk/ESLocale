Pod::Spec.new do |s|
  s.name         = "ESLocaleFramework"
  s.version      = "1.2.1"
  s.summary      = "ESLocale binary for both simulator and iOS devices"
  s.description  = "A library that helps configuring NSDateFormatter, NSCalendar and NSLocale correctly. It also contains locale aware date-time functions for SQLite."
  s.homepage     = "https://github.com/dodikk/ESLocale"
  s.license      = { :type => 'BSD', :file => 'ESLocale.framework/Resources/LICENSE.txt ' }
  s.source       = { :http => "https://github.com/dodikk/ESLocale/releases/download/v1.2.1/ESLocale.framework.zip" }
  s.authors      =  {'Alexander Dodatko' => 'dodikk88.tutor@gmail.com'}
  
  s.ios.platform          = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  s.ios.requires_arc = true  


  s.ios.preserve_paths = 'ESLocale.framework'
  s.public_header_files = 'ESLocale.framework/Headers/**/*.h'
  s.vendored_frameworks = 'ESLocale.framework'


  s.ios.frameworks = 'Foundation'
  s.ios.libraries = 'sqlite3', 'c++', 'stdc++'
end