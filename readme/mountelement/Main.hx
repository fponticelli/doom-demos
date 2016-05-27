import doom.html.Html.*;
import js.Browser.document as doc;

class Main {
  static function main()
    Doom.browser.mount(
      h1("I'm just a simple element"),
      doc.getElementById("main")
    );
}
