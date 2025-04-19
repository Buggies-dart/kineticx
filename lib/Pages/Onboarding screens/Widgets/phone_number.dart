import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';


PhoneNumber? phoneNumber;


class InputPhoneNumber extends StatefulWidget {
  const InputPhoneNumber({super.key, required this.phoneController, required this.errorBorder});
final TextEditingController phoneController;
final String errorBorder;
  @override
  State<InputPhoneNumber> createState() => __InputPhoneNumberState();
}

class __InputPhoneNumberState extends State<InputPhoneNumber> {
@override
void initState() {
  super.initState();
 phoneNumber = PhoneNumber(isoCode: 'US');
}
  @override
  Widget build(BuildContext context) {

return SizedBox( height: MediaQuery.of(context).size.height/9, width: double.infinity,
child: Padding(
  padding: const EdgeInsets.all(8.0),
  child: InternationalPhoneNumberInput( maxLength: 15, textStyle: Theme.of(context).textTheme.bodyMedium, textFieldController: widget.phoneController,
  
      inputDecoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
enabledBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
    prefixIcon: Padding(
    padding: EdgeInsets.only(right: 8.0),
    child: Icon(Icons.phone)
  ),
      filled: true, fillColor: Theme.of(context).colorScheme.tertiaryContainer,
       contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
errorText: widget.errorBorder),
      onInputChanged: (PhoneNumber number) {
     setState(() {
      phoneNumber = number;  
     }); 
      },
      searchBoxDecoration: InputDecoration(labelStyle: Theme.of(context).textTheme.titleMedium),
      selectorConfig: SelectorConfig(
      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
      setSelectorButtonAsPrefixIcon: true,
      leadingPadding: 5,
  
      ),
      
      initialValue: phoneNumber ?? PhoneNumber(isoCode: 'US'), 
      selectorTextStyle: Theme.of(context).textTheme.titleMedium,
     

      ),
),
    );
   
  }
}