package com.alphawallet.app.router;

import android.content.Context;
import android.content.Intent;

import com.alphawallet.app.ui.WalletsActivity;

import javax.inject.Inject;

public class ManageWalletsRouter {

    @Inject
    public ManageWalletsRouter() {
    }

    public void open(Context context, boolean isClearStack) {
        Intent intent = new Intent(context, WalletsActivity.class);
        if (isClearStack) {
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TASK);
        }
        context.startActivity(intent);
    }
}
