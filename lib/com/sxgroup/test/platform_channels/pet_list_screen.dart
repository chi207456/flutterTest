import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/com/sxgroup/test/platform_channels/pet_list_message_channel.dart';

class PetListScreen extends StatefulWidget {
  @override
  _PetListScreenState createState() => _PetListScreenState();
}

class _PetListScreenState extends State<PetListScreen> {
  PetListModel petListModel;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    BasicMessageChannel('stringCodecDemo', StringCodec())
        .setMessageHandler((message) async {
      if (message == null) {
        scaffoldKey.currentState.showSnackBar(SnackBar(
            content:
            const Text('An error occurred while adding pet details.')));
      } else {
        setState(() {
          petListModel = PetListModel.fromJson(message);
        });
      }
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('PetList'),
      ),
      body: petListModel?.petList?.isEmpty ?? true
          ? Center(child: Text('Enter Pet Details'),) : BuildPetList(
          petList: petListModel?.petList),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/addPetDetails');
        },
      ),
    );
  }
}

class BuildPetList extends StatelessWidget {
  final List<PetDetails> petList;

  BuildPetList({this.petList});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(padding: EdgeInsets.all(8.0),
      itemCount: petList.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text('Pet breed:${petList[index].breed}'),
          subtitle: Text('Pet Type:${petList[index].petType}'),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              try {
                await PetListMessageChannel.remove(index);
                showSnackBar('Removed successfully!', context);
              } catch (error) {
                showSnackBar(error.message.toString(), context);
              }
            },
          ),);
      },);
  }

  void showSnackBar(String message, BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
