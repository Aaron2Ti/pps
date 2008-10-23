1. 解压ruby-1.8.6-i386-mswin32, 注意解压后的路径应不含有中文.
   例: C:\ruby-1.8.6-i386-mswin32

2. 将C:\ruby-1.8.6-i386-mswin32\bin加入到环境变量的PATH中.

3. 配置config目录下的environment.rb文件,
    APP_ROOT = '<应用程序根目录的绝对路径>'

3. 打开cmd, 切换到应用程序根目录, 输入
    rake db:migrate
    ruby script\server -p 3000

4. 打开浏览器, 输入地址
   http://localhost:3000

5. 在线浏览3D图形需安装VRML插件, 在主页左下角"3D预览插件"处下载安装.

6. 本程序需要在服务器端安装Solidworks, 建议安装Solidworks 2008 sp1.