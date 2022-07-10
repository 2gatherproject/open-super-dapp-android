package com.alphawallet.app.service;

import android.content.Context;

import com.alphawallet.app.entity.ServiceErrorException;
import com.google.firebase.crashlytics.FirebaseCrashlytics;

public class AnalyticsService<T> implements AnalyticsServiceType<T> {

    public AnalyticsService(Context context)
    {
        //No code
    }

    @Override
    public void track(String eventName)
    {
        //No code
    }

    @Override
    public void track(String eventName, T event)
    {
        //No code
    }

    @Override
    public void identify(String uuid)
    {
        //No code
    }

    @Override
    public void recordException(ServiceErrorException e) {
        FirebaseCrashlytics.getInstance().recordException(e);
    }

    @Override
    public void flush()
    {
        //No code
    }
}