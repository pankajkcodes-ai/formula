import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formula/bloc/language/language_bloc.dart';
import 'package:formula/bloc/pdf_category/pdf_category_bloc.dart';
import 'package:formula/data/local/pref_service.dart';
import 'package:formula/res/resources.dart';
import 'package:formula/routes/routes_path.dart';
import 'package:formula/views/widgets/list_shimmer.dart';
import 'package:formula/views/widgets/no_data.dart';
import 'package:go_router/go_router.dart';

class PdfCategoryList extends StatefulWidget {
  const PdfCategoryList({super.key});

  @override
  State<PdfCategoryList> createState() => _PdfCategoryListState();
}

class _PdfCategoryListState extends State<PdfCategoryList> {
  String selectedItem = 'All';

  @override
  void initState() {
    context.read<PdfCategoryBloc>().add(PdfCategoryGetEvent());
    _setStudentClass();
    super.initState();
  }

  final PrefService _prefService = PrefService();

  void _setStudentClass() {
    String? language = _prefService.getStudentClass();
    selectedItem = language ?? 'All';
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
          'Math PDF',
          style: Resources.styles
              .kTextStyle18(Theme.of(context).colorScheme.tertiaryFixed),
        ),
        actions: [
          Container(
            height: Resources.dimens.height(context) * 0.04,
            padding: const EdgeInsets.only(left: 10),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: DropdownButton<String>(
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 27,
              underline: const SizedBox(),
              value: selectedItem,
              onChanged: (String? newValue) {
                setState(() {
                  selectedItem = newValue!;
                  _prefService.setStudentClass(newValue);
                });
                print(newValue);
              },
              items: const [
                DropdownMenuItem(
                  value: 'All',
                  child: Text('All'),
                ),
                DropdownMenuItem(
                  value: 'Class 8',
                  child: Text('Class 8'),
                ),
                DropdownMenuItem(
                  value: 'Class 9',
                  child: Text('Class 9'),
                ),
                DropdownMenuItem(
                  value: 'Class 10',
                  child: Text('Class 10'),
                ),
              ],
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
        child: BlocConsumer<PdfCategoryBloc, PdfCategoryState>(
          listener: (context, state) {
            print("listener State : $state");
          },
          builder: (context, state) {
            print("builder State : $state");
            if (state is PdfCategoryErrorState) {
              return const ListShimmer();
            } else if (state is PdfCategoryLoadingState) {
              return const ListShimmer();
            } else if (state is PdfCategoryGetState) {
              var data = state.pdfCategories;

              // Filter data based on selected class
              if (selectedItem != 'All') {
                data = data
                    .where(
                        (item) => item.title.toString().contains(selectedItem))
                    .toList();
              }

              return data.isNotEmpty? ListView.builder(
                  itemCount: data.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        /// navigate based on the index
                        print("data.PdfCategorys : ${data[index]}");

                        GoRouter.of(context)
                            .push(RoutesName.pdfListRoute, extra: data[index]);
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
                                  ? data[index].titleHi.toString()
                                  : data[index].title.toString(),
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    );
                  }):const NoData();
            }
            return const ListShimmer();
          },
        ),
      ),
    );
  }
}
