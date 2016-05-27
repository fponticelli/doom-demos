package todomvc.view;

import doom.html.Html.*;
import doom.html.Component;
import thx.ReadonlyArray;
import todomvc.data.TodoItem;
import todomvc.data.VisibilityFilter;

class List extends Component<{ api : ListApi, state : ListState }> {
  override function render()
    return section(["class" => "main"], [
      input([
        "class" => "toggle-all",
        "type" => "checkbox",
        "checked" => props.state.allCompleted,
        "change" => props.api.toggleAll
      ]),
      label(["for" => "toggle-all"], "Mark all as complete"),
      ul(["class" => "todo-list"], [
        for(item in props.state.items)
          new Item({
            api : {
              remove : props.api.remove.bind(item.id),
              toggle : props.api.toggle.bind(item.id),
              updateText : props.api.updateText.bind(item.id, _)
            },
            state : {
              item : item,
              editing : false
            }
          }).asNode()
      ])
    ]);
}

typedef ListApi = {
  function setFilter(filter : VisibilityFilter) : Void;
  function clearCompleted() : Void;
  function toggleAll() : Void;
  function remove(id : String) : Void;
  function updateText(id : String, text : String) : Void;
  function toggle(id : String) : Void;
}

typedef ListState = {
  items : ReadonlyArray<TodoItem>,
  allCompleted : Bool
}
