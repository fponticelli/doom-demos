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
    var property: Property<AppState> = new Property({
          visibilityFilter: getFilterFromHash(),
          todos: getTodosFromLocalStorage()
        }),
        store = new Store(property, todoApp, Middleware.use());

    // monitor hash change for browser back/forward buttons
    window.addEventListener('hashchange', function() {
      hashChange( store );
    });

    // init app
    var app = new App(store);
    Doom.browser.mount(app, Query.find("section.todoapp"));
  }

  static function getFilterFromHash() {
    var hash = window.location.hash.trimCharsLeft("#");
    return switch hash {
      case "/active": ShowActive;
      case "/completed": ShowCompleted;
      case _: ShowAll;
    };
  }

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
