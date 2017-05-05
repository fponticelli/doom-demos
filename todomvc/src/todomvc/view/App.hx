package todomvc.view;

import doom.html.Html.*;
import doom.html.Component;
import thx.stream.Store;
import todomvc.data.AppState;
import todomvc.data.TodoAction;
using thx.Objects;

class App extends Component<Store<AppState, TodoAction>> {
  override function render() {
    var bodyProps = {
          dispatch: function(a) props.dispatch(a),
          state: props.get()
        },
        header = new Header({
          add: function(text) props.dispatch(Add(text))
        }),
        body = new Body(bodyProps);
    props.stream()
      // stream can be synchronouse and `next` is going to trigger an updated
      // before the component has the opportunity to render
      .delayed(0)
      .next((v) -> body.update(bodyProps.shallowMerge({ state: v })))
      .run();
    return div([header.asNode(), body.asNode()]);
  }
}
