package todomvc.view;

import doom.html.Html.*;
import doom.html.Component;
import thx.ReadonlyArray;
import todomvc.data.TodoItem;
import todomvc.data.TodoAction;

class List extends Component<{ dispatch: TodoAction -> Void, state: ListState }> {
  override function render()
    return section(["class" => "main"], [
      input([
        "class" => "toggle-all",
        "type" => "checkbox",
        "checked" => props.state.allCompleted,
        "change" => () -> props.dispatch(ToggleAll)
      ]),
      label(["for" => "toggle-all"], "Mark all as complete"),
      ul(["class" => "todo-list"], [
        for(item in props.state.items)
          new Item({
            api: {
              remove: () -> props.dispatch(Remove(item.id)),
              toggle: () -> props.dispatch(Toggle(item.id)),
              updateText: (text) -> props.dispatch(UpdateText(item.id, text))
            },
            state: {
              item: item,
              editing: false
            }
          }).asNode()
      ])
    ]);
}

typedef ListState = {
  items: ReadonlyArray<TodoItem>,
  allCompleted: Bool
}
