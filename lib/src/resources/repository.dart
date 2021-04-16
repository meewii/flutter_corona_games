import 'dart:async';
import 'show_api_provider.dart';
import '../models/show_list_model.dart';

class ShowsRepository {
  final showsApiProvider = ShowApiProvider();

  Future<ShowListModel> fetchAllShows() => showsApiProvider.fetchShowList();
}
