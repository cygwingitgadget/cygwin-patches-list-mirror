Return-Path: <cygwin-patches-return-2792-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 30475 invoked by alias); 7 Aug 2002 20:47:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30456 invoked from network); 7 Aug 2002 20:47:47 -0000
Message-ID: <056501c23e54$031f67c0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <040201c23e37$256b0810$6132bc3e@BABEL> <20020807200131.GA9098@redhat.com>
Subject: Re: IsBad*Ptr patch
Date: Wed, 07 Aug 2002 13:47:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00240.txt.bz2

"Christopher Faylor" <cgf@redhat.com> wrote:
>
> On Wed, Aug 07, 2002 at 06:23:26PM +0100, Conrad Scott wrote:
> >
> >I've attached a patch that starts from changing the signature
of
> >__check_null_invalid_struct and
__check_null_invalid_struct_errno
> >to take a non-const void *.  Previously they took a const
argument
> >and as a result, were being called in a couple of places on
const
> >system call arguments that should have had
> >__check_invalid_read_ptr_errno called on them.
>
> I don't understand why changing the const is necessary.  AFAICT,
it is
> accurate, even if IsBad*Ptr doesn't take a const pointer.

The idea is that if a system call takes a const pointer argument
(e.g. const void *) then the correct check on that argument can
only be IsBadReadPtr, since the system call's not going to write
to it; while if the argument is not const (e.g. void *) then
presumably the system call will write to it.  If you make the
argument to IsBadWritePtr non-const, then the compiler will
complain if you try to check const arguments with it: and that can
only be a good thing since a system call can't be taking a const
argument if it's going to write into it.  (i.e. it's not a
question of whether the function to which you're passing the
pointer is going to modify it or not, it's just for the the type
information to make sure you only call the function on the
relevant sort of pointer.)

I think that should answer your question, but ping me again if I'm
missing the point.

> (Btw, would you mind adding a 'p' to your diffs, i.e., 'cvs
diff -up'?
> This makes it easier to see what function is changing).

I didn't even know about that extremely useful option: thanks for
the pointer.  I've spent ages pissing when about writing ChangeLog
entries trying to work out which function is being affected.  I'll
RTFM a little bit more in future.

> >   if (__check_null_invalid_struct_errno (buf, (unsigned) len)
> >-      || check_null_invalid_struct_errno (fromlen)
> >-      || (from && __check_null_invalid_struct_errno (from,
(unsigned) *fromlen))
> >+      || (from
> >+   && (check_null_invalid_struct_errno (fromlen)
> >+       ||__check_null_invalid_struct_errno (from, (unsigned)
*fromlen)))
>
> Are you sure fromlen is allowed to be invalid if from == NULL?
I don't see this
> from SUSv2.

There's nothing explicitly in there (or SUSv3, which is what I'm
using) but the page only mentions *using* it if the address
argument is not null.  Also, the code examples in Stevens's "Unix
Network Programming" for recvmsg(2) simply set the address pointer
to null and leave the length pointer uninitialised, which would
make cygwin barf if it were also to check the address length
pointer.

> >@@ -970,7 +978,7 @@
> > extern "C" struct hostent *
> > cygwin_gethostbyaddr (const char *addr, int len, int type)
> > {
> >-  if (__check_null_invalid_struct_errno (addr, len))
> >+  if (__check_invalid_read_ptr_errno (addr, len))
> >     return NULL;
>
> Isn't addr writable?  invalid_struct_errno checks that addr is
in writable
> memory.

It can't be writable: it's a const char *, and this is exactly one
of cases I found by changing the signature of the checking
functions.  The addr is just a key into the hosts database.

> >@@ -1011,13 +1018,13 @@
> > extern "C" int
> > cygwin_bind (int fd, const struct sockaddr *my_addr, int
addrlen)
> > {
> >-  if (__check_null_invalid_struct_errno (my_addr, addrlen))
> >-    return -1;
> >-
> >-  int res = -1;
> >-
> >+  int res;
> >   fhandler_socket *fh = get (fd);
> >-  if (fh)
> >+
> >+  if (__check_invalid_read_ptr_errno (my_addr, addrlen)
> >+      || !fh)
> >+    res = -1;
> >+  else
> >     res = fh->bind (my_addr, addrlen);
>
> Ditto.

Again: the address pointer is a const.  This is strange, since if
you provide a 0 for the port, the system allocates you a temporary
port number, which you might expect to be passed back via the
address structure.  In fact, you've got to go call getsockname(2)
to find out what you've been given.

> >   syscall_printf ("%d = bind (%d, %x, %d)", res, fd, my_addr,
addrlen);
> >@@ -1028,14 +1035,14 @@
> > extern "C" int
> > cygwin_getsockname (int fd, struct sockaddr *addr, int
*namelen)
> > {
> >-  if (check_null_invalid_struct_errno (namelen)
> >-      || __check_null_invalid_struct_errno (addr, (unsigned)
*namelen))
> >-    return -1;
> >-
> >-  int res = -1;
> >-
> >+  int res;
> >   fhandler_socket *fh = get (fd);
> >-  if (fh)
> >+
> >+  if (check_null_invalid_struct_errno (namelen)
> >+      || __check_null_invalid_struct_errno (addr, (unsigned)
*namelen)
> >+      || !fh)
> >+    res = -1;
> >+  else
> >     res = fh->getsockname (addr, namelen);
>
> Hmm.  Why is getsockname different from gethostbyaddr?

'Cos the result comes back in the address object.  The
gethostbyaddr(3) function is the wierd one here: it doesn't need
to be re-entrant or thread safe: it returns pointers to data it's
allocated (AFAIK).

> >@@ -1161,13 +1169,12 @@
> >   int res;
> >   fhandler_socket *fh = get (fd);
> >
> >-  if (__check_invalid_read_ptr_errno (buf, len) || !fh)
> >+  if ((len &&__check_invalid_read_ptr_errno (buf, len)) ||
!fh)
> >     res = -1;
> >   else
> >     res = fh->send (buf, len, flags);
> >
> >   syscall_printf ("%d = send (%d, %x, %d, %x)", res, fd, buf,
len, flags);
> >-
> >   return res;
> > }
>
> This is one of a few places where you've explictly checked for
len before
> calling a __check routine.  Are you sure that is the way linux
works?

This is like write(2): if the buffer is zero length, the function
is a no-op and succeeds w/o doing anything, i.e. it's the length
not the buffer pointer that is checked.

> There are more of these philosophy type questions in this patch
but the
> same basic questions apply.

I hope my sprinkled replies have helped sort things out: I've
spent a while going through the SUSv3 definitions checking these.
Most of it falls out from the const / non-const state of the
arguments though.

HTH,

// Conrad


