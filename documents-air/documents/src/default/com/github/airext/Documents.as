/**
 * Created by max.rozdobudko@gmail.com on 6/2/18.
 */
package com.github.airext {
import com.github.airext.core.documents;

import flash.system.Capabilities;

use namespace documents;

public class Documents {
    
    //--------------------------------------------------------------------------
    //
    //  Class methods
    //
    //--------------------------------------------------------------------------

    //-------------------------------------
    //  isSupported
    //-------------------------------------

    public static function get isSupported(): Boolean {
        return false;
    }

    //-------------------------------------
    //  sharedInstance
    //-------------------------------------

    private static var instance: Documents;

    public static function get shared(): Documents {
        if (instance == null) {
            new Documents();
        }
        return instance;
    }

    //-------------------------------------
    //  extensionVersion
    //-------------------------------------

    public static function get extensionVersion(): String {
        trace("Documents extension is not supported for " + Capabilities.os);
        return null;
    }

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function Documents() {
        super();
        instance = this;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    public function previewDocumentWithPath(path: String): void {
        trace("Documents extension is not supported for " + Capabilities.os);
    }

    public function clearDocumentWithPath(path: String): void {
        trace("Documents extension is not supported for " + Capabilities.os);
    }

}
}