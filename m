From: DJ Delorie <dj@delorie.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: fgets/crlf patch
Date: Thu, 18 May 2000 10:13:00 -0000
Message-id: <200005181712.NAA24757@envy.delorie.com>
X-SW-Source: 2000-q2/msg00061.html

I think this fixes the CR/LF problems we've been seeing in 1.1.1.
Comments?

2000-05-18  DJ Delorie  <dj@cygnus.com>

	* libc/stdio/fgets.c (fgets): perform CRLF conversions if __SCLE
	
Index: libc/stdio/fgets.c
===================================================================
RCS file: /cvs/src/src/newlib/libc/stdio/fgets.c,v
retrieving revision 1.1.1.1
diff -p -3 -r1.1.1.1 fgets.c
*** fgets.c	2000/02/17 19:39:47	1.1.1.1
--- fgets.c	2000/05/18 17:09:28
*************** _DEFUN (fgets, (buf, n, fp),
*** 79,84 ****
--- 79,103 ----
      return 0;
  
    s = buf;
+ 
+ #ifdef __SCLE
+   if (fp->_flags & __SCLE)
+     {
+       int c;
+       /* Sorry, have to do it the slow way */
+       while (--n > 0 && (c = __sgetc(fp)) != EOF)
+ 	{
+ 	  *s++ = c;
+ 	  if (c == '\n')
+ 	    break;
+ 	}
+       if (c == EOF && s == buf)
+ 	return NULL;
+       *s = 0;
+       return buf;
+     }
+ #endif
+ 
    n--;				/* leave space for NUL */
    do
      {
