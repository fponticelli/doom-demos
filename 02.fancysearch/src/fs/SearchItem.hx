package fs;

import doom.html.Html.*;
import doom.html.Component;
import haxe.ds.Option;
using thx.Functions;
using thx.Arrays;
import thx.Options;
import thx.ReadonlyArray;

class SearchItem extends Component<AppState> {
  override function render() {
    var veggieComp = new VeggieComponent({ veggie : None });

    return switch props {
      case Loading:
        section(["class" => "container"], "Loading ...");
      case Data(data):
        section(["class" => "container"], [
          header(div(["class" => "fancy"],
            new FancySearchComponent({
              suggestionOptions : {
                suggestions : data.toArray(),
                onChooseSelection : function(toString, input, v) {
                  input.blur();
                  input.value = switch v {
                    case Some(veggie): toString(veggie);
                    case None: input.value;
                  };
                  veggieComp.update({ veggie : v });
                },
                suggestionToString : function(v) return v.vegetable
              }
            }))),
          comp(veggieComp)
        ]);
      case Error(msg):
        section(["class" => "container error"], msg);
    };
  }
}
