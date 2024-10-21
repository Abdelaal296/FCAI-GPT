import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:fcai_gpt/core/utils/courses.dart';
import 'package:fcai_gpt/features/courses/data/course.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fcai_gpt/constants.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'courses_states.dart';

class CoursesCubit extends Cubit<CoursesStates> {
  CoursesCubit() : super(CoursesInitialState());
  static CoursesCubit get(context)=>BlocProvider.of(context);
  List<String> selectedCourses = [];
  List<String> courses = Cousres.courses.map((course) => course.name).toList()..sort();

  void check(String course){
      selectedCourses.add(course);
      emit(ChangeCheckState());                                       
  }
   void uncheck(String course){
      selectedCourses.remove(course);  
      emit(ChangeCheckState());                                       
  }

 void getAvailableCourses() {
    emit(SendAvailableCoursesLoadingState());
    Set<Course> availableCourses ={};
    Set<String> passedCoursesSet = selectedCourses.toSet();
    Cousres.courses.forEach((course) {
      if ( !passedCoursesSet.contains(course.name)&&course.prerequisites.every((prerequisite) => passedCoursesSet.contains(prerequisite))) {
        availableCourses.add(course);
      }
    });

    emit(SendAvailableCoursesSuccessState(courses: availableCourses.toList()));
  
    
  }


}
