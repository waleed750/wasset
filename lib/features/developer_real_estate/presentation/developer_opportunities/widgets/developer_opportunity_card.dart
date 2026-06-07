import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waseet/app/bloc/app_bloc.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/developer_opportunity_request_entity.dart';
import 'package:waseet/res/res.dart';

class DeveloperOpportunityCard extends StatelessWidget {
  const DeveloperOpportunityCard({
    super.key,
    required this.request,
    required this.onTap,
  });
  final DeveloperOpportunityRequestEntity request;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final showBrokerCommission =
        context.select((AppBloc bloc) => bloc.state.isWasset);

    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row with public request type only.
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColors.primaryColor.withValues(alpha: 0.08),
                    ),
                    child: const Icon(
                      Icons.assignment_outlined,
                      color: AppColors.primaryColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (request.communicationRequestType != null)
                          Text(
                            request.communicationRequestType!,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: AppColors.primaryColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Details grid
              _buildDetailsGrid(context, showBrokerCommission),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsGrid(BuildContext context, bool showBrokerCommission) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Location row
        if (request.city != null || request.neighborhood != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    [
                      if (request.city != null) request.city,
                      if (request.neighborhood != null) request.neighborhood,
                    ].join(' - '),
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        // Opportunity type row
        if (request.opportunityType != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                const Icon(Icons.category, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  'النوع: ${request.opportunityType}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        // Commission percentage row
        if (showBrokerCommission && request.commissionPercentage != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                const Icon(Icons.percent, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  'العمولة: ${request.commissionPercentage}%',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        // Description preview
        if (request.description != null && request.description!.isNotEmpty)
          Text(
            request.description!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
      ],
    );
  }
}
