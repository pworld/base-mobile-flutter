import 'package:app_management_system/feature/job_order/domain/model/job_order_model.dart';
import 'package:app_management_system/feature/job_order/presentation/pages/transfer_vehicle_screen.dart';
import 'package:app_management_system/feature/job_order/presentation/states/job_order_provider.dart';
import 'package:app_management_system/feature/job_order/presentation/widgets/job_order_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../shared/services/request_paginations_model.dart';

class HistoryJobOrderNewScreen extends HookConsumerWidget {
  const HistoryJobOrderNewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState<bool>(false);
    final jobOrders = useState<List<ResponseJobOrderList>>([]);
    const int limit = 10; // Number of items to fetch per request
    final offset = useState<int>(0); // Offset for pagination
    final hasMoreData = useState<bool>(
        false); // Flag to indicate if more data is available to fetch

    final refreshState = useState<int>(0);

    Future<void> fetchJobOrders() async {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(content: Text('Loaded')));

      // if (isLoading.value || !hasMoreData.value) return;
      if (isLoading.value) return;
      isLoading.value = true;

      // Construct the filter payload
      RequestPage jsonResponse = RequestPage(
        includeTotalRows: true,
        queryOps: QueryOps(
          filter: Filter(
            status: 'done'
          ),
          limit: 10,
          offset: 0,
          page: 1,
          totalRows: 50,
          sort: Sort(
            jobOrderDate: 'desc',
          ),
        ),
      );

      final result =
          await ref.read(jobOrderNewUseCaseProvider).jobOrders(jsonResponse);

      result.fold(
        (failure) {
          // Handle failure, perhaps by showing an error message.
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error fetching job orders: $failure')));
          isLoading.value =
              false; // Ensure isLoading is set to false in case of failure
        },
        (paginatedResponse) {
          if (paginatedResponse.data != null &&
              paginatedResponse.data!.isNotEmpty) {
            // Append the new job orders to the existing list
            // jobOrders.value = [...jobOrders.value, ...paginatedResponse.data!];
            jobOrders.value = paginatedResponse.data!;

            // Update the offset for the next fetch operation
            offset.value = paginatedResponse.data!.length;

            // Check if there might be more data to fetch
            // hasMoreData.value = paginatedResponse.data!.length == limit;
          } else {
            // No more data to fetch
            hasMoreData.value = false;
          }
          isLoading.value =
              false; // Ensure isLoading is set to false after processing the response
        },
      );
    }

    useEffect(() {
      fetchJobOrders();

      // Cleanup function
      return () {};
    }, [refreshState]);

    final scrollController = useScrollController();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        fetchJobOrders();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Orders'),
        backgroundColor: const Color.fromARGB(255, 0, 115, 247),
      ),
      body: isLoading.value && jobOrders.value.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Container(
              decoration: null,
              child: Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      triggerMode: RefreshIndicatorTriggerMode.anywhere,
                      onRefresh: fetchJobOrders,
                      child: ListView.builder(
                        controller: scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsetsDirectional.all(8.0),
                        itemCount: jobOrders.value.length +
                            (hasMoreData.value ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index >= jobOrders.value.length) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          final jobOrder = jobOrders.value[index];

                          // Creating a custom card widget for each job order
                          return JobOrderListItem(
                              jobOrder: jobOrder,
                              onTouch: () {
                                // Navigate to TransferVehicleScreen with the job order ID

                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => TransferVehicleScreen(
                                    jobOrderId: jobOrder.jobOrderId,
                                    listRefreshCallback: () {
                                      refreshState.value++;
                                    },
                                  ),
                                ));
                              });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
