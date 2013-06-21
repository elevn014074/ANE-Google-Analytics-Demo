/**
 * Author:  alessandro.bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 20/06/2013 15:10
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.views {
import eu.alebianco.air.extensions.analytics.demo.views.api.ITrackViews;

import feathers.controls.Label;
import feathers.controls.ScrollContainer;
import feathers.controls.Scroller;
import feathers.controls.TextInput;

import mx.utils.StringUtil;

import starling.events.Event;

public class TrackViewScreen extends TrackBaseScreen implements ITrackViews {

    private var name_row:ScrollContainer;
    private var name_lbl:Label;
    private var name_fld:TextInput;

    public function get screenName():String {
        return (isInitialized) ? StringUtil.trim(name_fld.text) : "";
    }

    override public function dispose():void {
        super.dispose();
        name_fld.removeEventListener(Event.CHANGE, name_changeHandler);
    }

    override protected function initialize():void {
        super.initialize();
        info_lbl.text = resources.tracker.view.info;
    }

    override protected function createFormFields():void {

        name_row = new ScrollContainer();
        name_row.layout = getFormFieldLayout();
        container.scrollerProperties.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
        container.addChild(name_row);

        name_lbl = new Label();
        name_lbl.text = resources.tracker.view.fields.name;
        name_row.addChild(name_lbl);

        name_fld = new TextInput();
        name_fld.addEventListener(Event.CHANGE, name_changeHandler);
        name_row.addChild(name_fld);
    }

    private function name_changeHandler(event:Event):void {
        change.dispatch();
    }

    override protected function createHeader():void {
        super.createHeader();
        header.title = resources.tracker.view.title;
    }
}
}
