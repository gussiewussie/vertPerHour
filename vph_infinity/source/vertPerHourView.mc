import Toybox.Activity;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;
import Toybox.System;

class vertPerHourView extends WatchUi.SimpleDataField {

    var device_settings = System.getDeviceSettings();
    var meters_or_feet;

    // Set the label of the data field here.
    function initialize() {
        SimpleDataField.initialize();

        label = "VpH";

        if(device_settings.elevationUnits == false){
            meters_or_feet = 1;
        } else{
            meters_or_feet = 3.28084;
        }

    }

    // The given info object contains all the current workout
    // information. Calculate a value and return it in this method.
    // Note that compute() and onUpdate() are asynchronous, and there is no
    // guarantee that compute() will be called before onUpdate().
    function compute(info as Activity.Info) as Numeric or Duration or String or Null {
        // See Activity.Info in the documentation for available information.

        // timer time (not elapsed time (doesn't include paused time)) in hours
        var t = ( ( info.timerTime / 1000.0) / 60.0) / 60.0;

        var ascent;
        // add new observation of total ascent to array
        if(info.totalAscent == null){
            ascent = 0;
        }else{
            ascent = info.totalAscent * meters_or_feet;
        }

        // return vert per hour
        if(t <= 0){
            return 0;
        } else{
            return (ascent / t).toNumber();
        }
    }

}