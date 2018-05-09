public class HelloWorld {
    // This declares that the static `hello` method will be provided
    // a native library.
    public static native String hello(String input);

    static {
        // This actually loads the shared object that we'll be creating.
        // The actual location of the .so or .dll may differ based on your
        // platform.
        // this looks for "libexample.dylib" on macOS
        System.loadLibrary("example");
    }
}
