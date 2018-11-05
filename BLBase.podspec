#
# Be sure to run `pod lib lint BLBase.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BLBase'
  s.version          = '1.0.2'
  s.summary          = 'A short description of BLBase.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/boundlessocean/BLBase'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'fuhaiyang' => 'fuhaiyang@xycentury.com' }
  s.source           = { :git => 'https://github.com/boundlessocean/BLBase.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  
  s.subspec 'BLTableView' do |ss|
      ss.subspec 'Base' do |sss|
          sss.source_files = 'BLBase/Classes/BLTableView/Base/**/*'
      end
      ss.subspec 'EmptyDataSet' do |sss|
          sss.source_files = 'BLBase/Classes/BLTableView/EmptyDataSet/**/*'
          sss.dependency 'DZNEmptyDataSet'
          sss.dependency 'BLBase/BLTableView/Base'
      end
      ss.subspec 'Refresh' do |sss|
          sss.source_files = 'BLBase/Classes/BLTableView/Refresh/**/*'
          sss.dependency 'MJRefresh'
          sss.dependency 'BLBase/BLTableView/Base'
      end
  end
  
  s.subspec 'BLModel' do |ss|
      ss.source_files = 'BLBase/Classes/BLModel/**/*'
  end
  
  s.subspec 'BLView' do |ss|
      ss.source_files = 'BLBase/Classes/BLView/**/*'
  end
  
  s.subspec 'BLViewController' do |ss|
      ss.source_files = 'BLBase/Classes/BLViewController/**/*'
      ss.dependency 'Masonry'
  end
  
  s.subspec 'BLNavigationController' do |ss|
      ss.source_files = 'BLBase/Classes/BLNavigationController/**/*'
  end
  
  s.subspec 'BLTabBarController' do |ss|
      ss.source_files = 'BLBase/Classes/BLTabBarController/**/*'
  end
  
  s.subspec 'BLCell' do |ss|
      ss.source_files = 'BLBase/Classes/BLCell/**/*'
  end
end
