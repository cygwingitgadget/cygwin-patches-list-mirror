Return-Path: <cygwin-patches-return-2949-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 23798 invoked by alias); 10 Sep 2002 15:21:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23756 invoked from network); 10 Sep 2002 15:21:21 -0000
Subject: Re: pthread_testcancel() causes SEGV
From: Robert Collins <rbcollins@cygwin.com>
To: Jason Tishler <jason@tishler.net>
Cc: Thomas Pfaff <tpfaff@gmx.net>, cygwin-developers@cygwin.com, 
	cygwin-patches@cygwin.com
In-Reply-To: <20020807185435.GA2228@tishler.net>
References: <20020806183632.GA1892@tishler.net>
	<Pine.WNT.4.44.0208070927490.268-100000@algeria.intern.net> 
	<20020807185435.GA2228@tishler.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-3SLYnUOmvy3i9fbm4Bqg"
Date: Tue, 10 Sep 2002 08:21:00 -0000
Message-Id: <1031671312.22457.19.camel@lifelesswks>
Mime-Version: 1.0
X-SW-Source: 2002-q3/txt/msg00397.txt.bz2


--=-3SLYnUOmvy3i9fbm4Bqg
Content-Type: multipart/mixed; boundary="=-hCds+Qhr9lxBvJ04zbDc"


--=-hCds+Qhr9lxBvJ04zbDc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 1189

On Thu, 2002-08-08 at 04:54, Jason Tishler wrote:
> Thomas,
>=20
> On Wed, Aug 07, 2002 at 09:34:14AM +0200, Thomas Pfaff wrote:
> > Thanks for tracking it down.
>=20
> No problem.  Thanks for the quick turn around on the patch.  I tested it
> and can confirm that it fixes the ipc-daemon service startup problem.

Jason,=20
sorry for the *cough* long delay.=20

the attached patch is the 'right way' to deal with this issue IMO. It
also gives us full pthread* support for threads created using the win32
CreateThread call (although I won't officially support that at this
point :}).

Generally speaking, when you find yourself writing the same bit of code
twice, the design is wrong. Anyway, enough said:

ChangeLog
2002-09-11  Robert Collins  <rbtcollins@hotmail.com>

	* init.cc (dll_entry): On thread detach, if the thread hasn't
	exit()ed, do so.
	* thread.cc (pthread::self): Instantiate a new pthread object=20
	when called and none exists.
	(pthread::precreate): Factor out common code.
	(pthread::postcreate): Ditto.
	(pthread::create): Ditto.
	(pthread::exit): Remove the TLS value when we exit to prevent
	double exits.
	* thread.h (pthread): Declare pre- and post-create.

Rob

--=-hCds+Qhr9lxBvJ04zbDc
Content-Disposition: attachment; filename=pthread_self_fix.patch
Content-Type: text/plain; name=pthread_self_fix.patch; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-length: 4844

? cvs.exe.stackdump
? cygwin_daemon.patch
? localdiff
? pthread_cancel.patch
? pthread_fix.patch
? pthread_self_fix.patch
? t
Index: init.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/init.cc,v
retrieving revision 1.14
diff -u -p -r1.14 init.cc
--- init.cc	10 Oct 2001 02:32:12 -0000	1.14
+++ init.cc	10 Sep 2002 15:15:50 -0000
@@ -35,6 +35,13 @@ WINAPI dll_entry (HANDLE h, DWORD reason
     case DLL_PROCESS_DETACH:
       break;
     case DLL_THREAD_DETACH:
+      pthread *thisthread =3D (pthread *) TlsGetValue (
+			user_data->threadinterface->thread_self_dwTlsIndex);
+      if (thisthread) {
+	  /* Some non-pthread call created this thread,=20
+	   * but we need to clean it up */
+	  thisthread->exit(0);
+      }
 #if 0 // FIXME: REINSTATE SOON
       waitq *w;
       if ((w =3D waitq_storage.get ()) !=3D NULL)
Index: thread.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/thread.cc,v
retrieving revision 1.76
diff -u -p -r1.76 thread.cc
--- thread.cc	4 Jul 2002 14:17:29 -0000	1.76
+++ thread.cc	10 Sep 2002 15:15:50 -0000
@@ -350,7 +350,16 @@ MTinterface::fixup_after_fork (void)
 pthread *
 pthread::self ()
 {
-  return (pthread *) TlsGetValue (MT_INTERFACE->thread_self_dwTlsIndex);
+  pthread *temp =3D (pthread *) TlsGetValue (MT_INTERFACE->thread_self_dwT=
lsIndex);
+  if (temp)
+      return temp;
+  temp =3D new pthread ();
+  temp->precreate (NULL);
+  if (!temp->magic)
+    /* Something seriously wrong */
+    return NULL;=20
+  temp->postcreate ();
+  return temp;
 }
=20
 /* member methods */
@@ -370,8 +379,7 @@ pthread::~pthread ()
=20
=20
 void
-pthread::create (void *(*func) (void *), pthread_attr *newattr,
-		 void *threadarg)
+pthread::precreate (pthread_attr *newattr)
 {
   pthread_mutex *verifyable_mutex_obj =3D &mutex;
=20
@@ -386,8 +394,6 @@ pthread::create (void *(*func) (void *),
       attr.inheritsched =3D newattr->inheritsched;
       attr.stacksize =3D newattr->stacksize;
     }
-  function =3D func;
-  arg =3D threadarg;
=20
   if (verifyable_object_isvalid (&verifyable_mutex_obj, PTHREAD_MUTEX_MAGI=
C) !=3D VALID_OBJECT)
     {
@@ -405,6 +411,17 @@ pthread::create (void *(*func) (void *),
       magic =3D 0;
       return;
     }
+}
+
+void
+pthread::create (void *(*func) (void *), pthread_attr *newattr,
+		 void *threadarg)
+{=20
+  precreate (newattr);
+  if (!magic)
+      return;
+   function =3D func;
+   arg =3D threadarg;
=20
   win32_obj_id =3D ::CreateThread (&sec_none_nih, attr.stacksize,
 				(LPTHREAD_START_ROUTINE) thread_init_wrapper,
@@ -415,17 +432,22 @@ pthread::create (void *(*func) (void *),
       thread_printf ("CreateThread failed: this %p LastError %E", this);
       magic =3D 0;
     }
-  else
-    {
-      InterlockedIncrement (&MT_INTERFACE->threadcount);
-      /*FIXME: set the priority appropriately for system contention scope =
*/
-      if (attr.inheritsched =3D=3D PTHREAD_EXPLICIT_SCHED)
-	{
-	  /*FIXME: set the scheduling settings for the new thread */
-	  /*sched_thread_setparam (win32_obj_id, attr.schedparam); */
-	}
+  else {
+      postcreate ();
       ResumeThread (win32_obj_id);
-    }
+  }
+}
+
+void
+pthread::postcreate ()
+{
+    InterlockedIncrement (&MT_INTERFACE->threadcount);
+    /*FIXME: set the priority appropriately for system contention scope */
+    if (attr.inheritsched =3D=3D PTHREAD_EXPLICIT_SCHED)
+      {
+	/*FIXME: set the scheduling settings for the new thread */
+	/*sched_thread_setparam (win32_obj_id, attr.schedparam); */
+      }
 }
=20
 void
@@ -447,6 +469,9 @@ pthread::exit (void *value_ptr)
       return_ptr =3D value_ptr;
       mutex.UnLock ();
     }
+
+  /* Prevent DLL_THREAD_DETACH Attempting to clean us up */
+  TlsSetValue (MT_INTERFACE->thread_self_dwTlsIndex, 0);
=20
   if (InterlockedDecrement (&MT_INTERFACE->threadcount) =3D=3D 0)
     ::exit (0);
Index: thread.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/thread.h,v
retrieving revision 1.40
diff -u -p -r1.40 thread.h
--- thread.h	4 Jul 2002 14:17:29 -0000	1.40
+++ thread.h	10 Sep 2002 15:15:50 -0000
@@ -284,6 +284,8 @@ public:
   sigset_t *sigmask;
   LONG *sigtodo;
   void create (void *(*)(void *), pthread_attr *, void *);
+  void precreate (pthread_attr *);
+  void postcreate ();
=20
     pthread ();
    ~pthread ();

--=-hCds+Qhr9lxBvJ04zbDc--

--=-3SLYnUOmvy3i9fbm4Bqg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9fg4OI5+kQ8LJcoIRAk/5AKCUf4x3th1AT1ybD9WLufc7WiQnBQCg1cm4
VXXtNR/nceVbcGd+btdKCNI=
=KSQ7
-----END PGP SIGNATURE-----

--=-3SLYnUOmvy3i9fbm4Bqg--
