import 'package:festival_app/colors.dart';
import 'package:festival_app/components/custom_feild_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(height: 0.12.sh),
              Center(
                child: Container(
                  width: 0.3.sw,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28.r),
                    child: Image.asset(
                      "assets/images/avatar.png",
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: Icon(
                            Icons.person,
                            size: 48.sp,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "Hi ! 新朋友",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w800),
              ),
              Text(
                "请登录",
                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w100),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.only(right: 70.w),
                child: const CustomInputField(
                  label: "手机号",
                  value: "159****5655",
                ),
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.only(right: 70.w),
                child: const CustomInputField(
                  label: "验证码",
                  value: "666688",
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                width: 137.w,
                height: 54.h,
                decoration: BoxDecoration(
                  color: AppColors.loginButton,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '登录 ',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 21.sp,
                      ),
                    ),
                    Image.asset(
                      'assets/images/login/ArrowRightContained2.png',
                      width: 20.w,
                      height: 20.h,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 35.h),
              Padding(
                padding: EdgeInsets.only(left: 70.w),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/loginOther');
                  },
                  child: const CustomInputFieldRigte(
                    label: "其他方式登录",
                    value: "",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 250.w),
                child: Text(
                  "无法使用？试试别的方法",
                  style: TextStyle(color: Color(0xFF7B7B7B), fontSize: 10.sp),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.scale(
                scale: 0.8,
                child: Checkbox(
                  value: _isSelected,
                  onChanged: (bool? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _isSelected = newValue;
                      });
                    }
                  },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: CircleBorder(
                    side: BorderSide(
                      color: Colors.grey[600]!,
                      width: 2.w,
                    ),
                  ),
                  checkColor: Colors.white,
                  activeColor: Colors.blue,
                  side: BorderSide(
                    color: Colors.grey[800]!,
                    width: 2.w,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.w),
                  child: Text.rich(
                    TextSpan(
                      text: '我已阅读并同意',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12.sp,
                      ),
                      children: [
                        TextSpan(
                          text: '《用户协议》',
                          style: TextStyle(color: Colors.blue, fontSize: 12.sp),
                        ),
                        TextSpan(
                          text: '《隐私政策》',
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        TextSpan(
                          text: '《儿童/青少年个人信息保护规则》',
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
