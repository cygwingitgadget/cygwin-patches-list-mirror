Return-Path: <cygwin-patches-return-2612-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 29716 invoked by alias); 7 Jul 2002 14:35:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29701 invoked from network); 7 Jul 2002 14:35:38 -0000
Message-ID: <015501c225c3$d8ddcc20$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
Subject: mark_closed messages
Date: Sun, 07 Jul 2002 07:35:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0152_01C225CC.3A4CC120"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00060.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0152_01C225CC.3A4CC120
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 1558

As I mentioned before, when using cygserver I've been seeming
rather too many error messages from "mark_closed" (in debug.cc).
Altho' triggered by cygserver, the problem turned out to an
existing problem with the protected handle debugging code, which
has some but not all the code needed to deal with inherited
handles.

I was looking to fix this properly but I've decided, after some
investigation that taught me lots about how fork() works in
cygwin, that I've not the time or energy for this right now.

AFAICT (and this was all new to me, so I may be utterly adrift
here), the difficulty is that the child process needs to create
and protect handles *before* the parent's data space is copied
down into it.  So, the child would need to keep a temporary list
of protected handles and merge these into the list it inherited
from the parent once it had access to it.  Not impossible but not
my cup of tea today.

The current implementation simply doesn't copy down the protected
handle list at all (all the data structures are marked NO_COPY).
Unfortunately there is still code in the fhandler class that tries
to update inherited handle values with new child handles; see
fhandler_base::fork_fixup () and setclexec_pid ().  This ended up
overwriting child handle values with other child handle values.
Lots of fun on close.  So, I've just #if 0'd setclexec_pid () for
now.  Volunteers welcome etc.

I've attached a patch that fixes a couple of other minor issues in
debug.cc (mostly muto handling) and disables the "setclexec_pid()"
function.

// Conrad


------=_NextPart_000_0152_01C225CC.3A4CC120
Content-Type: text/plain;
	name="ChangeLog.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ChangeLog.txt"
Content-length: 692

2002-07-07  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* debug.cc (class lock_debug): Make a class, rather than a struct.
	Fix problem where explicit use of the lock_debug::unlock method
	released the muto twice.
	(lock_debug::acquired): New field.
	(lock_debug::lock_debug): Set acquired only if the muto is
	actually acquired.
	(lock_debug::unlock): Only release the muto if it is still
	acquired by this object.
	(setclexec_pid): Disable until such time as the protected handle
	list is inherited by child processes.
	(add_handle): Unlock the lock_debug muto before using
	system_printf.
	(mark_closed): Ditto.
	(debug_fixup_after_fork): Use lock_debug, tho' it's probably
	unnecessary.

------=_NextPart_000_0152_01C225CC.3A4CC120
Content-Type: application/octet-stream;
	name="debug.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="debug.patch"
Content-length: 2398

Index: debug.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/debug.cc,v=0A=
retrieving revision 1.24.2.4=0A=
diff -u -r1.24.2.4 debug.cc=0A=
--- debug.cc	2 Jul 2002 10:58:17 -0000	1.24.2.4=0A=
+++ debug.cc	7 Jul 2002 14:17:29 -0000=0A=
@@ -184,11 +184,15 @@=0A=
=20=0A=
 static muto NO_COPY *debug_lock =3D NULL;=0A=
=20=0A=
-struct lock_debug=0A=
+class lock_debug=0A=
 {=0A=
-  lock_debug () {if (debug_lock) debug_lock->acquire (INFINITE);}=0A=
-  void unlock () {if (debug_lock) debug_lock->release ();}=0A=
+public:=0A=
+  lock_debug () : acquired (false)=0A=
+  {if (debug_lock) acquired =3D debug_lock->acquire (INFINITE);}=0A=
+  void unlock () {if (acquired) debug_lock->release (); acquired =3D false=
;}=0A=
   ~lock_debug () {unlock ();}=0A=
+private:=0A=
+  bool acquired;=0A=
 };=0A=
=20=0A=
 static bool __stdcall mark_closed (const char *, int, HANDLE, const char *=
, BOOL);=0A=
@@ -217,12 +221,16 @@=0A=
 void=0A=
 setclexec_pid (HANDLE oh, HANDLE nh, bool setit)=0A=
 {=0A=
+#if 0=0A=
+  lock_debug here;=0A=
   handle_list *hl =3D find_handle (oh);=0A=
   if (hl)=0A=
     {=0A=
+      hl =3D hl->next;=0A=
       hl->clexec_pid =3D setit ? GetCurrentProcessId () : 0;=0A=
       hl->h =3D nh;=0A=
     }=0A=
+#endif /* 0 */=0A=
 }=0A=
=20=0A=
 /* Create a new handle record */=0A=
@@ -257,6 +265,7 @@=0A=
   if ((hl =3D find_handle (h)))=0A=
     {=0A=
       hl =3D hl->next;=0A=
+      here.unlock ();	// race here=0A=
       system_printf ("%s:%d - multiple attempts to add handle %s<%p>", fun=
c,=0A=
 		     ln, name, h);=0A=
       system_printf (" previously allocated by %s:%d(%s<%p>)",=0A=
@@ -296,6 +305,7 @@=0A=
 void=0A=
 debug_fixup_after_fork ()=0A=
 {=0A=
+  lock_debug here;=0A=
   handle_list *hl;=0A=
   for (hl =3D &starth; hl->next !=3D NULL; hl =3D hl->next)=0A=
     if (hl->next->clexec_pid)=0A=
@@ -321,6 +331,7 @@=0A=
   handle_list *hln;=0A=
   if (hl && (hln =3D hl->next) && strcmp (name, hln->name))=0A=
     {=0A=
+      here.unlock ();	// race here=0A=
       system_printf ("closing protected handle %s:%d(%s<%p>)",=0A=
 		     hln->func, hln->ln, hln->name, hln->h);=0A=
       system_printf (" by %s:%d(%s<%p>)", func, ln, name, h);=0A=

------=_NextPart_000_0152_01C225CC.3A4CC120--

