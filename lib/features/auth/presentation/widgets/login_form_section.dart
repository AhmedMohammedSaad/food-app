import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/presentation/view/widgets/app_default_button.dart';
import '../../../../core/presentation/view/widgets/app_default_text_form_field.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/theme/app_text_style.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class LoginFormSection extends StatefulWidget {
  const LoginFormSection({super.key});

  @override
  State<LoginFormSection> createState() => _LoginFormSectionState();
}

class _LoginFormSectionState extends State<LoginFormSection> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
            controller: _emailController,
            label: "Email",
            hintText: "Enter your email",
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 24.h),
          AppDefaultTextFormField(
            controller: _passwordController,
            label: "Password",
            hintText: "Enter your password",
            prefixIcon: Icons.lock_outline,
            isPassword: true,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => Navigator.pushNamed(
                context,
                Routes.forgotPassword,
              ),
              child: Text(
                "Forgot Password?",
                style: AppTextStyle.font14BoldPrimary,
              ),
            ),
          ),
          SizedBox(height: 24.h),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return AppDefaultButton(
                text: "Login",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<AuthCubit>().login(
                          _emailController.text,
                          _passwordController.text,
                        );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
