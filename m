Return-Path: <cygwin-patches-return-2455-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 23751 invoked by alias); 18 Jun 2002 10:12:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23731 invoked from network); 18 Jun 2002 10:12:24 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Message-ID: <3D0F0777.EA957049@gmx.net>
Date: Tue, 18 Jun 2002 03:12:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
X-Accept-Language: en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Pthreads patches
References: <00a501c21207$d45a6480$0200a8c0@lifelesswks>
Content-Type: multipart/mixed;
 boundary="------------DB421978B10ED821C89E2CD0"
X-SW-Source: 2002-q2/txt/msg00438.txt.bz2

This is a multi-part message in MIME format.
--------------DB421978B10ED821C89E2CD0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 892

I am sorry, but i recognized that my patch was incomplete. The diff
included only threads.cc.
I have attached a new one.

Thomas

2002-06-12  Thomas Pfaff  <tpfaff@gmx.net>

	* thread.h (pthread::cleanup_stack): Renamed cleanup_handlers to
	cleanup_stack.
	* thread.cc (pthread::pthread): Ditto.
	(pthread::create): Fixed mutex verification.
	(pthread::push_cleanup_handler): Renamed cleanup_handlers to
	cleanup_stack.
	Mutex calls removed, used InterlockedExchangePointer instead.
	(pthread::pop_cleanup_handler): Renamed cleanup_handlers to
	cleanup_stack.
	(pthread::pop_all_cleanup_handlers): Ditto.
	(__pthread_once): Check state first and return if already done.
	(__pthread_join): DEADLOCK test reverted to __pthread_equal
	call.
	(__pthread_detach): Unlock mutex before deletion.

Robert Collins wrote:
> 
> I'll review this latest patch in ~20 hours. (i.e. tomorrow night).
> 
> Rob
--------------DB421978B10ED821C89E2CD0
Content-Type: text/plain; charset=us-ascii;
 name="pthread_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pthread_fix.patch"
Content-length: 4685

diff -urp src.old/winsup/cygwin/thread.cc src/winsup/cygwin/thread.cc
--- src.old/winsup/cygwin/thread.cc	Mon Jun 10 21:24:28 2002
+++ src/winsup/cygwin/thread.cc	Tue Jun 18 11:54:04 2002
@@ -355,7 +355,7 @@ pthread::self ()
 
 /* member methods */
 pthread::pthread ():verifyable_object (PTHREAD_MAGIC), win32_obj_id (0),
-cancelstate (0), canceltype (0), joiner (NULL), cleanup_handlers(NULL) 
+                    cancelstate (0), canceltype (0), joiner (NULL), cleanup_stack(NULL) 
 {
 }
 
@@ -370,6 +370,8 @@ void
 pthread::create (void *(*func) (void *), pthread_attr *newattr,
 		 void *threadarg)
 {
+  pthread_mutex *verifyable_mutex_obj = &mutex;
+
   /*already running ? */
   if (win32_obj_id)
     return;
@@ -384,7 +386,7 @@ pthread::create (void *(*func) (void *),
   function = func;
   arg = threadarg;
 
-  if (verifyable_object_isvalid (&mutex, PTHREAD_MUTEX_MAGIC) != VALID_OBJECT)
+  if (verifyable_object_isvalid (&verifyable_mutex_obj, PTHREAD_MUTEX_MAGIC) != VALID_OBJECT)
     {
       thread_printf ("New thread object access mutex is not valid. this %p",
 		     this);
@@ -417,10 +419,8 @@ pthread::push_cleanup_handler (__pthread
   if (this != self ())
     // TODO: do it?
     api_fatal ("Attempt to push a cleanup handler across threads"); 
-  mutex.Lock();
-  handler->next = cleanup_handlers;
-  cleanup_handlers = handler;
-  mutex.UnLock();
+  handler->next = cleanup_stack;
+  InterlockedExchangePointer( &cleanup_stack, handler );
 }
 
 void
@@ -430,21 +430,20 @@ pthread::pop_cleanup_handler (int const 
     // TODO: send a signal or something to the thread ?
     api_fatal ("Attempt to execute a cleanup handler across threads");
   
-  if (cleanup_handlers != NULL )
+  if (cleanup_stack != NULL)
     {
-      __pthread_cleanup_handler *handler = cleanup_handlers;
+      __pthread_cleanup_handler *handler = cleanup_stack;
 
       if (execute)
-	 (*handler->function) (handler->arg);
-
-      cleanup_handlers = handler->next;
+        (*handler->function) (handler->arg);
+      cleanup_stack = handler->next;
     }
 }
 
 void
 pthread::pop_all_cleanup_handlers ()
 {
-  while (cleanup_handlers != NULL)
+  while (cleanup_stack != NULL)
     pop_cleanup_handler (1);
 }
 
@@ -1015,6 +1014,10 @@ __pthread_create (pthread_t *thread, con
 int
 __pthread_once (pthread_once_t *once_control, void (*init_routine) (void))
 {
+  // already done ?
+  if (once_control->state)
+    return 0;
+
   pthread_mutex_lock (&once_control->mutex);
   /*Here we must set a cancellation handler to unlock the mutex if needed */
   /*but a cancellation handler is not the right thing. We need this in the thread
@@ -1022,7 +1025,7 @@ __pthread_once (pthread_once_t *once_con
    *at a time. Stote a mutex_t *in the pthread_structure. if that's non null unlock
    *on pthread_exit ();
    */
-  if (once_control->state == 0)
+  if (!once_control->state)
     {
       init_routine ();
       once_control->state = 1;
@@ -1556,7 +1559,7 @@ __pthread_exit (void *value_ptr)
   pthread * thread = pthread::self ();
 
   // run cleanup handlers
-  thread->pop_all_cleanup_handlers();
+  thread->pop_all_cleanup_handlers ();
 
   MT_INTERFACE->destructors.IterateNull ();
   
@@ -1581,23 +1584,21 @@ __pthread_join (pthread_t *thread, void 
 {
    pthread_t joiner = pthread::self ();
 
+   // Initialize return val with NULL
+   if (return_val)
+     *return_val = NULL;
+
   /*FIXME: wait on the thread cancellation event as well - we are a cancellation point*/
   if (verifyable_object_isvalid (thread, PTHREAD_MAGIC) != VALID_OBJECT)
     return ESRCH;
 
-  if ( joiner == *thread)    
-    {
-      if (return_val)
-        *return_val = NULL;
-      return EDEADLK;
-    }
+  if (__pthread_equal(thread,&joiner))
+    return EDEADLK;
 
   (*thread)->mutex.Lock ();
 
   if((*thread)->attr.joinable == PTHREAD_CREATE_DETACHED)
     {
-      if (return_val)
-        *return_val = NULL;
       (*thread)->mutex.UnLock ();
       return EINVAL;
     }
@@ -1640,8 +1641,11 @@ __pthread_detach (pthread_t *thread)
       (*thread)->mutex.UnLock ();
     }
   else
-    // thread has already terminated.
+    {
+      // thread has already terminated.
+      (*thread)->mutex.UnLock ();
       delete (*thread);
+    }
 
   return 0;
 }
diff -urp src.old/winsup/cygwin/thread.h src/winsup/cygwin/thread.h
--- src.old/winsup/cygwin/thread.h	Mon Jun 10 21:24:28 2002
+++ src/winsup/cygwin/thread.h	Tue Jun 18 11:55:49 2002
@@ -296,7 +296,7 @@ public:
 
 private:
     DWORD thread_id;
-    __pthread_cleanup_handler *cleanup_handlers;
+    __pthread_cleanup_handler *cleanup_stack;
     pthread_mutex mutex;
 
     friend void __pthread_exit (void *value_ptr);


--------------DB421978B10ED821C89E2CD0--
