package todomvc.view;

import doom.html.Html.*;
import doom.html.Component;
import lies.Store;
import thx.ReadonlyArray;
import todomvc.data.AppState;
import todomvc.data.TodoAction;
import todomvc.data.VisibilityFilter;

class App extends Component<Store<AppState, TodoAction>> {
  override function render() {
    var header = new Header({
          add : function(text) props.dispatch(Add(text))
        }),
        body = new Body({
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
        });
    props.subscribe(function() {
      body.update({
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
      });
    });
    return div([comp(header), comp(body)]);
  }
}
