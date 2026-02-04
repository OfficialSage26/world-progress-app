package com.example.world_progress_app

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class WorldProgressWidgetProvider : HomeWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.world_progress_widget)

            val percentLine = widgetData.getString("percent_line", "0.00% of ${java.util.Calendar.getInstance().get(java.util.Calendar.YEAR)} has passed")
            val dateLine = widgetData.getString("date_line", "")
            val progressBp = widgetData.getInt("progress_bp", 0) // 0..10000

            views.setTextViewText(R.id.txtPercent, percentLine)
            views.setTextViewText(R.id.txtDate, dateLine)
            views.setProgressBar(R.id.progYear, 10000, progressBp, false)

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
