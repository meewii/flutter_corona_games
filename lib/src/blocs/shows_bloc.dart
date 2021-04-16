import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/show_list_model.dart';

class MoviesBloc {
  final _repository = ShowsRepository();
  final _showsFetcher = PublishSubject<ShowListModel>();

  Observable<ShowListModel> get allShows => _showsFetcher.stream;

  fetchAllShows() async {
    ShowListModel showListModel = await _repository.fetchAllShows();
    _showsFetcher.sink.add(showListModel);
  }

  dispose() {
    _showsFetcher.close();
  }
}

final bloc = MoviesBloc();
