source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!
inhibit_all_warnings!



def pods

  pod 'ReactiveSwift', '~> 4.0'

end

def test_pods

  pod 'Quick', '~> 1.3'
  pod 'Nimble', '~> 7.3'

end



target 'ReactiveSwifty-iOS' do
  platform :ios, '8.0'

  pods

  target 'ReactiveSwifty-iOSTests' do
    inherit! :search_paths
    
    test_pods

  end

end



post_install do |installer|
  installer.pods_project.targets.each do |target|

    target.new_shell_script_build_phase.shell_script = "mkdir -p $PODS_CONFIGURATION_BUILD_DIR/#{target.name}"

    target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.2'
        config.build_settings['ENABLE_TESTABILITY'] = 'YES'
        config.build_settings['CONFIGURATION_BUILD_DIR'] = '$PODS_CONFIGURATION_BUILD_DIR'
    end

  end
end
