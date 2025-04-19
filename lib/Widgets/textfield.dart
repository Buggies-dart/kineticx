import 'package:flutter/material.dart';
import 'package:kineticx/Utils/components.dart';

class TextfieldWidget extends StatefulWidget {
  const TextfieldWidget({super.key, required this.text, required this.hintIcon, required this.controller, required this.errorBorder, required this.errorText});
final String text; final String errorText; final IconData hintIcon; final TextEditingController controller; final InputBorder errorBorder;
  @override
  State<TextfieldWidget> createState() => _TextfieldWidgetState();
}

class _TextfieldWidgetState extends State<TextfieldWidget> {
bool obscureText = true;
  @override
  Widget build(BuildContext context) {
bool showHidePassword = widget.text == 'Password'  || widget.text == 'Confirm Password';
final theme = Theme.of(context);
return Column( crossAxisAlignment: CrossAxisAlignment.start,
children: [
Padding(
padding: const EdgeInsets.only(left: 12),
child: Text(widget.text, style: theme.textTheme.titleMedium),
),
Padding(
padding: const EdgeInsets.all(10),
child: TextField( controller: widget.controller, style: theme.textTheme.bodyMedium, obscureText:  showHidePassword ? obscureText : false,
decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: theme.primaryColor, width: 1)), 
enabledBorder: widget.errorBorder, hintText: 'Enter ${widget.text}', hintStyle: theme.textTheme.bodyMedium!.copyWith(color: const Color.fromARGB(255, 53, 53, 53)),
filled: true, fillColor: theme.colorScheme.tertiaryContainer, prefixIcon: Icon(widget.hintIcon, size: 25), suffixIcon: showHidePassword ?
IconButton(onPressed: (){
setState(() {
obscureText = !obscureText;
});
}, icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: blackColor,)) : null,
 contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16), errorText: widget.errorText),
),
)]);
}
}