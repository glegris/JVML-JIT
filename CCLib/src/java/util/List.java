/* Copyright (c) 2008-2014, Avian Contributors

   Permission to use, copy, modify, and/or distribute this software
   for any purpose with or without fee is hereby granted, provided
   that the above copyright notice and this permission notice appear
   in all copies.

   There is NO WARRANTY for this software.  See license.txt for
   details. */

<<<<<<< HEAD
package java.util;
=======
		@Override
		public T next() {
			return list.get(++i);
		}

		@Override
		public void remove() {
			list.remove(i--);
		}
    }

    public class LIterator<U> extends UtilityIterator<U> implements ListIterator<U> {
    	public LIterator(List<U> l) {
    		super(l);
    	}

    	public LIterator(List<U> l, int index) {
    		super(l);
    		i = index - 1;
    	}
>>>>>>> upstream/master

public interface List<T> extends Collection<T> {
  public T get(int index);

  public T set(int index, T value);

  public T remove(int index);

  public boolean add(T element);

  public void add(int index, T element);

  public boolean addAll(int startIndex, Collection<? extends T> c);

  public int indexOf(Object value);

  public int lastIndexOf(Object value);

  public boolean isEmpty();

  public ListIterator<T> listIterator(int index);

  public ListIterator<T> listIterator();
}
