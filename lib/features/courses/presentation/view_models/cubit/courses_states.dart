part of 'courses_cubit.dart';

@immutable
abstract class CoursesStates {}

final class CoursesInitialState extends CoursesStates {}

final class ChangeCheckState extends CoursesStates {}

final class SendAvailableCoursesLoadingState extends CoursesStates {}
final class SendAvailableCoursesSuccessState extends CoursesStates {
  final List<Course> courses;

  SendAvailableCoursesSuccessState({required this.courses});
}
final class SendAvailableCoursesFailureState extends CoursesStates {
  final String error;

  SendAvailableCoursesFailureState({required this.error});
}


