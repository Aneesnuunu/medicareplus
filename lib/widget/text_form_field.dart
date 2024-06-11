import 'package:flutter/material.dart';
import 'package:medi_care/Theam/theme.dart';
import 'package:flutter/services.dart';


class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? hintTextColor;
  final IconData? prefixIcon;

  const CustomTextFormField({
    required this.controller,
    required this.hintText,
    this.backgroundColor,
    this.iconColor,
    this.hintTextColor,
    this.prefixIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: backgroundColor ?? const Color(0xFF28263E),
            hintText: hintText,
            hintStyle: const TextStyle(color: AppThemeData.primaryColor),

            prefixIcon: Icon(prefixIcon ?? Icons.email,
                color: AppThemeData.primaryColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),

          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}


class CustomTextFormFieldName extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? hintTextColor;
  final IconData? prefixIcon;

  const CustomTextFormFieldName({
    required this.controller,
    required this.hintText,
    this.backgroundColor,
    this.iconColor,
    this.hintTextColor,
    this.prefixIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: backgroundColor ?? const Color(0xFF28263E),
            hintText: hintText,
            hintStyle: const TextStyle(color: AppThemeData.primaryColor),

            prefixIcon: Icon(prefixIcon ?? Icons.email,
                color: AppThemeData.primaryColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),


          ),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
          ],

        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class CustomTextFormFieldAge extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? hintTextColor;
  final IconData? prefixIcon;

  const CustomTextFormFieldAge({
    required this.controller,
    required this.hintText,
    this.backgroundColor,
    this.iconColor,
    this.hintTextColor,
    this.prefixIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: backgroundColor ?? const Color(0xFF28263E),
            hintText: hintText,
            hintStyle: const TextStyle(color: AppThemeData.primaryColor),

            prefixIcon: Icon(prefixIcon ?? Icons.email,
                color: AppThemeData.primaryColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),


          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(2), // Limit to 2 characters

            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],

        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}



class CustomTextFormFieldPassword extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? hintTextColor;
  final IconData? prefixIcon;

  const CustomTextFormFieldPassword({
    required this.controller,
    required this.hintText,
    this.backgroundColor,
    this.iconColor,
    this.hintTextColor,
    this.prefixIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          obscureText: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: backgroundColor ?? const Color(0xFF28263E),
            hintText: hintText ,
            hintStyle: const TextStyle(color: AppThemeData.primaryColor),
            prefixIcon: Icon(prefixIcon ?? Icons.lock_outline,
                color: AppThemeData.primaryColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(6),
            FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z]')),
          ],
        ),

        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class CustomTextFormFieldPhone extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? hintTextColor;
  final IconData? prefixIcon;

  const CustomTextFormFieldPhone({
    required this.controller,
    required this.hintText,
    this.backgroundColor,
    this.iconColor,
    this.hintTextColor,
    this.prefixIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: backgroundColor ?? const Color(0xFF28263E),
            hintText: hintText,
            hintStyle: const TextStyle(color: AppThemeData.primaryColor),

            prefixIcon: Icon(prefixIcon ?? Icons.email,
                color: AppThemeData.primaryColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),


          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(13), // Limit to 10 characters
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Allow only numbers
          ],
          validator: (value) {
            if (value == null || value.isEmpty || value.length != 10) {
              return 'Please enter a valid 10-digit phone number';
            }
            return null;
          },

        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}





class CustomTextFormFieldGender extends StatelessWidget {
  final String? selectedGender;
  final List<String> genderOptions;
  final ValueChanged<String?> onChanged;

  const CustomTextFormFieldGender({
    required this.selectedGender,
    required this.genderOptions,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedGender,
      items: genderOptions.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: const TextStyle(color: Colors.white)),
        );
      }).toList(),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF28263E),
        hintText: 'Gender',
        hintStyle: const TextStyle(color: AppThemeData.primaryColor),
        prefixIcon: const Icon(Icons.wc_outlined, color: AppThemeData.primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.white),
      dropdownColor: const Color(0xFF28263E),
      onChanged: onChanged,
    );
  }
}



class CustomTextFormFieldBlood extends StatelessWidget {
  final String? selectedBloodGroup;
  final List<String> bloodGroupOptions;
  final ValueChanged<String?> onChanged;

  const CustomTextFormFieldBlood({
    required this.selectedBloodGroup,
    required this.bloodGroupOptions,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedBloodGroup,
      items: bloodGroupOptions.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: const TextStyle(color: Colors.white)),
        );
      }).toList(),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF28263E),
        hintText: 'Blood Group',
        hintStyle: const TextStyle(color: AppThemeData.primaryColor),
        prefixIcon: const Icon(Icons.bloodtype_outlined, color: AppThemeData.primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.white),
      dropdownColor: const Color(0xFF28263E),
      onChanged: onChanged,
    );
  }
}













