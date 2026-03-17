import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/presentation/view/widgets/app_default_button.dart';
import '../../../../core/presentation/view/widgets/app_default_text_form_field.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/app_text_style.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class RegisterFormSection extends StatefulWidget {
  const RegisterFormSection({super.key});

  @override
  State<RegisterFormSection> createState() => _RegisterFormSectionState();
}

class _RegisterFormSectionState extends State<RegisterFormSection> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppDefaultTextFormField(
            controller: _nameController,
            label: "Full Name",
            hintText: "Enter your full name",
            prefixIcon: Icons.person_outline,
          ),
          SizedBox(height: 20.h),
          AppDefaultTextFormField(
            controller: _emailController,
            label: "Email",
            hintText: "Enter your email",
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 20.h),
          AppDefaultTextFormField(
            controller: _passwordController,
            label: "Password",
            hintText: "Create a password",
            prefixIcon: Icons.lock_outline,
            isPassword: true,
          ),
          SizedBox(height: 20.h),
          AppDefaultTextFormField(
            controller: _confirmPasswordController,
            label: "Confirm Password",
            hintText: "Repeat your password",
            prefixIcon: Icons.lock_outline,
            isPassword: true,
          ),
          SizedBox(height: 32.h),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return AppDefaultButton(
                text: "Create Account",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<AuthCubit>().register(
                      fullName: _nameController.text,
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                  }
                },
              );
            },
          ),
          SizedBox(height: 24.h),
          Center(
            child: TextButton(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, Routes.login),
              child: Text.rich(
                TextSpan(
                  text: "Already have an account? ",
                  style: AppTextStyle.font14RegularSlate600,
                  children: [
                    TextSpan(
                      text: "Login",
                      style: AppTextStyle.font14BoldPrimary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
