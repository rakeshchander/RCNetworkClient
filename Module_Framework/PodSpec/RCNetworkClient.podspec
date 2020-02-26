Pod::Spec.new do |s|
  s.name         = "RCNetworkClient"
  s.version      = "0.1.0"
  s.summary      = "RCNetworkClient"
  s.description  = <<-DESC
  RCNetworkClient - setup description.
                   DESC
  s.homepage     = ""
  s.license      = ""
  s.author       = { "Rakesh" => "rakeshchander.cse@gmail.com" }
  s.platform     = :ios, "11.0"
  s.source       = { :http => ""}
  s.preserve_paths = "RCNetworkClient.xcframework"
  s.vendored_frameworks = "RCNetworkClient.xcframework"
  s.requires_arc = true

end
