import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final _nameController = TextEditingController(text: "Mohamed Mohamed Nabil");
  final _emailController = TextEditingController(text: "mohamed.N@gmail.com");
  final _passwordController = TextEditingController(text: "1234567890123");
  final _mobileController = TextEditingController(text: "01122118855");
  final _addressController = TextEditingController(text: "6th October, street 11.....");

  bool _isNameEditing = false;
  bool _isEmailEditing = false;
  bool _isPasswordEditing = false;
  bool _isMobileEditing = false;
  bool _isAddressEditing = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          Text("Welcome, Mohamed", style: AppStyles.blueSemi20),
          SizedBox(height: 4.h),
          Text("mohamed.N@gmail.com", style: AppStyles.blackReg14.copyWith(color: AppColors.textColor.withOpacity(0.6))),
          SizedBox(height: 32.h),

          _buildProfileField(
            label: "Your full name",
            controller: _nameController,
            isEditing: _isNameEditing,
            onEdit: () => setState(() => _isNameEditing = !_isNameEditing),
          ),
          
          _buildProfileField(
            label: "Your E-mail",
            controller: _emailController,
            isEditing: _isEmailEditing,
            onEdit: () => setState(() => _isEmailEditing = !_isEmailEditing),
          ),
          
          _buildProfileField(
            label: "Your password",
            controller: _passwordController,
            isEditing: _isPasswordEditing,
            obscureText: true,
            onEdit: () => setState(() => _isPasswordEditing = !_isPasswordEditing),
          ),
          
          _buildProfileField(
            label: "Your mobile number",
            controller: _mobileController,
            isEditing: _isMobileEditing,
            onEdit: () => setState(() => _isMobileEditing = !_isMobileEditing),
          ),
          
          _buildProfileField(
            label: "Your Address",
            controller: _addressController,
            isEditing: _isAddressEditing,
            onEdit: () => setState(() => _isAddressEditing = !_isAddressEditing),
          ),
          SizedBox(height: 80.h), // Provide spacing for bottom navigation bar
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
                borderSide: BorderSide(color: AppColors.mainColor.withOpacity(0.3), width: 1.w),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide(color: AppColors.mainColor.withOpacity(0.3), width: 1.w),
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
