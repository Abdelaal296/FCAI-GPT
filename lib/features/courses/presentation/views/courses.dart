import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fcai_gpt/constants.dart';
import 'package:fcai_gpt/core/utils/courses.dart';
import 'package:fcai_gpt/core/widgets/custom_button.dart';
import 'package:fcai_gpt/core/widgets/custom_flutter_toast.dart';
import 'package:fcai_gpt/features/courses/presentation/view_models/cubit/courses_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecommendScreen extends StatelessWidget {
  RecommendScreen({super.key});

  final ScrollController _scrollController = ScrollController();

  void _scrollToCourse(String course, BuildContext context) {
    final index = CoursesCubit.get(context).courses.indexOf(course);
    if (index != -1) {
      _scrollController.animateTo(
        index * 58.0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CoursesCubit(),
      child: BlocConsumer<CoursesCubit, CoursesStates>(
        listener: (context, state) {
          if (state is SendAvailableCoursesSuccessState) {
            

            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: const Color.fromARGB(255, 155, 192, 232),
                title: const Text(
                  'Courses you can register',
                  style: TextStyle(
                    fontFamily: 'Philosopher',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                content: SizedBox(
                  width: double.maxFinite,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.courses.length,
                    itemBuilder: (context, index) => Text(
                      '${state.courses[index].name} (${state.courses[index].hours})',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK',style: TextStyle(color: Colors.black),),
                  ),
                ],
              ),
            );
          }  else if (state is SendAvailableCoursesFailureState) {
            showToast(text: state.error, state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          final cubit = CoursesCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: KPrimaryColor,
              leading: Container(),
              title: const Text(
                'Courses',
                style: TextStyle(
                  fontFamily: 'Philosopher',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: CourseSearchDelegate(
                        courses: cubit.courses,
                        onSelected: (course) {
                          _scrollToCourse(course, context);
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Please select courses that you passed',
                    style: TextStyle(
                      fontFamily: 'Philosopher',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: cubit.courses.length,
                        itemBuilder: (context, index) {
                          final course = cubit.courses[index];
                          return CheckboxListTile(
                            checkColor: KPrimaryColor,
                            activeColor: Colors.white,
                            title: Text(course),
                            value: cubit.selectedCourses.contains(course),
                            onChanged: (bool? value) {
                              if (value == true) {
                                cubit.check(course);
                              } else {
                                cubit.uncheck(course);
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ConditionalBuilder(
                    condition: state is! SendAvailableCoursesLoadingState,
                    builder: (context) => Container(
                      decoration: BoxDecoration(
                        color: KPrimaryColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          cubit.getAvailableCourses();
                        },
                        child: const Text(
                          'Confirm',
                          style: TextStyle(
                            fontFamily: 'Philosopher',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    fallback: (context) => const Center(
                      child: CircularProgressIndicator(color: KPrimaryColor),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CourseSearchDelegate extends SearchDelegate<String> {
  final List<String> courses;
  final ValueChanged<String> onSelected;

  CourseSearchDelegate({required this.courses, required this.onSelected});

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: KPrimaryColor,
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: KPrimaryColor,
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear, color: Colors.white),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: courses
            .where(
                (course) => course.toLowerCase().contains(query.toLowerCase()))
            .map((course) => ListTile(
                  title: Text(course),
                  onTap: () {
                    onSelected(course);
                    close(context, course);
                  },
                ))
            .toList(),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = courses
        .where((course) => course.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Container(
      color: Colors.white,
      child: ListView(
        children: suggestions
            .map((course) => ListTile(
                  title: Text(course),
                  onTap: () {
                    onSelected(course);
                    close(context, course);
                  },
                ))
            .toList(),
      ),
    );
  }
}
