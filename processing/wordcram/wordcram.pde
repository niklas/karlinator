import wordcram.*;
import java.util.List;
import java.util.ArrayList;
import processing.pdf.*;

size(1920, 1080, PDF, "wordcram.pdf");
background(255);
PFont font = createFont("Georgia Italic", 1);

BufferedReader reader;
String line;

reader = createReader("var/word_count.txt");
List<Word> wordList = new ArrayList<Word>();

try {
  while ((line = reader.readLine()) != null) {
    String[] pieces = split(line, ':');
    String w = pieces[0];
    int c = int(pieces[1]);
    wordList.add( new Word(w, c) );
  }
} catch (IOException e) {
  e.printStackTrace();
  line = null;
}

Word[] wordArray = new Word[ wordList.size() ];
wordList.toArray( wordArray );

// Pass in the sketch (the variable "this"), so WordCram can draw to it.
WordCram wordcram = new WordCram(this)

// Pass in the words to draw.
  .fromWords(wordArray)
//.angledAt(radians(30), radians(30), radians(-60))
  .withFont(font)
  .withColors(#8C3D26, #7F3822, #FF7045, #401C11, #E5653E) // reddish
  .sizedByWeight(10,90)

  ;

// Now we've created our WordCram, we can draw it:
wordcram.drawAll();

