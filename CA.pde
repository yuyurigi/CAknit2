class CA {

  int[] cells;
  int[] colorCells;
  int generation;

  int[]ruleset, skipNumber, colorReverse;

  String[] lines, lines2, lines3;

  int w = 7;
  int index = 0;
  int x = 238; //パターン描き始めのx位置
  int y = 235; //パターン描き始めのy位置
  int pw = 343; //パターンの横幅
  int ph = 530; //パターンの縦幅

  CA(int r) {
    lines = loadStrings("ruleset.txt");
    rule = r;
    String[] pieces = split(lines[rule], ' ');
    ruleset = int(split(pieces[1], ','));
    cells = new int[pw/w];
    colorCells = new int[pw/w];
    restart();
    lines2 = loadStrings("skipNumber.txt");
    lines3 = loadStrings("colorReverse.txt");
    skipNumber = int(split(lines2[0], ' '));
    colorReverse = int(split(lines3[0], ' '));
  }

  // Make a random ruleset
  void randomize() {
    rule = int(random(lines.length));
    println(rule);
    //単調なルールは飛ばす
    for (int i = 0; i < skipNumber.length; i++) {
      if (rule == skipNumber[i]) {
        randomize();
      }
    }
    String[] pieces = split(lines[rule], ' ');
    String[] pieces2 = split(pieces[1], ',');
    for (int i = 0; i < 8; i++) {
      ruleset[i] = int(pieces2[i]);
    }
  }

  //Reset to generation 0
  void restart() {
    for (int i = 0; i < cells.length; i++) {
      cells[i] = 0;
    }
    cells[cells.length/2] = 1;
    generation = 0;
  }

  void generate() {
    int[] nextgen = new int[cells.length];
    int[] cNextgen = new int[cells.length];
    for (int i = 1; i < cells.length-1; i++) {
      int left = cells[i-1];
      int me = cells[i];
      int right = cells[i+1];
      nextgen[i] = rules(left, me, right);
      cNextgen[i] = colorRules(left, me, right);
    }
    cells = nextgen;
    colorCells = cNextgen;
    generation++;

    //println(colorCells[0]);
  }


  void display() {
    for (int i = 0; i < cells.length; i++) {

      switch( colorCells[i] ) {
      case 0:
        fill(204, 229, 235); //水色
        break;
      case 1:
        fill(230, 205, 224); //薄紫
        break;
      case 2:
        fill(250, 210, 219); //ピンク
        break;
      case 3:
        fill(204, 223, 212); //黄緑
        break;
      case 4:
        fill(50, 129, 155); //青
        break;
      case 5:
        fill(116, 146, 176); //薄青
        break;
      case 6:
        fill(243, 180, 204); //濃ピンク
        break;
      case 7:
        fill(254, 236, 222);  //黄色
        break;
      }

      //色の塗り方が逆のパターンを設定
      for (int j = 0; j < colorReverse.length; j++) {
        if (rule == colorReverse[j]) {
          switch( colorCells[i] ) {
          case 0:
            fill(254, 236, 222);  //黄色
            break;
          case 7:
            fill(204, 229, 235); //水色
            break;
          }
        }
      }


      noStroke();
      rect(x+i*w, y+generation*w, w, w);
    }
  }

  int rules (int a, int b, int c) {
    if (a == 1 && b == 1 && c == 1) return ruleset[0];
    if (a == 1 && b == 1 && c == 0) return ruleset[1];
    if (a == 1 && b == 0 && c == 1) return ruleset[2];
    if (a == 1 && b == 0 && c == 0) return ruleset[3];
    if (a == 0 && b == 1 && c == 1) return ruleset[4];
    if (a == 0 && b == 1 && c == 0) return ruleset[5];
    if (a == 0 && b == 0 && c == 1) return ruleset[6];
    if (a == 0 && b == 0 && c == 0) return ruleset[7];
    return 0;
  }

  int colorRules (int a, int b, int c) {
    if (a == 1 && b == 1 && c == 1) return 0;
    if (a == 1 && b == 1 && c == 0) return 1;
    if (a == 1 && b == 0 && c == 1) return 2;
    if (a == 1 && b == 0 && c == 0) return 3;
    if (a == 0 && b == 1 && c == 1) return 4;
    if (a == 0 && b == 1 && c == 0) return 5;
    if (a == 0 && b == 0 && c == 1) return 6;
    if (a == 0 && b == 0 && c == 0) return 7;
    return 0;
  }

  boolean finished() {
    if (generation > ph/w) {
      return true;
    } else {
      return false;
    }
  }
}
