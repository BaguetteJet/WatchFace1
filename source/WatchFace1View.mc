import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Time;
import Toybox.Time.Gregorian;

class WatchFace1View extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc) {
        var colours = [Graphics.COLOR_BLACK, Graphics.COLOR_RED, Graphics.COLOR_GREEN, Graphics.COLOR_YELLOW, Graphics.COLOR_DK_BLUE, Graphics.COLOR_PINK, Graphics.COLOR_BLUE, Graphics.COLOR_WHITE];
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();

        for (var i = 0; i < 8; i++) {
            dc.setColor(colours[i], Graphics.COLOR_TRANSPARENT);
            dc.fillRectangle(dc.getWidth()/2 - 20*(4-i), dc.getWidth()/2 - 50, 20, 20);
        }

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);

        // Get and show the current time
        var clockTime = System.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]);

        dc.drawText(
            dc.getWidth()/2,
            dc.getHeight()/3,
            Graphics.FONT_NUMBER_MEDIUM,
            timeString,
            Graphics.TEXT_JUSTIFY_CENTER
        );

        dc.drawText(
            dc.getWidth()/2,
            dc.getHeight()/1.5,
            Graphics.FONT_MEDIUM,
            "Hello World",
            Graphics.TEXT_JUSTIFY_CENTER
        );
    }

    function getDate() as String {
        var now = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        var dateString = Lang.format("$1$, $2$ $3$", [now.day_of_week, now.month, now.day]);
        return dateString;
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
