import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnsButton extends StatelessWidget {
  const AnsButton({required this.ansText, required this.onTap, super.key});
  final String ansText;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 20,
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          Colors.white,
        ),
        foregroundColor: MaterialStateProperty.all<Color>(
          Colors.black,
        ),
        overlayColor: MaterialStateProperty.all<Color>(const Color(0xFF4255FF)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.black45,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      child: Text(ansText,
          textAlign: TextAlign.center,
          style: GoogleFonts.nunito(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          )),
    );
  }
}
