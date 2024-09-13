import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class vertPerHourApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    //
    // the max time-frame for the vertPerHourView object should probably
    // be 60 (minutes) cause any more and the Enduro watch runs out
    // of memory.
    function getInitialView() as [Views] or [Views, InputDelegates] {
        // return [ new vertPerHourView(30) ];
        return [ new vertPerBarrel.barrelVertView(15) ];
    }

}

function getApp() as vertPerHourApp {
    return Application.getApp() as vertPerHourApp;
}