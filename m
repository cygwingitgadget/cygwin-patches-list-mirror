Return-Path: <cygwin-patches-return-2978-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 21383 invoked by alias); 16 Sep 2002 11:44:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21363 invoked from network); 16 Sep 2002 11:44:16 -0000
Subject: Re: [PATCH] pthread_fork Part 1
From: Robert Collins <rbcollins@cygwin.com>
To: Thomas Pfaff <tpfaff@gmx.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Pine.WNT.4.44.0208162159200.-283127@thomas.kefrig-pfaff.de>
References: <Pine.WNT.4.44.0208162159200.-283127@thomas.kefrig-pfaff.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-FO65Sa9bwne4VquY9PWY"
Date: Mon, 16 Sep 2002 04:44:00 -0000
Message-Id: <1032176687.17674.131.camel@lifelesswks>
Mime-Version: 1.0
X-SW-Source: 2002-q3/txt/msg00426.txt.bz2


--=-FO65Sa9bwne4VquY9PWY
Content-Type: multipart/mixed; boundary="=-FaqlCVwFL0O3jy6Zu5Z7"


--=-FaqlCVwFL0O3jy6Zu5Z7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 803

On Sat, 2002-08-17 at 06:18, Thomas Pfaff wrote:
>=20
> Rob suggested to break the pthread_fork patch into smaller chunks. Ths is
> part 1 providing a fork save key value handling.
> The patch will add a linked list of keys to MTinterface and a fork buffer
> in pthread_key where the key values are passed between parent and child.

In general, I liked this patch.
I've made some essentially stylistic alterations, to make the resulting
code a little easier to read. I realise you followed my lead on some of
the layout - I need to fix up my existing code too :].

Here's a snapshot of HEAD with your patch after my changes.

I'd love it if you sent me the source for the test case you used when
developing this.

I'm really sorry that it's taken me so long to get back to reviewing
these.

Cheers,
Rob

--=-FaqlCVwFL0O3jy6Zu5Z7
Content-Disposition: attachment; filename=pthread_fork_part1_rob1.patch
Content-Type: text/plain; name=pthread_fork_part1_rob1.patch; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-length: 12103

? cvs.exe.stackdump
? cygwin_daemon.patch
? localdiff
? pthread_cancel.patch
? pthread_fix.patch
? pthread_fork_save_keys.patch
? t
Index: fork.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/fork.cc,v
retrieving revision 1.91
diff -u -p -r1.91 fork.cc
--- fork.cc	18 Aug 2002 05:49:25 -0000	1.91
+++ fork.cc	16 Sep 2002 11:41:34 -0000
@@ -313,10 +313,8 @@ fork_child (HANDLE& hParent, dll *&first
     if ((*t)->clear_on_fork ())
       (*t)->set ();
=20
-  user_data->threadinterface->fixup_after_fork ();
-
   wait_for_sigthread ();
-  __pthread_atforkchild ();
+  pthread::atforkchild ();
   cygbench ("fork-child");
   return 0;
 }
@@ -354,8 +352,7 @@ fork_parent (HANDLE& hParent, dll *&firs
   DWORD rc;
   PROCESS_INFORMATION pi =3D {0, NULL, 0, 0};
=20
-  /* call the pthread_atfork prepare functions */
-  __pthread_atforkprepare ();
+  pthread::atforkprepare ();
=20
   subproc_init ();
=20
@@ -601,7 +598,7 @@ fork_parent (HANDLE& hParent, dll *&firs
   ForceCloseHandle (forker_finished);
   forker_finished =3D NULL;
   pi.hThread =3D NULL;
-  __pthread_atforkparent ();
+  pthread::atforkparent ();
=20
   return forked->pid;
=20
Index: thread.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/thread.cc,v
retrieving revision 1.77
diff -u -p -r1.77 thread.cc
--- thread.cc	16 Sep 2002 10:53:29 -0000	1.77
+++ thread.cc	16 Sep 2002 11:41:36 -0000
@@ -294,7 +294,7 @@ MTinterface::Init (int forked)
   concurrency =3D 0;
   threadcount =3D 1; /*1 current thread when Init occurs.*/
=20
-  pthread::initMainThread(&mainthread, myself->hProcess);
+  pthread::initMainThread (&mainthread, myself->hProcess);
=20
   if (forked)
     return;
@@ -314,10 +314,17 @@ MTinterface::Init (int forked)
 #endif
 }
=20
+void
+MTinterface::fixup_before_fork (void)
+{
+  pthread_key::fixup_before_fork ();
+}
+
 /* This function is called from a single threaded process */
 void
 MTinterface::fixup_after_fork (void)
 {
+  pthread_key::fixup_after_fork ();
   pthread_mutex *mutex =3D mutexs;
   debug_printf ("mutexs is %x",mutexs);
   while (mutex)
@@ -345,11 +352,11 @@ MTinterface::fixup_after_fork (void)
=20
 /* static methods */
 void
-pthread::initMainThread(pthread *mainThread, HANDLE win32_obj_id)
+pthread::initMainThread (pthread *mainThread, HANDLE win32_obj_id)
 {
   mainThread->win32_obj_id =3D win32_obj_id;
   mainThread->setThreadIdtoCurrent ();
-  setTlsSelfPointer(mainThread);
+  setTlsSelfPointer (mainThread);
 }
=20
 pthread *
@@ -362,23 +369,25 @@ pthread::self ()
   temp->precreate (NULL);
   if (!temp->magic) {
       delete temp;
-      return pthreadNull::getNullpthread();
+      return pthreadNull::getNullpthread ();
   }
   temp->postcreate ();
   return temp;
 }
=20
 void
-pthread::setTlsSelfPointer(pthread *thisThread)
+pthread::setTlsSelfPointer (pthread *thisThread)
 {
   /*the OS doesn't check this for <=3D 64 Tls entries (pre win2k) */
   TlsSetValue (MT_INTERFACE->thread_self_dwTlsIndex, thisThread);
 }
=20
+
+
 /* member methods */
 pthread::pthread ():verifyable_object (PTHREAD_MAGIC), win32_obj_id (0),
-                    cancelstate (0), canceltype (0), cancel_event(0),
-                    joiner (NULL), cleanup_stack(NULL)=20
+                    cancelstate (0), canceltype (0), cancel_event (0),
+                    joiner (NULL), cleanup_stack (NULL)=20
 {
 }
=20
@@ -480,7 +489,7 @@ pthread::exit (void *value_ptr)
=20
   mutex.Lock ();
   // cleanup if thread is in detached state and not joined
-  if( __pthread_equal(&joiner, &thread ) )
+  if (__pthread_equal (&joiner, &thread ) )
     delete this;
   else
     {=20=20
@@ -489,7 +498,7 @@ pthread::exit (void *value_ptr)
     }
=20
   /* Prevent DLL_THREAD_DETACH Attempting to clean us up */
-  setTlsSelfPointer(0);
+  setTlsSelfPointer (0);
=20
   if (InterlockedDecrement (&MT_INTERFACE->threadcount) =3D=3D 0)
     ::exit (0);
@@ -514,7 +523,7 @@ pthread::cancel (void)
       return 0;
     }
=20
-  else if (__pthread_equal(&thread, &self))
+  else if (__pthread_equal (&thread, &self))
     {
       mutex.UnLock ();
       cancel_self ();
@@ -716,14 +725,14 @@ pthread::testcancel (void)
   if (cancelstate =3D=3D PTHREAD_CANCEL_DISABLE)
     return;
=20
-  if( WAIT_OBJECT_0 =3D=3D WaitForSingleObject (cancel_event, 0 ) )
+  if (WAIT_OBJECT_0 =3D=3D WaitForSingleObject (cancel_event, 0 ) )
     cancel_self ();
 }
=20
 void
 pthread::static_cancel_self (void)
 {
-  pthread::self()->cancel_self ();
+  pthread::self ()->cancel_self ();
 }
=20
=20
@@ -776,7 +785,7 @@ pthread::push_cleanup_handler (__pthread
     // TODO: do it?
     api_fatal ("Attempt to push a cleanup handler across threads");=20
   handler->next =3D cleanup_stack;
-  InterlockedExchangePointer( &cleanup_stack, handler );
+  InterlockedExchangePointer (&cleanup_stack, handler );
 }
=20
 void
@@ -808,13 +817,13 @@ pthread::pop_all_cleanup_handlers ()
 }
=20
 void
-pthread::cancel_self()
+pthread::cancel_self ()
 {
   exit (PTHREAD_CANCELED);
 }
=20
 DWORD
-pthread::getThreadId()
+pthread::getThreadId ()
 {
   return thread_id;
 }
@@ -1018,6 +1027,35 @@ pthread_cond::fixup_after_fork ()
 #endif
 }
=20
+/* pthread_key */
+/* static members */
+pthread_key *pthread_key::keys =3D NULL;
+
+void
+pthread_key::fixup_before_fork ()
+{
+  pthread_key *key =3D keys;
+  debug_printf ("keys is %x",keys);
+  while (key)
+    {
+      key->saveKeyToBuffer ();
+      key =3D key->next;
+    }
+}
+
+void
+pthread_key::fixup_after_fork ()
+{
+  pthread_key *key =3D keys;
+  debug_printf ("keys is %x",keys);
+  while (key)
+    {
+      key->recreateKeyFromBuffer ();
+      key =3D key->next;
+    }
+}
+
+/* non-static members */
=20
 pthread_key::pthread_key (void (*destructor) (void *)):verifyable_object (=
PTHREAD_KEY_MAGIC)
 {
@@ -1029,6 +1067,8 @@ pthread_key::pthread_key (void (*destruc
       MT_INTERFACE->destructors.
 	Insert (new pthread_key_destructor (destructor, this));
     }
+  /* threadsafe addition is easy */
+  next =3D (pthread_key *) InterlockedExchangePointer (&keys, this);
 }
=20
 pthread_key::~pthread_key ()
@@ -1036,6 +1076,18 @@ pthread_key::~pthread_key ()
   if (pthread_key_destructor *dest =3D MT_INTERFACE->destructors.Remove (t=
his))
     delete dest;
   TlsFree (dwTlsIndex);
+
+  /* I'm not 100% sure the next bit is threadsafe. I think it is... */
+  if (keys =3D=3D this)
+    InterlockedExchangePointer (keys, this->next);
+  else
+    {
+      pthread_key *tempkey =3D keys;
+      while (tempkey->next && tempkey->next !=3D this)
+        tempkey =3D tempkey->next;
+      /* but there may be a race between the loop above and this statement=
 */
+      InterlockedExchangePointer (&tempkey->next, this->next);
+    }
 }
=20
 int
@@ -1053,6 +1105,21 @@ pthread_key::get ()
   return TlsGetValue (dwTlsIndex);
 }
=20
+void
+pthread_key::saveKeyToBuffer ()
+{
+  fork_buf =3D get ();
+}
+
+void
+pthread_key::recreateKeyFromBuffer ()
+{
+  dwTlsIndex =3D TlsAlloc ();
+  if (dwTlsIndex =3D=3D TLS_OUT_OF_INDEXES)
+    api_fatal ("pthread_key::recreateKeyFromBuffer () failed to reallocate=
 Tls storage");
+  set (fork_buf);
+}
+
 /*pshared mutexs:
=20
  * REMOVED FROM CURRENT. These can be reinstated with the daemon, when all=
 the
@@ -1311,7 +1378,7 @@ pthread::thread_init_wrapper (void *_arg
   pthread *thread =3D (pthread *) _arg;
   struct __reent_t local_reent;
   struct _winsup_t local_winsup;
-  struct _reent local_clib =3D _REENT_INIT(local_clib);
+  struct _reent local_clib =3D _REENT_INIT (local_clib);
=20
   struct sigaction _sigs[NSIG];
   sigset_t _sig_mask;		/*one set for everything to ignore. */
@@ -1333,7 +1400,7 @@ pthread::thread_init_wrapper (void *_arg
   if (!TlsSetValue (MT_INTERFACE->reent_index, &local_reent))
     system_printf ("local storage for thread couldn't be set");
=20
-  setTlsSelfPointer(thread);
+  setTlsSelfPointer (thread);
=20
   thread->mutex.Lock ();
   // if thread is detached force cleanup on exit
@@ -1448,8 +1515,10 @@ __pthread_cancel (pthread_t thread)
  *If yes, we're safe, if no, we're not.
  */
 void
-__pthread_atforkprepare (void)
+pthread::atforkprepare (void)
 {
+  MT_INTERFACE->fixup_before_fork ();
+
   callback *cb =3D MT_INTERFACE->pthread_prepare;
   while (cb)
     {
@@ -1459,7 +1528,7 @@ __pthread_atforkprepare (void)
 }
=20
 void
-__pthread_atforkparent (void)
+pthread::atforkparent (void)
 {
   callback *cb =3D MT_INTERFACE->pthread_parent;
   while (cb)
@@ -1470,8 +1539,10 @@ __pthread_atforkparent (void)
 }
=20
 void
-__pthread_atforkchild (void)
+pthread::atforkchild (void)
 {
+  MT_INTERFACE->fixup_after_fork ();
+
   callback *cb =3D MT_INTERFACE->pthread_child;
   while (cb)
     {
@@ -1713,12 +1784,12 @@ __pthread_join (pthread_t *thread, void=20
   if (!pthread::isGoodObject (thread))
     return ESRCH;
=20
-  if (__pthread_equal(thread,&joiner))
+  if (__pthread_equal (thread,&joiner))
     return EDEADLK;
=20
   (*thread)->mutex.Lock ();
=20
-  if((*thread)->attr.joinable =3D=3D PTHREAD_CREATE_DETACHED)
+  if ((*thread)->attr.joinable =3D=3D PTHREAD_CREATE_DETACHED)
     {
       (*thread)->mutex.UnLock ();
       return EINVAL;
@@ -2462,20 +2533,20 @@ __sem_post (sem_t *sem)
=20
 /* pthreadNull */
 pthread *
-pthreadNull::getNullpthread()
+pthreadNull::getNullpthread ()
 {
   /* because of weird entry points */
   _instance.magic =3D 0;
   return &_instance;
 }
=20
-pthreadNull::pthreadNull()
+pthreadNull::pthreadNull ()
 {
   /* Mark ourselves as invalid */
   magic =3D 0;
 }
=20
-pthreadNull::~pthreadNull()
+pthreadNull::~pthreadNull ()
 {
 }
=20
@@ -2522,7 +2593,7 @@ pthreadNull::pop_cleanup_handler (int co
 {
 }
 unsigned long
-pthreadNull::getsequence_np()
+pthreadNull::getsequence_np ()
 {
   return 0;
 }
Index: thread.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/thread.h,v
retrieving revision 1.41
diff -u -p -r1.41 thread.h
--- thread.h	16 Sep 2002 10:53:29 -0000	1.41
+++ thread.h	16 Sep 2002 11:41:36 -0000
@@ -178,11 +178,21 @@ class pthread_key:public verifyable_obje
 public:
=20
   DWORD dwTlsIndex;
+  void *fork_buf;
+  class pthread_key *next;
+
   int set (const void *);
   void *get ();
=20
     pthread_key (void (*)(void *));
    ~pthread_key ();
+  static void fixup_before_fork();
+  static void fixup_after_fork();
+private:
+  // lists of objects. USE THREADSAFE INSERTS AND DELETES.
+  static pthread_key * keys;
+  void saveKeyToBuffer ();
+  void recreateKeyFromBuffer ();
 };
=20
 /* FIXME: test using multiple inheritance and merging key_destructor into =
pthread_key
@@ -281,6 +291,9 @@ public:
=20
    static void initMainThread(pthread *, HANDLE);
    static bool isGoodObject(pthread_t *);
+   static void atforkprepare();
+   static void atforkparent();
+   static void atforkchild();
=20
    virtual void exit (void *value_ptr);
=20
@@ -421,12 +434,14 @@ public:
   callback *pthread_child;
   callback *pthread_parent;
=20
-  // list of mutex's. USE THREADSAFE INSERTS AND DELETES.
+  // lists of pthread objects. USE THREADSAFE INSERTS AND DELETES.
+  class pthread_key   * keys;
   class pthread_mutex * mutexs;
   class pthread_cond  * conds;
   class semaphore     * semaphores;
=20
   void Init (int);
+  void fixup_before_fork (void);
   void fixup_after_fork (void);
=20
   MTinterface ():reent_index (0), indexallocated (0), threadcount (1)
@@ -436,10 +451,6 @@ public:
       pthread_parent  =3D NULL;
     }
 };
-
-void __pthread_atforkprepare(void);
-void __pthread_atforkparent(void);
-void __pthread_atforkchild(void);
=20
 /* Cancellation */
 int __pthread_cancel (pthread_t thread);

--=-FaqlCVwFL0O3jy6Zu5Z7--

--=-FO65Sa9bwne4VquY9PWY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9hcQuI5+kQ8LJcoIRAmroAKCT+m1rxAhQ/ju23XXsJmMm1iKYDQCfV2aP
EFseOUfxouzV9p+MljU9DjA=
=EBwH
-----END PGP SIGNATURE-----

--=-FO65Sa9bwne4VquY9PWY--
