package com.github.airext.documents.functions;

import android.app.Activity;
import android.content.Intent;
import android.content.res.AssetManager;
import android.support.v4.content.FileProvider;
import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.github.airext.Documents;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

public class PreviewDocumentFunction implements FREFunction {

    static private void copy(InputStream in, File dst) throws IOException {
        FileOutputStream out=new FileOutputStream(dst);
        byte[] buf=new byte[1024];
        int len;

        while ((len=in.read(buf)) > 0) {
            out.write(buf, 0, len);
        }

        in.close();
        out.close();
    }

    @Override
    public FREObject call(FREContext context, FREObject[] args) {
        Log.e(Documents.TAG, "PreviewDocumentFunction");

        if (args.length == 0) {
            return null;
        }

        String filename = null;
        try {
            filename = args[0].getAsString();
        } catch (Exception e) {
            Log.e(Documents.TAG, "PreviewDocumentFunction:", e);
        }

        if (filename == null) {
            Log.e(Documents.TAG, "Could not read filename.");
            return null;
        }

        Activity activity = context.getActivity();

        File file = new File(activity.getCacheDir(), filename);

        if (!file.getParentFile().exists()) {
            Log.d(Documents.TAG, "Creating parent directory for target file.");
            file.getParentFile().mkdirs();
        }

        if (!file.exists()) {
            Log.d(Documents.TAG, "Target file doesn't exist, creating it...");

            AssetManager assets = activity.getAssets();

            try {
                copy(assets.open(filename), file);
            } catch (IOException e) {
                Log.e(Documents.TAG, "Exception copying from assets", e);
                return null;
            }
        } else {
            Log.d(Documents.TAG, "Target file already exists and will be reused.");
        }

        String authority = activity.getPackageName() + ".airext.fileprovider.authority";

        Log.d(Documents.TAG, "authority:" + authority);

        try {
            Intent intent = new Intent(Intent.ACTION_VIEW, FileProvider.getUriForFile(activity, authority, file));
            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
            activity.startActivity(intent);
        } catch (Exception e) {
            Log.e(Documents.TAG, "PreviewDocumentFunction:", e);
        }

        return null;
    }
}
