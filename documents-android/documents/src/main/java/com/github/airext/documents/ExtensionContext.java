package com.github.airext.documents;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.github.airext.documents.functions.ClearDocumentFunction;
import com.github.airext.documents.functions.IsSupportedFunction;
import com.github.airext.documents.functions.PreviewDocumentFunction;

import java.util.HashMap;
import java.util.Map;

public class ExtensionContext extends FREContext {

    @Override
    public Map<String, FREFunction> getFunctions() {
        HashMap<String, FREFunction> functions = new HashMap<>();
        functions.put("isSupported", new IsSupportedFunction());
        functions.put("preview", new PreviewDocumentFunction());
        functions.put("clear", new ClearDocumentFunction());

        return functions;
    }

    @Override
    public void dispose() {

    }
}
