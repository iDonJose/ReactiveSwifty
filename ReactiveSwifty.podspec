#  Validate Podspec by running 'pod spec lint <Framework>.podspec'
#  Podspec attributes : http://docs.cocoapods.org/specification.html
#  Podspecs examples : https://github.com/CocoaPods/Specs/

Pod::Spec.new do |s|

    s.name         = "ReactiveSwifty"
    s.version      = "1.0.1"
    s.summary      = "Enhances streams of values provided by ReactiveSwift"
    s.description  = <<-DESC
                        Overloads `ReactiveSwift` for better streaming of values, allowing for high productivity.
                        DESC
    s.homepage     = "https://github.com/iDonJose/ReactiveSwifty"
    s.source       = { :git => "https://github.com/iDonJose/ReactiveSwifty.git", :tag => "#{s.version}" }

    s.license      = { :type => "Apache 2.0", :file => "LICENSE" }

    s.author       = { "iDonJose" => "donor.develop@gmail.com" }


    s.ios.deployment_target = "8.0"

    s.source_files  = "Sources/**/*.{h,swift}"

    s.frameworks = "Foundation"
    s.dependency "ReactiveSwift", "~> 4.0"

end
