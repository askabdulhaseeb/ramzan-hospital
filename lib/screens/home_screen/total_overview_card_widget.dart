import 'package:flutter/material.dart';
import 'package:ramdazhospital/utilities/utilities.dart';

class TotalOverviewCardWidget extends StatelessWidget {
  const TotalOverviewCardWidget({
    required this.amount,
    required this.noOfPatient,
    required this.date,
    Key? key,
  }) : super(key: key);
  final double amount;
  final int noOfPatient;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Utilities.borderRadious),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Colors.indigo,
            Colors.blue,
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          const Positioned(
            right: -40,
            bottom: -40,
            child: Icon(
              Icons.local_hospital_outlined,
              color: Colors.white10,
              size: 200,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      '$amount',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w900,
                        fontSize: (amount > 100000000) ? 32 : 46,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 4,
                    ),
                    child: Text(
                      'Rs',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
              Text(
                'No. of Patient: $noOfPatient',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
