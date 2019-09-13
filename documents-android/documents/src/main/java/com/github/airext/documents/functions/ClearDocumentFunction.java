package com.github.airext.documents.functions;

import android.app.Activity;
import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.github.airext.Documents;

import java.io.File;

public class ClearDocumentFunction implements FREFunction {

    @Override
    public FREObject call(FREContext context, FREObject[] args) {
        Log.e(Documents.TAG, "ClearDocumentFunction");

        if (args.length < 1) {
            return null;
        }

        String filename = null;
        try {
            filename = args[0].getAsString();
        } catch (Exception e) {
            Log.e(Documents.TAG, "ClearDocumentFunction:", e);
        }

        if (filename == null) {
            Log.e(Documents.TAG, "Could not read filename.");
            return null;
        }

        Activity activity = context.getActivity();

        File file = new File(activity.getCacheDir(), filename);

        if (!file.exists()) {
            Log.d(Documents.TAG, "Target file doesn't exist.");
            return null;
        }

        Log.d(Documents.TAG, "Deleting file " + file);

        file.delete();

        return null;
    }
}
