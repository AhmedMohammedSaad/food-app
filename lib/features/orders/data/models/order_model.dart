import 'package:equatable/equatable.dart';

enum OrderStatus {
  received,
  preparing,
  onTheWay,
  delivered,
  cancelled;

  static OrderStatus fromString(String status) {
    switch (status) {
      case 'received':
        return OrderStatus.received;
      case 'preparing':
        return OrderStatus.preparing;
      case 'on_the_way':
        return OrderStatus.onTheWay;
      case 'delivered':
        return OrderStatus.delivered;
      case 'cancelled':
        return OrderStatus.cancelled;
      default:
        return OrderStatus.received;
    }
  }

  String toDbString() {
    switch (this) {
      case OrderStatus.received:
        return 'received';
      case OrderStatus.preparing:
        return 'preparing';
      case OrderStatus.onTheWay:
        return 'on_the_way';
      case OrderStatus.delivered:
        return 'delivered';
      case OrderStatus.cancelled:
        return 'cancelled';
    }
  }
}

class OrderModel extends Equatable {
  final String id;
  final String userId;
  final String? restaurantId;
  final String? addressId;
  final OrderStatus status;
  final double subtotal;
  final double deliveryFee;
  final double tax;
  final double totalAmount;
  final String? restaurantName; // Joined from restaurants table
  final String? restaurantImageUrl; // Joined from restaurants table
  final DateTime createdAt;
  final List<OrderItemModel> items;

  const OrderModel({
    required this.id,
    required this.userId,
    this.restaurantId,
    this.addressId,
    required this.status,
    required this.subtotal,
    required this.deliveryFee,
    required this.tax,
    required this.totalAmount,
    this.restaurantName,
    this.restaurantImageUrl,
    required this.createdAt,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    var rData = json['restaurants'] ?? json['restaurant'];
    String? rName;
    String? rImg;

    if (rData != null) {
      if (rData is Map) {
        rName = rData['name']?.toString();
        rImg = rData['image_url']?.toString();
      } else if (rData is List && rData.isNotEmpty) {
        final first = rData.first;
        if (first is Map) {
          rName = first['name']?.toString();
          rImg = first['image_url']?.toString();
        }
      }
    }

    return OrderModel(
      id: json['id']?.toString() ?? '',
      userId: json['user_id']?.toString() ?? '',
      restaurantId: json['restaurant_id']?.toString(),
      addressId: json['address_id']?.toString(),
      status: OrderStatus.fromString(json['status']?.toString() ?? ''),
      subtotal: (json['subtotal'] as num?)?.toDouble() ?? 0.0,
      deliveryFee: (json['delivery_fee'] as num?)?.toDouble() ?? 0.0,
      tax: (json['tax'] as num?)?.toDouble() ?? 0.0,
      totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0.0,
      restaurantName: rName,
      restaurantImageUrl: rImg,
      createdAt:
          DateTime.tryParse(json['created_at']?.toString() ?? '') ??
          DateTime.now(),
      items: (json['order_items'] as List? ?? [])
          .map((i) => OrderItemModel.fromJson(i))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [
    id,
    userId,
    restaurantId,
    addressId,
    status,
    subtotal,
    deliveryFee,
    tax,
    totalAmount,
    restaurantName,
    restaurantImageUrl,
    createdAt,
    items,
  ];
}

class OrderItemModel extends Equatable {
  final String id;
  final String orderId;
  final String foodId;
  final String foodName;
  final int quantity;
  final String? sizeName;
  final double unitPrice;
  final double totalPrice;
  final List<OrderItemAddOnModel> addOns;

  const OrderItemModel({
    required this.id,
    required this.orderId,
    required this.foodId,
    required this.foodName,
    required this.quantity,
    this.sizeName,
    required this.unitPrice,
    required this.totalPrice,
    required this.addOns,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'],
      orderId: json['order_id'],
      foodId: json['food_id'],
      foodName: json['food_name'],
      quantity: json['quantity'],
      sizeName: json['size_name'],
      unitPrice: (json['unit_price'] as num).toDouble(),
      totalPrice: (json['total_price'] as num).toDouble(),
      addOns: (json['order_item_addons'] as List? ?? [])
          .map((a) => OrderItemAddOnModel.fromJson(a))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [
    id,
    orderId,
    foodId,
    foodName,
    quantity,
    sizeName,
    unitPrice,
    totalPrice,
    addOns,
  ];
}

class OrderItemAddOnModel extends Equatable {
  final String addonName;
  final double price;

  const OrderItemAddOnModel({required this.addonName, required this.price});

  factory OrderItemAddOnModel.fromJson(Map<String, dynamic> json) {
    return OrderItemAddOnModel(
      addonName: json['addon_name'],
      price: (json['price'] as num).toDouble(),
    );
  }

  @override
  List<Object?> get props => [addonName, price];
}
