package com.github.airext.documents.functions;

import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;
import com.github.airext.Documents;

public class IsSupportedFunction implements FREFunction {

    @Override
    public FREObject call(FREContext context, FREObject[] args) {
        Log.d(Documents.TAG, "IsSupportedFunction");

        try {
            return FREObject.newObject(true);
        } catch (FREWrongThreadException e) {
            e.printStackTrace();
        }

        return null;
    }
}
