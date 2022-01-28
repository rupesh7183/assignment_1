import 'package:assignment_cspar/modules/profile/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

ProfileBloc _profileBloc = ProfileBloc();
final List<Marker> _markers = [];

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();

    _profileBloc.add(FetchData());
    // _homebloc.add();
  }

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<ProfileBloc, ProfileState>(
            bloc: _profileBloc,
            builder: (context, state) {
              if (state is DataFetchSuccessfully) {
                return profilePage(state.profileData, state.mapDetails);
              }
              if (state is ProfileLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Container();
            }));
  }

  Widget profilePage(profileDetail, mapDetail) {
    _markers.add(Marker(
        markerId: const MarkerId("Your location"),
        draggable: false,
        position: LatLng(
            double.parse(mapDetail['lat']), double.parse(mapDetail['long']))));
    return Container(
      child: Column(
        children: [
          Container(
            // color: Colors.black87,
            height: MediaQuery.of(context).size.height * 0.18,
            width: MediaQuery.of(context).size.width,
            child: sliderWidget(profileDetail),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * 0.6,
            // color: Colors.amberAccent,
            child: GoogleMap(
              compassEnabled: true,
              buildingsEnabled: true,
              scrollGesturesEnabled: true,
              rotateGesturesEnabled: true,
              zoomControlsEnabled: true,
              tiltGesturesEnabled: true,
              zoomGesturesEnabled: true,
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(

                  // bearing: 192.8334901395799,

                  target: LatLng(double.parse(mapDetail['lat']),
                      double.parse(mapDetail['long'])),
                  // LatLng(double.parse(mapDetail['lat']),
                  //     double.parse(mapDetail['long'])),
                  // LatLng(double.parse(mapDetail['lat']), double.parse(mapDetail['long'])),
                  zoom: 18,
                  tilt: 59.440717697143555),
              markers: Set.from(_markers),
            ),
          ),
        ],
      ),
    );
  }

  Widget textField(title, content) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        // ignore: prefer_const_literals_to_create_immutables
        children: [Text(title), const Text(':'), Text(content)],
      ),
    );
  }

  Widget sliderWidget(data) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: CarouselSlider.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index, int int) {
            return Card(
              elevation: 8,
              child: SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Column(children: [
                      textField('Name', data[index]['name']),
                      textField('Email', data[index]['email']),
                      data[index]['created_at'] != null
                          ? textField('Created At', data[index]['created_at'])
                          : Container(),
                    ]),
                  )),
            );
          },
          options: CarouselOptions(
            pauseAutoPlayOnManualNavigate: true,
            initialPage: 0,
            enableInfiniteScroll: true,
            autoPlay: true,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
        ));
  }
}
