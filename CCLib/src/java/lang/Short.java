/* Copyright (c) 2008-2014, Avian Contributors

   Permission to use, copy, modify, and/or distribute this software
   for any purpose with or without fee is hereby granted, provided
   that the above copyright notice and this permission notice appear
   in all copies.

   There is NO WARRANTY for this software.  See license.txt for
   details. */
package java.lang;

public class Short extends Number {

	public static final short MAX_VALUE = 32767;
	public static final short MIN_VALUE = -32768;
	public static final int SIZE = 16;

	private final short value;
	public static final Class<Short> TYPE = (Class<Short>) Class.getPrimitiveClass("short");

	public static Short valueOf(short value) {
		return new Short(value);
	}

	public Short(short value) {
		this.value = value;
	}

	public String toString() {
		return toString(value);
	}

	public short shortValue() {
		return value;
	}

	@Override
	public boolean equals(Object obj) {
		if (obj instanceof Short) {
			return value == ((Short) obj).shortValue();
		}
		return false;
	}

	public int compareTo(Short o) {
		return value - o.value;
	}

	public int hashCode() {
		return value;
	}

	public static String toString(short v, int radix) {
		return Long.toString(v, radix);
	}

	public static String toString(short v) {
		return toString(v, 10);
	}

	public byte byteValue() {
		return (byte) value;
	}

	public int intValue() {
		return value;
	}

	public long longValue() {
		return value;
	}

	public float floatValue() {
		return (float) value;
	}

	public double doubleValue() {
		return (double) value;
	}
}