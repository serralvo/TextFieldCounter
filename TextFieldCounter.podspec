Pod::Spec.new do |s|

  s.name         = "TextFieldCounter"
  s.version      = "1.0.3"
  s.summary      = "UITextField character counter with lovable UX 💖. No math skills required 🙃."
  s.description  = <<-DESC
		   Set max length of UITextField,
                   Show a beautiful and animated label about the limits
                   Easy setup with @IBInspectable
                   DESC
  s.homepage     = "https://github.com/serralvo/TextFieldCounter"
  s.screenshots  = "https://github.com/serralvo/TextFieldCounter/blob/master/Images/inspector.png?raw=true"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Fabricio Serralvo" => "fabricio.serralvo@gmail.com" }
  s.social_media_url   = "http://serralvo.co"

  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/serralvo/TextFieldCounter.git", :tag => "#{s.version}" }
  s.requires_arc = true
  s.swift_versions = "5.0"

  s.source_files  = "TextFieldCounter.swift"
  s.exclude_files = "TextFieldCounter"
 
end
