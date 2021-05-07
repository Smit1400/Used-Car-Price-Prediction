import 'package:car_dealer/Screens/show_page.dart';
import 'package:car_dealer/components/constants.dart';
import 'package:car_dealer/models/car_details.dart';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:car_dealer/services/firebase_db.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';

//import 'package:flutter_launch/flutter_launch.dart';
const Color mainColor = Color(0xFF436eee);

class CarCard extends StatelessWidget {
  final FirebaseMethods _firebaseMethods = FirebaseMethods();
  final CarDetails car;
  final SnackBar _snackBar = SnackBar(
    content: Text("Car added to wishlist"),
  );
  CarCard({@required this.car});

  @override
  Widget build(BuildContext context) {
    String capsTitle = "${car.title}".substring(0, 1).toUpperCase() +
        "${car.title}".substring(1);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    int pr = (car.price).round();
    String p = '+91' + (car.mobileNumber).toString();
    return Stack(
      children: [
        Card(
          elevation: 10.0,
          // color: Colors.green.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
            // side: BorderSide(width: 1, color: Colors.green),
          ),
          margin: EdgeInsets.all(10),
          child: Container(
            width: width,
            padding: EdgeInsets.all(10),
            // height: height * 0.3,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: height * 0.2 * 0.7,
                      width: width * 0.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image.network(
                          car.imageUrls[0],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("${car.brand}",
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                                style: GoogleFonts.oswald(
                                  textStyle: TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.bold),
                                )),
                            Text(capsTitle,
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                                style: GoogleFonts.oswald(
                                  textStyle: TextStyle(
                                      fontSize: 15, fontWeight: FontWeight.w500),
                                )),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Rs.$pr',
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                                style: GoogleFonts.oswald(
                                  textStyle: TextStyle(
                                      color: Constants.secColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                )),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShowPage(
                                      productId: car.carId,
                                    )));
                      },
                      child: Container(
                        width: width * 0.4,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Constants.mainColor,
                        ),
                        child: Center(
                          child: Text("View",
                              style: GoogleFonts.oswald(
                                textStyle: TextStyle(
                                    color: Constants.secColor, fontSize: 18),
                              )),
                        ),
                      ),
                    ),

                    // var p = "+91" + (car.mobileNumber);
                    //      int pr = (car.price).round();
                    InkWell(
                      onTap: () {
                        FlutterOpenWhatsapp.sendSingleMessage(p, "Hello");
                      },
                      child: Container(
                        width: width * 0.4,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Constants.mainColor,
                        ),
                        child: Center(
                          child: Text("Chat",
                              style: GoogleFonts.oswald(
                                textStyle: TextStyle(
                                    color: Constants.secColor, fontSize: 18),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: GestureDetector(
            onTap: () async {
              _firebaseMethods.addCarToWishlist(car.carId);
              // _addToList();
              // ignore: deprecated_member_use
              Scaffold.of(context).showSnackBar(_snackBar);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 18.0, right: 20.0),
              child: Image.asset(
                "assets/images/saved_tab.png",
                scale: 1.6,
              ),
            ),
          ),
        )
      ],
    );
  }
}
