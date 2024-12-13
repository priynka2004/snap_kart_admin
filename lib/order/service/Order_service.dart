
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:snap_kart_admin/order/model/order_response_model.dart';
import 'package:snap_kart_admin/order/model/update__order_status_request.dart';

import '../../service/api_endpoint.dart';
import '../../service/storage_service.dart';
import '../model/placed_order_model.dart';

class OrderService {
  Future placeOrder(OrderResponse orderResponse)async{
    String? token = await StorageHelper.getToken();

    final header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'x-api-key': 'aihfj--qwnkqwr--jlkqwnjqw--jnkqwjnqwy',
    };

    Uri uri = Uri.parse(ApiEndpoint.order);
    final json=orderResponse.toJson();
    final jsonStr=jsonEncode(json);
    print('Headers: $header');
    print('Request Body: ${jsonEncode(orderResponse.toJson())}');

    final response = await http.post(
        uri,
        headers: header,
        body: jsonStr
    );

    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if(response.statusCode==201){
      return true;
    }else{
      throw 'Unable to place order';
    }
  }

  Future<OrderResponseList> fetchOrders() async {
    try {
      final token = await ApiEndpoint.order;

      final header = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjc0YzVmZWI5NTQ3Njg5YzgzZGRlYWM5IiwiZW1haWwiOiJqb2huZG9lQGV4YW1wbGUuY29tIn0sImlhdCI6MTczMzU4OTc4OCwiZXhwIjoxNzMzNzYyNTg4fQ.Tk6vl-S14DVjSO7F3Y5QSsjkz8bXSsya4vpsGsTLx6E',
        'x-api-key': 'aihfj--qwnkqwr--jlkqwnjqw--jnkqwjnqwy',
      };


      Uri uri = Uri.parse(ApiEndpoint.order);

      print('Headers: $header');


      final response = await http.get(uri, headers: header);

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return OrderResponseList.fromJson(json);
      } else {

        throw Exception('Failed to fetch orders: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<bool> updateOrderStatus(UpdateOrderStatusRequest updateOrderStatusRequest) async {
    try {
      String? token = await StorageHelper.getToken();
      final header = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'x-api-key': 'aihfj--qwnkqwr--jlkqwnjqw--jnkqwjnqwy',
      };

      Uri uri = Uri.parse(ApiEndpoint.orderUpdate(updateOrderStatusRequest.orderId));
      final jsonStr = jsonEncode(updateOrderStatusRequest.toJson());

      final response = await http.put(uri, headers: header, body: jsonStr);

      if (response.statusCode == 200) {
        return true;
      } else {
        print("Response: ${response.statusCode}, ${response.body}");
        throw 'Error ${response.statusCode}: ${response.body}';
      }
    } catch (e) {
      print("Exception in updateOrderStatus: $e");
      throw 'Failed to update order status: $e';
    }
  }


}