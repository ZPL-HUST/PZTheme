Pod::Spec.new do |s|
  s.name             = 'PZTheme'
  s.version          = '0.2.0'
  s.summary          = '一套代码搞定iOS13暗黑模式和iOS13以下自定义黑白样式适配，并支持控件单独配置（自动/暗黑/明亮）'
  s.homepage         = 'https://github.com/ZPL-HUST/PZTheme'
  s.license          = 'MIT'
  s.author           = { 'paul' => 'zpl_hust@qq.com' }
  s.platform     	 = :ios, '8.0'
  s.source           = { :git => 'https://github.com/ZPL-HUST/PZTheme.git', :tag => s.version.to_s }
  s.source_files     = 'PZTheme/*.{h,m}'
end
