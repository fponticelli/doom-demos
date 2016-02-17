package todomvc.view;

import doom.html.Html.*;
import doom.html.Component;
import lies.Store;
import todomvc.data.AppState;
import todomvc.data.TodoAction;
import todomvc.data.VisibilityFilter;
using thx.Objects;

class App extends Component<Store<AppState, TodoAction>> {
  override function render() {
    var bodyProps = {
          api : {
            setFilter : function(filter : VisibilityFilter)
              props.dispatch(SetVisibilityFilter(filter)),
            clearCompleted : function()
              props.dispatch(ClearCompleted),
            remove : function(id : String)
              props.dispatch(Remove(id)),
            toggle : function(id : String)
              props.dispatch(Toggle(id)),
            toggleAll : function()
              props.dispatch(ToggleAll),
            updateText : function(id : String, text : String)
              props.dispatch(UpdateText(id, text))
          },
          state : props.state
        },
        header = new Header({
          add : function(text) props.dispatch(Add(text))
        }),
        body = new Body(bodyProps);
    props.subscribe(function() {
      body.update(bodyProps.merge({ state : props.state }));
    });
    return div([header.asNode(), body.asNode()]);
  }
}
