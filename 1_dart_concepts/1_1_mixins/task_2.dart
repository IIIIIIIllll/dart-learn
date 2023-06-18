class Text {
  final String text;
  
  Text(this.text);
}

class Link {
  final String link;
  
  Link(this.link);
}

extension StringExtension on String {
  List<dynamic> parseLinks() {
    RegExp linkPattern = RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
    List<dynamic> result = [];

    var matches = linkPattern.allMatches(this);
    var currentIndex = 0;

    for (var match in matches) {
      if (match.start > currentIndex) {
        result.add(Text(this.substring(currentIndex, match.start)));
      }
      result.add(Link(match.group(0)!));
      currentIndex = match.end;
    }

    if (currentIndex < this.length) {
      result.add(Text(this.substring(currentIndex)));
    }

    return result;
  }
}

void main() {
  String text = 'Hello, google.com, yay';
  List<dynamic> parsedResult = text.parseLinks();
  
  for (var item in parsedResult) {
    if (item is Text) {
      print('Text: ${item.text}');
    } else if (item is Link) {
      print('Link: ${item.link}');
    }
  }
}
