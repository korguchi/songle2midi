

class Arrange {
  //パートごとの配列の個数
  int meloSize = music.melodyIndex().size();
  int chrdSize = music.chordName().size();

  //テンポ
  int temp =(int)music.beatStart().get(1) - (int)music.beatStart().get(0);
  int tempo = 60000/temp;

  //コード生成用
  int rootNum;//ルート音
  int num1;//堆積音
  int num2;
  int num3;
  int num4;
  int veloR;//コードのベロシティ
  int velo1;
  int velo2;
  int velo3;
  int cstart1;//ノートオン位置
  int cstart2;//ノートオフ位置

  //メロディ生成用
  int tickPerms;//ミリ秒をtickに変換
  int num;//ノートナンバー
  int velo;//ベロシティ
  int start1;//ノートオン位置
  int start2;//ノートオフ位置

  Sequencer sequencer;
  //ミリ秒をtickに変換する関数
  int msToTick(int ms) {
    float tk=0;
    tk = 4*((int)music.beatStart().get(1) - (int)music.beatStart().get(0));
    tk = tk/64.0;
    tk = ms/tk;
    return (int)tk;
  }

  void play(String _mood) {
    println("temp: "+temp);
    sequencer = new Sequencer();

    MidiIO midiIO = MidiIO.getInstance();
    midiIO.printDevices();
    midiIO.closeOutput(1);

    //(楽器番号,ポート番号),MIDIアウトのポート番号は環境ごとに異なります。適宜変更してください。
    MidiOut melo = midiIO.getMidiOut(0, 0);
    MidiOut chrd = midiIO.getMidiOut(1, 0);
    MidiOut bass = midiIO.getMidiOut(2, 0);
    MidiOut drum = midiIO.getMidiOut(9, 0);

    //各パートを用意
    Track meloTrack = new Track("songle", melo);
    Track chrdTrack = new Track("songle", chrd);
    Track bassTrack = new Track("songle", bass);
    Track rhythmTrack = new Track("songle", drum);

    //1小節を64分割
    meloTrack.setQuantization(Q._1_64);
    chrdTrack.setQuantization(Q._1_64);
    rhythmTrack.setQuantization(Q._1_64);
    bassTrack.setQuantization(Q._1_64);
    //曲調決定
    int mbank = 0;
    int cbank = 0;
    int bbank = 0;
    int dbank = 0;

    if (_mood.equals("pos") ) {
      tempo = 160;
      mbank=80;
      cbank =80;
      bbank=81;
    }
    if (_mood.equals("nega") ) {
      mbank = 10;
      cbank = 10;
      //tempo = 80;
    }
    //音色変更
    melo.sendProgramChange(new ProgramChange(mbank));
    chrd.sendProgramChange(new ProgramChange(cbank));
    bass.sendProgramChange(new ProgramChange(bbank));
    drum.sendProgramChange(new ProgramChange(dbank));

    //曲全体の長さ
    int songLenInms=0;
    for (int i = 0; i < meloSize; i++) {
      songLenInms = songLenInms + (int)music.melodyDuration().get(i);
    }

    //サビ抽出位置
    int chstart;
    int chend;
    int chstarttemp;
    int chendtemp;

    chstarttemp = (int)music.chorusStart().get(0);
    chendtemp = (int)music.chorusDuration().get(0);
    chstart = (chstarttemp)/(temp*4);
    chend = (chstarttemp+chendtemp)/(temp*4);

    //sequencer内では512tick=1小節
    int songLenIntick = (songLenInms*512)/temp;

    //ミリ秒/tick (tick: 1小節をここでは64分割したときの単位)
    tickPerms = 60000/(tempo*16);

    //生成
    if (_mood.equals("pos") ) {
      //リズム入力
      int bstart;
      for (int i = 0; i < 100; i++) {
        bstart = msToTick((int)music.beatStart().get(i));

        //バスドラム
        rhythmTrack.addEvent(new Note(36, 40, 40), bstart+64*i);
        rhythmTrack.addEvent(new Note(36, 40, 40), bstart+16+64*i);
        rhythmTrack.addEvent(new Note(36, 40, 40), bstart+32+64*i);
        rhythmTrack.addEvent(new Note(36, 40, 40), bstart+48+64*i);
        rhythmTrack.addEvent(new Note(36, 40, 40), bstart+64+64*i);

        //クローズドハイハット
        rhythmTrack.addEvent(new Note(42, 40, 40), bstart+64*i);
        rhythmTrack.addEvent(new Note(42, 40, 40), bstart+64*i+4);
        rhythmTrack.addEvent(new Note(42, 40, 40), bstart+16+64*i);
        rhythmTrack.addEvent(new Note(42, 40, 40), bstart+20+64*i);
        rhythmTrack.addEvent(new Note(42, 40, 40), bstart+32+64*i);
        rhythmTrack.addEvent(new Note(42, 40, 40), bstart+36+64*i);
        rhythmTrack.addEvent(new Note(42, 40, 40), bstart+48+64*i);
        rhythmTrack.addEvent(new Note(42, 40, 40), bstart+52+64*i);
        rhythmTrack.addEvent(new Note(42, 40, 40), bstart+64+64*i);
        rhythmTrack.addEvent(new Note(42, 40, 40), bstart+68+64*i);

        //オープンハイハット
        rhythmTrack.addEvent(new Note(46, 40, 40), bstart+8+64*i);
        rhythmTrack.addEvent(new Note(46, 40, 40), bstart+8+16+64*i);
        rhythmTrack.addEvent(new Note(46, 40, 40), bstart+8+32+64*i);
        rhythmTrack.addEvent(new Note(46, 40, 40), bstart+8+48+64*i);
        rhythmTrack.addEvent(new Note(46, 40, 40), bstart+8+64+64*i);
      }

      //ベース入力
      /*
      float bcount;
       int dstart;
       for (int i = 0; i < chrdSize; i++) {
       bcount = msToTick((int)music.chordDuration().get(i))/8.0;
       dstart = msToTick((int)music.chordStart().get(i));
       switchChord((String)music.chordName().get(i));
       for(int j = 0;j < bcount;j++){
       bassTrack.addEvent(new Note(rootNum-24, 70, 40), dstart+j*8);
       bassTrack.addEvent(new Note(rootNum-24, 70, 40), dstart+4+j*8);
       bassTrack.addEvent(new Note(rootNum-24, 0, 40), dstart+j*8+2);
       bassTrack.addEvent(new Note(rootNum-24, 0, 40), dstart+4+j*8+2);
       }
       }
       */


      //メロディ入力(一度出した音を止めるにはベロシティを0にして再度同じ音を打ち込む)

      for ( int i = 0; i < meloSize; i++ ) {

        num = (int)music.melodyNumber().get(i);
        start1 = (int)music.melodyStart().get(i)/tickPerms;
        start2 = ((int)(music.melodyStart().get(i))+(int)(music.melodyDuration().get(i)))/tickPerms;
        if (num==0) {
          velo = 0;
        } else {
          velo = 80;
        }
        num = num + 12;
        meloTrack.addEvent(new Note(num, velo, 1), start1);
        meloTrack.addEvent(new Note(num, 0, 1), start2);
      }
      //コード入力

      for (int i = 0; i < chrdSize; i++) {
        switchChord((String)(music.chordName().get(i)));

        cstart1 = (int)music.chordStart().get(i)/tickPerms;
        cstart2 = ((int)(music.chordStart().get(i))+(int)(music.chordDuration().get(i)))/tickPerms;


        if (rootNum==0) {
          veloR = 0;
        } else {
          veloR = 70;
        }
        if (num1==0) {
          velo1 = 0;
        } else {
          velo1 = 70;
        }
        if (num2==0) {
          velo2 = 0;
        } else {
          velo2 = 70;
        }
        if (num2==0) {
          velo3 = 0;
        } else {
          velo3 = 70;
        }

        rootNum+=24;
        num1+=24;
        num2+=24;
        num3+=24;
        num4+=24;

        chrdTrack.addEvent(new Note(rootNum+12, veloR, 40), cstart1);
        chrdTrack.addEvent(new Note(num1, velo1, 40), cstart1);
        chrdTrack.addEvent(new Note(num2, velo2, 40), cstart1);
        chrdTrack.addEvent(new Note(num3, velo3, 40), cstart1);
        chrdTrack.addEvent(new Note(num4, velo3, 40), cstart1);

        chrdTrack.addEvent(new Note(rootNum+12, 0, 40), cstart2);
        chrdTrack.addEvent(new Note(num1, 0, 40), cstart2);
        chrdTrack.addEvent(new Note(num2, 0, 40), cstart2);
        chrdTrack.addEvent(new Note(num3, 0, 40), cstart2);
        chrdTrack.addEvent(new Note(num4, 0, 40), cstart2);
        //chrdTrack.addEvent(new Note(num1+12, cvelo, 40), cstart2);
      }


      //chrdTrack.addEvent(new Note(60, 127, 40), 0);
      //println(chrdTrack.size());
      Song song = new Song("test", tempo);

      song.addTrack( meloTrack );
      song.addTrack( chrdTrack );
      song.addTrack( bassTrack );
      song.addTrack( rhythmTrack );
      sequencer.setSong( song );

      sequencer.setLoopStartPoint(512*chstart);
      sequencer.setLoopEndPoint( 512*(chend+1) );
      //sequencer.setTempoInBPM( tempo );
      sequencer.setTickPosition(512*chstart);
      sequencer.start();
    }
  }

  void stop() {
    sequencer.setLoopStartPoint(0);
    sequencer.stop();
  }
  void switchChord(String c) {
    //転回形を無視してルート音から順に堆積した変数
    int role1 = 0;
    int role2 = 0;
    int role3 = 0;
    int role4 = 0;

    //コードネーム"N"は全て無視
    if (c.indexOf("N")==0) {
      rootNum = 0;
      role1 = 0;
      role2 = 0;
      role3 = 0;
      role4 = 0;
    }

    //メジャーコード及び、基本堆積音
    if (c.indexOf("C")==0) {
      role1 = 36;
      role2 = role1 + 4;
      role3 = role1 + 7;
      role4 = role1 + 12;
      rootNum = role1 - 12;
    }
    if (c.indexOf("D")==0) {
      role1 = 38;
      role2 = role1 + 4;
      role3 = role1 + 7;
      role4 = role1 + 12;
      rootNum = role1 - 12;
    }
    if (c.indexOf("E")==0) {
      role1 = 40;
      role2 = role1 + 4;
      role3 = role1 + 7;
      role4 = role1 + 12;
      rootNum = role1 - 12;
    }
    if (c.indexOf("F")==0) {
      role1 = 41;
      role2 = role1 + 4;
      role3 = role1 + 7;
      role4 = role1 + 12;
      rootNum = role1 - 12;
    }
    if (c.indexOf("G")==0) {
      role1 = 43;
      role2 = role1 + 4;
      role3 = role1 + 7;
      role4 = role1 + 12;
      rootNum = role1 - 12;
    }
    if (c.indexOf("A")==0) {
      role1 = 45;
      role2 = role1 + 4;
      role3 = role1 + 7;
      role4 = role1 + 12;
      rootNum = role1 - 12;
    }
    if (c.indexOf("B")==0) {
      role1 = 47;
      role2 = role1 + 4;
      role3 = role1 + 7;
      role4 = role1 + 12;
      rootNum = role1 - 12;
    }

    //sus4,7thなど各コードネームの処理
    if (c.indexOf("add9")>-1) {
      role4+=2;
    } else if (c.indexOf("sus4")>-1) {
      role2++;
    } else if (c.indexOf("sus2")>-1) {
      role2-=2;
    } else if (c.indexOf("aug")>-1) {
      role3++;
    } else if (c.indexOf("dim")>-1) {
      role2--;
      role3--;
    } else if (c.indexOf("m7")>-1) {
      role2--;
      role4-=2;
    } else if (c.indexOf("M7")>-1) {
      role4--;
    } else if (c.indexOf("7")>-1) {
      role4--;
    } else if (c.indexOf("69")>-1) {
      role1+=2;
      role4= role3 + 2;
    } else if (c.indexOf("6")>-1) {
      role4 = role3 + 2;
    } else if (c.indexOf("9")>-1) {
      role4-=2;
      role1+=2;
    } else if (c.indexOf("m")>-1) {
      role2--;
    }
    //#,bがついた時の処理
    if (c.indexOf("#")==1) {
      role1++;
      role2++;
      role3++;
      role4++;
      rootNum++;
    }
    if (c.indexOf("b")==1) {
      role1--;
      role2--;
      role3--;
      role4--;
      rootNum--;
    }

    //オンコード時のルート音
    if (c.indexOf("/C")>-1) {   
      rootNum = 24;
    }
    if (c.indexOf("/D")>-1) {
      rootNum = 26;
    }
    if (c.indexOf("/E")>-1) {    
      rootNum = 28;
    }
    if (c.indexOf("/F")>-1) {      
      rootNum = 29;
    }
    if (c.indexOf("/G")>-1) {      
      rootNum = 19;
    }
    if (c.indexOf("/A")>-1) {      
      rootNum = 21;
    }
    if (c.indexOf("/B")>-1) {     
      rootNum = 23;
    }
    //#,b
    if (c.indexOf("/")>-1) {
      if (str(c.charAt(c.length()-1)).equals("#")) {
        rootNum++;
      }
      if (str(c.charAt(c.length()-1)).equals("b")) {
        rootNum--;
      }
    }

    //実際に使うノートナンバーへ代入  
    num1 = role1;
    num2 = role2;
    num3 = role3;
    num4 = role4;

    //転回させる処理
    if (rootNum>41) {
      rootNum -= 12;
    }
    if (role1>39&&role1<43) {
      num1 = role4 - 12;
      num2 = role1;
      num3 = role2;
      num4 = role3;
      if (role4==role1 + 12) {
        num1 = role3 - 12;
      }
    }
    if (role1>42&&role1<48) {
      num1 = role3 - 12;
      num2 = role4 - 12;
      num3 = role1;
      num4 = role2;
      if (role4==role1 + 12) {
        num1 = role2 - 12;
        num2 = role3 - 12;
      }
    }
  }
}