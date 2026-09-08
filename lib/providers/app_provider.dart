import 'package:flutter/foundation.dart';

class OrderItem {
  final String id;
  final String title;
  final String subtitle;
  final double price;
  final String status;
  final String time;

  OrderItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.status,
    required this.time,
  });
}

class ChatMessage {
  final String sender;
  final String text;
  final String time;
  final bool isMe;

  ChatMessage({
    required this.sender,
    required this.text,
    required this.time,
    required this.isMe,
  });
}

class AppProvider with ChangeNotifier {
  int _currentBottomNavIndex = 0;
  int get currentBottomNavIndex => _currentBottomNavIndex;

  void setBottomNavIndex(int index) {
    _currentBottomNavIndex = index;
    notifyListeners();
  }

  final List<OrderItem> _orders = [
    OrderItem(
      id: 'ORD-9021',
      title: 'طلب مسبق - برجر كلاسيك الفاخر',
      subtitle: 'الكمية: 1 - استلام من: برجر هاوس',
      price: 8.50,
      status: 'مؤكد وجارِ التجهيز',
      time: '02:30 م',
    ),
    OrderItem(
      id: 'ORD-8812',
      title: 'حجز طلب - سبانش لاتيه بارد',
      subtitle: 'الكمية: 2 - استلام من: كافيه روستري',
      price: 8.40,
      status: 'قيد التجهيز',
      time: '11:15 ص',
    ),
  ];

  List<OrderItem> get orders => _orders;

  void addOrder(OrderItem order) {
    _orders.insert(0, order);
    notifyListeners();
  }

  final List<ChatMessage> _messages = [
    ChatMessage(
      sender: 'المتجر',
      text: 'أهلاً بك! تم استلام طلبك وجارٍ تحضيره لتستلمه في الوقت المحدد.',
      time: '10:00 ص',
      isMe: false,
    ),
    ChatMessage(
      sender: 'أنا',
      text: 'ممتاز، سأصل للاستلام بعد قليل إن شاء الله.',
      time: '10:02 ص',
      isMe: true,
    ),
  ];

  List<ChatMessage> get messages => _messages;

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;
    _messages.add(
      ChatMessage(
        sender: 'أنا',
        text: text,
        time: 'الآن',
        isMe: true,
      ),
    );
    notifyListeners();
  }
}
