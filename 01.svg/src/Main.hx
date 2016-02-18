import dots.Query;
import svg.SvgApp;

class Main {
  static function main() {
    var doom = new doom.html.Render();
    doom.mount(
      new SvgApp({}),
      Query.find("section.svg")
    );
  }
}
