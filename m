Return-Path: <cygwin-patches-return-5364-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24347 invoked by alias); 4 Mar 2005 04:47:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24174 invoked from network); 4 Mar 2005 04:47:24 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.154.17)
  by sourceware.org with SMTP; 4 Mar 2005 04:47:24 -0000
Received: from [192.168.1.10] (helo=Compaq)
	by phumblet.no-ip.org with smtp (Exim 4.50)
	id ICT964-0001J0-ID
	for cygwin-patches@cygwin.com; Thu, 03 Mar 2005 23:45:48 -0500
Message-Id: <3.0.5.32.20050303234545.00b42bc0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Fri, 04 Mar 2005 04:47:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: Timer functions
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1109929545==_"
X-SW-Source: 2005-q1/txt/msg00067.txt.bz2

--=====================_1109929545==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1948

The attached patch implements the alarm, ualarm, setitimer and
getitimer with the timer_xxx calls created by Chris last year.

It has two objectives, both motivated by exim.
- The current implementation of alarm() opens a hidden window.
Thus, on Win9X, services calling alarm do not survive user logouts.
- When running exim as a service under a privileged (non system)
account on XP (trying out what's necessary on Win2003), I have hit
api_fatal ("couldn't create window, %E") with error 5.

The implementation of getitimer has necessitated the development
of timer_gettime (not yet exported) and some changes to the logic
of the timer_thread. I have also fixed a FIXME about race condition
and two bugs: 
- the initial code was not reusing the cygthreads (see attachment).
The fix involves using "auto_release" in the timer thread instead of 
"detach" in the calling function.
- the mu_to was not reinitialized on forks (non-inheritable event).

Pierre

2005-03-05  Pierre Humblet <pierre.humblet@ieee.org>

	* window.cc (getitimer): Delete.
	(setitimer): Ditto.
	(ualarm): Ditto.
	(alarm): Ditto.
	* timer.cc (struct timetracker): Delete it, flags and a creator.
	Add it_interval, interval_us, sleepto_us, running, init_muto(),
	and gettime().
	(timer_tracker::timer_tracker): Create event. Distinguish ttstart case.
	(timer_tracker::init_muto): New method.
	(to_us): Round up as per POSIX.
	(timer_thread): Reorganize to match timer_tracker::settime and 
	timer_tracker::gettime. Call sig_send without wait. Call th->auto_release.
	(timer_tracker::settime): Reorganize logic to avoid race.
	Call gettime to recover old value. Do not call th->detach. 
	(timer_tracker::gettime): New method.
	(timer_gettime): New function.
	(timer_delete): Stop the timer_thread, clear magic and close the event.
	(fixup_timers_after_fork): Reinit ttstart and the mu_to.
	(getitimer): New implementation.
	(setitimer): Ditto. 
	(ualarm): Ditto. 
	(alarm): Ditto.
--=====================_1109929545==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="timer.diff"
Content-length: 14652

Index: window.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/window.cc,v
retrieving revision 1.34
diff -u -p -r1.34 window.cc
--- window.cc	26 Nov 2004 04:15:09 -0000	1.34
+++ window.cc	4 Mar 2005 02:00:40 -0000
@@ -149,17 +149,6 @@ HWND ()
   return hwnd;
 }

-extern "C" int
-setitimer (int which, const struct itimerval *value, struct itimerval *old=
value)
-{
-  if (which !=3D ITIMER_REAL)
-    {
-      set_errno (ENOSYS);
-      return -1;
-    }
-  return winmsg.setitimer (value, oldvalue);
-}
-
 /* FIXME: Very racy */
 int __stdcall
 wininfo::setitimer (const struct itimerval *value, struct itimerval *oldva=
lue)
@@ -198,22 +187,6 @@ wininfo::setitimer (const struct itimerv
   return 0;
 }

-extern "C" int
-getitimer (int which, struct itimerval *value)
-{
-  if (which !=3D ITIMER_REAL)
-    {
-      set_errno (EINVAL);
-      return -1;
-    }
-  if (value =3D=3D NULL)
-    {
-      set_errno (EFAULT);
-      return -1;
-    }
-  return winmsg.getitimer (value);
-}
-
 /* FIXME: racy */
 int __stdcall
 wininfo::getitimer (struct itimerval *value)
@@ -236,39 +209,6 @@ wininfo::getitimer (struct itimerval *va
   return 0;
 }

-extern "C" unsigned int
-alarm (unsigned int seconds)
-{
-  int ret;
-  struct itimerval newt, oldt;
-
-  newt.it_value.tv_sec =3D seconds;
-  newt.it_value.tv_usec =3D 0;
-  newt.it_interval.tv_sec =3D 0;
-  newt.it_interval.tv_usec =3D 0;
-  setitimer (ITIMER_REAL, &newt, &oldt);
-  ret =3D oldt.it_value.tv_sec;
-  if (ret =3D=3D 0 && oldt.it_value.tv_usec)
-    ret =3D 1;
-  return ret;
-}
-
-extern "C" useconds_t
-ualarm (useconds_t value, useconds_t interval)
-{
-  struct itimerval timer, otimer;
-
-  timer.it_value.tv_sec =3D 0;
-  timer.it_value.tv_usec =3D value;
-  timer.it_interval.tv_sec =3D 0;
-  timer.it_interval.tv_usec =3D interval;
-
-  if (setitimer (ITIMER_REAL, &timer, &otimer) < 0)
-    return (u_int)-1;
-
-  return (otimer.it_value.tv_sec * 1000000) + otimer.it_value.tv_usec;
-}
-
 bool
 has_visible_window_station (void)
 {
Index: timer.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/timer.cc,v
retrieving revision 1.5
diff -u -p -r1.5 timer.cc
--- timer.cc	6 Jan 2005 16:33:59 -0000	1.5
+++ timer.cc	4 Mar 2005 02:00:49 -0000
@@ -26,25 +26,26 @@ struct timer_tracker
   unsigned magic;
   clockid_t clock_id;
   sigevent evp;
-  itimerspec it;
+  timespec it_interval;
   HANDLE cancel;
-  int flags;
+  long long interval_us;
+  long long sleepto_us;
   cygthread *th;
   struct timer_tracker *next;
+  volatile bool running;
+  void init_muto ();
   int settime (int, const itimerspec *, itimerspec *);
+  void gettime (bool, itimerspec *);
   timer_tracker (clockid_t, const sigevent *);
-  timer_tracker ();
 };

-timer_tracker ttstart;
+/* Used for the alarm, ualarm and setitimer calls.
+   Also serves as the head of the linked list.
+   The constructor initializes the shared protect. */
+timer_tracker ttstart (CLOCK_REALTIME, NULL);

 muto *timer_tracker::protect;

-timer_tracker::timer_tracker ()
-{
-  new_muto (protect);
-}
-
 timer_tracker::timer_tracker (clockid_t c, const sigevent *e)
 {
   if (e !=3D NULL)
@@ -56,104 +57,110 @@ timer_tracker::timer_tracker (clockid_t
       evp.sigev_value.sival_ptr =3D this;
     }
   clock_id =3D c;
-  cancel =3D NULL;
-  flags =3D 0;
-  memset (&it, 0, sizeof (it));
-  protect->acquire ();
-  next =3D ttstart.next;
-  ttstart.next =3D this;
-  protect->release ();
+  cancel =3D CreateEvent (&sec_none_nih, TRUE, FALSE, NULL);
+  if (this !=3D &ttstart)
+    {
+      protect->acquire ();
+      next =3D ttstart.next;
+      ttstart.next =3D this;
+      protect->release ();
+    }
+  else
+    init_muto ();
   magic =3D TT_MAGIC;
 }

+void
+timer_tracker::init_muto ()
+{
+  new_muto (protect);
+}
+
 static long long
-to_us (timespec& ts)
+to_us (const timespec& ts)
 {
   long long res =3D ts.tv_sec;
   res *=3D 1000000;
-  res +=3D ts.tv_nsec / 1000 + ((ts.tv_nsec % 1000) >=3D 500 ? 1 : 0);
+  res +=3D ts.tv_nsec / 1000 + ((ts.tv_nsec % 1000)? 1 : 0);
   return res;
 }

-static NO_COPY itimerspec itzero;
-static NO_COPY timespec tzero;
-
 static DWORD WINAPI
 timer_thread (VOID *x)
 {
   timer_tracker *tp =3D ((timer_tracker *) x);
-  timer_tracker tt =3D *tp;
-  for (bool first =3D true; ; first =3D false)
+  long long now, sleepto_us =3D  tp->sleepto_us;
+  while (1)
     {
-      long long sleep_us =3D to_us (first ? tt.it.it_value : tt.it.it_inte=
rval);
-      long long sleep_to =3D sleep_us;
-      long long now =3D gtod.usecs (false);
-      if (tt.flags & TIMER_ABSTIME)
-	sleep_us -=3D now;
+      long long sleep_us;
+      int sleep_ms;
+      /* Account for delays in starting thread
+	 and sending the signal */
+      now =3D gtod.usecs (false);
+      sleep_us =3D sleepto_us - now;
+      if (sleep_us > 0)
+	{
+	  tp->sleepto_us =3D sleepto_us;
+	  sleep_ms =3D (sleep_us + 999) / 1000;
+	}
       else
-	sleep_to +=3D now;
-
-      DWORD sleep_ms =3D (sleep_us < 0) ? 0 : (sleep_us / 1000);
-      debug_printf ("%p waiting for %u ms, first %d", x, sleep_ms, first);
-      tp->it.it_value =3D tzero;
-      switch (WaitForSingleObject (tt.cancel, sleep_ms))
+	{
+	  tp->sleepto_us =3D now;
+	  sleep_ms =3D 0;
+	}
+      debug_printf ("%p waiting for %u ms", x, sleep_ms);
+      switch (WaitForSingleObject (tp->cancel, sleep_ms))
 	{
 	case WAIT_TIMEOUT:
 	  debug_printf ("timed out");
 	  break;
 	case WAIT_OBJECT_0:
-	  now =3D gtod.usecs (false);
-	  sleep_us =3D sleep_to - now;
-	  if (sleep_us < 0)
-	    sleep_us =3D 0;
-	  tp->it.it_value.tv_sec =3D sleep_us / 1000000;
-	  tp->it.it_value.tv_nsec =3D (sleep_us % 1000000) * 1000;
-	  debug_printf ("%p cancelled, elapsed %D", x, sleep_us);
+	  debug_printf ("%p time wait cancelled", x);
 	  goto out;
 	default:
 	  debug_printf ("%p timer wait failed, %E", x);
 	  goto out;
 	}

-      switch (tt.evp.sigev_notify)
+      switch (tp->evp.sigev_notify)
 	{
 	case SIGEV_SIGNAL:
 	  {
 	    siginfo_t si;
 	    memset (&si, 0, sizeof (si));
-	    si.si_signo =3D tt.evp.sigev_signo;
-	    si.si_sigval.sival_ptr =3D tt.evp.sigev_value.sival_ptr;
-	    debug_printf ("%p sending sig %d", x, tt.evp.sigev_signo);
-	    sig_send (NULL, si);
+	    si.si_signo =3D tp->evp.sigev_signo;
+	    si.si_sigval.sival_ptr =3D tp->evp.sigev_value.sival_ptr;
+	    debug_printf ("%p sending sig %d", x, tp->evp.sigev_signo);
+	    sig_send (myself_nowait, si);
 	    break;
 	  }
 	case SIGEV_THREAD:
 	  {
 	    pthread_t notify_thread;
 	    debug_printf ("%p starting thread", x);
-	    int rc =3D pthread_create (&notify_thread, tt.evp.sigev_notify_attrib=
utes,
-				     (void * (*) (void *)) tt.evp.sigev_notify_function,
-				     tt.evp.sigev_value.sival_ptr);
+	    int rc =3D pthread_create (&notify_thread, tp->evp.sigev_notify_attri=
butes,
+				     (void * (*) (void *)) tp->evp.sigev_notify_function,
+				     tp->evp.sigev_value.sival_ptr);
 	    if (rc)
 	      {
 		debug_printf ("thread creation failed, %E");
-		return 0;
+		goto out;
 	      }
 	    // FIXME: pthread_join?
 	    break;
 	  }
 	}
-      if (!tt.it.it_interval.tv_sec && !tt.it.it_interval.tv_nsec)
+      if (!tp->interval_us)
 	break;
-      tt.flags =3D 0;
+
+      sleepto_us =3D tp->sleepto_us + tp->interval_us;
       debug_printf ("looping");
     }

 out:
-  CloseHandle (tt.cancel);
-  // FIXME: race here but is it inevitable?
-  if (tt.cancel =3D=3D tp->cancel)
-    tp->cancel =3D NULL;
+  tp->th->auto_release ();
+  /* Don't access tp after this */
+  tp->running =3D false;
   return 0;
 }

@@ -177,40 +184,61 @@ timer_tracker::settime (int in_flags, co
       return -1;
     }

-  if (__check_invalid_read_ptr_errno (value, sizeof (*value)))
+  if (__check_invalid_read_ptr_errno (value, sizeof (*value))
+      || it_bad (value->it_value)
+      || it_bad (value->it_interval)
+      || (ovalue && check_null_invalid_struct_errno (ovalue)))
     return -1;

-  if (ovalue && check_null_invalid_struct_errno (ovalue))
-    return -1;
+  long long now =3D in_flags & TIMER_ABSTIME ? 0 : gtod.usecs (false);

-  itimerspec *elapsed;
-  if (!cancel)
-    elapsed =3D &itzero;
-  else
+  timer_tracker::protect->acquire ();
+
+  bool old_running =3D running;
+  if (running)
     {
       SetEvent (cancel);	// should be closed when the thread exits
-      th->detach ();
-      elapsed =3D &it;
+      while (running)
+	low_priority_sleep (0);
     }

   if (ovalue)
-    *ovalue =3D *elapsed;
+    gettime (old_running, ovalue);

   if (value->it_value.tv_sec || value->it_value.tv_nsec)
+    running =3D true;
+
+  timer_tracker::protect->release ();
+
+  if (running)
     {
-      if (it_bad (value->it_value))
-	return -1;
-      if (it_bad (value->it_interval))
-	return -1;
-      flags =3D in_flags;
-      cancel =3D CreateEvent (&sec_none_nih, TRUE, FALSE, NULL);
-      it =3D *value;
+      sleepto_us =3D now + to_us (value->it_value);
+      interval_us =3D to_us (value->it_interval);
+      it_interval =3D value->it_interval;
+      ResetEvent (cancel);
       th =3D new cygthread (timer_thread, this, "itimer");
     }

   return 0;
 }

+void
+timer_tracker::gettime (bool force, itimerspec *ovalue)
+{
+  if (running || force)
+    {
+      ovalue->it_interval =3D it_interval;
+      long long now =3D gtod.usecs (false);
+      long long left_us =3D sleepto_us - now;
+      if (left_us < 0)
+	left_us =3D 0;
+      ovalue->it_value.tv_sec =3D left_us / 1000000;
+      ovalue->it_value.tv_nsec =3D (left_us % 1000000) * 1000;
+    }
+  else
+    memset (ovalue, 0, sizeof (*ovalue));
+}
+
 extern "C" int
 timer_create (clockid_t clock_id, struct sigevent *evp, timer_t *timerid)
 {
@@ -240,19 +268,37 @@ timer_settime (timer_t timerid, int flag
 }

 extern "C" int
+timer_gettime (timer_t timerid, struct itimerspec *ovalue)
+{
+  if (check_null_invalid_struct_errno (ovalue))
+    return -1;
+
+  timer_tracker *tt =3D (timer_tracker *) timerid;
+  if (check_null_invalid_struct_errno (tt) || tt->magic !=3D TT_MAGIC)
+    return -1;
+
+  tt->gettime (false, ovalue);
+  return 0;
+}
+
+extern "C" int
 timer_delete (timer_t timerid)
 {
   timer_tracker *in_tt =3D (timer_tracker *) timerid;
   if (check_null_invalid_struct_errno (in_tt) || in_tt->magic !=3D TT_MAGI=
C)
     return -1;

+  struct itimerspec value =3D {};
+  in_tt->settime (0, &value, NULL);
+
   timer_tracker::protect->acquire ();
   for (timer_tracker *tt =3D &ttstart; tt->next !=3D NULL; tt =3D tt->next)
     if (tt->next =3D=3D in_tt)
       {
-	timer_tracker *deleteme =3D tt->next;
-	tt->next =3D deleteme->next;
-	delete deleteme;
+	tt->next =3D in_tt->next;
+	CloseHandle (in_tt->cancel);
+	in_tt->magic =3D 0;
+	delete in_tt;
 	timer_tracker::protect->release ();
 	return 0;
       }
@@ -265,6 +311,9 @@ timer_delete (timer_t timerid)
 void
 fixup_timers_after_fork ()
 {
+  ttstart.running =3D false;
+  ttstart.cancel =3D CreateEvent (&sec_none_nih, TRUE, FALSE, NULL);
+  ttstart.init_muto();
   for (timer_tracker *tt =3D &ttstart; tt->next !=3D NULL; /* nothing */)
     {
       timer_tracker *deleteme =3D tt->next;
@@ -272,3 +321,95 @@ fixup_timers_after_fork ()
       delete deleteme;
     }
 }
+
+
+extern "C" int
+setitimer (int which, const struct itimerval *value, struct itimerval *ova=
lue)
+{
+  if (which !=3D ITIMER_REAL)
+    {
+      set_errno (EINVAL);
+      return -1;
+    }
+  struct itimerspec spec_value, spec_ovalue;
+  int ret;
+  spec_value.it_interval.tv_sec =3D value->it_interval.tv_sec;
+  spec_value.it_interval.tv_nsec =3D value->it_interval.tv_usec * 1000;
+  spec_value.it_value.tv_sec =3D value->it_value.tv_sec;
+  spec_value.it_value.tv_nsec =3D value->it_value.tv_usec * 1000;
+  ret =3D timer_settime ((timer_t) &ttstart, 0, &spec_value, &spec_ovalue);
+  if (!ret && ovalue)
+    {
+      ovalue->it_interval.tv_sec =3D spec_ovalue.it_interval.tv_sec;
+      ovalue->it_interval.tv_usec =3D spec_ovalue.it_interval.tv_nsec / 10=
00;
+      ovalue->it_value.tv_sec =3D spec_ovalue.it_value.tv_sec;
+      ovalue->it_value.tv_usec =3D spec_ovalue.it_value.tv_nsec / 1000;
+    }
+  syscall_printf ("%d =3D setitimer ()", ret);
+  return ret;
+}
+
+
+extern "C" int
+getitimer (int which, struct itimerval *ovalue)
+{
+  if (which !=3D ITIMER_REAL)
+    {
+      set_errno (EINVAL);
+      return -1;
+    }
+  if (ovalue =3D=3D NULL)
+    {
+      set_errno (EFAULT);
+      return -1;
+    }
+  struct itimerspec spec_ovalue;
+  int ret =3D timer_gettime ((timer_t) &ttstart, &spec_ovalue);
+  if (!ret)
+    {
+      ovalue->it_interval.tv_sec =3D spec_ovalue.it_interval.tv_sec;
+      ovalue->it_interval.tv_usec =3D spec_ovalue.it_interval.tv_nsec / 10=
00;
+      ovalue->it_value.tv_sec =3D spec_ovalue.it_value.tv_sec;
+      ovalue->it_value.tv_usec =3D spec_ovalue.it_value.tv_nsec / 1000;
+    }
+  syscall_printf ("%d =3D getitimer ()", ret);
+  return ret;
+}
+
+/* FIXME: POSIX - alarm survives exec */
+ extern "C" unsigned int
+ alarm (unsigned int seconds)
+ {
+   struct itimerspec newt =3D {}, oldt;
+   /* alarm cannot fail, but only needs not be
+      correct for arguments < 64k. Truncate */
+   if (seconds > (HIRES_DELAY_MAX / 1000 - 1))
+     seconds =3D (HIRES_DELAY_MAX / 1000 - 1);
+   newt.it_value.tv_sec =3D seconds;
+   timer_settime ((timer_t) &ttstart, 0, &newt, &oldt);
+   int ret =3D oldt.it_value.tv_sec + (oldt.it_value.tv_nsec > 0);
+   syscall_printf ("%d =3D alarm (%d)", ret, seconds);
+   return ret;
+ }
+
+ extern "C" useconds_t
+ ualarm (useconds_t value, useconds_t interval)
+ {
+   struct itimerspec timer =3D {}, otimer;
+   /* ualarm cannot fail.
+      Interpret negative arguments as zero */
+   if (value > 0)
+     {
+       timer.it_value.tv_sec =3D (unsigned int) value / 1000000;
+       timer.it_value.tv_nsec =3D ((unsigned int) value % 1000000) * 1000;
+     }
+   if (interval > 0)
+     {
+       timer.it_interval.tv_sec =3D (unsigned int) interval / 1000000;
+       timer.it_interval.tv_nsec =3D ((unsigned int) interval % 1000000) *=
 1000;
+     }
+   timer_settime ((timer_t) &ttstart, 0, &timer, &otimer);
+   useconds_t ret =3D otimer.it_value.tv_sec * 1000000 + (otimer.it_value.=
tv_nsec + 999) / 1000;
+   syscall_printf ("%d =3D ualarm (%d , %d)", ret, value, interval);
+   return ret;
+ }

--=====================_1109929545==_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="timer_trace.txt"
Content-length: 2911

  243   44481 [itimer] a 3816 cygthread::stub: thread 'itimer', id 0xD40, stack_ptr 0xD5F000
  124  151742 [itimer] a 3816 cygthread::stub: thread 'itimer', id 0x818, stack_ptr 0xFDF000
  115  258151 [itimer] a 3816 cygthread::stub: thread 'itimer', id 0x92C, stack_ptr 0x11DF000
  111  364953 [itimer] a 3816 cygthread::stub: thread 'itimer', id 0xF3C, stack_ptr 0x13DF000
  116  471052 [itimer] a 3816 cygthread::stub: thread 'itimer', id 0xAC0, stack_ptr 0x15DF000
  120  577517 [itimer] a 3816 cygthread::stub: thread 'itimer', id 0x7C, stack_ptr 0x17DF000
  117  684920 [itimer] a 3816 cygthread::stub: thread 'itimer', id 0x7C0, stack_ptr 0x19DF000
  123  791396 [itimer] a 3816 cygthread::stub: thread 'itimer', id 0xAFC, stack_ptr 0x1BDF000
  122  898771 [itimer] a 3816 cygthread::stub: thread 'itimer', id 0x890, stack_ptr 0x1DDF000
  129 1006225 [itimer] a 3816 cygthread::stub: thread 'itimer', id 0xC50, stack_ptr 0x1FDF000
  128 1113638 [itimer] a 3816 cygthread::stub: thread 'itimer', id 0x100, stack_ptr 0x21DF000
  132 1221077 [itimer] a 3816 cygthread::stub: thread 'itimer', id 0x260, stack_ptr 0x23DF000
  128 1328477 [itimer] a 3816 cygthread::stub: thread 'itimer', id 0xC48, stack_ptr 0x25DF000
  137 1435952 [itimer] a 3816 cygthread::stub: thread 'itimer', id 0xE90, stack_ptr 0x27DF000
  134 1543332 [itimer] a 3816 cygthread::stub: thread 'itimer', id 0xD88, stack_ptr 0x29DF000
  140 1650793 [itimer] a 3816 cygthread::stub: thread 'itimer', id 0xDA8, stack_ptr 0x2BDF000
  134 1757198 [itimer] a 3816 cygthread::stub: thread 'itimer', id 0xB04, stack_ptr 0x2DDF000
  130 1864621 [itimer] a 3816 cygthread::stub: thread 'itimer', id 0xFB8, stack_ptr 0x2FDF000
  119 1972042 [itimer] a 3816 cygthread::stub: thread 'itimer', id 0xDDC, stack_ptr 0x31DF000
  129 2079541 [itimer] a 3816 cygthread::stub: thread 'itimer', id 0xA8C, stack_ptr 0x33DF000
  247 2187074 [itimer] a 3816 cygthread::stub: thread 'itimer', id 0xF70, stack_ptr 0x35DF000
  148 2302155 [itimer] a 3816 cygthread::stub: thread 'itimer', id 0x8C4, stack_ptr 0x37DF000
  145 2409578 [itimer] a 3816 cygthread::stub: thread 'itimer', id 0x304, stack_ptr 0x39DF000
  156 2517047 [itimer] a 3816 cygthread::stub: thread 'itimer', id 0xBBC, stack_ptr 0x3BDF000
  379 2624360 [itimer] a 3816 cygthread::stub: thread 'itimer', id 0xB14, stack_ptr 0x3DDF000
  355 2731756 [itimer] a 3816 cygthread::stub: thread 'itimer', id 0xC68, stack_ptr 0x3FDF000
  404 2839224 [itimer] a 3816 cygthread::stub: thread 'itimer', id 0x384, stack_ptr 0x41DF000
  468 2946713 [itimer] a 3816 cygthread::stub: thread 'itimer', id 0x848, stack_ptr 0x43DF000
  467 3054131 [itimer] a 3816 cygthread::stub: thread 'itimer', id 0x2CC, stack_ptr 0x45DF000
  386 3161463 [itimer] a 3816 cygthread::stub: thread 'itimer', id 0xD9C, stack_ptr 0x47DF000
  404 3268923 [itimer] a 3816 cygthread::stub: thread 'itimer', id 0x4F0, stack_ptr 0x49DF000

--=====================_1109929545==_--
