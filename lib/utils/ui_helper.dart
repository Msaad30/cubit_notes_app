import 'package:flutter/material.dart';

class UiHelper{

  static customTextField({required TextEditingController controller, required String hintText, required IconData icon}){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextField(
        style: TextStyle(
          fontSize: 15,
        ),
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: Icon(icon),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            )
        ),
      ),
    );
  }

  static customBtn(VoidCallback callback,{required String btnText}){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: ElevatedButton(
          onPressed: (){
            callback();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            fixedSize: Size(110, 40),
          ),
          child: Text(
            btnText,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white
            ),
          )
      ),
    );
  }
}