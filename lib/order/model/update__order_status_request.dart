class UpdateOrderStatusRequest{
 String orderId;
 String orderStatus;

 UpdateOrderStatusRequest(
     this.orderId,
     this.orderStatus,
     );

 Map<String, dynamic> toJson(){
   return {'status': orderStatus};
 }
}