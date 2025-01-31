import 'package:app_management_system/core/http/http_model.dart';
import 'package:app_management_system/feature/orders/presentation/provider/order_provider.dart';
import 'package:app_management_system/feature/orders/presentation/widget/order_list_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OrderListScreen extends ConsumerStatefulWidget {
  const OrderListScreen({super.key});

  @override
  ConsumerState<OrderListScreen> createState() => OrderListScreenState();
}

class OrderListScreenState extends ConsumerState<OrderListScreen> {
  HTTPPaginationPayloadModel orderListPayload() {
    return const HTTPPaginationPayloadModel(
      queryOps: QueryOption(
        filter: {},
        sort: {},
        limit: 10,
        offset: 0,
        page: 1,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    load();
  }

  Future<void> load() async {
    var orderListNotifier = ref.read(orderListProvider.notifier);

    Future.delayed(
      const Duration(milliseconds: 1),
      () async {
        orderListNotifier.fetch(true, orderListPayload());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme color = theme.colorScheme;

    var orderListNotifier = ref.watch(orderListProvider.notifier);
    var orderList = ref.watch(orderListProvider);
    var orders = orderListNotifier.getList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Job Order',
          style: TextStyle(
            color: theme.textTheme.titleLarge?.color,
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
        backgroundColor: color.surfaceVariant,
      ),
      body: SafeArea(
        child: orderList.response.data == null
            ? Container(
                decoration: BoxDecoration(
                  color: color.surfaceVariant,
                ),
                child: const Center(child: CircularProgressIndicator()),
              )
            : Container(
                decoration: BoxDecoration(
                  color: color.surfaceVariant,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return RefreshIndicator(
                      triggerMode: RefreshIndicatorTriggerMode.anywhere,
                      child: orders.isNotEmpty
                          ? ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: constraints.maxWidth,
                                minHeight: constraints.maxHeight,
                              ),
                              child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: const EdgeInsetsDirectional.all(8.0),
                                shrinkWrap: true,
                                itemCount: orders.length,
                                itemBuilder: (context, i) {
                                  final order = orders[i];
                                  return OrderListItem(
                                    order: order,
                                    onTouch: () {
                                      print('AAAAAAAAA');
                                      context.push('/orderTransferVehicle',
                                          extra: order.jobOrderId);
                                    },
                                  );
                                },
                              ),
                            )
                          : SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: constraints.maxWidth,
                                  minHeight: constraints.maxHeight,
                                ),
                                child: const Center(
                                  child: Text('Tidak ada order.'),
                                ),
                              ),
                            ),
                      onRefresh: () async {
                        orderListNotifier.fetch(true, orderListPayload());
                      },
                    );
                  },
                ),
              ),
      ),
    );
  }
}
