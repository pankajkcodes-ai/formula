import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formula/bloc/language/language_bloc.dart';
import 'package:formula/bloc/pdf_category/pdf_bloc.dart';
import 'package:formula/model/pdf_category_model.dart';
import 'package:formula/res/app_urls.dart';
import 'package:formula/res/resources.dart';
import 'package:formula/views/html_view/pdf_view.dart';
import 'package:formula/views/widgets/list_shimmer.dart';
import 'package:formula/views/widgets/no_data.dart';

class PdfList extends StatefulWidget {
  final PdfCategoryModel pdfCategoryModel;
  const PdfList({super.key, required this.pdfCategoryModel});

  @override
  State<PdfList> createState() => _PdfListState();
}

class _PdfListState extends State<PdfList> {
  @override
  void initState() {
    context
        .read<PdfBloc>()
        .add(PdfGetEvent(pdfCategoryId: widget.pdfCategoryModel.id.toString()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.tertiaryFixed,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        toolbarHeight: Resources.dimens.height(context) * 0.08,
        title: Text(
          '${selectedLanguage == LanguageEnums.hindi
              ? widget.pdfCategoryModel.titleHi.toString()
              : widget.pdfCategoryModel.title.toString()} ',
          style: Resources.styles
              .kTextStyle18(Theme.of(context).colorScheme.tertiaryFixed),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
        child: BlocConsumer<PdfBloc, PdfState>(
          listener: (context, state) {
            print("listener State : $state");
          },
          builder: (context, state) {
            print("builder State : $state");
            if (state is PdfErrorState) {
              return const ListShimmer();
            } else if (state is PdfLoadingState) {
              return const ListShimmer();
            } else if (state is PdfGetState) {
              var data = state.pdfs;

              return data.isNotEmpty
                  ? ListView.builder(
                      itemCount: data.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        print("data.Pdfs : ${data[index]}");
                        return GestureDetector(
                          onTap: () {
                            /// navigate based on the index
                            print("data.Pdfs : ${data[index]}");

                            // AdmobHelper().loadRewardedAd();
                            // AdmobHelper().showRewardAd();

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PdfView(
                                          url:
                                              "${AppUrls.baseUrl}/${data[index].file}",
                                        )));
                          },
                          child: Card(
                            clipBehavior: Clip.none,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 1.0,
                                )),
                            child: ListTile(
                              contentPadding: const EdgeInsets.only(left: 10),
                              title: SizedBox(
                                width: Resources.dimens.width(context) * 0.7,
                                child: Text(
                                  selectedLanguage == LanguageEnums.hindi
                                      ? data[index].title.toString()
                                      : data[index].title.toString(),
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        );
                      })
                  : const NoData();
            }
            return const ListShimmer();
          },
        ),
      ),
    );
  }
}