import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class Contribute extends StatefulWidget {
  const Contribute({super.key});

  @override
  State<Contribute> createState() => _ContributeState();
}

class _ContributeState extends State<Contribute> {
  
  Map<String , dynamic>? paymentIntentData;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contribute'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            makePayment();
          }, 
          child: Text('Pay Now')),
      )
    );

  }
  Future<void> makePayment() async
  {
    try{
      paymentIntentData = await createPayment('20', 'INR');
      Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          applePay: PaymentSheetApplePay(
            merchantCountryCode: 'IN') ,
          googlePay: PaymentSheetGooglePay(merchantCountryCode: "IN"),
          merchantDisplayName: 'Sameer'
         
      ));

      displaySheet()async {

      }
    }
    catch(e)
    {
      EasyLoading.showError(e.toString());
    }
  }


  displayPaymentSheet() async
  {
    try{
      await Stripe.instance.presentPaymentSheet(
        options: PaymentSheetPresentOptions()
        // options: 
      );
      setState(() {
        paymentIntentData =null;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('PAid Sucessfully')));
    }
   on StripeException catch(e)
    {
      log(e.toString());
    }

  }

  createPayment(String amount ,String currency)
  async {
     try{
      Map<String,dynamic> body ={
        'amount' : calculateAmount(amount),
        'currency':'INR',
        'payment_method_types[]':'card'
      };

      var response = await  Dio().post('https://api.stripe.com/v1/payment_intents',
      options: Options(headers: {
        'Authorization': 'Bearer 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',
        'Content-Type' : 'application/x-www-form-urlencoded'
      }));

      return jsonDecode(response.data.toString());

     }
     catch(e)
     {
      EasyLoading.showError(e.toString());
     }
  }
  calculateAmount(String amount)
  {
    final price = int.parse(amount) *100;
    return price.toString();
  }
}
