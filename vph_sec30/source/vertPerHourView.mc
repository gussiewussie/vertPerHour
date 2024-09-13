import Toybox.Activity;
import Toybox.Lang;
import Toybox.Time;
import Toybox.WatchUi;
import Toybox.System;

class vertPerHourView extends WatchUi.SimpleDataField {

    var frame_mins, frame_secs;
    var frame_ascent_array as Array<Number>;

    var device_settings = System.getDeviceSettings();
    var meters_or_feet;

    // Set the label of the data field here.
    function initialize(frame_size_minutes) {
        SimpleDataField.initialize();

        frame_mins = frame_size_minutes;
        frame_secs = (frame_mins * 60).toNumber();
        frame_ascent_array = new Array<Number>[frame_secs];

        if(frame_mins < 1){
            label = Lang.format("VpH - $1$ sec", [frame_secs.format("%d")]);
        }else{
            label = Lang.format("VpH - $1$ min", [frame_mins.format("%d")]);
        }

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

        // timer time (not elapsed time (doesn't include paused time)) in seconds
        var t = info.timerTime / 1000;

        // add new observation of total ascent to array
        if(info.totalAscent == null){
            frame_ascent_array[t % frame_secs] = 0;
        }else{
            frame_ascent_array[t % frame_secs] = (info.totalAscent * meters_or_feet) as Number;
        }

        System.println("not a barrel");

        // compute vert per hour in 1 of 3 circumstances:
        var frame_vert, frame_vph;
        // 1: before activity is started
        if(t <= 0){
            frame_vert = 0;
            frame_vph = 0;
        } 
        // 2:  if time is less than frame_mins, estimate VpH over longest time frame possible
        else if(0 < t and t < frame_secs){
            frame_vert = frame_ascent_array[t % frame_secs];
            frame_vph = frame_vert / ( (t / 60.0) / 60.0 );
        }
        // 3: when array should be full of data
        else{ 
            if(frame_ascent_array[(t+1) % frame_secs] == null){
                frame_vert = frame_ascent_array[t % frame_secs];
            }else{
                frame_vert = frame_ascent_array[t % frame_secs] - frame_ascent_array[(t+1) % frame_secs];
            }
            frame_vph = frame_vert * 60 / frame_mins;
        }

        return frame_vph.toNumber();
        
    }

}