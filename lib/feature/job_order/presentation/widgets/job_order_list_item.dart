import 'package:app_management_system/feature/job_order/domain/model/job_order_model.dart';
import 'package:app_management_system/shared/helper.dart';
import 'package:app_management_system/shared/specifics/job_order_helpers.dart';
import 'package:app_management_system/theme/app_color.dart';
import 'package:app_management_system/theme/app_text.dart';
import 'package:flutter/material.dart';

class JobOrderListItem extends StatelessWidget {
  final void Function() onTouch;
  final ResponseJobOrderList jobOrder;

  const JobOrderListItem({
    super.key,
    required this.jobOrder,
    required this.onTouch,
  });

  TableRow labelValue(String label, Widget child) {
    return TableRow(children: [
      Text(
        label,
        style: const TextStyle(
          color: AppColors.richblack04,
        ),
      ),
      child,
    ]);
  }

  Widget cardHeader() {
    JobOrderStatus status = intoJobOrderStatus(jobOrder.status);

    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.richblack08)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(children: [
          Expanded(
            child: Text(
              jobOrder.jobOrderNumber,
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
                jobOrder.vehiclePlateNumber ?? '-',
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

  Widget cardBodyVehicleTransfer() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        'Asal',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.richblack04,
                        ),
                      ),
                      Text(
                        jobOrder.originCityName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                const Icon(Icons.arrow_right_alt),
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        'Tujuan',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.richblack04,
                        ),
                      ),
                      Text(
                        jobOrder.destinationCityName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Table(
            columnWidths: const {1: FractionColumnWidth(.6)},
            children: [
              // Tanggal Berangkat
              labelValue(
                'Tanggal Berangkat',
                Text(
                  convertTimeZone(
                    jobOrder.departureDateTime,
                    jobOrder.originTimeZoneId,
                  ),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),

              const TableRow(children: [
                SizedBox(height: 4.0),
                SizedBox(height: 4.0),
              ]),

              // Tanggal Sampai
              labelValue(
                'Tanggal Sampai',
                Text(
                  convertTimeZone(
                    jobOrder.departureDateTime,
                    jobOrder.originTimeZoneId,
                  ),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),

              const TableRow(children: [
                SizedBox(height: 4.0),
                SizedBox(height: 4.0),
              ]),

              // Tipe
              labelValue(
                'Tipe',
                Text(
                  JobOrderType.values.byName(jobOrder.jobOrderType).label,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),

              const TableRow(children: [
                SizedBox(height: 4.0),
                SizedBox(height: 4.0),
              ]),

              // Customer
              labelValue(
                'Customer',
                Text(
                  jobOrder.customerName!.isEmpty ? '-' : jobOrder.customerName!,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),

              const TableRow(children: [
                SizedBox(height: 4.0),
                SizedBox(height: 4.0),
              ]),

              // Return Trip:
              labelValue(
                'Return Trip',
                Row(
                  children: [
                    Checkbox(
                      value: jobOrder.isReturnTrip,
                      onChanged: null,
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget cardBodyCustomerOrder() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        'Asal',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.richblack04,
                        ),
                      ),
                      Text(
                        jobOrder.originCityName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                const Icon(Icons.arrow_right_alt),
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        'Tujuan',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.richblack04,
                        ),
                      ),
                      Text(
                        jobOrder.destinationCityName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Table(
            columnWidths: const {1: FractionColumnWidth(.6)},
            children: [
              // Tanggal Berangkat
              labelValue(
                'Tanggal Berangkat',
                Text(
                  convertTimeZone(
                    jobOrder.departureDateTime,
                    jobOrder.originTimeZoneId,
                  ),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),

              const TableRow(children: [
                SizedBox(height: 4.0),
                SizedBox(height: 4.0),
              ]),

              // Tanggal Sampai
              labelValue(
                'Tanggal Sampai',
                Text(
                  convertTimeZone(
                    jobOrder.departureDateTime,
                    jobOrder.originTimeZoneId,
                  ),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),

              const TableRow(children: [
                SizedBox(height: 4.0),
                SizedBox(height: 4.0),
              ]),

              // Tipe
              labelValue(
                'Tipe',
                Text(
                  JobOrderType.values.byName(jobOrder.jobOrderType).label,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),

              const TableRow(children: [
                SizedBox(height: 4.0),
                SizedBox(height: 4.0),
              ]),

              // Customer
              labelValue(
                'Customer',
                Text(
                  jobOrder.customerId,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),

              const TableRow(children: [
                SizedBox(height: 4.0),
                SizedBox(height: 4.0),
              ]),

              // Nomor Customer Order
              labelValue(
                'No. Customer Order',
                Text(
                  jobOrder.customerOrderId,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),

              const TableRow(children: [
                SizedBox(height: 4.0),
                SizedBox(height: 4.0),
              ]),

              // Return Trip:
              labelValue(
                'Return Trip',
                Row(
                  children: [
                    Checkbox(
                      value: jobOrder.isReturnTrip,
                      onChanged: null,
                    ),
                    const Expanded(child: SizedBox()),
                  ],
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
    var isVehicleTransfer = jobOrder.jobOrderType == 'transfer';

    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTouch,
        child: Column(
          children: [
            cardHeader(),
            isVehicleTransfer
                ? cardBodyVehicleTransfer()
                : cardBodyCustomerOrder(),
          ],
        ),
      ),
    );
  }
}
