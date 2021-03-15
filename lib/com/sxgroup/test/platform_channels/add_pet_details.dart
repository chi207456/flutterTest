import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/com/sxgroup/test/platform_channels/pet_list_message_channel.dart';

class AddPetDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddPetDetailsState();
}

class _AddPetDetailsState extends State<AddPetDetails> {
  final breedTextController = TextEditingController();
  String petType = 'Dog';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add pet Details'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              PetListMessageChannel.addPetDetails(
                PetDetails(
                  petType: petType,
                  breed: breedTextController.text,
                ),
              );

              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: breedTextController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  hintText: 'Breed of pet',
                  labelText: 'Breed'),
            ),
            SizedBox(
              height: 8,
            ),
            RadioListTile<String>(
                title: Text('Dog'),
                value: 'Dog',
                groupValue: petType,
                onChanged: (value){
                  setState(() {
                    petType=value;
                  });
                }),
            RadioListTile<String>(
                title: Text('Cat'),
                value: 'Cat',
                groupValue: petType,
                onChanged: (value){
                  setState(() {
                    petType=value;
                  });
                })
          ],
        ),
      ),
    );
  }
}
