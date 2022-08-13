/*
 * Copyright (C) 2018 The LineageOS Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.lineageos.settings;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.util.Log;

import org.lineageos.settings.dirac.DiracUtils;
import org.lineageos.settings.doze.DozeUtils;
import org.lineageos.settings.thermal.ThermalUtils;

import vendor.xiaomi.hardware.touchfeature.V1_0.ITouchFeature;

public class BootCompletedReceiver extends BroadcastReceiver {

    public static final String SHAREDD2TW = "sharadeD2TW";
    private ITouchFeature mTouchFeature;

    @Override
    public void onReceive(final Context context, Intent intent) {
        DiracUtils.initialize(context);
    //Micro-Service to restore sata of dt2w on reboot
    SharedPreferences prefs = context.getSharedPreferences(SHAREDD2TW, Context.MODE_PRIVATE);
    try {
        mTouchFeature = ITouchFeature.getService();
        mTouchFeature.setTouchMode(14,prefs.getInt(SHAREDD2TW, 1));
    } catch (Exception e) {
        // Do nothing
    }

        // Doze
        DozeUtils.checkDozeService(context);
        // Force apply our default value for doze if it is not set.
        DozeUtils.enableDoze(context, DozeUtils.isDozeEnabled(context));
        ThermalUtils.startService(context);
    }

}