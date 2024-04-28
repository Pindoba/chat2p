import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:url_launcher/link.dart';

class TextBalloon extends StatelessWidget {
  const TextBalloon({super.key, this.body_msg});
  final String? body_msg;

  @override
  Widget build(BuildContext context) {
    dynamic _openLink(String href, String? title) {
      return showDialog(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
          title: const Center(child: Text('Abrir link?')),
          children: [
            ListTile(
              title: Link(
                uri: Uri.parse(href),
                target: LinkTarget.self,
                builder: (BuildContext context, FollowLink? openLink) {
                  return Column(
                    children: [
                      TextButton.icon(
                        onPressed: openLink,
                        label: const Text('Abrir link'),
                        icon: const Icon(Icons.link),
                      ),
                      TextButton.icon(
                        onPressed: () => Navigator.pop(context),
                        label: const Text(
                          'Cancelar',
                          style: TextStyle(color: Colors.red),
                        ),
                        icon: const Icon(Icons.link_off, color: Colors.red),
                      ),
                    ],
                  );
                },
              ),
            ),
       
          ],
        ),
      );
   
    }

    return Container(
      constraints: const BoxConstraints(maxWidth: 250),
      child: body_msg == "Redacted"
          ? const SizedBox(
              width: 180,
              child: Row(
                children: [
                  Icon(Icons.delete, color: Colors.redAccent),
                  Text(
                    "Mensagem apagada",
                    style: TextStyle(
                      color: Colors.redAccent,
                    ),
                  )
                ],
              ),
            )
          : Column(
              children: [
                MarkdownBody(
                    styleSheet: MarkdownStyleSheet(
                        h1Align: WrapAlignment.center, textScaleFactor: 1.2),
                    shrinkWrap: true,
                    fitContent: true,
                    extensionSet: md.ExtensionSet(
                      md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                      <md.InlineSyntax>[
                        md.EmojiSyntax(),
                        ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes
                      ],
                    ),
                    onSelectionChanged: (text, selection, cause) {},
                    onTapText: () {},
                    data: body_msg.toString(),
                    selectable: true,
                    onTapLink: (text, href, title) {
                      _openLink(href!, title);
                    }),
              ],
            ),

      //  SelectableText(
      //   body_msg,
      //   style: TextStyle(fontSize: 16),
      // )
    );
  }
}
