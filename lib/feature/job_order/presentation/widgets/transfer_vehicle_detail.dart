import 'package:app_management_system/feature/job_order/domain/model/transfer_vehicle_model.dart';
import 'package:app_management_system/shared/helper.dart';
import 'package:app_management_system/shared/specifics/job_order_helpers.dart';
import 'package:app_management_system/theme/app_color.dart';
import 'package:app_management_system/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:slider_button/slider_button.dart';
import 'package:timeline_tile/timeline_tile.dart';

class JobOrderTransferVehicleDetail extends StatelessWidget {
  final ResponseTransferVehicleModel data;
  final Future<bool> Function() onAction;
  final void Function(ResponseTransferVehicleModel) onOpenMap;

  const JobOrderTransferVehicleDetail({
    super.key,
    required this.data,
    required this.onAction,
    required this.onOpenMap,
  });

  Widget titleSection() {
    JobOrderStatus status = intoJobOrderStatus(data.status);

    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.richblack08)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Row(children: [
          Expanded(
            child: Text(
              data.jobOrderNumber,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: AppText.heading4.fontSize,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                data.vehiclePlateNumber,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                status.label,
                style: TextStyle(
                  color: jobOrderStatusColor(status),
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }

  Widget lateBanner() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: AppColors.kErrorColor,
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            child: Text(
              'Terlambat',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppText.heading5.fontSize,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget routeSection() {
    return Column(
      children: [
        SizedBox(
          child: TimelineTile(
            isFirst: true,
            beforeLineStyle:
                const LineStyle(color: AppColors.kPrimaryColor, thickness: 2),
            indicatorStyle: const IndicatorStyle(
                color: AppColors.kPrimaryColor, width: 12, height: 12),
            endChild: Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 8),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          data.originCityName,
                          style: AppText.heading5,
                        ),
                      ),
                      Text(
                        convertTimeZone(
                          data.departureDateTime,
                          data.originTimeZoneId,
                        ),
                        style: const TextStyle(
                          color: AppColors.richblack04,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          child: TimelineTile(
            isLast: true,
            beforeLineStyle:
                const LineStyle(color: AppColors.kPrimaryColor, thickness: 2),
            indicatorStyle: const IndicatorStyle(
                color: AppColors.kPrimaryColor, width: 12, height: 12),
            endChild: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          data.destinationCityName,
                          style: AppText.heading5,
                        ),
                      ),
                      Text(
                        convertTimeZone(
                          data.arrivalDateTime,
                          data.destinationTimeZoneId,
                        ),
                        style: const TextStyle(
                          color: AppColors.richblack04,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  TableRow detailSectionLabelValue(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            label,
            style: const TextStyle(color: AppColors.richblack04),
          ),
        ),
        Text(value),
      ],
    );
  }

  Widget detailSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Text(
                'Rincian',
                style: TextStyle(
                  fontSize: AppText.heading6.fontSize,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Table(
            children: [
              detailSectionLabelValue(
                'Alamat lengkap',
                data.destinationAddressStreet,
              ),
              TableRow(
                children: [
                  const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: InkWell(
                      onTap: () {
                        onOpenMap(data);
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: AppColors.kPrimaryColor,
                          ),
                          Text(
                            'Buka Map',
                            style: TextStyle(
                              color: AppColors.kPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              detailSectionLabelValue(
                'Uang jalan',
                formatRupiah(data.tripExpenseAmount),
              ),
              detailSectionLabelValue(
                'Uang jalan diterima',
                formatRupiah(data.tripExpensePaidAmount),
              ),
              detailSectionLabelValue(
                'Alasan Transfer',
                data.transferReason,
              ),
              detailSectionLabelValue(
                'Catatan',
                data.driverNote,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    JobOrderStatus status = intoJobOrderStatus(data.status);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          titleSection(),
          const SizedBox(height: 8),
          // lateBanner(),
          routeSection(),
          const SizedBox(height: 16),
          detailSection(),
          const SizedBox(height: 8),
          Expanded(
            child: Padding(
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
                          action: onAction,
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
                              semanticLabel:
                                  'Text to announce in accessibility modes',
                            ),
                          ),
                          width: 240,
                          height: 60,
                          buttonColor: AppColors.ultramarine04,
                          backgroundColor: AppColors.ultramarine02,
                          highlightedColor: Colors.white,
                          baseColor: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
