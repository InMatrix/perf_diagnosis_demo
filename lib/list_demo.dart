import 'package:flutter/material.dart';

class ListDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("List Demo"),
        ),
        body: ListView(
          children: <Widget>[
            Card(
              color: Colors.amber.shade50,
              child: ListTile(
                title: Text("FLIGHT DEALS"),
                subtitle: Text("Discount flights to 100+ top destinations"),
                leading: Icon(Icons.flight),
              ),
            ),
            Card(
              color: Colors.red.shade50,
              child: ListTile(
                title: Text("HOTEL DEALS"),
                subtitle: Text("Best prices for over 10,000 hotels worldwide"),
                leading: Icon(Icons.hotel),
              ),
            ),
            Card(
              color: Colors.blue.shade50,
              child: ListTile(
                title: Text("EVENT DEALS"),
                subtitle: Text(
                    "Tickets at up to 80% discounts for all kinds of attractions and entertainment."),
                leading: Icon(Icons.event),
              ),
            ),
            Divider(),
            Column(
              children: createListItems(),
            ),
          ],
        ));
  }

  List<Widget> createListItems() {
    var listItems = List<Widget>.generate(
      100,
      (int) => InkWell(
            onTap: () {},
            child: ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text("A Great Travel Deal"),
              subtitle: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
                  "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, "
                  "when an unknown printer took a galley of type and scrambled it to make a type specimen book. "),
            ),
          ),
    );

    return listItems..add(new CircularProgressIndicator());
  }
}
