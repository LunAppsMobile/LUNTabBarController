Pod::Spec.new do |s|
  s.name         = 'LUNTabBarController'
  s.version      = '1.0.2'
  s.summary      = 'UITabBarController subclass designed to add cool floating from the bottom animation with scale effect to one of your tabs.'
  s.description  = 'UITabBarController subclass designed to add cool floating from the bottom animation with scale effect that adds feeling of 3D to one of your tabs.'
  s.screenshots  = 'https://lunapps.com/blog/wp-content/uploads/2016/02/LUNTabBarController_animation.gif'
  s.homepage     = 'https://github.com/LunApps/LUNTabBarController'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Victor Sharavara' => 'victor.sharavara@gmail.com' }
  s.platform     = :ios, '8.0'
  s.source       = { :git => 'https://github.com/LunApps/LUNTabBarController.git', :tag => '1.0.2' }
  s.source_files = 'LUNTabBarController/**/*.{h,m}'
  s.requires_arc = true
end
