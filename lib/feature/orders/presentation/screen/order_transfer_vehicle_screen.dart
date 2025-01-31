import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:app_management_system/feature/orders/domain/model/order_transfer_vehicle_response_model.dart';
import 'package:app_management_system/feature/orders/domain/model/order_transfer_vehicle_trip_payload_model.dart';
import 'package:app_management_system/feature/orders/presentation/provider/order_provider.dart';
import 'package:app_management_system/shared/helper.dart';
import 'package:app_management_system/shared/loading/loading_overlay.dart';
import 'package:app_management_system/shared/location/location_service.dart';
import 'package:app_management_system/shared/specifics/job_order_helpers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:slider_button/slider_button.dart';
import 'package:timeline_tile/timeline_tile.dart';

class OrderTransferVehicleDetailScreen extends ConsumerStatefulWidget {
  final String id;

  const OrderTransferVehicleDetailScreen({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<OrderTransferVehicleDetailScreen> createState() =>
      OrderTransferVehicleDetailState();
}

class OrderTransferVehicleDetailState
    extends ConsumerState<OrderTransferVehicleDetailScreen> {
  @override
  void initState() {
    super.initState();

    load();
  }

  Future<void> load() async {
    var orderNotifier = ref.read(orderTransferVehicleProvider.notifier);

    Future.delayed(
      const Duration(milliseconds: 1),
      () async {
        orderNotifier.fetch(widget.id);
      },
    );
  }

  void reset() async {
    ref.read(orderTransferVehicleProvider.notifier).reset();
  }

  void navigateBack() async {
    ref.read(orderTransferVehicleProvider.notifier).reset();
    ref.invalidate(orderListProvider);
    context.pop();
  }

  void openGoogleMap(OrderTransferVehicleResponseModel order) async {
    var latitude = order.destinationAddressLatitude;
    var longitude = order.destinationAddressLongitude;

    if (Platform.isAndroid) {
      AndroidIntent intent = AndroidIntent(
        action: 'action_view',
        package: 'com.google.android.apps.maps',
        // data: 'geo:-6.9534333,107.5359194',
        data: 'geo:$latitude,$longitude',
      );
      await intent.launch();
    } else {
      showSnackbar(context, 'Not supported for this platform');
    }
  }

  Future<bool?> onAction(OrderTransferVehicleResponseModel order) async {
    var viewNotifier = ref.read(detailViewProvider.notifier);

    viewNotifier.setState(loading: true);

    var orderProvider = ref.read(orderTransferVehicleProvider.notifier);
    var currentLocation = await LocationService().getLocation();

    OrderTransferVehicleTripPayloadModel payload =
        OrderTransferVehicleTripPayloadModel(
      addressLongitude: currentLocation.longitude ?? 0,
      addressLatitude: currentLocation.latitude ?? 0,
      rowVersion: order.rowVersion,
    );

    if (order.status == JobOrderStatus.planned.name) {
      orderProvider.startTrip(widget.id, payload, () {
        viewNotifier.setState(loading: false);
        showSnackbar(
          context,
          "Order started successfully!",
        );
        navigateBack();
      }, (error) {
        viewNotifier.setState(loading: false);
        showSnackbar(
          context,
          error,
        );
      });
    } else if (order.status == JobOrderStatus.ontrip.name) {
      orderProvider.finishTrip(widget.id, payload, () {
        viewNotifier.setState(loading: false);
        showSnackbar(
          context,
          "Order completed successfully!",
        );
        navigateBack();
      }, (error) {
        viewNotifier.setState(loading: false);
        showSnackbar(
          context,
          error,
        );
      });
    }

    return false;
  }

  Widget statusChip(JobOrderStatus status) {
    var (bg, text) = jobOrderStatusChipColor(status);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        color: bg,
      ),
      child: Text(
        status.label,
        style: TextStyle(
          color: text,
          fontWeight: FontWeight.w500,
          fontSize: 11,
        ),
      ),
    );
  }

  Widget routeInfo(
    BuildContext context,
    OrderTransferVehicleResponseModel? order,
  ) {
    ThemeData theme = Theme.of(context);
    var status = intoJobOrderStatus(order?.status ?? '');

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order?.jobOrderNumber ?? '-',
                      style: TextStyle(
                        color: theme.primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      order?.vehiclePlateNumber ?? '-',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [statusChip(status)],
              ),
            ],
          ),
          const Divider(),
          SizedBox(
            child: TimelineTile(
              isFirst: true,
              afterLineStyle:
                  LineStyle(color: theme.primaryColor, thickness: 2),
              indicatorStyle: IndicatorStyle(
                indicatorXY: 0.35,
                color: theme.primaryColor,
                width: 12,
                height: 12,
              ),
              endChild: Padding(
                padding: const EdgeInsets.only(left: 24, top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        order?.originCityName ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Text(
                      order == null
                          ? ''
                          : convertTimeZone(
                              order.departureDateTime,
                              order.originTimezoneId,
                            ),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            child: TimelineTile(
              isLast: true,
              beforeLineStyle:
                  LineStyle(color: theme.primaryColor, thickness: 2),
              indicatorStyle: IndicatorStyle(
                indicatorXY: 0.35,
                color: theme.primaryColor,
                width: 12,
                height: 12,
              ),
              endChild: Padding(
                padding: const EdgeInsets.only(left: 24, top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        order?.destinationCityName ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Text(
                      order == null
                          ? ''
                          : convertTimeZone(
                              order.arrivalDateTime,
                              order.destinationTimezoneId,
                            ),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget detailSectionLabelValue(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
                color: Color(0xFFC3C5C6),
                fontWeight: FontWeight.w500,
                fontSize: 12),
          ),
          Text(value)
        ],
      ),
    );
  }

  Widget detailSection(
    BuildContext context,
    OrderTransferVehicleResponseModel? order,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Text(
                  'Rincian',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              detailSectionLabelValue(
                'Alamat lengkap',
                order?.destinationAddressStreet ?? '',
              ),
              Row(
                children: [
                  Expanded(
                    child: detailSectionLabelValue(
                      'Uang jalan',
                      formatRupiah(order?.tripExpenseAmount),
                    ),
                  ),
                  Expanded(
                    child: detailSectionLabelValue(
                      'Uang jalan diterima',
                      formatRupiah(order?.tripExpenseAmount),
                    ),
                  ),
                ],
              ),
              detailSectionLabelValue(
                'Alasan Transfer',
                order?.transferReason ?? '-',
              ),
              detailSectionLabelValue(
                'Catatan',
                order?.driverNote ?? '-',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget actionSlider(
      BuildContext context, OrderTransferVehicleResponseModel? order) {
    ThemeData theme = Theme.of(context);
    var status = intoJobOrderStatus(order?.status ?? '');

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        verticalDirection: VerticalDirection.up,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: status == JobOrderStatus.ontrip ||
                    status == JobOrderStatus.planned,
                child: SliderButton(
                  action: () => onAction(order!),
                  label: Text(
                    status == JobOrderStatus.ontrip
                        ? 'Sampai Tujuan'
                        : 'Mulai Perjalanan',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
                  icon: const Center(
                    child: Icon(
                      Icons.local_shipping,
                      color: Colors.white,
                      size: 40.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                  ),
                  width: 240,
                  height: 60,
                  buttonColor: theme.primaryColor,
                  backgroundColor: Colors.white,
                  highlightedColor: Colors.white,
                  baseColor: theme.primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    var orderProvider = ref.watch(orderTransferVehicleProvider);
    var viewProvider = ref.watch(detailViewProvider);
    var order = orderProvider.response.data;

    return PopScope(
      canPop: false,
      onPopInvoked: (popped) {
        if (!popped) {
          Future.delayed(const Duration(milliseconds: 200), () {
            reset();
          });
          context.pop();
        }
      },
      child: StatelessLoadingOverlay(
        isLoading: viewProvider.loading,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: theme.colorScheme.onPrimary,
            iconTheme: const IconThemeData(color: Colors.black),
            titleTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            title: const Text(
              'Transfer Vehicle Detail',
              style: TextStyle(
                color: Color(0xFF000000),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              IconButton.outlined(
                onPressed: () {},
                icon: const Icon(Icons.refresh),
              ),
            ],
            actionsIconTheme: const IconThemeData(color: Colors.black),
          ),
          backgroundColor: theme.colorScheme.surfaceVariant,
          body: order == null
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        routeInfo(context, order),
                        const SizedBox(height: 8),
                        detailSection(context, order),
                        Expanded(child: actionSlider(context, order))
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
