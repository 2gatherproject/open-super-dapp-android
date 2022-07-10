# Contributing code to Open Super dApp

Support can be found at this [developer support room](https://matrix.to/#/#open-super-dapp-dev:2gather.community).

# Specific rules for Matrix Android projects

## Android Studio settings

Please set the "hard wrap" setting of Android Studio to 160 chars, this is the setting we use internally to format the source code (Menu `Settings/Editor/Code Style` then `Hard wrap at`).
Please ensure that you're using the project formatting rules (which are in the project at .idea/codeStyles/), and format the file before committing them.


## I want to submit a PR

Please check if a corresponding issue exists. If yes, please let us know in a comment that you're working on it.
If a relevant issue does not exist yet, please first raise your idea in the [developer support room](https://matrix.to/#/#open-super-dapp-dev:2gather.community) for feedback. If there are no objections there, then open a new issue and let us know that you're implementing it.

### Upstream contributions

Developing on your proposed contribution, it may be best made to the upstream [element-android](https://github.com/vector-im/element-android) or [alpha-wallet-android](https://github.com/AlphaWallet/alpha-wallet-android) projects if your contribition is confined to either one of those component apps.

### Kotlin and Java

element-android is written in Kotlin and alphawallet-android is written in Java. Please try to to match the language depending on where you modifications are in the project.

If you are writing entirely new code/functionality please prefer Kotlin.

### Changelog

Please create at least one file under ./changelog.d containing details about your change. 

### Code quality

Make sure the following commands execute without any error:

#### Internal tool

<pre>
./tools/check/check_code_quality.sh
</pre>

#### ktlint

<pre>
./gradlew ktlintCheck --continue
</pre>

Note that you can run

<pre>
./gradlew ktlintFormat
</pre>

For ktlint to fix some detected errors for you (you still have to check and commit the fix of course)

#### lint

<pre>
./gradlew lintGplayRelease
./gradlew lintFdroidRelease
</pre>

### Unit tests

Make sure the following commands execute without any error:

<pre>
./gradlew testGplayReleaseUnitTest
</pre>

### Tests

Element is currently supported on Android Lollipop (API 21+): please test your change on an Android device (or Android emulator) running with API 21. Many issues can happen (including crashes) on older devices.
Also, if possible, please test your change on a real device. Testing on Android emulator may not be sufficient.

You should consider adding Unit tests with your PR, and also integration tests (AndroidTest). Please refer to [this document](./docs/integration_tests.md) to install and run the integration test environment.


### Accessibility

Please consider accessibility as an important point. As a minimum requirement, in layout XML files please use attributes such as `android:contentDescription` and `android:importantForAccessibility`, and test with a screen reader if it's working well. You can add new string resources, dedicated to accessibility, in this case, please prefix theirs id with `a11y_`.

For instance, when updating the image `src` of an ImageView, please also consider updating its `contentDescription`. A good example is a play pause button.

### Layout

When adding or editing layouts, make sure the layout will render correctly if device uses a RTL (Right To Left) language.
You can check this in the layout editor preview by selecting any RTL language (ex: Arabic).

Also please check that the colors are ok for all the current themes of Element. Please use `?attr` instead of `@color` to reference colors in the layout. You can check this in the layout editor preview by selecting all the main themes (`AppTheme.Status`, `AppTheme.Dark`, etc.).

## Thanks

Thanks for contributing to Open Super dApp!
