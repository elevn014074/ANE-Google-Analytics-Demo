/**
 * Author:  alessandro.bianco
 * Website: http://alessandrobianco.eu
 * Twitter: @alebianco
 * Created: 21/06/2013 16:35
 *
 * Copyright © 2013 Alessandro Bianco
 */
package eu.alebianco.air.extensions.analytics.demo.mediators {

import eu.alebianco.air.extensions.analytics.api.Hit;
import eu.alebianco.air.extensions.analytics.api.IEventBuilder;
import eu.alebianco.air.extensions.analytics.api.ITracker;
import eu.alebianco.air.extensions.analytics.demo.events.NavigateEvent;
import eu.alebianco.air.extensions.analytics.demo.events.TrackDataEvent;
import eu.alebianco.air.extensions.analytics.demo.model.DemoScreen;
import eu.alebianco.air.extensions.analytics.demo.views.api.ITrackEvent;

import robotlegs.bender.bundles.mvcs.Mediator;

public class TrackEventMediator extends Mediator {

	private const CATEGORY_VALIDATOR:RegExp = new RegExp('^.+$', 'i');
	private const ACTION_VALIDATOR:RegExp = new RegExp('^.+$', 'i');
	private const LABEL_VALIDATOR:RegExp = new RegExp('^.+$', 'i');

	[Inject]
	public var view:ITrackEvent;

	[Inject]
	public var tracker:ITracker;

	override public function initialize():void {
		super.initialize();
		view.enabled = false;
		view.change.add(onChange);
		view.track.add(onTrack);
	}

	private function onChange():void {
		var isValid:Boolean = true;
		isValid &&= CATEGORY_VALIDATOR.test(view.category);
		isValid &&= ACTION_VALIDATOR.test(view.action);
		isValid &&= !view.hasLabel || LABEL_VALIDATOR.test(view.label);
		isValid &&= !view.hasValue || (view.value > 0);
		view.enabled = isValid;
	}

	private function onTrack():void {
		const builder:IEventBuilder = tracker.buildEvent(view.category, view.action);
		if (view.hasLabel) {
			builder.withLabel(view.label);
		}
		if (view.hasValue) {
			builder.withValue(view.value);
		}
		const hit:Hit = builder.create();
		dispatch(new TrackDataEvent(hit))
		dispatch(new NavigateEvent(DemoScreen.TRACKER_INFO));
	}

	override public function destroy():void {
		super.destroy();
		view.change.removeAll();
		view.track.removeAll();
	}
}
}
