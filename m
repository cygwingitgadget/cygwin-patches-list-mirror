From: Pavel Tsekov <ptsekov@syntrex.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] setup.exe: io_stream-ized SimpleSocket class
Date: Fri, 23 Nov 2001 09:24:00 -0000
Message-ID: <3BFE8631.AFC9AEF6@syntrex.com>
X-SW-Source: 2001-q4/msg00243.html
Message-ID: <20011123092400._UQDVK6g7EKDvqSnEcVs2n3fwfrCEsJNjCL7mt7aMxQ@z>

Hello, there!

This is a simple patch which is a step towards
merging the NetIO hierarchy with the new 
io_stream hierarchy. The supplied patch implemnts
all the abstract methods of io_stream except
tell() and seek(), and also implements its own
gets() method.

There is no Changelog since I post this patch
for comments/critics/flames/etc. I just want to
know if this change is needed and if this is the
right way to do it.

The next step I'll take if this is approved is to
inherit SimpleSocket in both NetIO_FTP and NetIO_HTTP
and include the " http://" ; and " ftp://" ; urls in
the list of known urls of io_stream::open(). 

Thanks.
diff -up ../cinstall/simpsock.cc ../cinstall_devel/simpsock.cc
--- ../cinstall/simpsock.cc	Wed Nov 21 12:15:12 2001
+++ ../cinstall_devel/simpsock.cc	Fri Nov 23 18:02:01 2001
@@ -25,7 +25,9 @@ static const char *cvsid =
 #include <stdio.h>
 #include <stdarg.h>
 #include <stdlib.h>
+#include <errno.h>
 
+#include "io_stream.h"
 #include "simpsock.h"
 #include "msg.h"
 
@@ -44,6 +46,7 @@ SimpleSocket::SimpleSocket (const char *
   s = INVALID_SOCKET;
   buf = 0;
   putp = getp = 0;
+  lasterr = NO_ERROR;
 
   int i1, i2, i3, i4;
   unsigned char ip[4];
@@ -61,6 +64,7 @@ SimpleSocket::SimpleSocket (const char *
       he = gethostbyname (hostname);
       if (!he)
 	{
+          lasterr = WSAGetLastError ();
 	  msg ("Can't resolve `%s'\n", hostname);
 	  return;
 	}
@@ -70,7 +74,8 @@ SimpleSocket::SimpleSocket (const char *
   s = socket (AF_INET, SOCK_STREAM, 0);
   if (s == INVALID_SOCKET)
     {
-      msg ("Can't create socket, %d", WSAGetLastError ());
+      lasterr = WSAGetLastError ();
+      msg ("Can't create socket, %d", lasterr);
       return;
     }
 
@@ -83,6 +88,7 @@ SimpleSocket::SimpleSocket (const char *
 
   if (connect (s, (sockaddr *) & name, sizeof (name)))
     {
+      lasterr = WSAGetLastError ();
       msg ("Can't connect to %s:%d", hostname, port);
       closesocket (s);
       s = INVALID_SOCKET;
@@ -115,14 +121,20 @@ SimpleSocket::printf (const char *fmt, .
   return write (buf, strlen (buf));
 }
 
-int
-SimpleSocket::write (const char *buf, int len)
+ssize_t
+SimpleSocket::write (const void *buffer, size_t len)
 {
-  int rv;
+  ssize_t rv;
   if (!ok ())
-    return -1;
+    {
+      lasterr = EBADF;
+      return -1;
+    }
   if ((rv = send (s, buf, len, 0)) == -1)
-    invalidate ();
+    {
+      lasterr = WSAGetLastError ();
+      invalidate ();
+    }
   return rv;
 }
 
@@ -130,7 +142,10 @@ int
 SimpleSocket::fill ()
 {
   if (!ok ())
-    return -1;
+    {
+      lasterr = EBADF;
+      return -1;
+    }
 
   if (buf == 0)
     buf = (char *) malloc (SSBUFSZ + 3);
@@ -147,14 +162,23 @@ SimpleSocket::fill ()
     }
   else if (r < 0 && putp == getp)
     {
+      lasterr = WSAGetLastError ();
       invalidate ();
     }
   return r;
 }
 
+#define MIN(a,b) ((a) < (b) ? (a) : (b))
+
 char *
-SimpleSocket::gets ()
+SimpleSocket::gets (char *buffer, size_t len)
 {
+  if (len < 2 || !buffer)
+    {
+      lasterr = EINVAL;
+      return 0;
+    }
+  // FIXME: This block seems to be no longer needed
   if (getp > 0 && putp > getp)
     {
       memmove (buf, buf + getp, putp - getp);
@@ -166,52 +190,66 @@ SimpleSocket::gets ()
       return 0;
 
   // getp is zero, always, here, and putp is the count
-  char *nl;
-  while ((nl = (char *) memchr (buf, '\n', putp)) == NULL && putp < SSBUFSZ)
-    if (fill () <= 0)
-      break;
-
-  if (nl)
-    {
-      getp = nl - buf + 1;
-      while ((*nl == '\n' || *nl == '\r') && nl >= buf)
-	*nl-- = 0;
-    }
-  else if (putp > getp)
-    {
-      getp = putp;
-      nl = buf + putp;
-      nl[1] = 0;
+  char *nl = NULL;
+  size_t minlen = MIN (len - 1, putp);
+  while (len > 1 && nl == NULL)
+    {
+      if ((nl = (char *) memchr (buf + getp, '\n', minlen)) != NULL)
+        minlen = (nl - buf) - getp;
+
+      read ((void *) buffer, minlen);
+      buffer += minlen;
+      len -= minlen;
+      
+      if (len > 1 && nl == NULL)
+        {
+          if (fill () <= 0)
+            break;
+          minlen = MIN (len - 1, putp - getp);
+        }
     }
-  else
+
+  if (error())
     return 0;
 
-  return buf;
-}
+  *buffer = '\0';
 
-#define MIN(a,b) ((a) < (b) ? (a) : (b))
+  return buffer;
+}
 
-int
-SimpleSocket::read (char *ubuf, int ulen)
+ssize_t
+SimpleSocket::read(char *ubuf, size_t ulen, int peek)
 {
   if (!ok ())
-    return -1;
+    {
+      lasterr = EBADF;
+      return -1;
+    }
+
+  int n, recvflags = 0;
+  ssize_t rv = 0;
+
+  if (peek)
+    recvflags |= MSG_PEEK;
 
-  int n, rv = 0;
   if (putp > getp)
     {
       n = MIN (ulen, putp - getp);
       memmove (ubuf, buf + getp, n);
-      getp += n;
       ubuf += n;
       ulen -= n;
       rv += n;
+      if (!peek)
+        getp += n;
     }
   while (ulen > 0)
     {
-      n = recv (s, ubuf, ulen, 0);
+      n = recv (s, ubuf, ulen, recvflags);
       if (n < 0)
-	invalidate ();
+        {
+          lasterr = WSAGetLastError ();
+	  invalidate ();
+        }
       if (n <= 0)
 	return rv > 0 ? rv : n;
       ubuf += n;
diff -up ../cinstall/simpsock.h ../cinstall_devel/simpsock.h
--- ../cinstall/simpsock.h	Wed Nov 21 12:15:12 2001
+++ ../cinstall_devel/simpsock.h	Fri Nov 23 18:07:24 2001
@@ -21,8 +21,10 @@ class SimpleSocket
   SOCKET s;
   char *buf;
   int putp, getp;
+  int lasterr;
   int fill ();
   void invalidate (void);
+  ssize_t read(char *buffer, size_t len, int peek);
 
 public:
     SimpleSocket (const char *hostname, int port);
@@ -31,8 +33,24 @@ public:
   int ok ();
 
   int printf (const char *fmt, ...);
-  int write (const char *buf, int len);
 
-  char *gets ();
-  int read (char *buf, int len);
+  virtual ssize_t read (void *buffer, size_t len)
+  {
+    return read((char *) buffer, len, 0);
+  }
+
+  virtual ssize_t write (const void *buffer, size_t len);
+
+  virtual ssize_t peek (void *buffer, size_t len)
+  {
+    return read((char *) buffer, len, 1);
+  }
+
+  virtual long tell () { lasterr = ENOSYS; return -1; }
+
+  virtual int seek (long, io_stream_seek_t) { lasterr = ENOSYS; return -1; }
+
+  virtual int error () { return lasterr; }
+
+  virtual char *gets (char *, size_t len);
 };
Common subdirectories: ../cinstall/temp and ../cinstall_devel/temp
Common subdirectories: ../cinstall/zlib and ../cinstall_devel/zlib
