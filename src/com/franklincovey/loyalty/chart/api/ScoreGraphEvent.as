/**
 * Loyalty Charts
 *
 * LICENSE
 *
 * This source file is subject to the new BSD license that is bundled
 * with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.franklincovey.com/license/new-bsd
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to opensource@franklincovey.com so we can send you a copy immediately.
 *
 * @category   Loyalty
 * @package    Charts
 * @copyright  Copyright (c) 2012 Franklin Covey Inc Inc. (http://www.franklincovey.com)
 * @license    http://opensource.franklincovey.com/license/new-bsd     New BSD License
 * @author     Sean Thayne <sean.thayne@franklincovey.com>
 */
package com.franklincovey.loyalty.chart.api
{
	import flash.events.Event;

	public class ScoreGraphEvent extends Event
	{

		public static const CHART_DATA_CHANGED:String = "chartDataChanged";

		public static const CHART_TYPE_CHANGED:String = "chartTypeChanged";

		public static const REPORT_CHANGED:String = "chartReportChanged";

		public static const CHART_SERIES_CHANGED:String = "chartSeriesChanged";

		public static const CHART_HORIZONTAL_AXIS_CHANGED:String = "chartHorizontalAxisChanged";

		public static const CHART_VERTICAL_AXIS_CHANGED:String = "chartVerticalAxisChanged";

		public static const LEVELS_CHANGED:String = "chartLevelsChanged";

		public static const SIDE_GRAPH_CHANGED:String = "sideGraphChanged";

		public function ScoreGraphEvent( type:String )
		{
			super( type );
		}

		override public function clone():Event
		{
			return new ScoreGraphEvent( type );
		}
	}
}


