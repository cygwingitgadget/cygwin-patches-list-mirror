Return-Path: <cygwin-patches-return-2883-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 15984 invoked by alias); 29 Aug 2002 18:56:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15970 invoked from network); 29 Aug 2002 18:56:33 -0000
Message-ID: <000101c24f8e$1a656c40$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
Subject: Base readv/writev patch
Date: Thu, 29 Aug 2002 11:56:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0032_01C24EF8.45BC4EE0"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00331.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0032_01C24EF8.45BC4EE0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 520

Attached is the base part of the readv/writev patch I sent in
yesterday, i.e. just the generic syscall.cc and fhandler_base
parts, w/o any of the socket changes.  Otherwise unchanged from
before except for the expunging of those darn new-fangled C++ cast
woojits :-)

Enjoy,

// Conrad

p.s. If consistency is the issue, would a patch be accepted that
changed all the casts in the cygwin code over to the new-style C++
casts :-)

pp.s Umm, on the other hand, perhaps I'd rather not do that; well,
not this year anyhow.


------=_NextPart_000_0032_01C24EF8.45BC4EE0
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 754

2002-08-27  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* fhandler.h (fhandler_base::readv): New method.
	(fhandler_base::writev): Ditto.
	* fhandler.cc (fhandler_base::readv): New method.
	(fhandler_base::writev): Ditto.
	* syscalls.cc (_read): Delegate to readv(2).
	 (_write): Ditto, mutatis mutandi.
	(readv): Rewrite, based on the old _read code, to use the new
	fhandler_base::readv method.  Improve access mode handling and
	ensure all calls reach the final strace statement.
	(writev): Ditto, mutatis mutandi.
	* include/sys/uio.h (struct iovec): Change field types to match SUSv3.
	* winsup.h (check_iovec_for_read): New function.
	(check_iovec_for_write): Ditto.
	* miscfuncs.cc (check_iovec_for_read): Ditto.
	(check_iovec_for_write): Ditto.

------=_NextPart_000_0032_01C24EF8.45BC4EE0
Content-Type: text/plain;
	name="iovec.patch.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="iovec.patch.txt"
Content-length: 15044

Index: fhandler.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
retrieving revision 1.133
diff -u -p -r1.133 fhandler.cc
--- fhandler.cc	14 Jul 2002 19:15:32 -0000	1.133
+++ fhandler.cc	28 Aug 2002 23:53:56 -0000
@@ -13,6 +13,7 @@ details. */
 #include <unistd.h>
 #include <stdlib.h>
 #include <sys/cygwin.h>
+#include <sys/uio.h>
 #include <signal.h>
 #include "cygerrno.h"
 #include "perprocess.h"
@@ -695,6 +696,109 @@ fhandler_base::write (const void *ptr, s
=20
   debug_printf ("%d =3D write (%p, %d)", res, ptr, len);
   return res;
+}
+
+ssize_t
+fhandler_base::readv (const struct iovec *const iov, const int iovcnt,
+		      ssize_t tot)
+{
+  assert (iov);
+  assert (iovcnt >=3D 1);
+
+  if (iovcnt =3D=3D 1)
+    return read (iov->iov_base, iov->iov_len);
+
+  if (tot =3D=3D -1)		// i.e. if not pre-calculated by the caller.
+    {
+      tot =3D 0;
+      const struct iovec *iovptr =3D iov + iovcnt;
+      do=20
+	{
+	  iovptr -=3D 1;
+	  tot +=3D iovptr->iov_len;
+	}
+      while (iovptr !=3D iov);
+    }
+
+  assert (tot >=3D 0);
+
+  if (tot =3D=3D 0)
+    return 0;
+
+  char *buf =3D (char *) alloca (tot);
+
+  if (!buf)
+    {
+      set_errno (ENOMEM);
+      return -1;
+    }
+
+  const ssize_t res =3D read (buf, tot);
+
+  const struct iovec *iovptr =3D iov;
+  int nbytes =3D res;
+
+  while (nbytes > 0)
+    {
+      const int frag =3D min (nbytes, (ssize_t) iovptr->iov_len);
+      memcpy (iovptr->iov_base, buf, frag);
+      buf +=3D frag;
+      iovptr +=3D 1;
+      nbytes -=3D frag;
+    }
+
+  return res;
+}
+
+ssize_t
+fhandler_base::writev (const struct iovec *const iov, const int iovcnt,
+		       ssize_t tot)
+{
+  assert (iov);
+  assert (iovcnt >=3D 1);
+
+  if (iovcnt =3D=3D 1)
+    return write (iov->iov_base, iov->iov_len);
+
+  if (tot =3D=3D -1)		// i.e. if not pre-calculated by the caller.
+    {
+      tot =3D 0;
+      const struct iovec *iovptr =3D iov + iovcnt;
+      do=20
+	{
+	  iovptr -=3D 1;
+	  tot +=3D iovptr->iov_len;
+	}
+      while (iovptr !=3D iov);
+    }
+
+  assert (tot >=3D 0);
+
+  if (tot =3D=3D 0)
+    return 0;
+
+  char *const buf =3D (char *) alloca (tot);
+
+  if (!buf)
+    {
+      set_errno (ENOMEM);
+      return -1;
+    }
+
+  char *bufptr =3D buf;
+  const struct iovec *iovptr =3D iov;
+  int nbytes =3D tot;
+
+  while (nbytes !=3D 0)
+    {
+      const int frag =3D min (nbytes, (ssize_t) iovptr->iov_len);
+      memcpy (bufptr, iovptr->iov_base, frag);
+      bufptr +=3D frag;
+      iovptr +=3D 1;
+      nbytes -=3D frag;
+    }
+
+  return write (buf, tot);
 }
=20
 __off64_t
Index: fhandler.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fhandler.h,v
retrieving revision 1.136
diff -u -p -r1.136 fhandler.h
--- fhandler.h	26 Aug 2002 09:57:26 -0000	1.136
+++ fhandler.h	28 Aug 2002 23:53:56 -0000
@@ -116,6 +116,7 @@ class path_conv;
 class fhandler_disk_file;
 typedef struct __DIR DIR;
 struct dirent;
+struct iovec;
=20
 enum bg_check_types
 {
@@ -297,6 +298,8 @@ class fhandler_base
   virtual char const * ttyname () { return get_name(); }
   virtual int __stdcall read (void *ptr, size_t len) __attribute__ ((regpa=
rm (3)));
   virtual int write (const void *ptr, size_t len);
+  virtual ssize_t readv (const struct iovec *, int iovcnt, ssize_t tot =3D=
 -1);
+  virtual ssize_t writev (const struct iovec *, int iovcnt, ssize_t tot =
=3D -1);
   virtual __off64_t lseek (__off64_t offset, int whence);
   virtual int lock (int, struct flock *);
   virtual void dump ();
Index: miscfuncs.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/miscfuncs.cc,v
retrieving revision 1.13
diff -u -p -r1.13 miscfuncs.cc
--- miscfuncs.cc	8 Aug 2002 17:03:20 -0000	1.13
+++ miscfuncs.cc	28 Aug 2002 23:53:56 -0000
@@ -11,6 +11,9 @@ details. */
 #include "winsup.h"
 #include "cygerrno.h"
 #include <sys/errno.h>
+#include <sys/uio.h>
+#include <assert.h>
+#include <limits.h>
 #include <winbase.h>
 #include <winnls.h>
=20
@@ -177,6 +180,74 @@ __check_invalid_read_ptr_errno (const vo
   if (s && !IsBadReadPtr (s, sz))
     return 0;
   return set_errno (EFAULT);
+}
+
+ssize_t
+check_iovec_for_read (const struct iovec *iov, int iovcnt)
+{
+  if (!(iovcnt > 0 && iovcnt <=3D IOV_MAX))
+    {
+      set_errno (EINVAL);
+      return -1;
+    }
+
+  if (__check_invalid_read_ptr_errno (iov, iovcnt * sizeof (*iov)))
+    return -1;
+
+  size_t tot =3D 0;
+
+  while (iovcnt !=3D 0)
+    {
+      if (iov->iov_len > SSIZE_MAX || (tot +=3D iov->iov_len) > SSIZE_MAX)
+	{
+	  set_errno (EINVAL);
+	  return -1;
+	}
+
+      if (__check_null_invalid_struct_errno (iov->iov_base, iov->iov_len))
+	return -1;
+
+      iov +=3D 1;
+      iovcnt -=3D 1;
+    }
+
+  assert (tot <=3D SSIZE_MAX);
+
+  return (ssize_t) tot;
+}
+
+ssize_t
+check_iovec_for_write (const struct iovec *iov, int iovcnt)
+{
+  if (!(iovcnt > 0 && iovcnt <=3D IOV_MAX))
+    {
+      set_errno (EINVAL);
+      return -1;
+    }
+
+  if (__check_invalid_read_ptr_errno (iov, iovcnt * sizeof (*iov)))
+    return -1;
+
+  size_t tot =3D 0;
+
+  while (iovcnt !=3D 0)
+    {
+      if (iov->iov_len > SSIZE_MAX || (tot +=3D iov->iov_len) > SSIZE_MAX)
+	{
+	  set_errno (EINVAL);
+	  return -1;
+	}
+
+      if (__check_invalid_read_ptr_errno (iov->iov_base, iov->iov_len))
+	return -1;
+
+      iov +=3D 1;
+      iovcnt -=3D 1;
+    }
+
+  assert (tot <=3D SSIZE_MAX);
+
+  return (ssize_t) tot;
 }
=20
 UINT
Index: syscalls.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.224
diff -u -p -r1.224 syscalls.cc
--- syscalls.cc	18 Aug 2002 05:49:25 -0000	1.224
+++ syscalls.cc	28 Aug 2002 23:53:57 -0000
@@ -321,15 +321,42 @@ getsid (pid_t pid)
 extern "C" ssize_t
 _read (int fd, void *ptr, size_t len)
 {
-  if (len =3D=3D 0)
-    return 0;
+  const struct iovec iov =3D
+    {
+      iov_base: ptr,
+      iov_len: len
+    };
+
+  return readv (fd, &iov, 1);
+}
=20
-  if (__check_null_invalid_struct_errno (ptr, len))
-    return -1;
+extern "C" ssize_t
+_write (int fd, const void *ptr, size_t len)
+{
+  const struct iovec iov =3D
+    {
+      iov_base: (void *) ptr,	// const_cast
+      iov_len: len
+    };
+
+  return writev (fd, &iov, 1);
+}
=20
-  int res;
+extern "C" ssize_t
+readv (int fd, const struct iovec *const iov, const int iovcnt)
+{
   extern int sigcatchers;
-  int e =3D get_errno ();
+  const int e =3D get_errno ();
+
+  int res =3D -1;
+
+  const ssize_t tot =3D check_iovec_for_read (iov, iovcnt);
+
+  if (tot <=3D 0)
+    {
+      res =3D tot;
+      goto done;
+    }
=20
   while (1)
     {
@@ -337,197 +364,119 @@ _read (int fd, void *ptr, size_t len)
=20
       cygheap_fdget cfd (fd);
       if (cfd < 0)
-	return -1;
+	break;
+
+      if ((cfd->get_flags () & O_ACCMODE) =3D=3D O_WRONLY)
+	{
+	  set_errno (EBADF);
+	  break;
+	}
=20
       DWORD wait =3D cfd->is_nonblocking () ? 0 : INFINITE;
=20
       /* Could block, so let user know we at least got here.  */
-      syscall_printf ("read (%d, %p, %d) %sblocking, sigcatchers %d",
-		      fd, ptr, len, wait ? "" : "non", sigcatchers);
+      syscall_printf ("readv (%d, %p, %d) %sblocking, sigcatchers %d",
+		      fd, iov, iovcnt, wait ? "" : "non", sigcatchers);
=20
       if (wait && (!cfd->is_slow () || cfd->get_r_no_interrupt ()))
 	debug_printf ("no need to call ready_for_read\n");
       else if (!cfd->ready_for_read (fd, wait))
-	{
-	  res =3D -1;
-	  goto out;
-	}
+	goto out;
=20
       /* FIXME: This is not thread safe.  We need some method to
 	 ensure that an fd, closed in another thread, aborts I/O
 	 operations. */
       if (!cfd.isopen ())
-	return -1;
+	break;
=20
       /* Check to see if this is a background read from a "tty",
 	 sending a SIGTTIN, if appropriate */
       res =3D cfd->bg_check (SIGTTIN);
=20
       if (!cfd.isopen ())
-	return -1;
+	{
+	  res =3D -1;
+	  break;
+	}
=20
       if (res > bg_eof)
 	{
 	  myself->process_state |=3D PID_TTYIN;
 	  if (!cfd.isopen ())
-	    return -1;
-	  res =3D cfd->read (ptr, len);
+	    {
+	      res =3D -1;
+	      break;
+	    }
+	  res =3D cfd->readv (iov, iovcnt, tot);
 	  myself->process_state &=3D ~PID_TTYIN;
 	}
=20
     out:
-
-      if (res && get_errno () =3D=3D EACCES &&
-	  !(cfd->get_flags () & (O_RDONLY | O_RDWR)))
+      if (!(res =3D=3D -1
+	    && get_errno () =3D=3D EINTR
+	    && thisframe.call_signal_handler ()))
 	{
-	  set_errno (EBADF);
 	  break;
 	}
=20
-      if (res >=3D 0 || get_errno () !=3D EINTR || !thisframe.call_signal_=
handler ())
-	break;
       set_errno (e);
     }
=20
-  syscall_printf ("%d =3D read (%d, %p, %d), errno %d", res, fd, ptr, len,
-		  get_errno ());
+done:
+  syscall_printf ("%d =3D readv (%d, %p, %d), errno %d",
+		  res, fd, iov, iovcnt, get_errno ());
   MALLOC_CHECK;
   return res;
 }
=20
 extern "C" ssize_t
-_write (int fd, const void *ptr, size_t len)
+writev (const int fd, const struct iovec *const iov, const int iovcnt)
 {
   int res =3D -1;
+  const ssize_t tot =3D check_iovec_for_write (iov, iovcnt);
=20
   sigframe thisframe (mainthread);
   cygheap_fdget cfd (fd);
   if (cfd < 0)
     goto done;
=20
-  /* No further action required for len =3D=3D 0 */
-  if (len =3D=3D 0)
+  if (tot <=3D 0)
     {
-      res =3D 0;
+      res =3D tot;
       goto done;
     }
=20
-  if (len && __check_invalid_read_ptr_errno (ptr, len))
-    goto done;
+  if ((cfd->get_flags () & O_ACCMODE) =3D=3D O_RDONLY)
+    {
+      set_errno (EBADF);
+      goto done;
+    }
=20
   /* Could block, so let user know we at least got here.  */
   if (fd =3D=3D 1 || fd =3D=3D 2)
-    paranoid_printf ("write (%d, %p, %d)", fd, ptr, len);
+    paranoid_printf ("writev (%d, %p, %d)", fd, iov, iovcnt);
   else
-    syscall_printf  ("write (%d, %p, %d)", fd, ptr, len);
+    syscall_printf  ("writev (%d, %p, %d)", fd, iov, iovcnt);
=20
   res =3D cfd->bg_check (SIGTTOU);
=20
   if (res > bg_eof)
     {
       myself->process_state |=3D PID_TTYOU;
-      res =3D cfd->write (ptr, len);
+      res =3D cfd->writev (iov, iovcnt, tot);
       myself->process_state &=3D ~PID_TTYOU;
-      if (res && get_errno () =3D=3D EACCES &&
-	  !(cfd->get_flags () & (O_WRONLY | O_RDWR)))
-	set_errno (EBADF);
     }
=20
 done:
   if (fd =3D=3D 1 || fd =3D=3D 2)
-    paranoid_printf ("%d =3D write (%d, %p, %d)", res, fd, ptr, len);
+    paranoid_printf ("%d =3D write (%d, %p, %d), errno %d",
+		     res, fd, iov, iovcnt, get_errno ());
   else
-    syscall_printf ("%d =3D write (%d, %p, %d)", res, fd, ptr, len);
-
-  return (ssize_t) res;
-}
-
-/*
- * FIXME - should really move this interface into fhandler, and implement
- * write in terms of it. There are devices in Win32 that could do this with
- * overlapped I/O much more efficiently - we should eventually use
- * these.
- */
-
-extern "C" ssize_t
-writev (int fd, const struct iovec *iov, int iovcnt)
-{
-  int i;
-  ssize_t len, total;
-  char *base;
-
-  if (iovcnt < 1 || iovcnt > IOV_MAX)
-    {
-      set_errno (EINVAL);
-      return -1;
-    }
-
-  /* Ensure that the sum of the iov_len values is less than
-     SSIZE_MAX (per spec), if so, we must fail with no output (per spec).
-  */
-  total =3D 0;
-  for (i =3D 0; i < iovcnt; ++i)
-    {
-    total +=3D iov[i].iov_len;
-    if (total > SSIZE_MAX)
-      {
-      set_errno (EINVAL);
-      return -1;
-      }
-    }
-  /* Now write the data */
-  for (i =3D 0, total =3D 0; i < iovcnt; i++, iov++)
-    {
-      len =3D iov->iov_len;
-      base =3D iov->iov_base;
-      while (len > 0)
-	{
-	  register int nbytes;
-	  nbytes =3D write (fd, base, len);
-	  if (nbytes < 0 && total =3D=3D 0)
-	    return -1;
-	  if (nbytes <=3D 0)
-	    return total;
-	  len -=3D nbytes;
-	  total +=3D nbytes;
-	  base +=3D nbytes;
-	}
-    }
-  return total;
-}
+    syscall_printf ("%d =3D write (%d, %p, %d), errno %d",
+		    res, fd, iov, iovcnt, get_errno ());
=20
-/*
- * FIXME - should really move this interface into fhandler, and implement
- * read in terms of it. There are devices in Win32 that could do this with
- * overlapped I/O much more efficiently - we should eventually use
- * these.
- */
-
-extern "C" ssize_t
-readv (int fd, const struct iovec *iov, int iovcnt)
-{
-  int i;
-  ssize_t len, total;
-  char *base;
-
-  for (i =3D 0, total =3D 0; i < iovcnt; i++, iov++)
-    {
-      len =3D iov->iov_len;
-      base =3D iov->iov_base;
-      while (len > 0)
-	{
-	  register int nbytes;
-	  nbytes =3D read (fd, base, len);
-	  if (nbytes < 0 && total =3D=3D 0)
-	    return -1;
-	  if (nbytes <=3D 0)
-	    return total;
-	  len -=3D nbytes;
-	  total +=3D nbytes;
-	  base +=3D nbytes;
-	}
-    }
-  return total;
+  MALLOC_CHECK;
+  return res;
 }
=20
 /* _open */
Index: winsup.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/winsup.h,v
retrieving revision 1.99
diff -u -p -r1.99 winsup.h
--- winsup.h	16 Aug 2002 19:49:54 -0000	1.99
+++ winsup.h	28 Aug 2002 23:53:57 -0000
@@ -221,6 +221,10 @@ int __stdcall __check_invalid_read_ptr_e
 #define check_null_invalid_struct_errno(s) \
   __check_null_invalid_struct_errno ((s), sizeof (*(s)))
=20
+struct iovec;
+ssize_t check_iovec_for_read (const struct iovec *, int) __attribute__ ((r=
egparm(2)));
+ssize_t check_iovec_for_write (const struct iovec *, int) __attribute__ ((=
regparm(2)));
+
 #define set_winsock_errno() __set_winsock_errno (__FUNCTION__, __LINE__)
 void __set_winsock_errno (const char *fn, int ln) __attribute__ ((regparm(=
2)));
=20
Index: include/sys/uio.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/include/sys/uio.h,v
retrieving revision 1.4
diff -u -p -r1.4 uio.h
--- include/sys/uio.h	5 Mar 2001 21:29:23 -0000	1.4
+++ include/sys/uio.h	28 Aug 2002 23:53:57 -0000
@@ -25,8 +25,8 @@ __BEGIN_DECLS
  */
=20
 struct iovec {
-	caddr_t iov_base;
-	int iov_len;
+  void *iov_base;
+  size_t iov_len;
 };
=20
 extern ssize_t readv __P ((int filedes, const struct iovec *vector, int co=
unt));

------=_NextPart_000_0032_01C24EF8.45BC4EE0--

