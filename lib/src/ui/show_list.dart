import 'package:flutter/material.dart';
import '../models/show_list_model.dart';
import '../blocs/shows_bloc.dart';

class ShowList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bloc.fetchAllShows();
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Shows'),
      ),
      body: StreamBuilder(
        stream: bloc.allShows,
        builder: (context, AsyncSnapshot<ShowListModel> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<ShowListModel> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.shows.length,
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          return _buildRow(snapshot.data.shows[i]);
        });
  }

  Widget _buildRow(Show show) {
    return ListTile(
      title: Text(
        show.originalTitle,
      ),
    );
  }
}
