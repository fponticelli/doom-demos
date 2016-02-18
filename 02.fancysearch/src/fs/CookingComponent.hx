package fs;

import doom.html.Html.*;
import doom.html.Component;

class CookingComponent extends Component<{ header : String, time : String }> {
  override function render() {
    return tr([
            th(props.header),
            td([props.time, " min."])
          ]);
  }
}
