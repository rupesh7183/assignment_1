
part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object> get props => [];
}

class FetchData extends ProfileEvent {
  // DataFetchSuccessfully copyWith({final obj}) {
  //   return DataFetchSuccessfully(obj: obj ?? this.obj);
  // }

  @override
  List<Object> get props => [];
}
