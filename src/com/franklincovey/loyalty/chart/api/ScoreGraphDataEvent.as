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

	public class ScoreGraphDataEvent extends Event
	{

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ScoreGraphDataEvent( type:String )
		{
			super( type, true, true );
		}

		//--------------------------------------------------------------------------
		//
		//  Public Static Constants
		//
		//--------------------------------------------------------------------------

		public static const CHART_SERIES_CHANGED:String = "chartSeriesChanged";

		public static const CHART_DATA_CHANGED:String = "chartDataChanged";

		public static const CHART_TYPE_CHANGED:String = "chartTypeChanged";

		public static const CHART_REPORT_CHANGED:String = "chartReportChanged";

		//--------------------------------------------------------------------------
		//
		//  Overriden Public Methods
		//
		//--------------------------------------------------------------------------

		override public function clone():Event
		{
			return new ScoreGraphDataEvent( type );
		}
	}
}
