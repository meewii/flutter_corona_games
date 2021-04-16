class ShowListModel {
  List<Show> _shows = [];

  ShowListModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['shows'].length);
    List<Show> temp = [];
    for (int i = 0; i < parsedJson['shows'].length; i++) {
      Show result = Show(parsedJson['shows'][i]);
      temp.add(result);
    }
    _shows = temp;
  }

  List<Show> get shows => _shows;
}

class Show {
  int _id;
  String _seasons;
  String _episodes;
  String _originalTitle;
  String _description;

  Show(result) {
    _id = result['id'];
    _seasons = result['seasons'];
    _episodes = result['episodes'];
    _originalTitle = result['original_title'];
    _description = result['description'];
  }

  int get id => _id;

  String get description => _description;

  String get originalTitle => _originalTitle;

  String get seasons => _seasons;

  String get episodes => _episodes;
}
