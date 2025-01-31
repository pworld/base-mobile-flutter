import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:app_management_system/feature/job_order/presentation/widgets/transfer_vehicle_detail.dart';
import 'package:app_management_system/shared/location/location_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/model/transfer_vehicle_model.dart';
import '../states/job_order_provider.dart';
import '../states/job_order_state.dart';

class TransferVehicleScreen extends HookConsumerWidget {
  final String jobOrderId;
  // TODO: Dirty hack to trigger refersh, improve later
  final Function() listRefreshCallback;

  const TransferVehicleScreen({super.key, required this.jobOrderId, required this.listRefreshCallback});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobItem = ref.watch(jobOrderTransferVehicleStateNotifierProvider);
    // final updateTransferVehicle = ref.watch(transferVehicleStateNotifierProvider);

    // Load Data Transfer Vehicle
    useEffect(() {
      Future.microtask(() => ref
          .read(jobOrderTransferVehicleStateNotifierProvider.notifier)
          .fetchJobOrderTransferVehicle(jobOrderId));
      return null;
    }, []);

    return jobItem.successData.when(
      data: (data) => _buildContent(context, ref, data),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Text('Error: $error'),
    );
  }
  // END Load Data Transfer Vehicle

  Future<bool> onSlideButtonAction(
    ScaffoldMessengerState scaffold,
    WidgetRef ref,
    ResponseTransferVehicleModel data,
    void Function() navigateCallback,
  ) async {
    var currentLocation = await LocationService().getLocation();

    RequestTransferVehicleTripModel payload = createPayload(
      currentLocation.longitude ?? 0,
      currentLocation.latitude ?? 0,
      data,
    );

    if (data.status == 'ontrip') {
      TransferVehicleTripState result = await ref
          .read(transferVehicleStateNotifierProvider.notifier)
          .finishTransferVehicle(payload);

      if (result.successData.hasError) {
        scaffold.showSnackBar(
          SnackBar(
            content: Text(result.successData.error.toString()),
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        scaffold.showSnackBar(
          const SnackBar(
            content: Text("Transfer completed successfully!"),
            duration: Duration(seconds: 2),
          ),
        );

        navigateCallback();
        listRefreshCallback();
      }
    } else if (data.status == 'planned') {
      TransferVehicleTripState result = await ref
          .read(transferVehicleStateNotifierProvider.notifier)
          .startTransferVehicle(payload);

      if (result.successData.hasError) {
        scaffold.showSnackBar(
          SnackBar(
            content: Text(result.successData.error.toString()),
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        scaffold.showSnackBar(
          const SnackBar(
            content: Text("Transfer started successfully!"),
            duration: Duration(seconds: 2),
          ),
        );

        navigateCallback();
        listRefreshCallback();
      }
    }

    return false;
  }

  void openGoogleMaps(
    ResponseTransferVehicleModel data,
  ) async {
    var latitude = data.destinationAddressLatitude;
    var longitude = data.destinationAddressLongitude;

    if (Platform.isAndroid) {
      AndroidIntent intent = AndroidIntent(
        action: 'action_view',
        package: 'com.google.android.apps.maps',
        // data: 'geo:-6.9534333,107.5359194',
        data: 'geo:$latitude,$longitude',
      );
      await intent.launch();
    }
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    ResponseTransferVehicleModel data,
  ) {
    var scaffold = ScaffoldMessenger.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer Vehicle Details'),
        backgroundColor: const Color.fromARGB(255, 0, 115, 247),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref
                .read(jobOrderTransferVehicleStateNotifierProvider.notifier)
                .fetchJobOrderTransferVehicle(jobOrderId),
          ),
        ],
      ),
      body: SafeArea(
        child: JobOrderTransferVehicleDetail(
          data: data,
          onOpenMap: openGoogleMaps,
          onAction: () async {
            return onSlideButtonAction(scaffold, ref, data, () {
              Navigator.pop(context);
            });
          },
        ),
      ),
    );
  }

  RequestTransferVehicleTripModel createPayload(
    double currentLng,
    double currentLat,
    ResponseTransferVehicleModel data,
  ) {
    return RequestTransferVehicleTripModel(
      statusTrip: data.status == 'planned' ? 'start-trip' : 'finish-trip',
      addressLatitude: 0,
      addressLongitude: 0,
      rowVersion: data.rowVersion,
      jobOrderId: data.jobOrderId,
      // Add other fields as required
    );
  }
}
