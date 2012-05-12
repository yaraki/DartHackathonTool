#import('dart:html');
#import('dart:dom', prefix:"dom");

class Camera {
  
  var localVideo;
  var localCanvas;
  var ctx2;
  
  void run() {
    localVideo = document.query("#selfView");
    localCanvas = document.query("#localCanvas");
    ctx2 = localCanvas.getContext('2d');
    startCamera();
  }
  
  void startCamera() {
    try {
      window.navigator.webkitGetUserMedia("video user", gotStream);
    } catch (var e) {
      print(e);
    }
  }
  
  void gotStream(var stream) {
    localVideo.src = new dom.DOMURL().createObjectURL(stream);
    startCanvasCopy();
  }
  
  void startCanvasCopy() {
    canvasCopy(100);
  }
  
  bool canvasCopy(num highResTime) {
    renderCanvas();
    window.requestAnimationFrame(canvasCopy);
  }
  
  void renderCanvas() {
    ctx2.drawImage(localVideo, 0, 0, 100, 100);
    var imgd = ctx2.getImageData(0, 0, localCanvas.width, localCanvas.height);
    var pix = imgd.data;
    for (var i = 0, n = pix.length; i < n; i += 4) {
      int color = (pix[i  ] + pix[i+1] + pix[i+2]) / 3;
      color = (color > 100) ? 255 : 0;
      pix[i  ] = color; // red
      pix[i+1] = color; // green
      pix[i+2] = color; // blue
      // i+3 is alpha (the fourth element)
    }
    ctx2.putImageData(imgd, 0, 0);
  }
}

void main() {
  new Camera().run();
}
