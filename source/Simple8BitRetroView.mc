import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Time;
import Toybox.Time.Gregorian;
import Toybox.Communications;

class Simple8BitRetroView extends WatchUi.WatchFace {

    var colours as Array<Graphics.ColorValue>;
    var pix;
    var height;

    function initialize() {
        WatchFace.initialize();
        colours = [Graphics.COLOR_BLACK, Graphics.COLOR_RED, Graphics.COLOR_GREEN, Graphics.COLOR_YELLOW, Graphics.COLOR_DK_BLUE, Graphics.COLOR_PINK, Graphics.COLOR_BLUE, Graphics.COLOR_WHITE];
        pix = (System.getDeviceSettings().screenWidth*0.05).toNumber();
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

        var ShowDate = Application.Properties.getValue("ShowDate");
        var ShowBarChart = Application.Properties.getValue("ShowBarChart");
        //var ShowBarChartValues = Application.Properties.getValue("ShowBarChartValues"); future

        var currentTime = getTime();
        var lowerText = (ShowDate) ? getDate() : "Hello World";

        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);

        // Display Time
        dc.drawText(
            dc.getWidth()/2,
            dc.getHeight()/3.1,
            Graphics.FONT_NUMBER_MEDIUM,
            currentTime,
            Graphics.TEXT_JUSTIFY_CENTER
        );
        // Display Text/Date
        dc.drawText(
            dc.getWidth()/2,
            dc.getHeight()/1.5,
            Graphics.FONT_MEDIUM,
            lowerText,  
            Graphics.TEXT_JUSTIFY_CENTER
        );

        // 8-Bit colour boxes
        for (var i = 0; i < 8; i++) {
            dc.setColor(colours[i], Graphics.COLOR_TRANSPARENT);
            dc.fillRectangle(dc.getWidth()/2 - pix*2*(4-i), dc.getHeight()/2 - pix*5, pix*2, pix*2);
        }
        // Bar Chart
        if (!ShowBarChart) {return;}

        var HR = ActivityMonitor.getHeartRateHistory(1, true).next().heartRate;
        var STP = ActivityMonitor.getInfo().steps;
        var STR = getStress();
        var CON = (System.getDeviceSettings().connectionAvailable) ? pix*2 : 0;
        var BAT = System.getSystemStats().battery;
        var BOD = getBodyBattery();
        var NOT = System.getDeviceSettings().notificationCount;

        // RED - Heart Rate
        dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
        HR = (HR > 0) ? HR : 0;
        height = pix*(HR)/UserProfile.getProfile().averageRestingHeartRate;
        height = (height > pix) ? height : pix;
        dc.fillRectangle(dc.getWidth()/2 - pix*6, dc.getHeight()/2 - pix*4.9 - height, pix*2, height);
        dc.drawText(
            dc.getWidth()/2 - pix*5,
            dc.getHeight()/2 - pix*7 - height,
            Graphics.FONT_XTINY,
            (HR > 0) ? HR : "-",
            Graphics.TEXT_JUSTIFY_CENTER
        );

        // GREEN - Steps
        dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
        height = pix*2*(STP)/ActivityMonitor.getInfo().stepGoal;
        height = (height < pix*3.3) ? height : pix*3.3;
        dc.fillRectangle(dc.getWidth()/2 - pix*4, dc.getHeight()/2 - pix*4.9 - height, pix*2, height);
        dc.drawText(
            dc.getWidth()/2 - pix*3,
            dc.getHeight()/2 - pix*7 - height,
            Graphics.FONT_XTINY,
            (STP/ActivityMonitor.getInfo().stepGoal).toNumber().format("%d"),
            Graphics.TEXT_JUSTIFY_CENTER
        );

        // YELLOW - Stress
        dc.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_TRANSPARENT);
        height = pix*2*STR/100;
        dc.fillRectangle(dc.getWidth()/2 - pix*2, dc.getHeight()/2 - pix*4.9 - height, pix*2, height);
        dc.drawText(
            dc.getWidth()/2 - pix*1,
            dc.getHeight()/2 - pix*7 - height,
            Graphics.FONT_XTINY,
            (STR > 0) ? STR.format("%d") : "-",
            Graphics.TEXT_JUSTIFY_CENTER
        );

        // DKBLUE - Bluetooth
        dc.setColor(Graphics.COLOR_DK_BLUE, Graphics.COLOR_TRANSPARENT);
        height = CON;
        dc.fillRectangle(dc.getWidth()/2 - pix*0, dc.getHeight()/2 - pix*4.9 - height, pix*2, height);
        dc.drawText(
            dc.getWidth()/2 - pix*-1,
            dc.getHeight()/2 - pix*7 - height,
            Graphics.FONT_XTINY,
            (CON > 0) ? "*" : "",
            Graphics.TEXT_JUSTIFY_CENTER
        );

        // PINK - Battery
        dc.setColor(Graphics.COLOR_PINK, Graphics.COLOR_TRANSPARENT);
        height = pix*3.3*BAT/100;
        dc.fillRectangle(dc.getWidth()/2 - pix*-2, dc.getHeight()/2 - pix*4.9 - height, pix*2, height);
        dc.drawText(
            dc.getWidth()/2 - pix*-3,
            dc.getHeight()/2 - pix*7 - height,
            Graphics.FONT_XTINY,
            BAT.format("%d"),
            Graphics.TEXT_JUSTIFY_CENTER
        );

        // BLUE - Body Battery
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_TRANSPARENT);
        height = pix*2.5*BOD/100;
        dc.fillRectangle(dc.getWidth()/2 - pix*-4, dc.getHeight()/2 - pix*4.9 - height, pix*2, height);
        dc.drawText(
            dc.getWidth()/2 - pix*-5,
            dc.getHeight()/2 - pix*7 - height,
            Graphics.FONT_XTINY,
            (BOD > 0) ? BOD.format("%2d") : "-",
            Graphics.TEXT_JUSTIFY_CENTER
        );

        // WHITE - Notification
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        height = 0;
        dc.fillRectangle(dc.getWidth()/2 - pix*-6, dc.getHeight()/2 - pix*4.9 - height, pix*2, height);
        dc.drawText(
            dc.getWidth()/2 - pix*-7,
            dc.getHeight()/2 - pix*7 - height,
            Graphics.FONT_XTINY,
            (NOT > 0) ? NOT : "",
            Graphics.TEXT_JUSTIFY_CENTER
        );
    }

    function getStressIterator() {
        if ((Toybox has: SensorHistory) && (Toybox.SensorHistory has: getStressHistory)) {
            return Toybox.SensorHistory.getStressHistory({: period => 1,: order => Toybox.SensorHistory.ORDER_NEWEST_FIRST});
        }
        return null;
    }

    function getStress() as Number {
        var strIterator = getStressIterator();
        var sample = strIterator.next();
        while (sample != null) {
            if (sample.data != null) {
                return sample.data;
            }
            sample = strIterator.next();
        }
        return -1;
    }

    function getBodyBatteryIterator() {
        if ((Toybox has: SensorHistory) && (Toybox.SensorHistory has: getBodyBatteryHistory)) {
            return Toybox.SensorHistory.getBodyBatteryHistory({: period => 1,: order => Toybox.SensorHistory.ORDER_NEWEST_FIRST});
        }
        return null;
    }

    function getBodyBattery() as Number or Null {
        var bbIterator = getBodyBatteryIterator();
        var sample = bbIterator.next();
        while (sample != null) {
            if (sample.data != null) {
                return sample.data;
            }
            sample = bbIterator.next();
        }
        return -1;
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
