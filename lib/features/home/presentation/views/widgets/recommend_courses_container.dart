import 'package:fcai_gpt/constants.dart';
import 'package:fcai_gpt/features/courses/presentation/views/courses.dart';
import 'package:flutter/material.dart';

class RecommendCoursesContainer extends StatelessWidget {
  const RecommendCoursesContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>  RecommendScreen()));
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: KPrimaryColor,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.recommend,
                    size: 30,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      'Courses',
                      style: TextStyle(
                        fontFamily: 'Philosopher',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.only(left: 36.0),
                child: Text(
                  'Based on your passed courses, you can know what courses are available for you to register ',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Philosopher',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
