package todomvc.view;

import doom.html.Html.*;
import doom.html.Component;
import todomvc.data.AppState;
import todomvc.data.TodoAction;
using todomvc.data.VisibilityFilter;

class Body extends Component<{ dispatch: TodoAction -> Void, state: AppState }> {
  override function render()
    return if(props.state.todos.length == 0) {
      dummy("nothing to do yet");
    } else {
      var all = props.state.todos.length,
          completed = props.state.todos.filterVisibility(ShowCompleted).length,
          remaining = all - completed;
      div([
        new List({
          dispatch: props.dispatch,
          state: {
            items: props.state.todos.filterVisibility(props.state.visibilityFilter),
            allCompleted: completed == 0
          }
        }).asNode(),
        new Footer({
          dispatch: props.dispatch,
          state: {
            remaining: remaining,
            filter: props.state.visibilityFilter,
            hasCompleted: completed > 0
          }
        }).asNode()
      ]);
    };
}
