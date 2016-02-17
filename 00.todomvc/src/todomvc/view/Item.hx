package todomvc.view;

import doom.html.Html.*;
import doom.html.Component;
import js.html.Element;
import js.html.KeyboardEvent;
import todomvc.data.TodoItem;
using thx.Objects;
using thx.Strings;

class Item extends Component<{ api : ItemApi, state : ItemState }> {
  override function render()
    return li([
        "class" => [
          "completed" => props.state.item.completed,
          "editing"   => props.state.editing,
        ],
        "dblclick" => handleDblClick
      ], [
      div(["class" => "view"], [
        input([
          "class"   => "toggle",
          "type"    => "checkbox",
          "checked" => props.state.item.completed,
          "change"  => props.api.toggle
        ]),
        label(props.state.item.text),
        button([
          "class" => "destroy",
          "click" => props.api.remove
        ])
      ]),
      input([
        "class" => "edit",
        "value" => props.state.item.text,
        "blur"  => handleBlur,
        "keyup" => handleKeydown,
      ])
    ]);

  function handleDblClick() {
    props.state.editing = true;
    update(props);
    getInput().select();
  }

  function handleBlur() {
    if(!props.state.editing) return;
    props.state.editing = false;
    var value = getInputValueAndTrim();
    if(value.isEmpty()) {
      props.api.remove();
    } else if(value != props.state.item.text) {
      props.api.updateText(value);
    } else {
      update(props.merge({ state : { item : props.state.item, editing : false }}));
    }
  }

  function handleKeydown(e : KeyboardEvent) {
    if(e.which != dots.Keys.ENTER)
      return;
    handleBlur();
  }

  function getInput() : js.html.InputElement
    return cast (cast element : Element).querySelector("input.edit");

  function getInputValueAndTrim() {
    var input = getInput();
    return input.value = input.value.trim();
  }
}

typedef ItemApi = {
  public function remove() : Void;
  public function toggle() : Void;
  public function updateText(text : String) : Void;
}

typedef ItemState = {
  item : TodoItem,
  editing : Bool
}
