import 'package:flutter/material.dart';

class TextfieldWidget extends StatefulWidget {
  const TextfieldWidget({super.key, required this.text, required this.hintIcon, required this.controller});
final String text; final IconData hintIcon; final TextEditingController controller;
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
decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
filled: true, fillColor: theme.colorScheme.tertiaryContainer, prefixIcon: Icon(widget.hintIcon, size: 25), suffixIcon: showHidePassword ?
IconButton(onPressed: (){
setState(() {
obscureText = !obscureText;
});
}, icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility,)) : null,
 contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16), ), 
),
)
],
);
}
}