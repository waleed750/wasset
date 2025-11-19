// ignore_for_file: public_member_api_docs, sort_constructors_first
class MySubscriptionEntity {
  final String? id;
  final String? name;
  final String? description;
  final String? price;
  final String? duration;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final String? startAt;
  final String? endAt;

  MySubscriptionEntity({
    this.id,
    this.name,
    this.description,
    this.price,
    this.duration,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.startAt,
    this.endAt,
  });

  String get startAtFormatted {
    final date = DateTime.tryParse(startAt ?? '2022-01-01') ?? DateTime.now();
    return '${date.day}/${date.month}/${date.year}';
  }

  String get endAtFormatted {
    final date = DateTime.parse(endAt ?? '2022-01-31');
    return '${date.day}/${date.month}/${date.year}';
  }
}

final dummyList = [
  MySubscriptionEntity(
    id: '1',
    name: 'Subscription 1',
    description: 'Subscription 1 Description',
    price: '100',
    duration: '30',
    status: 'active',
    createdAt: '2022-01-01',
    updatedAt: '2022-01-01',
    startAt: '2022-01-01',
    endAt: '2022-01-31',
  ),
  MySubscriptionEntity(
    id: '2',
    name: 'Subscription 2',
    description: 'Subscription 2 Description',
    price: '200',
    duration: '60',
    status: 'active',
    createdAt: '2022-01-01',
    updatedAt: '2022-01-01',
    startAt: '2022-01-01',
    endAt: '2022-02-28',
  ),
  MySubscriptionEntity(
    id: '3',
    name: 'Subscription 3',
    description: 'Subscription 3 Description',
    price: '300',
    duration: '90',
    status: 'active',
    createdAt: '2022-01-01',
    updatedAt: '2022-01-01',
    startAt: '2022-01-01',
    endAt: '2022-03-31',
  ),
  MySubscriptionEntity(
    id: '4',
    name: 'Subscription 4',
    description: 'Subscription 4 Description',
    price: '400',
    duration: '120',
    status: 'active',
    createdAt: '2022-01-01',
    updatedAt: '2022-01-01',
    startAt: '2022-01-01',
    endAt: '2022-04-30',
  ),
  MySubscriptionEntity(
    id: '5',
    name: 'Subscription 5',
    description: 'Subscription 5 Description',
    price: '500',
    duration: '150',
    status: 'active',
    createdAt: '2022-01-01',
    updatedAt: '2022-01-01',
    startAt: '2022-01-01',
    endAt: '2022-05-31',
  ),
];
