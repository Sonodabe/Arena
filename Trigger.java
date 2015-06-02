import java.util.HashSet;

public class Trigger {
  private HashSet<Event> subscribers;

  public Trigger() {
    subscribers = new HashSet<Event>();
  }

  public void subscribe(Event e) {
    subscribers.add(e);
  }

  public void unsubscribe(Event e) {
    subscribers.remove(e);
  }

  public void trigger(Object... params) {
    for (Event sub : subscribers) {
      sub.onTrigger(params);
    }
  }
}

