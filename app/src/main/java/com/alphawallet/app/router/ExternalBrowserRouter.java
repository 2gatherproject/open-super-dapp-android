package com.alphawallet.app.router;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;

import javax.inject.Inject;

public class ExternalBrowserRouter {

    @Inject
    public ExternalBrowserRouter(){}

    public void open(Context context, Uri uri) {
        Intent launchBrowser = new Intent(Intent.ACTION_VIEW, uri);
        context.startActivity(launchBrowser);
    }
}
