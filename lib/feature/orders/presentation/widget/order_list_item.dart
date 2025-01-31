import 'package:app_management_system/feature/orders/domain/model/order_list_response_model.dart';
import 'package:app_management_system/shared/helper.dart';
import 'package:app_management_system/shared/specifics/job_order_helpers.dart';
import 'package:app_management_system/theme/app_color.dart';
import 'package:flutter/material.dart';

class OrderListItem extends StatelessWidget {
  final void Function() onTouch;
  final OrderListResponseModel order;

  const OrderListItem({
    super.key,
    required this.order,
    required this.onTouch,
  });

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

  Column labelled(String label, List<Widget> child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.richblack04,
            fontSize: 12,
          ),
        ),
        ...child,
      ],
    );
  }

  Widget valueWidget(String value) {
    return Text(
      value,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  TableRow spacing() {
    return const TableRow(children: [
      SizedBox.square(dimension: 12),
      SizedBox.square(dimension: 12),
    ]);
  }

  Widget cardHeader(ThemeData theme) {
    JobOrderStatus status = intoJobOrderStatus(order.status);

    return Container(
      padding: const EdgeInsets.only(bottom: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.richblack08)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.jobOrderNumber,
                  style: TextStyle(
                    color: theme.primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  order.vehiclePlateNumber ?? '-',
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
    );
  }

  Widget cardBodyVehicleTransfer() {
    var isVehicleTransfer = order.jobOrderType == 'transfer';

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      order.originCityName,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 1.2),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              const Icon(Icons.arrow_right_alt),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      order.destinationCityName,
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
          columnWidths: const {
            1: FractionColumnWidth(.5),
            2: FractionColumnWidth(.5)
          },
          children: [
            TableRow(
              children: [
                labelled('Tgl Berangkat', [
                  valueWidget(formatTimezone(
                    order.departureDateTime,
                    order.destinationTimezoneId,
                  ).$1),
                  valueWidget(formatTimezone(
                    order.departureDateTime,
                    order.destinationTimezoneId,
                  ).$2),
                ]),
                labelled('Tgl Sampai', [
                  valueWidget(formatTimezone(
                    order.departureDateTime,
                    order.destinationTimezoneId,
                  ).$1),
                  valueWidget(formatTimezone(
                    order.departureDateTime,
                    order.destinationTimezoneId,
                  ).$2),
                ])
              ],
            ),
            spacing(),
            TableRow(
              children: [
                labelled('Tipe', [
                  valueWidget(
                      JobOrderType.values.byName(order.jobOrderType).label),
                ]),
                labelled('Customer', [
                  valueWidget(
                      order.customerName.isEmpty ? '-' : order.customerName),
                ]),
              ],
            ),
            spacing(),
            TableRow(
              children: [
                labelled('Return Trip', [
                  valueWidget('-'),
                ]),
                const SizedBox()
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: InkWell(
        onTap: onTouch,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
          child: Column(
            children: [
              cardHeader(theme),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: cardBodyVehicleTransfer(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
