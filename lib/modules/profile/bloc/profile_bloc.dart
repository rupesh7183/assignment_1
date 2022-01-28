import 'package:assignment_cspar/Modules/services/api_service.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

import '../../../overrides.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial());

  ProfileState get initialState => ProfileInitial();
  final DbService _dbService = DbService();

  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is FetchData) {
      try {
        yield ProfileLoading();
        var data = await _fetchData();
        print(data);
        yield DataFetchSuccessfully(profileData: data['success'], mapDetails: data['location']);
      } catch (e) {}
    }
  }

  //_datafetched() {}//<List<Album>>
  Future<dynamic> _fetchData() async {
    try {
      var data = await _dbService.getapi(Overrides.API_BASE_URL);
      print(data);
      var data1 = data.data;
      return data1;
    } catch (e) {
      throw Exception('');
    }
  }
}
