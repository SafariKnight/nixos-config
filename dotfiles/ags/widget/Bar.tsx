import { App, Astal, Gtk, Gdk } from "astal/gtk3";
import { Variable } from "astal";
import Hyprland from "./Hyprland";

const time = Variable("").poll(1000, "date");

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      className="Bar"
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={App}
    >
      <box>
        <Hyprland />
      </box>
    </window>
  );
}
