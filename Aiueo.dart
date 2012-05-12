#import('dart:html');
#import('dart:dom', prefix:"dom");

class Aiueo {

  Aiueo() {
  }

  void run() {
    write("Hello World!");
    write("It is fine today.");

  }

  void write(String message) {
    // the HTML library defines a global "document" variable
    document.query('#status').innerHTML = message;
  }
}

void main() {
  new Aiueo().run();
  try {
    window.navigator.webkitGetUserMedia("video user", gotStream);
  } catch (var e) {
    print(e);
  }
}

void gotStream(var stream) {
  print("MediaStream? ${stream is MediaStream} (${stream})");
  var objectURL = new dom.DOMURL().createObjectURL(stream);
  document.query("#selfView").attributes = { "src": objectURL };
  print("aaa");
}
