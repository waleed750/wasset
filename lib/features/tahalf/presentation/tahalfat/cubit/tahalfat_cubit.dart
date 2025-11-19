import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:waseet/features/tahalf/domain/entities/request/attach_to_tahalf_request.dart';
import 'package:waseet/features/tahalf/domain/entities/tahalf_entity.dart';
import 'package:waseet/features/tahalf/domain/repositories/tahalf_repository.dart';
import 'package:waseet/features/user/domain/entities/category/category_entity.dart';
import 'package:waseet/features/user/domain/entities/cities_entity.dart';
import 'package:waseet/features/user/domain/entities/request/complaint_request.dart';
import 'package:waseet/features/user/domain/repositories/complaints_repository.dart';
import 'package:waseet/features/user/domain/repositories/home_repository.dart';
import 'package:waseet/res/enums/complaint_type.dart';
import 'package:waseet/res/resource.dart';
part 'tahalfat_state.dart';

class TahalfatCubit extends Cubit<TahalfatState> {
  TahalfatCubit({
    required ComplaintRepository complaintRepository,
    required HomeRepository homeRepository,
    required this.myID,
    required TahalfRepository tahalfRepository,
  })  : _tahalfRepository = tahalfRepository,
        _homeRepository = homeRepository,
        _complaintRepository = complaintRepository,
        super(const MyTahalfatInitial()) {
    init();
  }
  final ComplaintRepository _complaintRepository;
  final HomeRepository _homeRepository;
  final TahalfRepository _tahalfRepository;
  List<TahalfEntity> joinedTahalfList = [];
  List<TahalfEntity> tahalfList = [];
  List<TahalfEntity> myTahalfList = [];
  final int myID;
  Future<void> init() async {
    try {
      emit(state.copyWith(status: TahalfatStatus.loading));
      final tahalfData = await _tahalfRepository.getTahalfat();
      final cities = await _homeRepository.getCities(
        pageSize: 100,
      );
      final categories = await _homeRepository.getCategories();
      if (tahalfData is ResourceSuccess &&
          categories is ResourceSuccess &&
          cities is ResourceSuccess) {
        tahalfData.data?.forEach((tahalf) {
          if (tahalf.createdBy!.id == myID) {
            myTahalfList.add(tahalf);
          } else {
            if (tahalf.members!.map((e) => e.id).toList().contains(myID)) {
              joinedTahalfList.add(tahalf);
            } else {
              tahalfList.add(tahalf);
            }
          }
        });
        emit(
          state.copyWith(
            tahalfList: tahalfList,
            status: TahalfatStatus.loaded,
            joinedTahalfList: joinedTahalfList,
            myTahalfList: myTahalfList,
            cities: cities.data,
            categories: categories.data,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: TahalfatStatus.error,
            errorMessage: tahalfData.message,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: TahalfatStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void setPassWord(String passWord) {
    emit(state.copyWith(status: TahalfatStatus.initial, passWord: passWord));
  }

  Future<void> attachToTahalf(int tahalfId) async {
    try {
      emit(state.copyWith(status: TahalfatStatus.attachLoading));
      final response = await _tahalfRepository.attachToTahalf(
        AttachToTahalfRequest(
          userId: myID,
          tahalfID: tahalfId,
          password: state.passWord,
        ),
      );
      if (response is ResourceSuccess) {
        tahalfList.removeWhere((tahalf) {
          if (tahalf.id == tahalfId) {
            joinedTahalfList.add(tahalf);
            return true;
          }
          return false;
        });

        emit(
          state.copyWith(
            status: TahalfatStatus.processSuccess,
            joinedTahalfList: joinedTahalfList,
            tahalfList: tahalfList,
            processMessage: response.data,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: TahalfatStatus.processFailure,
            processMessage: response.message,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: TahalfatStatus.processFailure,
          processMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> deleteTahalf(int tahalfId) async {
    try {
      emit(state.copyWith(status: TahalfatStatus.processLoading));
      final response = await _tahalfRepository.deleteTahalf(tahalfId);
      if (response is ResourceSuccess) {
        myTahalfList.removeWhere((tahalf) => tahalf.id == tahalfId);
        emit(
          state.copyWith(
            status: TahalfatStatus.processSuccess,
            myTahalfList: myTahalfList,
            processMessage: response.data,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: TahalfatStatus.processFailure,
            processMessage: response.message,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: TahalfatStatus.processFailure,
          processMessage: e.toString(),
        ),
      );
    }
    emit(
      state.copyWith(
        status: TahalfatStatus.loaded,
      ),
    );
  }

  Future<void> exitFromTahalf(int tahalfId) async {
    try {
      emit(state.copyWith(status: TahalfatStatus.processLoading));
      final response = await _tahalfRepository.exitFromTahalf(
        AttachToTahalfRequest(userId: myID, tahalfID: tahalfId),
      );
      if (response is ResourceSuccess) {
        joinedTahalfList.removeWhere((tahalf) {
          if (tahalf.id == tahalfId) {
            tahalfList.add(tahalf);
            return true;
          }
          return false;
        });
        emit(
          state.copyWith(
            status: TahalfatStatus.processSuccess,
            joinedTahalfList: joinedTahalfList,
            tahalfList: tahalfList,
            processMessage: response.message,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: TahalfatStatus.processFailure,
            processMessage: response.message,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: TahalfatStatus.processFailure,
          processMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> setCity(CitiesEntity city) async {
    emit(
      state.copyWith(
        selectedCity: city,
      ),
    );
  }

  void setSelectedCategory(CategoryEntity selectedCategory) {
    emit(state.copyWith(selectedCategory: selectedCategory));
  }

  void setBrokerType(String brokerType) {
    emit(state.copyWith(selectedBrokerType: brokerType));
  }

  void setTahalfType(String tahalfType) {
    emit(state.copyWith(selectedTahalfType: tahalfType));
  }

  void tahalfatUnfiltering() {
    emit(
      TahalfatState(
        categories: state.categories,
        cities: state.cities,
        errorMessage: state.errorMessage,
        processMessage: state.processMessage,
        tahalfList: tahalfList,
        joinedTahalfList: joinedTahalfList,
        myTahalfList: myTahalfList,
        status: TahalfatStatus.loaded,
        description: state.description,
        name: state.name,
      ),
    );
  }

  void tahalfatFiltering() {
    var tahalfatFilteringResult = tahalfList;
    if (state.selectedCity != null) {
      tahalfatFilteringResult = tahalfatFilteringResult.where((tahalf) {
        return tahalf.city == state.selectedCity;
      }).toList();
    }
    if (state.selectedTahalfType != null) {
      tahalfatFilteringResult = tahalfatFilteringResult.where((tahalf) {
        return tahalf.allianceType! == state.selectedTahalfType;
      }).toList();
    }
    if (state.selectedBrokerType != null) {
      tahalfatFilteringResult = tahalfatFilteringResult.where((tahalf) {
        if (tahalf.wassetType != null) {
          return tahalf.wassetType!.contains(state.selectedBrokerType);
        } else {
          return false;
        }
      }).toList();
    }
    if (state.selectedCategory != null) {
      tahalfatFilteringResult = tahalfatFilteringResult.where((tahalf) {
        if (tahalf.categories != null) {
          return tahalf.categories!.contains(state.selectedCategory);
        } else {
          return false;
        }
      }).toList();
    }
    emit(
      state.copyWith(
        tahalfList: tahalfatFilteringResult,
        status: TahalfatStatus.loaded,
      ),
    );
  }

  void setDescription(String description) {
    emit(
      state.copyWith(
        status: TahalfatStatus.initial,
        description: description,
      ),
    );
  }

  Future<void> createComplaint({
    required int allianceId,
  }) async {
    try {
      emit(state.copyWith(status: TahalfatStatus.processLoading));
      final response = await _complaintRepository.createComplaint(
        ComplaintRequest(
          description: state.description ?? '',
          type: ComplaintType.alliance.name,
          allianceId: allianceId,
        ),
      );
      if (response is ResourceSuccess) {
        emit(
          state.copyWith(
            status: TahalfatStatus.processSuccess,
            tahalfList: tahalfList,
            joinedTahalfList: joinedTahalfList,
            processMessage: response.data,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: TahalfatStatus.processFailure,
            processMessage: response.message,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: TahalfatStatus.processFailure,
          processMessage: e.toString(),
        ),
      );
    }
  }

  void updateScreen() {
    joinedTahalfList.clear();
    myTahalfList.clear();
    tahalfList.clear();
    init();
  }

  void searchByName(String? name) {
    var tahalfatSearchResult = tahalfList;
    if (name != null) {
      tahalfatSearchResult = tahalfatSearchResult.where((tahalf) {
        return tahalf.name!.contains(name);
      }).toList();
    }
    emit(
      state.copyWith(
        tahalfList: tahalfatSearchResult,
        status: TahalfatStatus.loaded,
      ),
    );
  }
}
