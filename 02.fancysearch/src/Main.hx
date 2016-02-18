import dots.Query;
import fs.App;

class Main {
  static function main() {
    var api = new fs.AppProps("vegetables.json");
    Doom.browser.mount(
      new App(api),
      Query.find("section.fs")
    );
  }
}
