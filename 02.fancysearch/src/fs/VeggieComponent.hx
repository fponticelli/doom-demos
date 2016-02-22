package fs;

import doom.html.Html.*;
import doom.html.Component;
import haxe.ds.Option;

class VeggieComponent extends Component<{ veggie : Option<Veggie>}> {
  override function render()
    return switch props.veggie {
      case Some(item):
        article([
          h2(item.vegetable),
          table([
            comp(new CookingComponent({ header : "steamed",     time : item.steamed })),
            comp(new CookingComponent({ header : "micro waved", time : item.microwaved })),
            comp(new CookingComponent({ header : "blanched",    time : item.blanched })),
            comp(new CookingComponent({ header : "boiled",      time : item.boiled })),
            comp(new CookingComponent({ header : "other",       time : item.other }))
          ])
        ]);
      case None:
        article("Please Search for a veggie");
    };
}
