import 'package:caferesto/features/shop/models/cart_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../personalization/models/address_model.dart';

class OrderModel {
  final String id;
  final String userId;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? address;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;

  OrderModel({
    required this.id,
    this.userId = '',
    required this.status,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
    this.paymentMethod = 'Payement à la caisse',
    this.deliveryDate,
    this.address,
  });

  /// Format the order date
  String get formattedOrderDate =>
      DateFormat('yyyy-MM-dd – kk:mm').format(orderDate);

  /// Format the delivery date if available
  String get formattedDeliveryDate => deliveryDate != null
      ? DateFormat('yyyy-MM-dd – kk:mm').format(deliveryDate!)
      : 'N/A';

  /// Human-readable order status
  String get orderStatusText {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }

  /// Convert model to JSON (for Firestore)
  Map<String, dynamic> toJson() {
    return {
      'UserId': userId,
      'PaymentMethod': paymentMethod,
      'Status': status.name, // save as string
      'TotalAmount': totalAmount,
      'OrderDate': orderDate.toIso8601String(),
      'DeliveryDate': deliveryDate?.toIso8601String(),
      'Address': address?.toJson(),
      'Items': items.map((item) => item.toJson()).toList(),
    };
  }

  /// Create model from Firestore document
  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return OrderModel.fromJson(data, snapshot.id);
  }

  /// Create model from JSON with id
  factory OrderModel.fromJson(Map<String, dynamic> data, String id) {
    return OrderModel(
      id: id,
      userId: data['UserId'] ?? '',
      paymentMethod: data['PaymentMethod'] ?? '',
      status: _statusFromString(data['Status']),
      totalAmount: (data['TotalAmount'] as num).toDouble(),
      orderDate: DateTime.parse(data['OrderDate']),
      deliveryDate: data['DeliveryDate'] != null
          ? DateTime.tryParse(data['DeliveryDate'])
          : null,
      address: data['Address'] != null
          ? AddressModel.fromJson(data['Address'])
          : null,
      items: (data['Items'] as List<dynamic>)
          .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Helper to parse string to enum
  static OrderStatus _statusFromString(String? status) {
    switch (status) {
      case 'pending':
        return OrderStatus.pending;
      case 'processing':
        return OrderStatus.processing;
      case 'shipped':
        return OrderStatus.shipped;
      case 'delivered':
        return OrderStatus.delivered;
      case 'cancelled':
        return OrderStatus.cancelled;
      default:
        return OrderStatus.pending;
    }
  }
}

enum OrderStatus {
  pending,
  processing,
  shipped,
  delivered,
  cancelled,
}
