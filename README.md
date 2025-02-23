# festival_app

A new Flutter project.



//dart工具 序列化model
 dart run build_runner build --delete-conflicting-outputs

 flutter pub run build_runner build --delete-conflicting-outputs

 监听器 
 dart run build_runner watch --delete-conflicting-outputs 启动监听



先构建一个 release 版本的 APK，然后验证签名。按以下步骤操作：
首先构建 release APK：
flutter build apk --release
APK 将会生成在这个位置：
D:\flutter-project\festival_app\build\app\outputs\flutter-apk\app-release.apk
然后验证 APK 的签名：
keytool -printcert -jarfile build/app/outputs/flutter-apk/app-release.apk
或者使用这个命令来查看详细的签名信息：
keytool -list -v -keystore my-release-key.keystore -alias key_alias -storepass 



================APP 签名================

// 创建签名
keytool -genkey -v -keystore my-release-key.keystore -alias key_alias -keyalg RSA -keysize 2048 -validity 10000 -storepass  -keypass  -dname "CN=mo.festivalre, OU=milcomo, O=milcomo, L=Unknown, ST=Unknown, C=CN"

// 查看签名
keytool -list -v -keystore my-release-key.keystore -alias key_alias -storepass 

// 删除签名
keytool -delete -alias key_alias -keystore my-release-key.keystore -storepass 

// 导出签名
keytool -exportcert -alias key_alias -keystore my-release-key.keystore -storepass  -file my-release-key.cer


运行展示
<img src="https://oss.milcomo.cn/milco/all/img/2025-02-23/202502231740312268706695.jpg" alt=""> 
<img src="https://oss.milcomo.cn/milco/all/img/2025-02-23/202502231740312312291351.jpg" alt=""> 
<img src="https://oss.milcomo.cn/milco/all/img/2025-02-23/202502231740312333982388.jpg" alt=""> 
<img src="https://oss.milcomo.cn/milco/all/img/2025-02-23/202502231740312346235560.jpg" alt=""> 
<img src="https://oss.milcomo.cn/milco/all/img/2025-02-23/202502231740312358170787.jpg" alt=""> 