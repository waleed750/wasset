import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:waseet/features/brokers/domain/entities/fav_broker_entity.dart';
import 'package:waseet/features/brokers/domain/repositories/brokers_repository.dart';
import 'package:waseet/features/user/domain/entities/category/category_entity.dart';
import 'package:waseet/features/user/domain/entities/request/complaint_request.dart';
import 'package:waseet/features/user/domain/entities/wasset_profile_entity.dart';
import 'package:waseet/features/user/domain/repositories/complaints_repository.dart';
import 'package:waseet/features/user/domain/repositories/home_repository.dart';
import 'package:waseet/res/enums/broker_type.dart';
import 'package:waseet/res/enums/complaint_type.dart';
import 'package:waseet/res/resource.dart';

part 'kingdom_broker_state.dart';

class KingdomBrokerCubit extends Cubit<KingdomBrokerState> {
  KingdomBrokerCubit({
    this.cityId,
    required BrokerRepository brokerRepository,
    required HomeRepository homeRepository,
    required ComplaintRepository complaintRepository,
  })  : _brokerRepository = brokerRepository,
        _homeRepository = homeRepository,
        _complaintRepository = complaintRepository,
        super(const KingdomBrokerInitial()) {
    init();
  }
  final ComplaintRepository _complaintRepository;
  final BrokerRepository _brokerRepository;
  final HomeRepository _homeRepository;
  final int? cityId;
  List<WassetProfileEntity?>? brokers;
  List<FavBrokerEntity?>? favBrokers;
  Future<void> init() async {
    try {
      emit(state.copyWith(status: BrokerStatus.loading));
      final brokersData = await _brokerRepository.getBrokers(cityId: cityId, page: 1);
      final favBrokersData =
          await _brokerRepository.getFavBrokers(cityId: cityId);
      final categories = await _homeRepository.getCategories();

      if (brokersData is ResourceSuccess && categories is ResourceSuccess) {
        favBrokers = favBrokersData.data;
        favBrokers?.forEach((favBroker) {
          favBroker!.profile!.isFav = true;
        });
        brokers = brokersData.data;
        if (favBrokers != null && brokers != null) {
          for (final broker in brokers!) {
            for (final favBroker in favBrokers!) {
              if (broker!.userId == favBroker!.profile!.userId) {
                broker.isFav = true;
                break;
              }
            }
          }
        }
        emit(
          state.copyWith(
            brokers: brokers,
            favBrokers: favBrokers,
            categories: categories.data,
            status: BrokerStatus.loaded,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: BrokerStatus.error,
            errorMessage: categories.message,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: BrokerStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void setSelectedCategory(List<CategoryEntity>? categories) {
    emit(state.copyWith(selectedCategories: categories));
  }

  void setSelectedType(BrokerType? type) {
    emit(state.copyWith(selectedTypes: type));
  }

  void setSelectedGender(String gender) {
    emit(state.copyWith(gender: gender));
  }

  void brokersUnfiltering() {
    emit(
      KingdomBrokerState(
        categories: state.categories,
        addAndRemoveBrokerMessage: state.addAndRemoveBrokerMessage,
        errorMessage: state.errorMessage,
        processMessage: state.processMessage,
        brokers: brokers!,
        favBrokers: favBrokers!,
        status: BrokerStatus.loaded,
        description: state.description,
        name: state.name,
      ),
    );
  }

  void brokersFiltering() {
    var brokersFilteringResult = brokers;
    if (state.selectedTypes != null) {
      brokersFilteringResult = brokersFilteringResult?.where((element) {
        return element!.officeType == state.selectedTypes!.name;
      }).toList();
    }
    if (state.selectedCategories != null) {
      brokersFilteringResult = brokersFilteringResult?.where((element) {
        if (element!.wassetSpecialization != null) {
          return state.selectedCategories!.any((category) {
            return element.wassetSpecialization!.contains(category);
          });
        } else {
          return false;
        }
      }).toList();
    }
    if (state.gender != null) {
      brokersFilteringResult = brokersFilteringResult?.where((element) {
        return element?.gender == state.gender;
      }).toList();
    }
    state.copyWith(
      brokers: brokersFilteringResult,
      status: BrokerStatus.loaded,
    );
  }

  Future<void> addFavBrokers(int brokerId) async {
    try {
      emit(
        state.copyWith(
          status: BrokerStatus.addLoading,
        ),
      );
      final response =
          await _brokerRepository.addFavBrokers(brokerId.toString());
      if (response is ResourceSuccess) {
        for (final broker in brokers!) {
          if (broker!.userId == brokerId) {
            broker.isFav = true;
            favBrokers!.add(FavBrokerEntity(profile: broker));
          }
        }
        emit(
          state.copyWith(
            status: BrokerStatus.addAndRemoveSuccess,
            addAndRemoveBrokerMessage: response.message,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: BrokerStatus.addAndRemoveError,
            errorMessage: response.message,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: BrokerStatus.addAndRemoveError,
          errorMessage: e.toString(),
        ),
      );
    }
    emit(
      state.copyWith(
        status: BrokerStatus.loaded,
      ),
    );
  }

  Future<void> removeFavBrokers(int brokerId) async {
    try {
      emit(
        state.copyWith(
          status: BrokerStatus.removeLoading,
        ),
      );
      final removeMessage =
          await _brokerRepository.removeFavBrokers(brokerId.toString());
      if (removeMessage is ResourceSuccess) {
        favBrokers!
            .removeWhere((broker) => broker?.profile?.userId == brokerId);
        for (final broker in brokers!) {
          if (broker?.userId == brokerId) {
            broker?.isFav = false;
          }
        }

        emit(
          state.copyWith(
            status: BrokerStatus.addAndRemoveSuccess,
            addAndRemoveBrokerMessage: removeMessage.message,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: BrokerStatus.addAndRemoveError,
            errorMessage: removeMessage.message,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: BrokerStatus.addAndRemoveError,
          errorMessage: e.toString(),
        ),
      );
    }
    emit(
      state.copyWith(
        status: BrokerStatus.loaded,
        errorMessage: '',
      ),
    );
  }

  void setDescription(String description) {
    emit(state.copyWith(description: description));
  }

  Future<void> createComplaint({
    required int brokerId,
  }) async {
    try {
      emit(state.copyWith(status: BrokerStatus.processLoading));
      final response = await _complaintRepository.createComplaint(
        ComplaintRequest(
          description: state.description ?? '',
          type: ComplaintType.user.name,
          userId: brokerId,
        ),
      );
      if (response is ResourceSuccess) {
        emit(
          state.copyWith(
            status: BrokerStatus.processSuccess,
            processMessage: response.data,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: BrokerStatus.processFailure,
            processMessage: response.message,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: BrokerStatus.processFailure,
          processMessage: e.toString(),
        ),
      );
    }
    emit(
      state.copyWith(
        status: BrokerStatus.loaded,
        processMessage: '',
      ),
    );
  }

  void setSearchKey(String name) {
    emit(state.copyWith(name: name));
  }

  void searchByName() {
    var brokerSearchResult = brokers;
    if (state.name != null) {
      brokerSearchResult = brokerSearchResult?.where((broker) {
        return broker!.name!.contains(state.name!);
      }).toList();
    }
    emit(
      state.copyWith(
        brokers: brokerSearchResult,
        status: BrokerStatus.loaded,
      ),
    );
  }

  Future<void> loadMore() async {
    if (state.status == BrokerStatus.loadingMore || !state.hasMore) {
      return;
    }
    
    try {
      emit(state.copyWith(status: BrokerStatus.loadingMore));
      
      final nextPage = state.currentPage + 1;
      final brokersData = await _brokerRepository.getBrokers(cityId: cityId, page: nextPage);
      
      if (brokersData is ResourceSuccess) {
        final newBrokers = brokersData.data;
        
        if (newBrokers == null || newBrokers.isEmpty) {
          emit(
            state.copyWith(
              status: BrokerStatus.loaded,
              hasMore: false,
            ),
          );
          return;
        }
        
        // دمج البيانات الجديدة مع القديمة
        final allBrokers = [...state.brokers, ...newBrokers];
        brokers = allBrokers;
        
        emit(
          state.copyWith(
            brokers: allBrokers,
            currentPage: nextPage,
            status: BrokerStatus.loaded,
            hasMore: newBrokers.length >= 10, // افترض أن كل صفحة تحتوي على 10 عناصر
          ),
        );
      } else {
        emit(state.copyWith(status: BrokerStatus.loaded));
      }
    } catch (e) {
      emit(state.copyWith(status: BrokerStatus.loaded));
    }
  }
}
