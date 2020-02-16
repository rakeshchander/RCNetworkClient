
platform :ios, '11.0'

use_frameworks!
inhibit_all_warnings!


source 'https://github.com/CocoaPods/Specs.git'

plugin 'cocoapods-art', :sources => [

'comviva-cocoapods'

]

def target_pods
  pod 'SwiftLint'
end

target 'Module_Framework' do
  target_pods
end

target 'Module_FrameworkTests' do
  target_pods
end

target 'Module_Framework_Sample' do
  target_pods
end

target 'Module_Framework_SampleUITests' do
  target_pods
end
