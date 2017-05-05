package todomvc.data;

import thx.stream.Reducer.Middleware as MW;
import js.Browser.*;
import haxe.Json;

class Middleware {
  public static function use(): MW<AppState, TodoAction>
    return MW.empty() + save + changeUrl + log;

  // save changes to local storage
  public static function save(state: AppState)
    window.localStorage.setItem(Main.STORAGE_KEY, Json.stringify(state.todos));

  // set filter in hash
  public static function changeUrl(state: AppState)
    window.location.hash = switch state.visibilityFilter {
      case ShowActive: "/active";
      case ShowCompleted: "/completed";
      case _: "";
    };

  // log to console
  public static function log(_, action: TodoAction)
    js.Browser.console.log(thx.Enums.string(action));
}
