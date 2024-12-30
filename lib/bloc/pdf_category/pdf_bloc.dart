import 'package:bloc/bloc.dart';
import 'package:formula/model/pdf_model.dart';

import 'package:formula/repository/repository.dart';
import 'package:meta/meta.dart';

class PdfBloc extends Bloc<PdfEvent, PdfState> {
  Repository repository = Repository();

  PdfBloc() : super(PdfInitial()) {
    on<PdfEvent>((event, emit) {});
    on<PdfGetEvent>(getPdfs);
  }

  Future<void> getPdfs(
      PdfGetEvent event, Emitter<PdfState> state) async {
    emit(PdfLoadingState(isLoading: true));

    await repository.getPdfs(event.pdfCategoryId).then((List<PdfModel> pdfCategories) {
      emit(PdfGetState(pdfs: pdfCategories));
    }).catchError((e) {
      emit(PdfErrorState(e: e));
    });
  }
}

@immutable
sealed class PdfEvent {}

class PdfGetEvent extends PdfEvent {
  final String pdfCategoryId;
  PdfGetEvent({required this.pdfCategoryId});
}

@immutable
sealed class PdfState {}

final class PdfInitial extends PdfState {}

final class PdfLoadingState extends PdfState {
  final bool isLoading;

  PdfLoadingState({required this.isLoading});
}

final class PdfGetState extends PdfState {
  final List<PdfModel> pdfs;

  PdfGetState({required this.pdfs});
}

final class PdfErrorState extends PdfState {
  final dynamic e;

  PdfErrorState({required this.e});
}
