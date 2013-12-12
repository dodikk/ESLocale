Pod::Spec.new do |s|
  s.name         = "ESLocale"
  s.version      = "1.0"
  s.summary      = "ESLocale"
  s.description  = "bla bla bla bla bla bla v bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla"
  s.homepage     = "https://github.com/dodikk/ESLocale.git"
  s.license      = 'some licence info'
  s.source       = { :git => "https://github.com/dodikk/ESLocale.git",}

  s.authors       =  {'name1' => 'mail1@mail.com'}
  
  s.ios.header_mappings_dir = 'ESLocale'
  
  s.ios.source_files = "ESLocale/**/*.{c,cpp,mm,h,m}"
  
  s.ios.platform          = :ios, '6.0'
  s.ios.deployment_target = '6.0'
  s.ios.prefix_header_file = 'ESLocale/ESLocale-Prefix.pch'
    
  s.ios.frameworks = 'Foundation'
  s.ios.libraries = 'sqlite3', 'c++', 'stdc++'
  
end
