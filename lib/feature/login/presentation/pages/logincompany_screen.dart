import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../locale/app_localization.dart';
import '../../../../shared/storages/secure_storage.dart';
import '../../domain/model/loginOTP_model.dart';
import '../../domain/model/logincompany_model.dart';
import '../states/login_provider.dart';

class LoginCompanyScreen extends HookConsumerWidget {
  final ResponseAuthenticationModel authResponse;

  const LoginCompanyScreen({super.key, required this.authResponse});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(true); // Start with loading true
    final companyList = useState<List<CompanyModel>>([]);

    useEffect(() {
      Future<void> loadCompanies() async {
        try {
          final companies = await ref.read(getLoginCompanyStateNotifierProvider.notifier).getCompanies();
          companyList.value = companies; // Assuming `getCompanies` returns a List<CompanyModel>
        } catch (error) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: Text(error.toString()),
              ),
            );
          });
        } finally {
          isLoading.value = false; // Stop loading whether there was an error or not
        }
      }

      loadCompanies();
      return null; // No cleanup action needed
    }, []); // Empty dependency array to run only once

    void navigateToDetail(CompanyModel company) async {
      isLoading.value = true; // Show loading indicator
      String? refreshToken = await SecureStorageHelper.read('refreshToken');
      RequestLoginCompanyModel requestData = RequestLoginCompanyModel(
        TenantId: company.TenantId,
        RefreshToken: refreshToken!,
      );

      await ref.read(loginUseCaseProvider).loginCompany(requestData).then((_) {
        isLoading.value = false; // Hide loading indicator
        context.go('/home'); // Navigate to the home screen upon success
      }).catchError((error) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Failed to select company: $error'),
              content: Text(error.toString()),
            ),
          );
        });
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.translate('choosecompany')),
      ),
      body: isLoading.value ? const Center(child: CircularProgressIndicator()) : Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
          ),
          itemCount: companyList.value.length,
          itemBuilder: (context, index) {
            final company = companyList.value[index];
            return InkWell(
              onTap: () => navigateToDetail(company),
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Placeholder image; replace with actual company image if available
                    const Icon(Icons.business, size: 50),
                    const SizedBox(height: 10),
                    Text(company.CompanyName),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
