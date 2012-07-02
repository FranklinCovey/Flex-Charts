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
package com.franklincovey.loyalty.chart.impl
{

	import com.franklincovey.loyalty.chart.api.IScoreGraphChart;
	import com.franklincovey.loyalty.chart.api.IScoreGraphDataDeligate;
	import com.franklincovey.loyalty.chart.api.IScoreGraphManager;
	import com.franklincovey.loyalty.chart.api.IScoreGraphReportType;
	import com.franklincovey.loyalty.chart.api.ISideGraphConfig;
	import com.franklincovey.loyalty.chart.api.ScoreGraphChartType;
	import com.franklincovey.loyalty.chart.api.ScoreGraphEvent;

	import flash.events.Event;
	import flash.events.EventDispatcher;

	import mx.charts.chartClasses.IAxis;
	import mx.charts.events.ChartItemEvent;
	import mx.collections.ArrayCollection;
	import mx.containers.TitleWindow;

	[Event( name = "chartDataChanged", type = "com.franklincovey.loyalty.chart.api.ScoreGraphEvent" )]
	[Event( name = "chartHorizontalAxisChanged", type = "com.franklincovey.loyalty.chart.api.ScoreGraphEvent" )]
	[Event( name = "chartVerticalAxisChanged", type = "com.franklincovey.loyalty.chart.api.ScoreGraphEvent" )]
	[Event( name = "chartLevelsChanged", type = "com.franklincovey.loyalty.chart.api.ScoreGraphEvent" )]
	[Event( name = "chartReportChanged", type = "com.franklincovey.loyalty.chart.api.ScoreGraphEvent" )]
	[Event( name = "chartSeriesChanged", type = "com.franklincovey.loyalty.chart.api.ScoreGraphEvent" )]

	public class ScoreGraphManager extends EventDispatcher implements IScoreGraphManager
	{

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		public function ScoreGraphManager()
		{

		}

		//--------------------------------------------------------------------------
		//
		// Variables
		// 
		//--------------------------------------------------------------------------

		/**
		 * @private
		 * Current Level of the Graph. Controlled by drilling up/down.
		 */
		private var _currentLevel:int = -1;

		/**
		 * @private
		 * Delegate Vector. Stores all current layers from drilling.
		 */
		private var _delegates:Array = new Array();

		/**
		 * @private
		 * Delagate that we are transition from.
		 */
		private var _previousDelegate:IScoreGraphDataDeligate;


		//--------------------------------------------------------------------------
		//
		// Public Properties
		// 
		//--------------------------------------------------------------------------

		//----------------------------------
		//  currentChart
		//----------------------------------

		/**
		 * Current Chart.
		 */
		public function get currentChart():IScoreGraphChart
		{
			return currentDelegate.chart;
		}

		//----------------------------------
		//  currentDelegate
		//----------------------------------

		/**
		 * Current Delegate
		 */
		public function get currentDelegate():IScoreGraphDataDeligate
		{
			if ( _currentLevel >= 0 )
				return _delegates[ _currentLevel ];

			return null;
		}

		//----------------------------------
		//  title
		//----------------------------------

		/**
		 * Title
		 */
		public function get title():String
		{
			return "Score History";
		}

		//----------------------------------
		//  data
		//----------------------------------

		[Bindable( event = "chartDataChanged" )]

		/**
		 * Chart Data.
		 */
		public function get data():ArrayCollection
		{
			return currentDelegate.data;
		}

		//----------------------------------
		//  levels
		//----------------------------------

		[Bindable( event = "chartLevelsChanged" )]
		/**
		 * Available levels.
		 *
		 * Levels are added by drilling down. They are removed by drilling up.
		 */
		public function get levels():ArrayCollection
		{
			var levels:ArrayCollection = new ArrayCollection();

			for ( var i:uint = 0; i < _delegates.length; i++ )
			{
				levels.addItem( _delegates[ i ]);
			}

			return levels;
		}

		//----------------------------------
		//  Current Level
		//----------------------------------


		[Bindable( event = "chartLevelsChanged" )]
		public function get currentLevel():uint
		{
			return _currentLevel;
		}

		public function set currentLevel( value:uint ):void
		{
			_unHookEventsFromDelegate();

			var drillingUp:Boolean = _currentLevel > value;
			_previousDelegate = currentDelegate;
			_currentLevel = value;

			if ( _previousDelegate && currentChart != _previousDelegate.chart )
			{
				invalidateChart();
			}

			if ( drillingUp )
			{
				currentDelegate.drillUp();
				_delegates.splice( value + 1, _delegates.length - ( value + 1 ));
			}

			currentDelegate.activate();

			invalidateData();
			_hookEventsToDelegate();

			dispatchEvent( new ScoreGraphEvent( ScoreGraphEvent.LEVELS_CHANGED ));
		}

		private function _unHookEventsFromDelegate():void
		{
			if ( currentDelegate )
			{
				currentDelegate.removeEventListener( ScoreGraphEvent.REPORT_CHANGED, handleDelegateEvents );
				currentDelegate.removeEventListener( ScoreGraphEvent.CHART_DATA_CHANGED, handleDelegateEvents );
				currentChart.removeEventListener( ScoreGraphEvent.CHART_HORIZONTAL_AXIS_CHANGED, handleDelegateEvents );
				currentChart.removeEventListener( ScoreGraphEvent.CHART_VERTICAL_AXIS_CHANGED, handleDelegateEvents );
				currentChart.removeEventListener( ScoreGraphEvent.CHART_SERIES_CHANGED, handleDelegateEvents );
				currentChart.removeEventListener( ScoreGraphEvent.CHART_TYPE_CHANGED, handleDelegateEvents );
			}
		}

		private function _hookEventsToDelegate():void
		{
			currentDelegate.addEventListener( ScoreGraphEvent.REPORT_CHANGED, handleDelegateEvents );
			currentDelegate.addEventListener( ScoreGraphEvent.CHART_DATA_CHANGED, handleDelegateEvents );
			currentChart.addEventListener( ScoreGraphEvent.CHART_HORIZONTAL_AXIS_CHANGED, handleDelegateEvents );
			currentChart.addEventListener( ScoreGraphEvent.CHART_VERTICAL_AXIS_CHANGED, handleDelegateEvents );
			currentChart.addEventListener( ScoreGraphEvent.CHART_SERIES_CHANGED, handleDelegateEvents );
			currentChart.addEventListener( ScoreGraphEvent.CHART_TYPE_CHANGED, handleDelegateEvents );
		}

		private function handleDelegateEvents( event:ScoreGraphEvent ):void
		{
			dispatchEvent( event );
		}

		public function invalidateChart():void
		{
			dispatchEvent( new ScoreGraphEvent( ScoreGraphEvent.CHART_SERIES_CHANGED ));
			dispatchEvent( new ScoreGraphEvent( ScoreGraphEvent.CHART_HORIZONTAL_AXIS_CHANGED ));
			dispatchEvent( new ScoreGraphEvent( ScoreGraphEvent.CHART_VERTICAL_AXIS_CHANGED ));

			if ( _previousDelegate && _previousDelegate.chart.selectedChartType.type != currentChart.selectedChartType.type )
			{
				dispatchEvent( new ScoreGraphEvent( ScoreGraphEvent.CHART_TYPE_CHANGED ));
			}
		}

		public function invalidateData():void
		{
			dispatchEvent( new ScoreGraphEvent( ScoreGraphEvent.CHART_DATA_CHANGED ));
			dispatchEvent( new ScoreGraphEvent( ScoreGraphEvent.REPORT_CHANGED ));
		}

		//----------------------------------
		//  Chart Series
		//----------------------------------

		[Bindable( event = "chartSeriesChanged" )]
		public function get chartSeries():Array
		{
			return currentChart.series;
		}

		//----------------------------------
		//  Chart Horizontal Axis
		//----------------------------------

		[Bindable( event = "chartHorizontalAxisChanged" )]
		public function get chartHorizontalAxis():IAxis
		{
			return currentChart.horizontalAxis;
		}

		//----------------------------------
		//  Chart Vertical Axis
		//----------------------------------

		[Bindable( event = "chartVerticalAxisChanged" )]
		public function get chartVerticalAxis():IAxis
		{
			return currentChart.verticalAxis;
		}

		//----------------------------------
		//  Report Types
		//----------------------------------

		[Bindable( event = "chartReportChanged" )]
		public function get reportTypes():ArrayCollection
		{
			return currentDelegate.reportTypes;
		}

		//----------------------------------
		//  Selected Report Type
		//----------------------------------

		[Bindable( event = "chartReportChanged" )]
		public function get selectedReportType():IScoreGraphReportType
		{
			return currentDelegate.selectedReportType;
		}

		public function set selectedReportType( value:IScoreGraphReportType ):void
		{
			currentDelegate.selectedReportType = value;
			currentDelegate.activate();
		}

		//----------------------------------
		//  Selected Report Type Index
		//----------------------------------

		[Bindable( event = "chartReportChanged" )]
		public function get selectedReportTypeIndex():uint
		{
			return reportTypes.getItemIndex( selectedReportType );
		}

		public function set selectedReportTypeIndex( index:uint ):void
		{
			selectedReportType = reportTypes.getItemAt( index ) as IScoreGraphReportType;
		}

		//----------------------------------
		//  Chart Types
		//----------------------------------

		[Bindable( event = "chartTypeChanged" )]
		public function get chartTypes():ArrayCollection
		{
			return currentChart.chartTypes;
		}

		public function get hasSideGraph():Boolean
		{
			return false;
		}

		public function get sideGraphConfig():ISideGraphConfig
		{
			return null;
		}

		//----------------------------------
		//  Selected Chart Type
		//----------------------------------

		[Bindable( event = "chartTypeChanged" )]
		public function get selectedChartType():ScoreGraphChartType
		{
			return currentChart.selectedChartType;
		}

		public function set selectedChartType( value:ScoreGraphChartType ):void
		{
			currentChart.selectedChartType = value;
		}

		//----------------------------------
		//  Selected Chart Index
		//----------------------------------

		[Bindable( event = "chartTypeChanged" )]
		public function get selectedChartTypeIndex():uint
		{
			return currentChart.chartTypes.getItemIndex( selectedChartType );
		}

		public function set selectedChartTypeIndex( index:uint ):void
		{
			currentChart.selectedChartType = chartTypes.getItemAt( index ) as ScoreGraphChartType;
		}

		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------

		public function canDrill( index:uint ):Boolean
		{
			return currentDelegate.canDrill( index );
		}

		public function drillDown( index:uint ):void
		{
			_unHookEventsFromDelegate();
			var newDelegate:IScoreGraphDataDeligate = currentDelegate.drillDown( index );
			_initializeDelegate( newDelegate );
		}

		public function getOptionPrompt():TitleWindow
		{
			return null;
		}

		public function getOption( optionName:String ):String
		{
			return null;
		}

		public function setOption( optionName:String, optionValue:String ):void
		{
		}

		//--------------------------------------------------------------------------
		//
		//  Functions
		//
		//--------------------------------------------------------------------------

		protected function _initializeDelegate( delegate:IScoreGraphDataDeligate ):void
		{

			var chart:IScoreGraphChart;

			//Find Existing Chart. If Exists.
			for ( var i:uint = 0; i < _delegates.length; i++ )
			{
				if ( _delegates[ i ].chart is delegate.chartClass )
				{
					//Found one. Share it.
					chart = _delegates[ i ].chart;
					break;
				}
			}

			//No Chart exists. So we build a new one.
			if ( !chart )
			{
				chart = new delegate.chartClass;
			}

			delegate.chart = chart;
			_delegates.push( delegate );

			//Switch to the new level.
			currentLevel = _delegates.length - 1;
		}

		//--------------------------------------------------------------------------
		//
		//  Event Handlers
		//
		//--------------------------------------------------------------------------

		public function chartItemClick( event:ChartItemEvent ):void
		{
			if ( canDrill( event.hitData.chartItem.index ))
			{
				drillDown( event.hitData.chartItem.index );
			}
		}
	}
}


