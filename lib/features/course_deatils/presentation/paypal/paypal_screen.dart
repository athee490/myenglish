import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

class PayPalCheckoutScreen extends StatefulWidget {
  const PayPalCheckoutScreen({super.key});

  @override
  State<PayPalCheckoutScreen> createState() => _PayPalCheckoutScreenState();
}

class _PayPalCheckoutScreenState extends State<PayPalCheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
        UsePaypal(
            sandboxMode: true,
            clientId:
            "AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0",
            secretKey:
            "EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9",
            returnURL: "https://samplesite.com/return",
            cancelURL: "https://samplesite.com/cancel",
            transactions: const [
              {
                "amount": {
                  "total": '10.12',
                  "currency": "USD",
                  "details": {
                    "subtotal": '10.12',
                    "shipping": '0',
                    "shipping_discount": 0
                  }
                },
                "description":
                "The payment transaction description.",
                // "payment_options": {
                //   "allowed_payment_method":
                //       "INSTANT_FUNDING_SOURCE"
                // },
                "item_list": {
                  "items": [
                    {
                      "name": "A demo product",
                      "quantity": 1,
                      "price": '10.12',
                      "currency": "USD"
                    }
                  ],

                  // shipping address is not required though
                  "shipping_address": {
                    "recipient_name": "Jane Foster",
                    "line1": "Travis County",
                    "line2": "",
                    "city": "Austin",
                    "country_code": "US",
                    "postal_code": "73301",
                    "phone": "+00000000",
                    "state": "Texas"
                  },
                }
              }
            ],
            note: "Contact us for any questions on your order.",
            onSuccess: (Map params) async {
              print("onSuccess: $params");
            },
            onError: (error) {
              print("onError: $error");
            },
            onCancel: (params) {
              print('cancelled: $params');
            }),
      ),
    );
  }
}













// import 'package:flutter/material.dart';
// // import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
//
// class PayPalCheckOutPage extends StatefulWidget {
//   const PayPalCheckOutPage({super.key});
//
//   @override
//   State<PayPalCheckOutPage> createState() => _PayPalCheckOutPageState();
// }
//
// class _PayPalCheckOutPageState extends State<PayPalCheckOutPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "PayPal Checkout",
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//       body: Center(
//         child: TextButton(
//           onPressed: () async {
//             Navigator.of(context).push(MaterialPageRoute(
//               builder: (BuildContext context) => PaypalCheckout(
//                 sandboxMode: true,
//                 clientId: "",
//                 secretKey: "",
//                 returnURL: "success.snippetcoder.com",
//                 cancelURL: "cancel.snippetcoder.com",
//                 transactions: const [
//                   {
//                     "amount": {
//                       "total": '70',
//                       "currency": "USD",
//                       "details": {
//                         "subtotal": '70',
//                         "shipping": '0',
//                         "shipping_discount": 0
//                       }
//                     },
//                     "description": "The payment transaction description.",
//                     // "payment_options": {
//                     //   "allowed_payment_method":
//                     //       "INSTANT_FUNDING_SOURCE"
//                     // },
//                     "item_list": {
//                       "items": [
//                         {
//                           "name": "Apple",
//                           "quantity": 4,
//                           "price": '5',
//                           "currency": "USD"
//                         },
//                         {
//                           "name": "Pineapple",
//                           "quantity": 5,
//                           "price": '10',
//                           "currency": "USD"
//                         }
//                       ],
//
//                       // shipping address is not required though
//                       //   "shipping_address": {
//                       //     "recipient_name": "Raman Singh",
//                       //     "line1": "Delhi",
//                       //     "line2": "",
//                       //     "city": "Delhi",
//                       //     "country_code": "IN",
//                       //     "postal_code": "11001",
//                       //     "phone": "+00000000",
//                       //     "state": "Texas"
//                       //  },
//                     }
//                   }
//                 ],
//                 note: "Contact us for any questions on your order.",
//                 onSuccess: (Map params) async {
//                   print("onSuccess: $params");
//                 },
//                 onError: (error) {
//                   print("onError: $error");
//                   Navigator.pop(context);
//                 },
//                 onCancel: () {
//                   print('cancelled:');
//                 },
//               ),
//             ));
//           },
//           style: TextButton.styleFrom(
//             backgroundColor: Colors.teal,
//             foregroundColor: Colors.white,
//             shape: const BeveledRectangleBorder(
//               borderRadius: BorderRadius.all(
//                 Radius.circular(1),
//               ),
//             ),
//           ),
//           child: const Text('Checkout'),
//         ),
//       ),
//     );
//   }
// }

