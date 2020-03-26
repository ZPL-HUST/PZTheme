Pod::Spec.new do |s|
  s.name             = 'PZTheme'
  s.version          = '0.1.0'
  s.summary          = '用一套代码去实现iOS13明亮/暗黑模式和iOS13以下黑白版样式适配.'
  s.homepage         = 'https://github.com/ZPL-HUST/PZTheme'
  s.license          = 'MIT'
  s.author           = { 'paul' => 'zpl_hust@qq.com' }
  s.platform     	 = :ios, '8.0'
  s.source           = { :git => 'https://github.com/ZPL-HUST/PZTheme.git', :tag => s.version.to_s }
  s.source_files     = 'PZTheme/*.{h,m}'
end
