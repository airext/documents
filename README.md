documents ![License MIT](http://img.shields.io/badge/license-MIT-lightgray.svg)
==========

![iOS](http://img.shields.io/badge/platform-ios-blue.svg) ![Android](http://img.shields.io/badge/platform-android-green.svg)

[AIR Native Extension](http://www.adobe.com/devnet/air/native-extensions-for-air.html) for working with documents.

## Dependencies
This ANE requires `android.support.v4` on Android, one of your another extensions should have it (for example you could  use `com.distriqt.androidsupport.V4` from Distriqt).

### Open documents

```as3
if (Documents.isSupported) {
    Documents.shared.previewDocumentWithPath("data/test.pdf");
}
```

Opens specified document for preview using `Intent.ACTION_VIEW` on Android and `UIDocumentInteractionController` on iOS.
