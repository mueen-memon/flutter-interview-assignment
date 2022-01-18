import 'package:flutter/material.dart';
import '../models/weight.dart';
import '../providers/weights.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WeightItem extends StatelessWidget {
  final WeightData weightData;
  const WeightItem({
    Key? key,
    required this.weightData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    final measureDate = DateTime.parse(weightData.measureDate);

    return ListTile(
      leading: CircleAvatar(
        radius: 27,
        backgroundColor: const Color(0xffE9F4F9),
        foregroundColor: Colors.black,
        child: Text(
          weightData.weight.toString(),
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
        ),
      ),
      title: Text(DateFormat('dd/MM/yyyy').format(measureDate)),
      subtitle: Text(DateFormat('hh:mm:ss a').format(measureDate)),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                try {
                  var weight = weightData.weight;

                  showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                            content: const Text('Edit your recorded weight.'),
                            actions: [
                              TextFormField(
                                initialValue: weight.toString(),
                                decoration:
                                    const InputDecoration(labelText: 'Weight'),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  weight = double.parse(value);
                                },
                              ),
                              TextButton(
                                onPressed: () async {
                                  await Provider.of<Weights>(context,
                                          listen: false)
                                      .updateWeight(weightData.id!, weight);
                                  Navigator.of(ctx).pop();
                                },
                                child: const Text('Done'),
                              ),
                            ],
                          ));
                } catch (e) {}
                //Navigator.of(context).pushNamed(EditProductScreen.routename,
                //  arguments: product.id);
              },
              icon: const Icon(Icons.edit),
              color: Colors.black,
            ),
            IconButton(
              onPressed: () async {
                try {
                  await Provider.of<Weights>(context, listen: false)
                      .deleteWeight(weightData.id!);
                } catch (e) {
                  scaffold.showSnackBar(
                    const SnackBar(
                      content: Text('Deleting Failed!'),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.delete),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
