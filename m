Return-Path: <cygwin-patches-return-2229-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9357 invoked by alias); 27 May 2002 10:57:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9317 invoked from network); 27 May 2002 10:57:15 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Mon, 27 May 2002 03:57:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH] pthread cancel patch
Message-ID: <Pine.WNT.4.44.0205271255530.280-101000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; boundary="----_=_NextPart_000_01C2056C.F5504AB0"
Content-ID: <Pine.WNT.4.44.0205271255531.280@algeria.intern.net>
X-SW-Source: 2002-q2/txt/msg00213.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

------_=_NextPart_000_01C2056C.F5504AB0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-ID: Pine.WNT.4.44.0205271148461.272@algeria.intern.net
Content-length: 545


While Rob is reviewing my patches i got a bugfix for the pthread
cancellation code.

2002-05-27  Thomas Pfaff  <tpfaff@gmx.net>

	* thread.h (pthread::cleanup_stack): Renamed from
	cleanup_handlers to cleanup_stack.
	* thread.cc (pthread::pthread): Ditto.
	(__pthread_cleanup_push): Ditto.
	(__pthread_cleanup_pop): Ditto.
	(__pthread_cleanup_pop_all): Ditto.
	(__pthread_cancel): Check the cancelstate and type before
	pthread_equal to make sure that the thread is cancelled the
	right way.
	Unlock the mutex before the cancellation.










------_=_NextPart_000_01C2056C.F5504AB0
Content-Type: APPLICATION/OCTET-STREAM; name="pthread_cancel1.patch"
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: Pine.WNT.4.44.0205271255040.280@algeria.intern.net
Content-Description: 
Content-Disposition: attachment; filename="pthread_cancel1.patch"
Content-length: 3964

diff -urp src.old/winsup/cygwin/thread.cc src/winsup/cygwin/thread.cc=0A=
--- src.old/winsup/cygwin/thread.cc	Mon May 27 12:28:12 2002=0A=
+++ src/winsup/cygwin/thread.cc	Mon May 27 12:29:01 2002=0A=
@@ -368,7 +368,7 @@ MTinterface::fixup_after_fork (void)=0A=
 pthread::pthread ():verifyable_object (PTHREAD_MAGIC), win32_obj_id (0),=
=0A=
                     cancelstate (0), canceltype (0), cancel_event (0),=0A=
                     mutex ((pthread_mutex *)PTHREAD_MUTEX_INITIALIZER),=0A=
-                    cleanup_handlers(NULL), joiner(NULL)=0A=
+                    cleanup_stack(NULL), joiner(NULL)=0A=
 {=0A=
 }=0A=
=20=0A=
@@ -1038,22 +1038,24 @@ __pthread_cancel (pthread_t thread)=0A=
   if (verifyable_object_isvalid (&thread, PTHREAD_MAGIC) !=3D VALID_OBJECT=
)=0A=
     return ESRCH;=0A=
=20=0A=
-  if( __pthread_equal(&thread, &self ) )=0A=
-    {=0A=
-      __pthread_cancel_self ();=0A=
-    }=0A=
-=0A=
   __pthread_mutex_lock (&thread->mutex);=0A=
=20=0A=
   if (thread->canceltype =3D=3D PTHREAD_CANCEL_DEFERRED ||=0A=
       thread->cancelstate =3D=3D PTHREAD_CANCEL_DISABLE)=0A=
 	{=0A=
       // cancel deferred=0A=
-      SetEvent (thread->cancel_event);=0A=
       __pthread_mutex_unlock (&thread->mutex);=0A=
+      SetEvent (thread->cancel_event);=0A=
       return 0;=0A=
 	}=0A=
=20=0A=
+  else if (__pthread_equal(&thread, &self))=0A=
+    {=0A=
+      __pthread_mutex_unlock (&thread->mutex);=0A=
+      __pthread_cancel_self ();=0A=
+      return 0; // Never reached=0A=
+    }=0A=
+=0A=
   // cancel asynchronous=0A=
   SuspendThread (thread->win32_obj_id);=0A=
   if (WaitForSingleObject (thread->win32_obj_id, 0) =3D=3D WAIT_TIMEOUT)=
=0A=
@@ -1064,9 +1066,8 @@ __pthread_cancel (pthread_t thread)=0A=
       PROGCTR(context) =3D (DWORD) __pthread_cancel_self;=0A=
       SetThreadContext (thread->win32_obj_id, &context);=0A=
     }=0A=
-  ResumeThread (thread->win32_obj_id);=0A=
-=0A=
   __pthread_mutex_unlock (&thread->mutex);=0A=
+  ResumeThread (thread->win32_obj_id);=0A=
=20=0A=
   return 0;=0A=
 /*=0A=
@@ -1314,8 +1315,8 @@ __pthread_cleanup_push (__pthread_cleanu=0A=
   // cleanup_push is not async cancel safe=0A=
   __pthread_mutex_lock(&thread->mutex);=0A=
=20=0A=
-  handler->next =3D thread->cleanup_handlers;=0A=
-  thread->cleanup_handlers =3D handler;=0A=
+  handler->next =3D thread->cleanup_stack;=0A=
+  thread->cleanup_stack =3D handler;=0A=
=20=0A=
   __pthread_mutex_unlock(&thread->mutex);=0A=
 }=0A=
@@ -1325,15 +1326,15 @@ __pthread_cleanup_pop (int execute)=0A=
 {=0A=
   pthread_t thread =3D __pthread_self ();=0A=
=20=0A=
-  if( thread->cleanup_handlers !=3D NULL )=0A=
-  {=0A=
-     __pthread_cleanup_handler *handler =3D thread->cleanup_handlers;=0A=
+  if (thread->cleanup_stack !=3D NULL)=0A=
+    {=0A=
+      __pthread_cleanup_handler *handler =3D thread->cleanup_stack;=0A=
=20=0A=
-     if (execute)=0A=
-       (*handler->function) (handler->arg);=0A=
+      if (execute)=0A=
+        (*handler->function) (handler->arg);=0A=
=20=0A=
-     thread->cleanup_handlers =3D handler->next;=0A=
-  }=0A=
+      thread->cleanup_stack =3D handler->next;=0A=
+    }=0A=
 }=0A=
=20=0A=
 void=0A=
@@ -1341,10 +1342,10 @@ __pthread_cleanup_pop_all (void)=0A=
 {=0A=
   pthread_t thread =3D __pthread_self ();=0A=
=20=0A=
-  while(thread->cleanup_handlers !=3D NULL)=0A=
-  {=0A=
+  while (thread->cleanup_stack !=3D NULL)=0A=
+   {=0A=
      __pthread_cleanup_pop (1);=0A=
-  }=0A=
+   }=0A=
 }=0A=
=20=0A=
 /*=0A=
diff -urp src.old/winsup/cygwin/thread.h src/winsup/cygwin/thread.h=0A=
--- src.old/winsup/cygwin/thread.h	Mon May 27 12:28:12 2002=0A=
+++ src/winsup/cygwin/thread.h	Mon May 27 12:28:27 2002=0A=
@@ -243,7 +243,7 @@ public:=0A=
   int cancelstate, canceltype;=0A=
   HANDLE cancel_event;=0A=
   pthread_mutex *mutex;=0A=
-  __pthread_cleanup_handler *cleanup_handlers;=0A=
+  __pthread_cleanup_handler *cleanup_stack;=0A=
   pthread_t joiner;=0A=
   // int joinable;=0A=
=20=0A=

------_=_NextPart_000_01C2056C.F5504AB0--
