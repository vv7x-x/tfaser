import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../shared/models/quran_models.dart';
import '../../../../shared/services/quran_api_service.dart';

// Events
abstract class QuranEvent extends Equatable {
  const QuranEvent();

  @override
  List<Object?> get props => [];
}

class LoadSurahs extends QuranEvent {}

class SearchSurahs extends QuranEvent {
  final String query;

  const SearchSurahs(this.query);

  @override
  List<Object?> get props => [query];
}

class FilterSurahs extends QuranEvent {
  final String filter;

  const FilterSurahs(this.filter);

  @override
  List<Object?> get props => [filter];
}

class LoadSurahDetails extends QuranEvent {
  final int surahNumber;

  const LoadSurahDetails(this.surahNumber);

  @override
  List<Object?> get props => [surahNumber];
}

// States
abstract class QuranState extends Equatable {
  const QuranState();

  @override
  List<Object?> get props => [];
}

class QuranInitial extends QuranState {}

class QuranLoading extends QuranState {}

class QuranLoaded extends QuranState {
  final List<Surah> surahs;
  final List<Surah> filteredSurahs;

  const QuranLoaded({
    required this.surahs,
    required this.filteredSurahs,
  });

  @override
  List<Object?> get props => [surahs, filteredSurahs];
}

class QuranError extends QuranState {
  final String message;

  const QuranError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class QuranBloc extends Bloc<QuranEvent, QuranState> {
  final QuranApiService _quranApiService;

  QuranBloc({QuranApiService? quranApiService}) 
      : _quranApiService = quranApiService ?? QuranApiService(),
        super(QuranInitial()) {
    on<LoadSurahs>(_onLoadSurahs);
    on<SearchSurahs>(_onSearchSurahs);
    on<FilterSurahs>(_onFilterSurahs);
    on<LoadSurahDetails>(_onLoadSurahDetails);
  }

  void _onLoadSurahs(LoadSurahs event, Emitter<QuranState> emit) async {
    emit(QuranLoading());
    
    try {
      final surahs = await _quranApiService.getSurahs();
      emit(QuranLoaded(
        surahs: surahs,
        filteredSurahs: surahs,
      ));
    } catch (e) {
      emit(QuranError('فشل في تحميل السور: $e'));
    }
  }

  void _onSearchSurahs(SearchSurahs event, Emitter<QuranState> emit) {
    if (state is QuranLoaded) {
      final currentState = state as QuranLoaded;
      final query = event.query.toLowerCase();
      
      final filteredSurahs = currentState.surahs.where((surah) {
        return surah.name.toLowerCase().contains(query) ||
               surah.englishName.toLowerCase().contains(query) ||
               surah.arabicName.toLowerCase().contains(query);
      }).toList();
      
      emit(QuranLoaded(
        surahs: currentState.surahs,
        filteredSurahs: filteredSurahs,
      ));
    }
  }

  void _onFilterSurahs(FilterSurahs event, Emitter<QuranState> emit) {
    if (state is QuranLoaded) {
      final currentState = state as QuranLoaded;
      List<Surah> filteredSurahs = currentState.surahs;
      
      switch (event.filter) {
        case 'makkah':
          filteredSurahs = currentState.surahs
              .where((surah) => surah.revelationType == 'Meccan')
              .toList();
          break;
        case 'madinah':
          filteredSurahs = currentState.surahs
              .where((surah) => surah.revelationType == 'Medinan')
              .toList();
          break;
        case 'all':
        default:
          filteredSurahs = currentState.surahs;
          break;
      }
      
      emit(QuranLoaded(
        surahs: currentState.surahs,
        filteredSurahs: filteredSurahs,
      ));
    }
  }

  void _onLoadSurahDetails(LoadSurahDetails event, Emitter<QuranState> emit) async {
    emit(QuranLoading());
    
    try {
      final surah = await _quranApiService.getSurah(event.surahNumber);
      emit(QuranLoaded(
        surahs: [surah],
        filteredSurahs: [surah],
      ));
    } catch (e) {
      emit(QuranError('فشل في تحميل تفاصيل السورة: $e'));
    }
  }

}
