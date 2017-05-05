package todomvc.view;

import todomvc.data.VisibilityFilter;
import doom.html.Html.*;
import doom.html.Component;
import doom.core.VNodes;
import todomvc.data.TodoAction;

class Footer extends Component<{ dispatch: TodoAction -> Void, state: FooterState }> {
  override function render() {
    var footerContent: VNodes= [
        span([
            "class" => "todo-count"
          ],
          getItemsLeftLabel()
        ),
        ul(["class" => "filters"], [
          li(a([
            "class" => [
              "selected" => isFilter(ShowAll)
            ],
            "href" => "#",
            "click" => handleClickFilter.bind(ShowAll)
          ], "All")),
          li(a([
            "class" => [
              "selected" => isFilter(ShowActive)
            ],
            "href" => "#/active",
            "click" => handleClickFilter.bind(ShowActive)
          ], "Active")),
          li(a([
            "class" => [
              "selected" => isFilter(ShowCompleted)
            ],
            "href" => "#/completed",
            "click" => handleClickFilter.bind(ShowCompleted)
          ], "Completed"))
        ])
      ];
    if(props.state.hasCompleted) {
      footerContent.add(
        button([
          "class" => "clear-completed",
          "click" => handleClear
        ], "Clear completed")
      );
    }
    return footer(["class" => "footer"], footerContent);
  }

  function handleClear()
    props.dispatch(ClearCompleted);

  function handleClickFilter(filter: VisibilityFilter)
    props.dispatch(SetVisibilityFilter(filter));

  function isFilter(filter: VisibilityFilter)
    return Type.enumEq(props.state.filter, filter);

  function getItemsLeftLabel(): VNodes
    return props.state.remaining == 1 ? [strong("1"), " item left"]: [strong('${props.state.remaining}'), " items left"];
}

typedef FooterState = {
  remaining: Int,
  filter: VisibilityFilter,
  hasCompleted: Bool
}
