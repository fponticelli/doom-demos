package todomvc.view;

import doom.html.Html.*;
import doom.html.Component;
import todomvc.data.AppState;
using todomvc.data.VisibilityFilter;

class Body extends Component<{ api : BodyApi, state : AppState }> {
  override function render()
    return if(props.state.todos.length == 0) {
      dummy("nothing to do yet");
    } else {
      var all = props.state.todos.length,
          completed = props.state.todos.filterVisibility(ShowCompleted).length,
          remaining = all - completed;
      div([
        new List({
          api : props.api,
          state : {
            items : props.state.todos.filterVisibility(props.state.visibilityFilter),
            allCompleted : completed == 0
          }
        }).asNode(),
        new Footer({
          api : props.api,
          state : {
            remaining : remaining,
            filter : props.state.visibilityFilter,
            hasCompleted : completed > 0
          }
        }).asNode()
      ]);
    };
}

typedef BodyApi = {
  function setFilter(filter : VisibilityFilter) : Void;
  function clearCompleted() : Void;
  function remove(id : String) : Void;
  function updateText(id : String, text : String) : Void;
  function toggle(id : String) : Void;
  function toggleAll() : Void;
}
