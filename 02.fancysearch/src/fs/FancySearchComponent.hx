package fs;

import doom.html.Html.*;
import doom.html.Component;
import fancy.Search;
import fancy.search.util.Types;

class FancySearchComponent extends Component<FancySearchOptions<Veggie>> {
  override function render()
    return input([
      "class" => "fancy-search-component fancify",
      "placeholder" => "type to search",
      "type"  => "text",
    ]);

  override function didMount()
    new Search(cast element, props);

  override function shouldRender()
    return false;
}
