import 'package:practice/api_integrate/api_repository.dart';
import 'package:practice/model/catergory_model.dart';
import 'package:practice/model/news_headline_json.dart';

class newsViewModel{

  final _repo = apiRepository();

  Future<newsHeadlines> headlines(String channelName) async{
    final responce = await _repo.headline(channelName);
    return responce;
  }

  Future<categoryModel> category(String category) async {
    final response = _repo.category(category);
    return response;
  }

}