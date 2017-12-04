import promidi.*;

MusicMap music = new MusicMap();

String beatURL = "https://widget.songle.jp/api/v1/song/beat.xml?url=https://www.youtube.com/watch?v=PqJNc9KVIZE";
String chordURL = "https://widget.songle.jp/api/v1/song/chord.xml?url=https://www.youtube.com/watch?v=PqJNc9KVIZE";
String melodyURL = "https://widget.songle.jp/api/v1/song/melody.xml?url=https://www.youtube.com/watch?v=PqJNc9KVIZE";
String chorusURL = "https://widget.songle.jp/api/v1/song/chorus.xml?url=https://www.youtube.com/watch?v=PqJNc9KVIZE";

processing.data.XML xml1;
processing.data.XML xml2;
processing.data.XML xml3; 

//↓↓↓↓↓↓↓↓↓↓↓追加↓↓↓↓↓↓↓↓↓↓↓↓↓
processing.data.XML xml4; 
//↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

Arrange arrange;

void setup() {
  xml1 = loadXML(beatURL);
  xml2 = loadXML(chordURL);
  xml3 = loadXML(melodyURL);
  
 //↓↓↓↓↓↓↓↓↓↓↓追加↓↓↓↓↓↓↓↓↓↓↓↓↓ 
  xml4 = loadXML(chorusURL);
//↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
  
  arrange = new Arrange();
  arrange.play("pos");
  /*
  delay(20000);
  arrange.stop();
  delay(5000);
  arrange.play("nega");
  */
}