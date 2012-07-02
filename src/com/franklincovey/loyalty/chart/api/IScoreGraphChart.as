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


	import flash.events.IEventDispatcher;

	import mx.charts.chartClasses.IAxis;
	import mx.collections.ArrayCollection;
	import mx.core.IToolTip;

	//--------------------------------------
	//  Events
	//--------------------------------------

	[Event( name = "chartSeriesChanged", type = "com.franklincovey.loyalty.chart.api.ScoreGraphEvent" )]
	[Event( name = "chartHorizontalAxisChanged", type = "com.franklincovey.loyalty.chart.api.ScoreGraphEvent" )]
	[Event( name = "chartVerticalAxisChanged", type = "com.franklincovey.loyalty.chart.api.ScoreGraphEvent" )]
	[Event( name = "chartTypeChanged", type = "com.franklincovey.loyalty.chart.api.ScoreGraphEvent" )]


	/**
	 * Score Graph Chart Interface
	 *
	 * @category   Loyalty
	 * @package    Charts
	 * @copyright  Copyright (c) 2012 Franklin Covey Inc Inc. (http://www.franklincovey.com)
	 * @license    http://opensource.franklincovey.com/license/new-bsd     New BSD License
	 * @author     Sean Thayne <sean.thayne@franklincovey.com>
	 */
	public interface IScoreGraphChart extends IEventDispatcher
	{

		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------

		//----------------------------------
		//  Series
		//----------------------------------

		[Bindable( event = "chartSeriesChanged" )]
		function get series():Array;

		//----------------------------------
		//  Horizontal Axis
		//----------------------------------

		[Bindable( event = "chartHorizontalAxisChanged" )]
		function get horizontalAxis():IAxis;

		//----------------------------------
		//  Vertical Axis
		//----------------------------------

		[Bindable( event = "chartVerticalAxisChanged" )]
		function get verticalAxis():IAxis;

		//----------------------------------
		//  Chart Types
		//----------------------------------

		[Bindable( event = "chartTypeChanged" )]
		function get chartTypes():ArrayCollection;

		//----------------------------------
		//  Selected Chart Type
		//----------------------------------

		[Bindable( event = "chartTypeChanged" )]
		function get selectedChartType():ScoreGraphChartType;
		function set selectedChartType( value:ScoreGraphChartType ):void;

		function invalidateDisplay():void;
		function createToolTip( data:Object ):IToolTip;
	}
}


