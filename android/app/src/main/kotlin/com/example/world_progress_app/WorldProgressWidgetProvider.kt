package com.example.world_progress_app 

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.os.Bundle
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin
import es.antonborri.home_widget.HomeWidgetProvider

class WorldProgressWidgetProvider : HomeWidgetProvider() {

    private fun pickLayout(minW: Int, minH: Int): Int {
        return when {
            minH >= 140 || minW >= 300 -> R.layout.world_progress_widget_large
            minH >= 110 || minW >= 240 -> R.layout.world_progress_widget_medium
            else -> R.layout.world_progress_widget_small
        }
    }

    private fun render(
        context: Context,
        appWidgetManager: AppWidgetManager,
        widgetId: Int,
        widgetData: SharedPreferences,
        options: Bundle
    ) {
        val minW = options.getInt(AppWidgetManager.OPTION_APPWIDGET_MIN_WIDTH)
        val minH = options.getInt(AppWidgetManager.OPTION_APPWIDGET_MIN_HEIGHT)
        val layoutId = pickLayout(minW, minH)

        val views = RemoteViews(context.packageName, R.layout.world_progress_widget_medium)

        val raw = widgetData.getString("percent_line", "0.00% of 2026 has passed") ?: ""
        val percentLine = widgetData.getString("percent_line", "0.00% of 2026 has passed") ?: ""
        val dateLine = widgetData.getString("date_line", "") ?: ""
        val progressBp = widgetData.getInt("progress_bp", 0)

        views.setTextViewText(R.id.txtPercent, percentLine)
        views.setTextViewText(R.id.txtDate, dateLine)
        views.setProgressBar(R.id.progYear, 10000, progressBp, false)

        appWidgetManager.updateAppWidget(widgetId, views)
    }

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val options = appWidgetManager.getAppWidgetOptions(widgetId)
            render(context, appWidgetManager, widgetId, widgetData, options)
        }
    }

    override fun onAppWidgetOptionsChanged(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetId: Int,
        newOptions: Bundle
    ) {
        val widgetData = HomeWidgetPlugin.getData(context)
        render(context, appWidgetManager, appWidgetId, widgetData, newOptions)
    }
}
