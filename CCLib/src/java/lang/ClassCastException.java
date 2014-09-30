<<<<<<< HEAD
/* Copyright (c) 2008, Avian Contributors

   Permission to use, copy, modify, and/or distribute this software
   for any purpose with or without fee is hereby granted, provided
   that the above copyright notice and this permission notice appear
   in all copies.

   There is NO WARRANTY for this software.  See license.txt for
   details. */

package java.lang;

public class ClassCastException extends RuntimeException {
  public ClassCastException(String message) {
    super(message);
  }

  public ClassCastException() {
    super();
  }
=======
package java.lang;

public class ClassCastException extends RuntimeException {
    private static final long serialVersionUID = -9223365651070458532L;

    public ClassCastException() {
        super();
    }

    public ClassCastException(String s) {
        super(s);
    }
>>>>>>> upstream/master
}
