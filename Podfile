source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '8.0'

#use_frameworks!
inhibit_all_warnings!

workspace 'iOS_KnowledgeStructure.xcworkspace'

target "iOS_KnowledgeStructure" do
    
   platform :ios, "9.0"

   pod 'GRMustache', '~> 7.3.2' #//模版渲染
   pod 'WebViewJavascriptBridge', '~> 6.0' #//本地与js调用
   pod 'DZNEmptyDataSet' #空列表占位视图
   pod 'MJRefresh' #空列表占位视图
   
   pod 'GCDWebServer', '~> 3.0'#模拟服务器
   pod 'GCDWebServer/WebUploader', '~> 3.0'
   pod 'GCDWebServer/WebDAV', '~> 3.0'
   pod 'BottomComponentLib',:path=>"../BottomComponentLib"#,:testspecs => ['BottomComponentLibTests']
end

target 'iOS_KnowledgeStructureUITests' do
    pod 'KIF'
end


post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            #关闭 Enable Modules
            config.build_settings['CLANG_ENABLE_MODULES'] = 'NO'
            # 在生成的 Pods 项目文件中加入 CC 参数，路径的值根据你自己的项目来修改
            config.build_settings['CC'] = '$(PODS_ROOT)/../ccache-clang++'
        end
    end
end

