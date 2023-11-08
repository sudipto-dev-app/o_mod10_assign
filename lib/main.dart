import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ostad Assignment 10',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'new'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   List<ListItem> items = [];

   TextEditingController titleEditingController = TextEditingController();
   TextEditingController subtitleEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(widget.title),
        actions: const [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Icon(Icons.search),
          )
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: titleEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: subtitleEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Subtitle',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    addItem();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent),
                  child: const Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
          ListView.builder(
            itemCount: items.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.redAccent,
                      child: Text('${index+1}'),
                    ),
                    title: Text('${items[index].title}',style:const TextStyle(fontSize: 20),),
                    subtitle: Text('${items[index].subtitle}'),
                    trailing:  const Icon(Icons.arrow_forward_outlined),
                onLongPress: () {
                  _showOptionsDialog(context, index);
                },
                  ))
        ],
      ),
    );
  }

   void _showOptionsDialog(BuildContext context, int index) {
     showDialog(
       context: context,
       builder: (BuildContext context) {
         return AlertDialog(
           title: const Text("Alert"),
           content: Column(
             mainAxisSize: MainAxisSize.min,
             children: <Widget>[
               ListTile(
                 title: const Text("Edit"),
                 onTap: () {
                   Navigator.pop(context);
                   _showEditBottomSheet(context, index);
                 },
               ),
               ListTile(
                 title: const Text("Delete"),
                 onTap: () {
                   Navigator.pop(context);
                   setState(() {
                     items.removeAt(index);
                   }
                   );

                 },
               ),
             ],
           ),
         );
       },
     );
   }

   void _showEditBottomSheet(BuildContext context, int index) {
     TextEditingController titleController =
     TextEditingController(text: items[index].title);
     TextEditingController subtitleController =
     TextEditingController(text: items[index].subtitle);

     showModalBottomSheet(
       context: context,
       isScrollControlled: true,
       builder: (BuildContext context) {
         return SingleChildScrollView(
           child: Column(
             children: <Widget>[
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: TextFormField(
                   controller: titleController,
                   decoration: const InputDecoration(
                       labelText: "Title", border: OutlineInputBorder()),
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: TextFormField(
                   controller: subtitleController,
                   decoration: const InputDecoration(
                       labelText: "Subtitle", border: OutlineInputBorder()),
                 ),
               ),
               ElevatedButton(
                 onPressed: () {
                   setState(() {
                     items[index].title = titleController.text;
                     items[index].subtitle = subtitleController.text;
                   });
                   Navigator.pop(context);
                 },
                 style:
                 ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                 child: const Text("Edit Done"),
               ),
               const SizedBox(
                 height: 152,
               )
             ],
           ),
         );
       },
     );
   }

   void addItem() {
     final String title = titleEditingController.text;
     final String subtitle = subtitleEditingController.text;
     if (title.isNotEmpty && subtitle.isNotEmpty) {
       setState(() {
         items.add(ListItem(title, subtitle));
       });
       titleEditingController.clear();
       subtitleEditingController.clear();
     }
   }

}

class ListItem {
  dynamic title;
  dynamic subtitle;
  ListItem(this.title, this.subtitle);
}


