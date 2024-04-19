import 'package:flutter/material.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class TextBalloon extends StatelessWidget {
  const TextBalloon({super.key, this.body_msg});
  final  body_msg;

  @override
  Widget build(BuildContext context) {
    final QuillEditorController controller = QuillEditorController();
    return 
    Container(
                    constraints: const BoxConstraints(maxWidth: 250),
                    child: body_msg == "Redacted" ?
                    Container(width: 180,
                      child: const Row(
                        
                        children: [
                        Icon(Icons.delete, color: Colors.redAccent),
                        Text("Mensagem apagada",style: TextStyle( color: Colors.redAccent,),)
                      ],),
                    ):



                    // Expanded(child: HtmlWidget(body_msg))
                     
                    //  SelectableText(
                    //   body_msg,
                    //   style: TextStyle(fontSize: 16),
                    // )
                    
QuillHtmlEditor(
        text: body_msg,
        hintText: 'Hint text goes here',
        controller: controller,
        isEnabled: false,
        minHeight: 100,
        // textStyle: _editorTextStyle,
        // hintTextStyle: _hintTextStyle,
        hintTextAlign: TextAlign.start,
        padding: const EdgeInsets.only(left: 10, top: 5),
        hintTextPadding: EdgeInsets.zero,
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        onFocusChanged: (hasFocus) => debugPrint('has focus $hasFocus'),
        onTextChanged: (text) => debugPrint('widget text change $text'),
        onEditorCreated: () => debugPrint('Editor has been loaded'),
        onEditingComplete: (s) => debugPrint('Editing completed $s'),
        onEditorResized: (height) =>
        debugPrint('Editor resized $height'),
        onSelectionChanged: (sel) =>
        debugPrint('${sel.index},${sel.length}'),
        loadingBuilder: (context) {
            return const Center(
            child: CircularProgressIndicator(
            strokeWidth: 0.4,
            ));},
      ),









                    )
    ;
  }
}



