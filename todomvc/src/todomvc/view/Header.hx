package todomvc.view;

import doom.html.Html.*;
import doom.html.Component;
import dots.Keys;
import js.html.InputElement;
import js.html.KeyboardEvent;
using thx.Strings;

class Header extends Component<AddItemApi> {
  override function render()
    return header([
        "class" => "header"
      ], [
        h1("todos"),
        input([
          "class"       => "new-todo",
          "placeholder" => "What needs to be done?",
          "autofocus"   => true,
          "keydown"     => handleKeys
        ])
      ]);

  function handleKeys(e: KeyboardEvent) {
    if(Keys.ENTER == e.which) {
      e.preventDefault();
      var value = getInputValueAndEmpty();
      if(value.isEmpty()) return;
      props.add(value);
    }
  }

  function getInputValueAndEmpty() {
    var el: InputElement = cast element.querySelector("input"),
        value = el.value.trim();
    el.value = "";
    return value;
  }
}

typedef AddItemApi = {
  public function add(label: String): Void;
}
