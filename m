Return-Path: <cygwin-patches-return-2230-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 26787 invoked by alias); 27 May 2002 11:25:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26772 invoked from network); 27 May 2002 11:25:44 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Mon, 27 May 2002 04:25:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH] pthread key patch
Message-ID: <F0E13277A26BD311944600500454CCD054A977-101000@antarctica.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; boundary="----_=_NextPart_000_01C2056E.C79160B0"
Content-ID: <Pine.WNT.4.44.0205271317380.280@algeria.intern.net>
X-SW-Source: 2002-q2/txt/msg00214.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

------_=_NextPart_000_01C2056E.C79160B0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-ID: Pine.WNT.4.44.0205271151021.272@algeria.intern.net
Content-length: 3403


This patch is an improvement to the pthread key code (pthread_key_create,
pthread_getspecific, pthread_setspecific).
This patch will fix some problems if you build gcc
with --enable-threads=posix. I would like to discuss the reason for this
in the cygwin-developers list but unfortunately i am not a member ( i
tried to subscribe but got no answer for my confirmation ).

Here is a small test program

#include <stdio.h>

#include <pthread.h>
static void * TestThread( void * );

int main( void )
{
   for(;;)
   {
      pthread_t t;
      void * result;

      pthread_create(&t, NULL, TestThread, NULL);
      pthread_join(t,  &result);
   }

   return 0;
}

static void * TestThread( void * )
{

   try {

      pthread_exit(NULL);
   }

   catch( ... )
   {
      printf( "Got exception\n" );
   }

   return NULL;
}

Even if i build this with with my pthread patched version of cygwin i see
that the program memory leaks. The reason is that the exception handler of
the newly created thread never gets freed.

This is from gthr-win32.h in gcc/gcc:

#if __MINGW32_MAJOR_VERSION >= 1 || \
  (__MINGW32_MAJOR_VERSION == 0 && __MINGW32_MINOR_VERSION > 2)
#define MINGW32_SUPPORTS_MT_EH 1
extern int __mingwthr_key_dtor PROTO((DWORD, void (*) (void *)));
/* Mingw runtime >= v0.3 provides a magic variable that is set to
non-zero if -mthreads option was specified, or 0 otherwise. This is to
get around the lack of weak symbols in PE-COFF.  */
extern int _CRT_MT;
#endif

You will see that the exception handler removal via mthreads is limited
to mingw. To work around this problem cygwin1.dll will need a helper dll
like mingwm10.dll or use a different approach.

IMHO the cleanest way is to configure gcc with posix thread handling.
I have already build my gcc this way.

The disadvantages are:

1. A posix build libgcc.a will break the no-cygwin feature.
To work around this the mingw runtime should be shipped with a native
build libgcc.a (and libstdc++.a) .
2. The cygwin1.dll can't be build with this libgcc.a.
Even if the dll is build with no-exceptions it does make some
__get_eh_context calls that will result in __pthread_once, __mutex_lock
and and unlock calls while the dll is not initialized. The cygwin1.dll
will hang at some point during initialization. To get a working dll i
build cygwin1.dll with a single-threaded libgcc.a. I have renamed the
single-threaded libgcc.a to libgcc-single.a and modified the Makefile in
winsup/cygwin to link against libgcc-single instead of libgcc. Since
cygwin1.dll does not use exception handling internally it is save to do
so.

Changelog:

2002-05-27  Thomas Pfaff  <tpfaff@gmx.net>

	* init.cc (dll_entry): Run the pthread_key destructors on thread
	and process detach. This will make sure that regardless a thread
	is created with pthread_create or CreateThread its eh context
	will be freed.
	* thread.cc: Moved #define MT_INTERFACE from thread.cc to
	thread.h.
	(pthread_key_destructor_list::IterateNull): Run
	destructor only if the value is not NULL.
	(pthread_key::get): Save and restore WIN32 LastError to avoid
	that the Lasterror is cleared in the exception handling code.
	(__pthread_exit): Removed IterateNull call. This will be done
	during thread detach.
	* thread.h (pthread::cleanup_stack): Renamed from
	cleanup_handlers to cleanup_stack.
	Moved #define MT_INTERFACE user_data->threadinterface from
	thread.cc to this location.





------_=_NextPart_000_01C2056E.C79160B0
Content-Type: APPLICATION/OCTET-STREAM; name="pthread_key.patch"
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: Pine.WNT.4.44.0205271253200.280@algeria.intern.net
Content-Description: 
Content-Disposition: attachment; filename="pthread_key.patch"
Content-length: 2504

diff -urp src.old/winsup/cygwin/init.cc src/winsup/cygwin/init.cc=0A=
--- src.old/winsup/cygwin/init.cc	Mon May 27 12:43:26 2002=0A=
+++ src/winsup/cygwin/init.cc	Mon May 27 12:32:19 2002=0A=
@@ -33,6 +33,7 @@ WINAPI dll_entry (HANDLE h, DWORD reason=0A=
 	}=0A=
       break;=0A=
     case DLL_PROCESS_DETACH:=0A=
+      MT_INTERFACE->destructors.IterateNull ();=0A=
       break;=0A=
     case DLL_THREAD_DETACH:=0A=
 #if 0 // FIXME: REINSTATE SOON=0A=
@@ -48,6 +49,7 @@ WINAPI dll_entry (HANDLE h, DWORD reason=0A=
 	}=0A=
 	// FIXME: Need to add other per_thread stuff here=0A=
 #endif=0A=
+      MT_INTERFACE->destructors.IterateNull ();=0A=
       break;=0A=
     }=0A=
   return 1;=0A=
diff -urp src.old/winsup/cygwin/thread.cc src/winsup/cygwin/thread.cc=0A=
--- src.old/winsup/cygwin/thread.cc	Mon May 27 12:43:26 2002=0A=
+++ src/winsup/cygwin/thread.cc	Mon May 27 12:43:57 2002=0A=
@@ -148,14 +148,17 @@ pthread_key_destructor_list::IterateNull=0A=
   pthread_key_destructor *temp =3D head;=0A=
   while (temp)=0A=
     {=0A=
-      temp->destructor ((temp->key)->get ());=0A=
+      void *value =3D (temp->key)->get ();=0A=
+      if (value)=0A=
+        {=0A=
+          temp->destructor (value);=0A=
+          (temp->key)->set (NULL);=0A=
+        }=0A=
       temp =3D temp->Next ();=0A=
     }=0A=
 }=0A=
=20=0A=
=20=0A=
-#define MT_INTERFACE user_data->threadinterface=0A=
-=0A=
 struct _reent *=0A=
 _reent_clib ()=0A=
 {=0A=
@@ -669,8 +672,14 @@ pthread_key::set (const void *value)=0A=
 void *=0A=
 pthread_key::get ()=0A=
 {=0A=
+  void *result;=0A=
+  int last_error =3D GetLastError ();=0A=
+=0A=
   set_errno (0);=0A=
-  return TlsGetValue (dwTlsIndex);=0A=
+  result =3D TlsGetValue (dwTlsIndex);=0A=
+  SetLastError (last_error);=0A=
+=0A=
+  return result;=0A=
 }=0A=
=20=0A=
 /*pshared mutexs:=0A=
@@ -1626,8 +1635,6 @@ __pthread_exit (void *value_ptr)=0A=
=20=0A=
   // run cleanup handlers=0A=
   __pthread_cleanup_pop_all ();=0A=
-=0A=
-  MT_INTERFACE->destructors.IterateNull ();=0A=
=20=0A=
   __pthread_mutex_lock(&thread->mutex);=0A=
=20=0A=
diff -urp src.old/winsup/cygwin/thread.h src/winsup/cygwin/thread.h=0A=
--- src.old/winsup/cygwin/thread.h	Mon May 27 12:43:26 2002=0A=
+++ src/winsup/cygwin/thread.h	Mon May 27 12:47:47 2002=0A=
@@ -522,6 +522,8 @@ int __sem_trywait (sem_t * sem);=0A=
 int __sem_post (sem_t * sem);=0A=
 };=0A=
=20=0A=
+#define MT_INTERFACE user_data->threadinterface=0A=
+=0A=
 #endif // MT_SAFE=0A=
=20=0A=
 #endif // _CYGNUS_THREADS_=0A=

------_=_NextPart_000_01C2056E.C79160B0--
