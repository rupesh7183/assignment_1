part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class DataFetchSuccessfully extends ProfileState {
  final profileData;
  final mapDetails;

  DataFetchSuccessfully({required this.profileData, required this.mapDetails});
  @override
  List<Object> get props => [profileData, mapDetails];
}

class ProfileErrorReceived extends ProfileState {
  final err;
  ProfileErrorReceived({this.err});
  ProfileErrorReceived copyWith({final err}) {
    return ProfileErrorReceived(err: err ?? this.err);
  }

  @override
  List<Object> get props => [err];
}
