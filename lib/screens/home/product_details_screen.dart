import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String title;
  final String store;
  final double price;

  const ProductDetailsScreen({
    super.key,
    required this.title,
    required this.store,
    required this.price,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _quantity = 1;
  final _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final totalPrice = widget.price * _quantity;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(
                Icons.fastfood_rounded,
                size: 80,
                color: Color(0xFF1E3A8A),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  '${widget.price.toStringAsFixed(2)} \$',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0D9488),
                  ),
                ),
              ],
            ),
            Text(
              widget.store,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            const Text(
              'طريقة الاستلام:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 6),
            const Text(
              'حجز وطلب مسبق يتم إعداده فوراً في المتجر لتستلمه جاهزاً مباشرة فور وصولك.',
              style: TextStyle(color: Colors.black87, height: 1.5),
            ),
            const SizedBox(height: 20),
            const Text(
              'الكمية:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton.filledTonal(
                  onPressed: () {
                    if (_quantity > 1) setState(() => _quantity--);
                  },
                  icon: const Icon(Icons.remove),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    '$_quantity',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton.filledTonal(
                  onPressed: () => setState(() => _quantity++),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 18),
            TextField(
              controller: _notesController,
              decoration: InputDecoration(
                labelText: 'ملاحظات إضافية للمتجر (اختياري)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            context.read<AppProvider>().addOrder(
                  OrderItem(
                    id: 'ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
                    title: widget.title,
                    subtitle: 'الكمية: $_quantity - استلام من: ${widget.store}',
                    price: totalPrice,
                    status: 'مؤكد وجارِ التجهيز',
                    time: 'الآن',
                  ),
                );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم تأكيد طلبك المسبق بنجاح!')),
            );
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E3A8A),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          child: Text(
            'تأكيد الطلب المسبق (${totalPrice.toStringAsFixed(2)} \$)',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
