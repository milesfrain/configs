import Clutter from 'gi://Clutter';
import St from 'gi://St';

import {Extension} from 'resource:///org/gnome/shell/extensions/extension.js';
import * as Main from 'resource:///org/gnome/shell/ui/main.js';
import * as SwitcherPopup from 'resource:///org/gnome/shell/ui/switcherPopup.js';

let originalAllocate = null;

function monitorForFocusedWindow() {
    const window = global.display.focus_window;

    if (window) {
        const monitorIndex = window.get_monitor();
        const monitor = Main.layoutManager.monitors[monitorIndex];

        if (monitor)
            return monitor;
    }

    const [pointerX, pointerY] = global.get_pointer();
    const pointerMonitor = Main.layoutManager.monitors.find(monitor =>
        pointerX >= monitor.x &&
        pointerX < monitor.x + monitor.width &&
        pointerY >= monitor.y &&
        pointerY < monitor.y + monitor.height);

    return pointerMonitor ?? Main.layoutManager.currentMonitor ?? Main.layoutManager.primaryMonitor;
}

export default class AltTabFocusedMonitorExtension extends Extension {
    enable() {
        if (originalAllocate)
            return;

        originalAllocate = SwitcherPopup.SwitcherPopup.prototype.vfunc_allocate;

        SwitcherPopup.SwitcherPopup.prototype.vfunc_allocate = function(box) {
            this.set_allocation(box);

            const childBox = new Clutter.ActorBox();
            const monitor = monitorForFocusedWindow();

            const leftPadding = this.get_theme_node().get_padding(St.Side.LEFT);
            const rightPadding = this.get_theme_node().get_padding(St.Side.RIGHT);
            const hPadding = leftPadding + rightPadding;

            const [, childNaturalHeight] = this._switcherList.get_preferred_height(monitor.width - hPadding);
            const [, childNaturalWidth] = this._switcherList.get_preferred_width(childNaturalHeight);

            childBox.x1 = Math.max(
                monitor.x + leftPadding,
                monitor.x + Math.floor((monitor.width - childNaturalWidth) / 2));
            childBox.x2 = Math.min(
                monitor.x + monitor.width - rightPadding,
                childBox.x1 + childNaturalWidth);
            childBox.y1 = monitor.y + Math.floor((monitor.height - childNaturalHeight) / 2);
            childBox.y2 = childBox.y1 + childNaturalHeight;

            this._switcherList.allocate(childBox);
        };
    }

    disable() {
        if (!originalAllocate)
            return;

        SwitcherPopup.SwitcherPopup.prototype.vfunc_allocate = originalAllocate;
        originalAllocate = null;
    }
}
