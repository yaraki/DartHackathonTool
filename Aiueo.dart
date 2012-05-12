#import('dart:html');
#import('dart:dom', prefix:"dom");

class Camera {
  void run() {
    takePicture();
  }
  
  void takePicture() {
    try {
      window.navigator.webkitGetUserMedia("video user", gotStream);
      window.setTimeout(takePicture, 1000);
    } catch (var e) {
      print(e);
    }
  }
  
  void gotStream(var stream) {
    document.query("#selfView").attributes = { "src": new dom.DOMURL().createObjectURL(stream) };
  }
}

void main() {
  new Camera().run();
}
