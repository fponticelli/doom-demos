package fs;

import doom.html.Html.*;
import doom.html.Component;

class App extends Component<AppProps> {
  override function render() {
    return div(["class" => "fancy-container"], [
      h1("veggies cooking time"),
      comp(new SearchItem(props.state))
    ]);
  }

  override function didMount() {
    props.onUpdate = function() update(props);
    props.load();
  }
}
