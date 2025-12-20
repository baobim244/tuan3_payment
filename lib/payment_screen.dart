import 'package:flutter/material.dart';
 
import 'models/payment_method.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
   
  final List<PaymentMethod> methods = [PayPal(), GooglePay(), ApplePay()];

   
  PaymentMethod? selectedMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Chọn hình thức thanh toán",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          
          Expanded(
            flex: 2,
            child: Center(
              child: selectedMethod == null
                  ? const Icon(
                      Icons.add_business_rounded,
                      size: 100,
                      color: Colors.grey,
                    )
                  : Image.network(
                      selectedMethod!.imageUrl,  
                      height: 100,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.broken_image,
                        size: 100,
                        color: Colors.red,
                      ),
                    ),
            ),
          ),

          const Divider(height: 1),

           
          Expanded(
            flex: 3,
            child: ListView(
              children: methods.map((method) {
                return RadioListTile<PaymentMethod>(
                  title: Text(
                    method.name,
                    style: const TextStyle(fontSize: 16),
                  ),
                   
                  secondary: Image.network(
                    method.imageUrl,
                    width: 40,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.image),
                  ),
                  value: method,
                  groupValue: selectedMethod,
                  onChanged: (value) {
                    setState(() {
                      selectedMethod = value;
                    });
                  },
                );
              }).toList(),
            ),
          ),

          
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: ElevatedButton(
              onPressed: selectedMethod == null
                  ? null
                  : () => selectedMethod!.processPayment(),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Continue", style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
