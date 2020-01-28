Pod::Spec.new do |s|
  s.name             = "Segment-Apptimize"
  s.version          = "0.3.0"
  s.summary          = "Apptimize Integration for Segment's analytics-ios library."

  s.description      = <<-DESC
                       Analytics for iOS provides a single API that lets you
                       integrate with over 100s of tools.
                       This is the Apptimize integration for the iOS library.
                       DESC

  s.homepage         = "http://apptimize.com"
  s.license          =  { :type => 'MIT' }
  s.author           = { "Apptimize" => "support@apptimize.com" }
  s.source           = { :git => "https://github.com/Apptimize/analytics-ios-integration-apptimize.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/apptimizeAB'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Segment-Apptimize/Classes/**/*'

  s.dependency 'Analytics', '~> 3.0'
  s.dependency 'Apptimize', '~> 3.0'
end
