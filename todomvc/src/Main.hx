import dots.Query;
import todomvc.view.App;
import todomvc.data.AppState;
import todomvc.data.TodoAction;
import todomvc.data.TodoItem;
import todomvc.data.VisibilityFilter;
import todomvc.data.Reducers.*;
import todomvc.data.Middleware;
import thx.stream.Property;
import thx.stream.Store;
import js.Browser.*;
import haxe.Json;
using thx.Strings;
using thx.ReadonlyArray;

class Main {
  public static inline var STORAGE_KEY: String = "TodoMVC-Doom";
  static function main() {
    var state = {
          visibilityFilter: getFilterFromHash(),
          todos: getTodosFromLocalStorage()
        },
        property = new Property(state),
        store = new Store(property, todoApp, Middleware.use());

    // monitor hash change for browser back/forward buttons
    window.addEventListener('hashchange', hashChange.bind(store));

    // init app
    Doom.browser.mount(new App(store), Query.find("section.todoapp"));
  }

  static function getFilterFromHash()
    return switch window.location.hash.trimCharsLeft("#") {
      case "/active": ShowActive;
      case "/completed": ShowCompleted;
      case _: ShowAll;
    };

  static function getTodosFromLocalStorage(): ReadonlyArray<TodoItem> {
    var v = window.localStorage.getItem(STORAGE_KEY);
    if(v.hasContent())
      return Json.parse(v);
    else
      return [];
  }

  static function hashChange(store: Store<AppState, TodoAction>)
    store.dispatch(SetVisibilityFilter(getFilterFromHash()));
}
