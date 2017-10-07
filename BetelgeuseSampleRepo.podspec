Pod::Spec.new do |s|
s.name = 'BetelgeuseSampleRepo'
s.version = '12.0.0'
s.license = { :type => 'MIT', :file => 'LICENCE' }
s.summary = 'Betelguse Sample Swift SDK'

s.homepage = 'https://github.com/GabrielCTroia/beetlejuice-sample-repo1.git'
s.author = { name: 'Gabriel C. Troia', 'email' => 'catalin.troia@gmail.com' }

s.source = { :git => 'https://github.com/GabrielCTroia/beetlejuice-sample-repo1.git', :tag => "v#{s.version}" }
s.source_files = "SampleRepoSwift/SampleRepoSwift/**/*.{swift}", ".bin/Model.swift"
# s.source_files = ".bin/Model.swift"
s.resource_bundles = {
    'SampleRepoSwiftDataBundle' => [
        '.bin/Data.json'
    ]
  }

s.ios.deployment_target = '8.0'
# s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.0' }

# s.dependency 'Alamofire', '~> 4.4.0'
# s.dependency 'SwiftyJSON', '~> 3.1.4'

# This will be added when the swift client will be pushed to git
# Until then, I load it as adpendency in the client app
s.dependency 'BetelgeuseSwiftClient', '~> 0.0.6'

end