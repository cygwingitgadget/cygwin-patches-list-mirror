Return-Path: <cygwin-patches-return-2791-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 10215 invoked by alias); 7 Aug 2002 20:01:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10186 invoked from network); 7 Aug 2002 20:01:33 -0000
Date: Wed, 07 Aug 2002 13:01:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: IsBad*Ptr patch
Message-ID: <20020807200131.GA9098@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <040201c23e37$256b0810$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <040201c23e37$256b0810$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00239.txt.bz2

On Wed, Aug 07, 2002 at 06:23:26PM +0100, Conrad Scott wrote:
>I've attached a patch that starts from changing the signature of
>__check_null_invalid_struct and __check_null_invalid_struct_errno
>to take a non-const void *.  Previously they took a const argument
>and as a result, were being called in a couple of places on const
>system call arguments that should have had
>__check_invalid_read_ptr_errno called on them.

I don't understand why changing the const is necessary.  AFAICT, it is
accurate, even if IsBad*Ptr doesn't take a const pointer.

More comments follow.


(Btw, would you mind adding a 'p' to your diffs, i.e., 'cvs diff -up'?
This makes it easier to see what function is changing).

>   if (__check_null_invalid_struct_errno (buf, (unsigned) len)
>-      || check_null_invalid_struct_errno (fromlen)
>-      || (from && __check_null_invalid_struct_errno (from, (unsigned) *fromlen))
>+      || (from
>+	  && (check_null_invalid_struct_errno (fromlen)
>+	      ||__check_null_invalid_struct_errno (from, (unsigned) *fromlen)))

Are you sure fromlen is allowed to be invalid if from == NULL?  I don't see this
from SUSv2.

>@@ -970,7 +978,7 @@
> extern "C" struct hostent *
> cygwin_gethostbyaddr (const char *addr, int len, int type)
> {
>-  if (__check_null_invalid_struct_errno (addr, len))
>+  if (__check_invalid_read_ptr_errno (addr, len))
>     return NULL;

Isn't addr writable?  invalid_struct_errno checks that addr is in writable
memory.
 
>@@ -1011,13 +1018,13 @@
> extern "C" int
> cygwin_bind (int fd, const struct sockaddr *my_addr, int addrlen)
> {
>-  if (__check_null_invalid_struct_errno (my_addr, addrlen))
>-    return -1;
>-
>-  int res = -1;
>-
>+  int res;
>   fhandler_socket *fh = get (fd);
>-  if (fh)
>+
>+  if (__check_invalid_read_ptr_errno (my_addr, addrlen)
>+      || !fh)
>+    res = -1;
>+  else
>     res = fh->bind (my_addr, addrlen);

Ditto.

>   syscall_printf ("%d = bind (%d, %x, %d)", res, fd, my_addr, addrlen);
>@@ -1028,14 +1035,14 @@
> extern "C" int
> cygwin_getsockname (int fd, struct sockaddr *addr, int *namelen)
> {
>-  if (check_null_invalid_struct_errno (namelen)
>-      || __check_null_invalid_struct_errno (addr, (unsigned) *namelen))
>-    return -1;
>-
>-  int res = -1;
>-
>+  int res;
>   fhandler_socket *fh = get (fd);
>-  if (fh)
>+
>+  if (check_null_invalid_struct_errno (namelen)
>+      || __check_null_invalid_struct_errno (addr, (unsigned) *namelen)
>+      || !fh)
>+    res = -1;
>+  else
>     res = fh->getsockname (addr, namelen);

Hmm.  Why is getsockname different from gethostbyaddr?

>@@ -1161,13 +1169,12 @@
>   int res;
>   fhandler_socket *fh = get (fd);
> 
>-  if (__check_invalid_read_ptr_errno (buf, len) || !fh)
>+  if ((len &&__check_invalid_read_ptr_errno (buf, len)) || !fh)
>     res = -1;
>   else
>     res = fh->send (buf, len, flags);
> 
>   syscall_printf ("%d = send (%d, %x, %d, %x)", res, fd, buf, len, flags);
>-
>   return res;
> }

This is one of a few places where you've explictly checked for len before
calling a __check routine.  Are you sure that is the way linux works?

There are more of these philosophy type questions in this patch but the
same basic questions apply.

cgf 
