class StringUtils {
  static String zenkakuToHankaku(String text) {
    var sb = StringBuffer();
    for (var i = 0; i < text.length; i++) {
      var c = text[i];
      switch (c) {
        case '！':
          c = "!";
          break;
        case '”':
          c = "\"";
          break;
        case '＃':
          c = "#";
          break;
        case '＄':
          c = "\$";
          break;
        case '￥':
          c = "\\";
          break;
        case '％':
          c = "%";
          break;
        case '＆':
          c = "&";
          break;
        case '’':
          c = "\'";
          break;
        case '（':
          c = "(";
          break;
        case '）':
          c = ")";
          break;
        case '＊':
          c = "*";
          break;
        case '＋':
          c = "+";
          break;
        case '，':
          c = ",";
          break;
        case '－':
          c = "-";
          break;
        case '．':
          c = ".";
          break;
        case '／':
          c = "/";
          break;
        case '０':
          c = "0";
          break;
        case '１':
          c = "1";
          break;
        case '２':
          c = "2";
          break;
        case '３':
          c = "3";
          break;
        case '４':
          c = "4";
          break;
        case '５':
          c = "5";
          break;
        case '６':
          c = "6";
          break;
        case '７':
          c = "7";
          break;
        case '８':
          c = "8";
          break;
        case '９':
          c = "9";
          break;
        case '：':
          c = ":";
          break;
        case '；':
          c = ";";
          break;
        case '＜':
          c = "<";
          break;
        case '＝':
          c = "=";
          break;
        case '＞':
          c = ">";
          break;
        case '？':
          c = "?";
          break;
        case '＠':
          c = "@";
          break;
        case 'Ａ':
          c = "A";
          break;
        case 'Ｂ':
          c = "B";
          break;
        case 'Ｃ':
          c = "C";
          break;
        case 'Ｄ':
          c = "D";
          break;
        case 'Ｅ':
          c = "E";
          break;
        case 'Ｆ':
          c = "F";
          break;
        case 'Ｇ':
          c = "G";
          break;
        case 'Ｈ':
          c = "H";
          break;
        case 'Ｉ':
          c = "I";
          break;
        case 'Ｊ':
          c = "J";
          break;
        case 'Ｋ':
          c = "K";
          break;
        case 'Ｌ':
          c = "L";
          break;
        case 'Ｍ':
          c = "M";
          break;
        case 'Ｎ':
          c = "N";
          break;
        case 'Ｏ':
          c = "O";
          break;
        case 'Ｐ':
          c = "P";
          break;
        case 'Ｑ':
          c = "Q";
          break;
        case 'Ｒ':
          c = "R";
          break;
        case 'Ｓ':
          c = "S";
          break;
        case 'Ｔ':
          c = "T";
          break;
        case 'Ｕ':
          c = "U";
          break;
        case 'Ｖ':
          c = "V";
          break;
        case 'Ｗ':
          c = "W";
          break;
        case 'Ｘ':
          c = "X";
          break;
        case 'Ｙ':
          c = "Y";
          break;
        case 'Ｚ':
          c = "Z";
          break;
        case '＾':
          c = "^";
          break;
        case '＿':
          c = "_";
          break;
        case '‘':
          c = "`";
          break;
        case 'ａ':
          c = "a";
          break;
        case 'ｂ':
          c = "b";
          break;
        case 'ｃ':
          c = "c";
          break;
        case 'ｄ':
          c = "d";
          break;
        case 'ｅ':
          c = "e";
          break;
        case 'ｆ':
          c = "f";
          break;
        case 'ｇ':
          c = "g";
          break;
        case 'ｈ':
          c = "h";
          break;
        case 'ｉ':
          c = "i";
          break;
        case 'ｊ':
          c = "j";
          break;
        case 'ｋ':
          c = "k";
          break;
        case 'ｌ':
          c = "l";
          break;
        case 'ｍ':
          c = "m";
          break;
        case 'ｎ':
          c = "n";
          break;
        case 'ｏ':
          c = "o";
          break;
        case 'ｐ':
          c = "p";
          break;
        case 'ｑ':
          c = "q";
          break;
        case 'ｒ':
          c = "r";
          break;
        case 'ｓ':
          c = "s";
          break;
        case 'ｔ':
          c = "t";
          break;
        case 'ｕ':
          c = "u";
          break;
        case 'ｖ':
          c = "v";
          break;
        case 'ｗ':
          c = "w";
          break;
        case 'ｘ':
          c = "x";
          break;
        case 'ｙ':
          c = "y";
          break;
        case 'ｚ':
          c = "z";
          break;
        case '｛':
          c = "{";
          break;
        case '｜':
          c = "|";
          break;
        case '｝':
          c = "}";
          break;
        case '・':
          c = "･";
          break;
        case '　':
          c = " ";
          break;
        default:
          break;
      }
      sb.write(c);
    }
    return sb.toString();
  }
}
