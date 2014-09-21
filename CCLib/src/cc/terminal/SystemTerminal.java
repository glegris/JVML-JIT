package cc.terminal;

public class SystemTerminal extends Terminal {
	static {
		System.load("cc/native/SystemTerminal.lua");
	}

	@Override public native void write(String text);

	@Override public native void clearLine();

	@Override public native int getCursorX();
	@Override public native int getCursorY();
	@Override public native void setCursor(int x, int y);

	@Override public native boolean isColor();

	@Override public native int width();
	@Override public native int height();

	@Override public native void scroll(int n);

	@Override public native void setTextColor(Color c);
	@Override public native void setBackgroundColor(Color c);
}