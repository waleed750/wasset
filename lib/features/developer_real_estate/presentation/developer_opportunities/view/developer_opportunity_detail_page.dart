import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waseet/app/bloc/app_bloc.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/developer_opportunity_request_entity.dart';
import 'package:waseet/res/res.dart';

class DeveloperOpportunityDetailPage extends StatelessWidget {
  const DeveloperOpportunityDetailPage({
    super.key,
    required this.request,
  });
  final DeveloperOpportunityRequestEntity request;

  @override
  Widget build(BuildContext context) {
    final showBrokerCommission =
        context.select((AppBloc bloc) => bloc.state.isWasset);

    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل الطلب'),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Details section
              _buildDetailSection(context, showBrokerCommission),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection(
    BuildContext context,
    bool showBrokerCommission,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'تفاصيل الطلب',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        _buildDetailRow('نوع الفرصة', request.opportunityType),
        _buildDetailRow('نوع طلب التواصل', request.communicationRequestType),
        _buildDetailRow('الموقع', request.city),
        _buildDetailRow('الحي', request.neighborhood),
        if (_hasLocationUrl) ...[
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => _openLocation(context),
            icon: const Icon(Icons.map_outlined),
            label: const Text('الذهاب للموقع'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primaryColor,
              side: const BorderSide(color: AppColors.primaryColor),
            ),
          ),
        ],
        if (request.description != null) ...[
          const SizedBox(height: 12),
          Text(
            'الوصف: ',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 4),
          Text(
            request.description!,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
        if (showBrokerCommission && request.commissionPercentage != null) ...[
          const SizedBox(height: 12),
          _buildDetailRow(
            'نسبة العمولة',
            '${request.commissionPercentage}%',
          ),
        ],
        if (request.communicationMethods != null &&
            request.communicationMethods!.isNotEmpty) ...[
          const SizedBox(height: 12),
          _buildDetailRow(
            'طرق التواصل',
            request.communicationMethods!.join(', '),
          ),
        ],
        if (request.additionalIncentive != null) ...[
          const SizedBox(height: 12),
          Text(
            'الحوافز الإضافية: ',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 4),
          Text(
            request.additionalIncentive!,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ],
    );
  }

  bool get _hasLocationUrl => request.locationUrl?.trim().isNotEmpty ?? false;

  Future<void> _openLocation(BuildContext context) async {
    final locationUrl = request.locationUrl?.trim();
    if (locationUrl == null || locationUrl.isEmpty) return;

    final uri = Uri.tryParse(locationUrl);
    if (uri != null && await canLaunchUrl(uri) && context.mounted) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      return;
    }

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تعذر فتح الموقع')),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    if (value == null || value.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
