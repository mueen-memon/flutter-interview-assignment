import 'package:flutter/material.dart';
import '../models/weight.dart';
import '../providers/auth.dart';
import '../providers/weights.dart';
import '../widgets/weights_list..dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static String routeId = 'HomeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

String weight = '20.0';

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final _auth = Provider.of<Auth>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Weight Tracker',
        ),
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  weight.toString(),
                  style: const TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const Text(
                  'kg',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFF8D8E98),
                  ),
                ),
                const SizedBox(
                  width: 80,
                ),
                IconButton(
                  onPressed: () async {
                    final date = DateTime.now();
                    final newWeight = WeightData(
                        weight: double.parse(weight),
                        measureDate: date.toIso8601String());
                    await Provider.of<Weights>(context, listen: false)
                        .addWeight(newWeight);
                  },
                  icon: const Icon(
                    Icons.check,
                  ),
                  iconSize: 30.0,
                  padding: const EdgeInsets.only(right: 20.0),
                )
              ],
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.black,
                  inactiveTrackColor: const Color(0xFF8D8E98),
                  thumbColor: const Color(0xFFF6046B),
                  overlayColor: const Color(0x29F6046B),
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 15.0,
                  ),
                  overlayShape: const RoundSliderOverlayShape(
                    overlayRadius: 30,
                  )),
              child: Slider(
                value: double.parse(weight),
                min: 20.0,
                max: 200.0,
                onChanged: (double value) {
                  setState(() {
                    weight = double.parse(value.toString()).toStringAsFixed(2);
                  });
                },
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 8.0,
              child: Container(
                width: deviceSize.width * 0.90,
                height: deviceSize.height * 0.7,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: const WeightsList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
