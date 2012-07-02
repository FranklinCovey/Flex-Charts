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
	import mx.charts.events.ChartItemEvent;
	import mx.collections.ArrayCollection;
	import mx.containers.TitleWindow;

	[Event( name = "chartDataChanged", type = "com.franklincovey.xcl.view.graphs.score.api.ScoreGraphEvent" )]
	[Event( name = "chartLevelsChanged", type = "com.franklincovey.xcl.view.graphs.score.api.ScoreGraphEvent" )]
	public interface IScoreGraphManager extends IEventDispatcher
	{

		//--------------------------------------------------------------------------
		//
		//  Public Propeties
		//
		//--------------------------------------------------------------------------

		//----------------------------------
		//  Title
		//----------------------------------

		function get title():String;

		//----------------------------------
		//  Chart Data
		//----------------------------------

		[Bindable( event = "chartDataChanged" )]
		function get data():ArrayCollection;

		//----------------------------------
		//  Levels
		//----------------------------------

		[Bindable( event = "chartLevelsChanged" )]
		function get levels():ArrayCollection;

		//----------------------------------
		//  Current Level
		//----------------------------------

		function get currentLevel():uint;
		function set currentLevel( value:uint ):void;

		//----------------------------------
		//  Chart Series
		//----------------------------------

		[Bindable( event = "chartSeriesChanged" )]
		function get chartSeries():Array;

		//----------------------------------
		//  Chart Horizontal Axis
		//----------------------------------

		[Bindable( event = "chartHorizontalAxisChanged" )]
		function get chartHorizontalAxis():IAxis;

		//----------------------------------
		//  Chart Vertical Axis
		//----------------------------------

		[Bindable( event = "chartVerticalAxisChanged" )]
		function get chartVerticalAxis():IAxis;

		//----------------------------------
		//  Chart Report Types
		//----------------------------------

		[Bindable( event = "chartReportChanged" )]
		function get reportTypes():ArrayCollection;

		//----------------------------------
		//  Chart Selected Report Type
		//----------------------------------

		[Bindable( event = "chartReportChanged" )]
		function get selectedReportType():IScoreGraphReportType;
		function set selectedReportType( value:IScoreGraphReportType ):void;

		//----------------------------------
		//  Chart Selected Report Type Index
		//----------------------------------

		[Bindable( event = "chartReportChanged" )]
		function get selectedReportTypeIndex():uint;
		function set selectedReportTypeIndex( index:uint ):void;

		//----------------------------------
		//  Chart Types
		//----------------------------------

		[Bindable( event = "chartTypeChanged" )]
		function get chartTypes():ArrayCollection;

		//----------------------------------
		//  Side Graph
		//----------------------------------

		function get hasSideGraph():Boolean;
		function get sideGraphConfig():ISideGraphConfig;

		//----------------------------------
		//  Selected Chart Type
		//----------------------------------

		[Bindable( event = "chartTypeChanged" )]
		function get selectedChartType():ScoreGraphChartType;
		function set selectedChartType( value:ScoreGraphChartType ):void;

		//----------------------------------
		//  Selected Chart Type Index
		//----------------------------------

		[Bindable( event = "chartTypeChanged" )]
		function get selectedChartTypeIndex():uint;
		function set selectedChartTypeIndex( index:uint ):void;

		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------

		function canDrill( index:uint ):Boolean;

		function drillDown( index:uint ):void;

		function chartItemClick( event:ChartItemEvent ):void;

		function getOptionPrompt():TitleWindow;

		function getOption( optionName:String ):String;

		function setOption( optionName:String, optionValue:String ):void;
	}
}


