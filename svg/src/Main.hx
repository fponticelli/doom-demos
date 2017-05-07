import dots.Query;
import svg.SvgApp;
import doom.Doom;

class Main {
  static function main() {
    Doom.browser.mount(
      new SvgApp({}),
      Query.find("section.svg")
    );
  }
}
