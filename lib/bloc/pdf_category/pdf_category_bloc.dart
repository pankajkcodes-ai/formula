import 'package:bloc/bloc.dart';
import 'package:formula/model/pdf_category_model.dart';

import 'package:formula/repository/repository.dart';
import 'package:meta/meta.dart';

class PdfCategoryBloc extends Bloc<PdfCategoryEvent, PdfCategoryState> {
  Repository repository = Repository();

  PdfCategoryBloc() : super(PdfCategoryInitial()) {
    on<PdfCategoryEvent>((event, emit) {});
    on<PdfCategoryGetEvent>(getPdfCategories);
  }

  Future<void> getPdfCategories(
      PdfCategoryGetEvent event, Emitter<PdfCategoryState> state) async {
    emit(PdfCategoryLoadingState(isLoading: true));
    await repository
        .getPdfCategories()
        .then((List<PdfCategoryModel> pdfCategories) {
      emit(PdfCategoryGetState(pdfCategories: pdfCategories));
    }).catchError((e) {
      emit(PdfCategoryErrorState(e: e));
    });
  }
}

@immutable
sealed class PdfCategoryEvent {}

class PdfCategoryGetEvent extends PdfCategoryEvent {}

@immutable
sealed class PdfCategoryState {}

final class PdfCategoryInitial extends PdfCategoryState {}

final class PdfCategoryLoadingState extends PdfCategoryState {
  final bool isLoading;

  PdfCategoryLoadingState({required this.isLoading});
}

final class PdfCategoryGetState extends PdfCategoryState {
  final List<PdfCategoryModel> pdfCategories;

  PdfCategoryGetState({required this.pdfCategories});
}

final class PdfCategoryErrorState extends PdfCategoryState {
  final dynamic e;

  PdfCategoryErrorState({required this.e});
}
