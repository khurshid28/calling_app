import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List <Contact>? contacts;
  @override
  void initState() {
    getContacts();
    super.initState();
  }

  void getContacts()async{
    if (await FlutterContacts.requestPermission()) {
        contacts=await FlutterContacts.getContacts(
          withProperties: true,
        );
        setState(() {});
    }
  }

  calling(number)async{
      await FlutterPhoneDirectCaller.callNumber(number);
  }
  deleting(Contact contact)async{
     await contact.delete();
  }
  viewing(Contact contact)async{
     await FlutterContacts.openExternalView(contact.id);
  }
  editing(Contact contact)async{
    await FlutterContacts.openExternalEdit(contact.id);
  }
  adding()async{
     await FlutterContacts.openExternalInsert();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title:const Text("Calling App",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
        actions: [
          Container(
            padding:const EdgeInsets.only(right: 15),
            child: InkWell(
              onTap: ()async{
                  await adding();

              },
              borderRadius: BorderRadius.circular(12),
              child:const CircleAvatar(
                radius: 24,child: Icon(Icons.person_add_outlined,size: 30,),
                backgroundColor: Colors.transparent,
                ),
            ),
          ),
        ],

        ),
      backgroundColor: Colors.blueGrey,
      body: contacts ==null ? const  Center(
         child: CircularProgressIndicator(
           strokeWidth: 6,
           backgroundColor: Colors.white,
           ),
      ):
      SingleChildScrollView(
        child: Column(
          children: List.generate(
            contacts!.length,
             (index) => InkWell(
               onDoubleTap: ()async{
                 showDialog(
                     context: context,
                     builder: (context) {
                       return CupertinoAlertDialog(
                         content: const Text( "Are you sure that this contact edited?"),
                          actions: <Widget>[
                        CupertinoDialogAction(
                          child:const Text("CANCEL"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },),
                        CupertinoDialogAction(
                          child:const Text("OK"),
                          onPressed: () async{
                            await editing(contacts![index]);
                            Navigator.of(context).pop();
                          },),
       
                         ]
                       );
                     },
                   );
                 
               },
               onTap: ()async{
                  showDialog(
                     context: context,
                     builder: (context) {
                       return CupertinoAlertDialog(
                         content: const Text( "Are you sure that this contact viewed?"),
                          actions: <Widget>[
                        CupertinoDialogAction(
                          child:const Text("CANCEL"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },),
                        CupertinoDialogAction(
                          child:const Text("OK"),
                          onPressed: () async{
                            await viewing(contacts![index]);
                            Navigator.of(context).pop();
                          },),
       
                         ]
                       );
                     },
                   );
                   
               },
               onLongPress: ()async{
                showDialog(
                     context: context,
                     builder: (context) {
                       return CupertinoAlertDialog(
                         content: const Text( "Are you sure that this contact deleted?"),
                          actions: <Widget>[
                        CupertinoDialogAction(
                          child:const Text("CANCEL"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },),
                        CupertinoDialogAction(
                          child:const Text("OK"),
                          onPressed: () async{
                           await deleting(contacts![index]);
                            Navigator.of(context).pop();
                                 contacts=await FlutterContacts.getContacts(
                            withProperties: true,
                          );
                          setState(() {});
                          },),
       
                         ]
                       );
                     },
                   );
                    
                    },
               child: Container(
                 alignment: Alignment.center,
                 padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                 decoration:const BoxDecoration(
                   border: Border(
                     top: BorderSide(
                       color: Colors.black,
                       width: 1,
                     ),
                     bottom: BorderSide(
                       color: Colors.black,
                       width: 1,
                     )
                   )
                 ),
                 child: ListTile(
                  
                   leading:const CircleAvatar(child: Icon(Icons.person_outline_rounded,color: Colors.white,size: 30,),backgroundColor: Colors.black,),
                   title: Text(contacts![index].name.first+" "+contacts![index].name.last,style:const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),),
                   subtitle: Text(contacts![index].phones[0].number,style:const TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black),),
                   trailing: SizedBox(
                     width: 48,
                     child:Row(
                       children: [
                         InkWell(
                           onTap: ()async{
                             await calling(contacts![index].phones[0].number);
                           },
                           borderRadius: BorderRadius.circular(12),
                           radius: 24,
                           child:const CircleAvatar(
                             backgroundColor: Colors.black,
                             radius: 24,
                             child: Icon(Icons.call,color: Colors.white,size: 25,),
                           ),
                         ),
                       ],
                     )
                   ),
                 ),
               ),
             ),
             ),
        ),
      ),
    );
  }
}