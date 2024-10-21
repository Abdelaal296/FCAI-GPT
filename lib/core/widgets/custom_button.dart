import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.onTap, this.isLoading = false, required this.text});

  final Function()? onTap;
  final bool isLoading;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
            child: isLoading
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ))
                :  Text(
                    text,
                    style:const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Philosopher',
                      fontSize: 20,
                    ),
                  )),
      ),
    );
  }
}
