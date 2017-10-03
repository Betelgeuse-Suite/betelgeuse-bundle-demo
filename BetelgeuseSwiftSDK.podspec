Pod::Spec.new do |s|
s.name = 'BetelgeuseSwiftSDK'
s.version = '11.1.0'
s.license = { :type => 'MIT' }
s.summary = 'Betelguse Sample Swift SDK'

s.homepage = 'https://github.com/GabrielCTroia/beetlejuice-sample-repo1.git'
s.author = { name: 'Gabriel C. Troia', 'email' => 'gabriel@jackpocket.com' }

s.source = { :git => 'https://github.com/GabrielCTroia/beetlejuice-sample-repo1.git', :tag => "v#{s.version}" }
s.source_files = 'BetelgeuseSwiftSDK/BetelgeuseSwiftSDK/*.swift'
s.ios.deployment_target = '8.0'
# s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.0' }

# s.dependency 'Alamofire', '~> 4.4.0'
# s.dependency 'SwiftyJSON', '~> 3.1.4'

end 