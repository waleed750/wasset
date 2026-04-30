import 'package:flutter/material.dart';
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
              // Developer info card
              if (request.developer != null)
                _buildDeveloperCard(context, request.developer!),
              const SizedBox(height: 24),
              // Details section
              _buildDetailSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeveloperCard(
    BuildContext context,
    DeveloperInfoEntity developer,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo
            if (developer.logo != null && developer.logo!.isNotEmpty)
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(developer.logo!),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[300],
                ),
                child: const Icon(
                  Icons.business,
                  color: Colors.grey,
                ),
              ),
            const SizedBox(width: 12),
            // Developer info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (developer.companyName != null)
                    Text(
                      developer.companyName!,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 4),
                  if (developer.responsibleName != null)
                    Text(
                      'المسؤول: ${developer.responsibleName}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  const SizedBox(height: 4),
                  if (developer.responsibleMobile != null)
                    Text(
                      developer.responsibleMobile!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(BuildContext context) {
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
        if (request.commissionPercentage != null) ...[
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
