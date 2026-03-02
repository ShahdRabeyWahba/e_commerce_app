import 'package:e_commerce_app/core/localization/app_localizations.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/core/utils/prefs_helper.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  final _passwordController = TextEditingController(text: "1234567890123");
  late TextEditingController _mobileController;
  late TextEditingController _addressController;
  
  String userName = "";
  String userEmail = "";
  String userPhone = "";
  String userAddress = "";

  bool _isNameEditing = false;
  bool _isEmailEditing = false;
  bool _isPasswordEditing = false;
  bool _isMobileEditing = false;
  bool _isAddressEditing = false;

  @override
  void initState() {
    super.initState();
    importPrefsData();
  }

  void importPrefsData() {
    setState(() {
      userName = PrefsHelper.getUserName() ?? "User";
      userEmail = PrefsHelper.getUserEmail() ?? "user@example.com";
      userPhone = PrefsHelper.getUserPhone() ?? "01122118855";
      userAddress = PrefsHelper.getUserAddress() ?? "6th October, street 11.....";
      
      _nameController = TextEditingController(text: userName);
      _emailController = TextEditingController(text: userEmail);
      _mobileController = TextEditingController(text: userPhone);
      _addressController = TextEditingController(text: userAddress);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          Text("${AppLocalizations.of(context).welcome}, ${userName.split(' ').first}", style: AppStyles.blueSemi20),
          SizedBox(height: 4.h),
          Text(userEmail, style: AppStyles.blackReg14.copyWith(color: AppColors.textColor.withValues(alpha: 0.6))),
          SizedBox(height: 32.h),

          _buildProfileField(
            label: AppLocalizations.of(context).full_name,
            controller: _nameController,
            isEditing: _isNameEditing,
            onEdit: () {
              if (_isNameEditing) {
                // Save logic
                setState(() {
                  userName = _nameController.text;
                });
                PrefsHelper.saveUser(userName, userEmail);
              }
              setState(() => _isNameEditing = !_isNameEditing);
            },
          ),
          
          _buildProfileField(
            label: AppLocalizations.of(context).email_address,
            controller: _emailController,
            isEditing: _isEmailEditing,
            onEdit: () {
              if (_isEmailEditing) {
                // Save logic
                setState(() {
                  userEmail = _emailController.text;
                });
                PrefsHelper.saveUser(userName, userEmail);
              }
              setState(() => _isEmailEditing = !_isEmailEditing);
            },
          ),
          
          _buildProfileField(
            label: AppLocalizations.of(context).your_password,
            controller: _passwordController,
            isEditing: _isPasswordEditing,
            obscureText: true,
            onEdit: () => setState(() => _isPasswordEditing = !_isPasswordEditing),
          ),
          
          _buildProfileField(
            label: AppLocalizations.of(context).mobile_number,
            controller: _mobileController,
            isEditing: _isMobileEditing,
            onEdit: () {
              if (_isMobileEditing) {
                setState(() {
                  userPhone = _mobileController.text;
                });
                PrefsHelper.saveUser(userName, userEmail, phone: userPhone, address: userAddress);
              }
              setState(() => _isMobileEditing = !_isMobileEditing);
            },
          ),
          
          _buildProfileField(
            label: AppLocalizations.of(context).address,
            controller: _addressController,
            isEditing: _isAddressEditing,
            onEdit: () {
              if (_isAddressEditing) {
                setState(() {
                  userAddress = _addressController.text;
                });
                PrefsHelper.saveUser(userName, userEmail, phone: userPhone, address: userAddress);
              }
              setState(() => _isAddressEditing = !_isAddressEditing);
            },
          ),
          
          SizedBox(height: 20.h),
          
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                await PrefsHelper.removeToken();
                // Clear user details too
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('userName');
                await prefs.remove('userEmail');
                
                if (context.mounted) {
                  Navigator.pushNamedAndRemoveUntil(context, AppRoutes.loginScreenRoute, (route) => false);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
              ),
              child: Text(AppLocalizations.of(context).logout, style: AppStyles.whiteMedium18),
            ),
          ),
          
          SizedBox(height: 100.h), // Provide spacing for bottom navigation bar
        ],
      ),
    );
  }

  Widget _buildProfileField({
    required String label,
    required TextEditingController controller,
    required bool isEditing,
    required VoidCallback onEdit,
    bool obscureText = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppStyles.blueMedium18),
          SizedBox(height: 12.h),
          TextFormField(
            controller: controller,
            enabled: isEditing,
            obscureText: obscureText && !isEditing,
            style: AppStyles.blackReg14.copyWith(color: AppColors.textColor),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
              suffixIcon: IconButton(
                icon: Icon(isEditing ? Icons.check : Icons.mode_edit_outline_outlined, color: AppColors.mainColor),
                onPressed: onEdit,
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide(color: AppColors.mainColor.withValues(alpha: 0.3), width: 1.w),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide(color: AppColors.mainColor.withValues(alpha: 0.3), width: 1.w),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide(color: AppColors.mainColor, width: 1.5.w),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
