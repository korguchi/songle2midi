class MusicMap {

  ArrayList<Integer>chorusStart = new ArrayList<Integer>();
  ArrayList<Integer>chorusDuraiton = new ArrayList<Integer>();

  ArrayList chorusStart() {

    processing.data.XML [] chorus= xml4.getChild("chorusSegments").getChild("chorusSegment").getChild("repeats").getChildren("repeat");

    for (int i=0; i<chorus.length; i++) {
      processing.data.XML start = chorus[i].getChild("start");
      chorusStart.add(int(start.getContent()));
    }
    println(chorusStart);
    return chorusStart;
  }
  ArrayList chorusDuration() {

    processing.data.XML [] chorus= xml4.getChild("chorusSegments").getChild("chorusSegment").getChild("repeats").getChildren("repeat");

    for (int i=0; i<chorus.length; i++) {
      processing.data.XML duration = chorus[i].getChild("duration");
      chorusDuraiton.add(int(duration.getContent()));
    }
    //println(chorusDuration);
    return chorusDuraiton;
  }


  ArrayList<Integer>beatIndex = new ArrayList<Integer>();
  ArrayList<Integer>beatStart = new ArrayList<Integer>();
  ArrayList<Integer>beatPosition = new ArrayList<Integer>();

  ArrayList<Integer>chordIndex = new ArrayList<Integer>();
  ArrayList<Integer>chordStart = new ArrayList<Integer>();
  ArrayList<Integer>chordDuration = new ArrayList<Integer>();
  ArrayList<String>chordName = new ArrayList<String>();

  ArrayList<Integer>melodyIndex = new ArrayList<Integer>();
  ArrayList<Integer>melodyStart = new ArrayList<Integer>();
  ArrayList<Integer>melodyDuration = new ArrayList<Integer>();
  ArrayList<Integer>melodyPitch = new ArrayList<Integer>();
  ArrayList<Integer>melodyNumber = new ArrayList<Integer>();


  //拍の取得
  ArrayList beatIndex() {

    processing.data.XML [] beat= xml1.getChild("beats").getChildren("beat");

    for (int i=0; i<beat.length; i++) {
      processing.data.XML index = beat[i].getChild("index");
      beatStart.add(int(index.getContent()));
    }
    //println(beatIndex);
    return beatIndex;
  }

  ArrayList beatStart() {

    processing.data.XML [] beat= xml1.getChild("beats").getChildren("beat");

    for (int i=0; i<beat.length; i++) {
      processing.data.XML start = beat[i].getChild("start");
      beatStart.add(int(start.getContent()));
    }
    //println(beatStart);
    return beatStart;
  }

  ArrayList beatPosition() {

    processing.data.XML [] beat= xml1.getChild("beats").getChildren("beat");

    for (int i=0; i<beat.length; i++) {
      processing.data.XML position = beat[i].getChild("position");
      beatPosition.add(int(position.getContent()));
    }
    //println(beatPosition);
    return beatPosition;
  }

  //和音の取得
  ArrayList chordIndex() {

    processing.data.XML [] chord = xml2.getChild("chords").getChildren("chord");

    for (int i=0; i<chord.length; i++) {
      processing.data.XML index = chord[i].getChild("index");
      chordStart.add(int(index.getContent()));
    }
    //println(chordIndex);
    return chordIndex;
  }

  ArrayList chordStart() {

    processing.data.XML [] chord = xml2.getChild("chords").getChildren("chord");

    for (int i=0; i<chord.length; i++) {
      processing.data.XML start = chord[i].getChild("start");
      chordStart.add(int(start.getContent()));
    }
    //println(chordStart);
    return chordStart;
  }

  ArrayList chordDuration() {

    processing.data.XML [] chord = xml2.getChild("chords").getChildren("chord");

    for (int i=0; i<chord.length; i++) {
      processing.data.XML duration = chord[i].getChild("duration");
      chordDuration.add(int(duration.getContent()));
    }
    //println(chordDuration);
    return chordDuration;
  }

  ArrayList chordName() {

    processing.data.XML [] chord = xml2.getChild("chords").getChildren("chord");

    for (int i=0; i<chord.length; i++) {
      processing.data.XML name = chord[i].getChild("name");
      chordName.add(name.getContent());
    }
    //println(chordDuration);
    return chordName;
  }

  //メロディーの取得
  ArrayList melodyIndex() {

    processing.data.XML [] note = xml3.getChild("notes").getChildren("note");

    for (int i=0; i<note.length; i++) {
      processing.data.XML index = note[i].getChild("index");
      melodyIndex.add(int(index.getContent()));
    }
    return melodyIndex;
  }

  ArrayList melodyStart() {

    processing.data.XML [] note = xml3.getChild("notes").getChildren("note");

    for (int i=0; i<note.length; i++) {
      processing.data.XML start = note[i].getChild("start");
      melodyStart.add(int(start.getContent()));
    }
    return melodyStart;
  }

  ArrayList melodyDuration() {

    processing.data.XML [] note = xml3.getChild("notes").getChildren("note");

    for (int i=0; i<note.length; i++) {
      processing.data.XML duration = note[i].getChild("duration");
      melodyDuration.add(int(duration.getContent()));
    }
    return melodyDuration;
  }

  ArrayList melodyPitch() {   


    processing.data.XML [] note = xml3.getChild("notes").getChildren("note");

    for (int i=0; i<note.length; i++) {
      processing.data.XML pitch = note[i].getChild("pitch");
      melodyPitch.add(int(pitch.getContent()));
    }
    return melodyPitch;
  }

  ArrayList melodyNumber() {

    processing.data.XML [] note = xml3.getChild("notes").getChildren("note");

    for (int i=0; i<note.length; i++) {
      processing.data.XML number = note[i].getChild("number");
      melodyNumber.add(int(number.getContent()));
    }
    //println(melodyNumber);
    return melodyNumber;
  }
}