import 'package:flutter/material.dart';

abstract class PaymentMethod {
  final String name;
  final String imageUrl;

  PaymentMethod({required this.name, required this.imageUrl});

  void processPayment();
}

class PayPal extends PaymentMethod {
  PayPal()
    : super(
        name: 'PayPal',
        imageUrl:
            'https://cdn.pixabay.com/photo/2018/05/08/21/29/paypal-3384015_640.png',
      );

  @override
  void processPayment() => debugPrint("Đang xử lý qua hệ thống PayPal...");
}

class GooglePay extends PaymentMethod {
  GooglePay()
    : super(
        name: 'Google Pay',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRb5LOPUgzjbz_m4aVulC-GU5zu-30HBdYnAg&s',
      );

  @override
  void processPayment() => debugPrint("Đang kết nối Google Pay...");
}

class ApplePay extends PaymentMethod {
  ApplePay()
    : super(
        name: 'Apple Pay',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfp_3jN-zgVDJzWjr1I4lKWWRothBbWHb8hQ&s',
      );

  @override
  void processPayment() => debugPrint("Xác thực FaceID cho Apple Pay...");
}

void main() {
  runApp(
    const MaterialApp(home: PaymentScreen(), debugShowCheckedModeBanner: false),
  );
}

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
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: selectedMethod == null
                  ? const Icon(
                      Icons.add_card_rounded,
                      size: 100,
                      color: Colors.grey,
                    )
                  : Image.network(
                      selectedMethod!.imageUrl,
                      height: 120,
                      fit: BoxFit.contain,

                      loadingBuilder: (context, child, loading) =>
                          loading == null
                          ? child
                          : const CircularProgressIndicator(),
                      errorBuilder: (context, error, stack) => const Icon(
                        Icons.broken_image,
                        size: 100,
                        color: Colors.red,
                      ),
                    ),
            ),
          ),

          const Divider(thickness: 1, indent: 20, endIndent: 20),

          Expanded(
            flex: 3,
            child: ListView(
              children: methods
                  .map(
                    (method) => RadioListTile<PaymentMethod>(
                      title: Text(
                        method.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      secondary: Image.network(method.imageUrl, width: 45),
                      value: method,
                      groupValue: selectedMethod,
                      activeColor: Colors.blueAccent,
                      onChanged: (value) {
                        setState(() {
                          selectedMethod = value;
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            child: ElevatedButton(
              onPressed: selectedMethod == null
                  ? null
                  : () {
                      selectedMethod!.processPayment();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Bạn đã chọn ${selectedMethod!.name}"),
                        ),
                      );
                    },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
              ),
              child: const Text(
                "Continue",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
