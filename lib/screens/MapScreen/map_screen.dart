import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yolustunde_mobile/models/company_model.dart';
import 'package:yolustunde_mobile/models/dio/dio_response.dart';
import 'package:yolustunde_mobile/screens/CompanyDetail/company_detail.dart';
import 'package:yolustunde_mobile/services/dio_service.dart';
import 'dart:ui' as ui;

import 'package:yolustunde_mobile/services/image_service.dart';
import 'package:yolustunde_mobile/theme/colors.dart';
import 'package:yolustunde_mobile/widgets/favorite_button.dart';
import 'package:yolustunde_mobile/widgets/my_app_bar.dart';

// istanbul lat long
const double istanbulLat = 41.0082;
const double istanbulLng = 28.9784;

class MapsScreen extends StatefulWidget {
  const MapsScreen({Key? key, required this.type}) : super(key: key);

  final String type;

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  CameraPosition? initialCameraPosition;
  Completer<GoogleMapController> googleMapController = Completer();
  Set<Marker> markers = {};
  double elementSize = 0;
  List<Map> typeFilters = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      elementSize = MediaQuery.of(context).size.width * 0.55;
      checkLocation();
      getData();
      getTypeFilters();
    });
  }

  List<CompanyModel> companies = [];
  bool companiesGet = false;
  BitmapDescriptor? markerIcon;
  BitmapDescriptor? markerIconSelected;
  ScrollController scrollController = ScrollController();

  CompanyModel? selectedCompany;

  Future<void> getData() async {
    DioResponse dioResponse = await DioService().request(
      'customer/company/${widget.type}',
      data: {
        'latitude': istanbulLat,
        'longitude': istanbulLng,
        'distance': 1000,
      },
    );
    if (dioResponse.isSuccessful) {
      companies = dioResponse.data['data'].map<CompanyModel>((e) => CompanyModel.fromMap(e)).toList();
      selectedCompany = companies.first;
      setMarkers();
      googleMapController.future.then((value) {
        if (selectedCompany != null) value.animateCamera(CameraUpdate.newLatLngZoom(LatLng(selectedCompany!.latitude, selectedCompany!.longitude), 11));
      });
      companiesGet = true;
      setState(() {});
    }
  }

  Future<void> getTypeFilters() async {
    DioResponse dioResponse = await DioService().request(
      'parameters/filters/${widget.type}',
    );
    if (dioResponse.isSuccessful) {
      typeFilters = dioResponse.data['data'].map<Map>((e) => e as Map).toList();
      setState(() {});
    }
  }

  void checkLocation() {
    //! location izni ve getirilmesi işlemleri yapılacak, ankara demo data
    initialCameraPosition = CameraPosition(target: LatLng(istanbulLat, istanbulLng), zoom: 9);
    setState(() {});
  }

  void setMarkers() {
    setCustomMapPin().then((value) {
      companies.forEach((element) {
        markers.add(
          Marker(
            markerId: MarkerId(element.id.toString()),
            icon: (selectedCompany != null && selectedCompany?.id == element.id) ? markerIconSelected! : markerIcon!,
            position: LatLng(element.latitude, element.longitude),
            onTap: () {
              if (selectedCompany == element) {
                return;
              }
              CompanyModel oldSelectedCompany = selectedCompany!;

              if (selectedCompany != null && selectedCompany!.id == element.id) {
              } else {
                selectedCompany = element;
              }

              scrollController.animateTo(
                (companies.indexOf(element) * (elementSize + 20)).toDouble(),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
              markers.removeWhere((element) => element.markerId.value == selectedCompany!.id.toString());
              markers.add(
                Marker(
                  markerId: MarkerId(selectedCompany!.id.toString()),
                  icon: markerIconSelected!,
                  position: LatLng(selectedCompany!.latitude, selectedCompany!.longitude),
                  // infoWindow: InfoWindow(title: selectedCompany!.title),
                  onTap: () {},
                ),
              );
              markers.add(
                Marker(
                  markerId: MarkerId(oldSelectedCompany.id.toString()),
                  icon: markerIcon!,
                  position: LatLng(oldSelectedCompany.latitude, oldSelectedCompany.longitude),
                  // infoWindow: InfoWindow(title: oldSelectedCompany.title),
                  onTap: () {},
                ),
              );

              setState(() {});
            },
          ),
        );
      });
    });
  }

  Future<void> setCustomMapPin() async {
    final Uint8List uint8listGrey = await getBytesFromAsset(ImageService.pin(widget.type));
    final Uint8List uint8listBlue = await getBytesFromAsset(ImageService.pin(widget.type + '-selected'));
    markerIcon = await BitmapDescriptor.fromBytes(uint8listGrey);
    markerIconSelected = await BitmapDescriptor.fromBytes(uint8listBlue);
    setState(() {});
  }

  Future<Uint8List> getBytesFromAsset(String path) async {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: pixelRatio.round() * 40);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: '', color: Colors.transparent),
      extendBodyBehindAppBar: true,
      body: Builder(builder: (context) {
        if (initialCameraPosition == null) {
          return Center(child: CircularProgressIndicator.adaptive());
        }
        return Stack(
          children: [
            GoogleMap(
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              initialCameraPosition: initialCameraPosition!,
              onMapCreated: (GoogleMapController controller) async {
                googleMapController.complete(controller);
              },
              markers: markers,
            ),
            Positioned(
              child: Row(
                children: [],
              ),
            ),
            Positioned(
              bottom: 0,
              child: SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 0),
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.red,
                  height: 290,
                  child: ListView.separated(
                    controller: scrollController,
                    itemCount: companies.length,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 20);
                    },
                    itemBuilder: (context, index) {
                      CompanyModel company = companies[index];
                      bool selected = selectedCompany != null && selectedCompany!.id == company.id;

                      return GestureDetector(
                        onTap: () async {
                          if (selectedCompany != company) {
                            CompanyModel oldSelectedCompany = selectedCompany!;
                            selectedCompany = company;
                            googleMapController.future.then((value) {
                              value.animateCamera(CameraUpdate.newLatLngZoom(LatLng(selectedCompany!.latitude, selectedCompany!.longitude), 11));
                            });
                            scrollController.animateTo(
                              (companies.indexOf(company) * (elementSize + 20)).toDouble(),
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                            markers.removeWhere((element) => element.markerId.value == selectedCompany!.id.toString());
                            markers.add(
                              Marker(
                                markerId: MarkerId(selectedCompany!.id.toString()),
                                icon: markerIconSelected!,
                                position: LatLng(selectedCompany!.latitude, selectedCompany!.longitude),
                                infoWindow: InfoWindow(title: selectedCompany!.title),
                                onTap: () {},
                              ),
                            );
                            markers.add(
                              Marker(
                                markerId: MarkerId(oldSelectedCompany.id.toString()),
                                icon: markerIcon!,
                                position: LatLng(oldSelectedCompany.latitude, oldSelectedCompany.longitude),
                                infoWindow: InfoWindow(title: oldSelectedCompany.title),
                                onTap: () {},
                              ),
                            );

                            setState(() {});
                            await Future.delayed(Duration(milliseconds: 500));
                          }

                          Navigator.push(context, MaterialPageRoute(builder: (context) => CompanyDetail(id: company.id)));
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          margin: EdgeInsets.symmetric(vertical: 20).add(EdgeInsets.only(top: selected ? 0 : 30, left: index == 0 ? 20 : 0)),
                          height: 245,
                          width: elementSize,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(13),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: Offset(5, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8),
                              Expanded(
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.network(
                                          'https://images.unsplash.com/photo-1543857182-68106299b6b2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2071&q=80',
                                          height: selected ? 130 : 100,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 8,
                                      right: 16,
                                      child: FavoriteButton(id: company.id),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        for (var i = 0; i < 5; i++)
                                          Padding(
                                            padding: const EdgeInsets.only(left: 2.0),
                                            child: Image.asset(
                                              ImageService.pngIcon('star'),
                                              height: 16,
                                            ),
                                          ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      company.title,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Image.asset(
                                          ImageService.pngIcon('routing'),
                                          height: 16,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          '6.5 km',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Image.asset(
                                          ImageService.pngIcon('park'),
                                          height: 16,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'Kapalı / Self Park',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  SizedBox(width: 8),
                                  Text(
                                    'Tutar:  ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '₺29.99',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      // olny top left and bottom rights
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                      color: MyColors.yellow,
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Center(
                                      child: Text(
                                        'Rezervasyon Yap',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
