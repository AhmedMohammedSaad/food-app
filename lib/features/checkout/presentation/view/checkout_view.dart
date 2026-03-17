import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_style.dart';
import '../widgets/checkout_footer_section.dart';
import '../widgets/checkout_order_summary_section.dart';
import '../widgets/delivery_address_section.dart';
import '../widgets/payment_method_section.dart';
import '../widgets/promo_code_section.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Checkout',
          style: AppTextStyle.font18SemiBoldCharcoal,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            DeliveryAddressSection(),
            PaymentMethodSection(),
            PromoCodeSection(),
            CheckoutOrderSummarySection(
              subtotal: 29.97,
              deliveryFee: 2.99,
              tax: 1.50,
              total: 34.46,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: const CheckoutFooterSection(),
    );
  }
}
