import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sport_plus/config/app_consts.dart';
import 'package:sport_plus/screens/map/bloc/map_bloc.dart';
import 'package:sport_plus/screens/map/widgets/facility_map_dialog.dart';
import 'package:sport_plus/screens/map/widgets/legend.dart';
import 'package:sport_plus/widgets/app_scaffold.dart';
import 'package:sport_plus/widgets/loading_view.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  static const String route = "/map";

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        if (!state.isLoaded) {
          return const LoadingView();
        }
        return AppScaffold(
          setPadding: false,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              FlutterMap(
                options: MapOptions(
                    initialZoom:
                        state.userLocation == AppConsts.centerCoords ? 6 : 14,
                    initialCenter: LatLng(state.userLocation.latitude,
                        state.userLocation.longitude)),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                  MarkerLayer(markers: [
                    ...state.cords.where((cord) => cord.cords != null).map(
                          (cord) => Marker(
                            alignment: Alignment.topCenter,
                            rotate: true,
                            point: LatLng(
                                cord.cords!.latitude, cord.cords!.longitude),
                            child: GestureDetector(
                              onTap: () => showDialog(
                                context: context,
                                builder: (context) =>
                                    FacilityMapDialog(facility: cord),
                              ),
                              child: Icon(
                                Icons.location_pin,
                                color: cord.pinColor,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                  ])
                ],
              ),
              const Legend(),
            ],
          ),
        );
      },
    );
  }
}
