import 'package:flutter_command/flutter_command.dart';
import 'package:flutter_command_example/models/joke_dto.dart';
import 'package:flutter_command_example/services/api_service.dart';

class HomeViewModel {
  final apiService = ApiService();
  Command<String, JokeDto> getJokeCommand;
  Command<void, List<String>> getJokeCategories;

  HomeViewModel() {
    getJokeCommand = Command.createAsync<String, JokeDto>(
      getJoke,
      null, // Initial value
    );
    getJokeCommand.thrownExceptions.listen((ex, _) => print(ex.toString()));
    getJokeCommand.execute("history");

    getJokeCategories =
        Command.createAsyncNoParam<List<String>>(getCategories, []);
    getJokeCategories.execute();
  }
  Future<JokeDto> getJoke(String category) async {
    final res = apiService.getJoke(category);
    return res;
  }

  Future<List<String>> getCategories() async {
    final res = apiService.getCatgories();
    return res;
  }
}
