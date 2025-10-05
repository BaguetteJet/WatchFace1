import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Time;
import Toybox.Time.Gregorian;

class WatchFace1View extends WatchUi.WatchFace {

    var colours as Array<Graphics.ColorValue>;
    var size;
    var center;
    var pix;

    function initialize() {
        WatchFace.initialize();
        colours = [Graphics.COLOR_BLACK, Graphics.COLOR_RED, Graphics.COLOR_GREEN, Graphics.COLOR_YELLOW, Graphics.COLOR_DK_BLUE, Graphics.COLOR_PINK, Graphics.COLOR_BLUE, Graphics.COLOR_WHITE];
        size = System.getDeviceSettings().screenWidth;
        center = size*0.5;
        pix = (center*0.1).toNumber();
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
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();

        // 8-Bit colour boxes
        for (var i = 0; i < 8; i++) {
            dc.setColor(colours[i], Graphics.COLOR_TRANSPARENT);
            //dc.fillRectangle(dc.getWidth()/2 - pix*2*(4-i), dc.getHeight()/2 - pix*5, pix*2, pix*2);
        }


        dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
        var hRed = pix*2*(ActivityMonitor.getHeartRateHistory(1, true).next().heartRate)/UserProfile.getProfile().averageRestingHeartRate;
        dc.fillRectangle(dc.getWidth()/2 - pix*8, dc.getHeight()/2 - pix*3 - hRed, pix*2, hRed);


        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);


        dc.drawText(
            dc.getWidth()/2,
            dc.getHeight()/3,
            Graphics.FONT_NUMBER_MEDIUM,
            getTime(),
            Graphics.TEXT_JUSTIFY_CENTER
        );

        dc.drawText(
            dc.getWidth()/2,
            dc.getHeight()/1.5,
            Graphics.FONT_MEDIUM,
            getDate(),
            Graphics.TEXT_JUSTIFY_CENTER
        );

        dc.drawText(
            dc.getWidth()/2 + 40, 
            dc.getHeight()/2 - 53,
            Graphics.FONT_TINY,
            getBattery(),
            Graphics.TEXT_JUSTIFY_LEFT
        );

        dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            dc.getWidth()/2 - pix*4.1, 
            dc.getHeight()/2 - pix*7,
            Graphics.FONT_XTINY,
            getHeartRate(),
            Graphics.TEXT_JUSTIFY_RIGHT
        );

        dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            dc.getWidth()/2 + pix*1.9, 
            dc.getHeight()/2 - pix*7,
            Graphics.FONT_XTINY,
            getSteps(),
            Graphics.TEXT_JUSTIFY_RIGHT
        );

        dc.setColor(Graphics.COLOR_PINK, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            dc.getWidth()/2 + pix*3.9, 
            dc.getHeight()/2 - pix*7,
            Graphics.FONT_XTINY,
            getBattery(),
            Graphics.TEXT_JUSTIFY_RIGHT
        );












    }

    function getTime() as String {
        var clockTime = System.getClockTime();
        var timeString = Lang.format("$1$:$2$", [clockTime.hour.format("%02d"), clockTime.min.format("%02d")]);
        return timeString;
    }

    function getDate() as String {
        var now = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        var dateString = Lang.format("$1$, $2$ $3$", [now.day_of_week, now.month, now.day]);
        return dateString;
    }

    function getHeartRate() as String {
        var mHeartRate = ActivityMonitor.getHeartRateHistory(1, true).next().heartRate;
        var hrString = (mHeartRate > 0) ? mHeartRate.toString() : "--";
        return hrString;
    }

    function getSteps() as String {
        var mSteps = ActivityMonitor.getInfo().steps;
        var stepsString = (mSteps >0) ? mSteps.toString() : "0";
        return stepsString;
    }

    function getBattery() as String {
        var batteryString = System.getSystemStats().battery.format("%d");
        return batteryString;
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
