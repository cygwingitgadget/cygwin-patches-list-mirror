Return-Path: <cygwin-patches-return-4479-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22389 invoked by alias); 6 Dec 2003 02:30:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22374 invoked from network); 6 Dec 2003 02:30:46 -0000
Message-Id: <3.0.5.32.20031205212917.008395e0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sat, 06 Dec 2003 02:30:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: Create Global Privilege
In-Reply-To: <20031205135429.GB3958@cygbert.vinschen.de>
References: <3.0.5.32.20031205080236.0082c420@incoming.verizon.net>
 <3.0.5.32.20031204221654.0082c250@incoming.verizon.net>
 <3.0.5.32.20031201225546.0082ce20@incoming.verizon.net>
 <20031129230722.GB6964@cygbert.vinschen.de>
 <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net>
 <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net>
 <3.0.5.32.20031126104557.00838210@incoming.verizon.net>
 <20031129230722.GB6964@cygbert.vinschen.de>
 <3.0.5.32.20031201225546.0082ce20@incoming.verizon.net>
 <3.0.5.32.20031204221654.0082c250@incoming.verizon.net>
 <3.0.5.32.20031205080236.0082c420@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1070695757==_"
X-SW-Source: 2003-q4/txt/msg00198.txt.bz2

--=====================_1070695757==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1299

At 02:54 PM 12/5/2003 +0100, Corinna Vinschen wrote:
>On Dec  5 08:02, Pierre A. Humblet wrote:
>> At 12:14 PM 12/5/2003 +0100, Corinna Vinschen wrote:
>> >Two questions:
>> >
>
>> >What is the advantage of using a finite loop with fcntl(F_SETLK) over
>> >using fcntl(F_SETLKW) just once?  This seems potentially less secure
>> >than F_SETLKW and also less secure than the former Mutex solution.
>> 
>> The only reason is that F_SETLKW doesn't work on 9X so you need
>> a loop there anyway. But thinking more about it, we should have both
>> F_SETLKW and a loop. On NT the loop will never kick in. On 9x F_SETLKW 
>> works like F_SETLK and the loop is useful. The loop could also be made
>> much longer.
>
>I agree.  Are you going to change your patch accordingly?

Sure, here it is. BTW, F_SETLKW is yucky, at least on NT4. Not only
the fcntl call isn't interruptible but the process itself can't be 
killed with kill -9 while waiting. The sig thread itself waits during
the close() call in the exit sequence.
Also a thread can deadlock by locking overlapping file segments.
This is FYI, it doesn't matter greatly here.   

Pierre

2003-12-06  Pierre Humblet <pierre.humblet@ieee.org>

	* syscalls.cc (locked_append): New.
	(updwtmp): Remove mutex code and call locked_append.
	(pututline): Ditto.

--=====================_1070695757==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="syscalls.cc.diff"
Content-length: 2765

Index: syscalls.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.301
diff -u -p -r1.301 syscalls.cc
--- syscalls.cc	28 Nov 2003 20:55:58 -0000	1.301
+++ syscalls.cc	6 Dec 2003 01:06:35 -0000
@@ -2553,28 +2553,37 @@ ffs (int i)
   return table[x >> a] + a;
 }

+static void
+locked_append (int fd, const void * buf, size_t size)
+{
+  struct __flock64 lock_buffer =3D {F_WRLCK, SEEK_SET, 0, 0, 0};
+  int count =3D 0;
+
+  do
+    if ((lock_buffer.l_start =3D lseek64 (fd, 0, SEEK_END)) !=3D (_off64_t=
)-1
+	&& fcntl_worker (fd, F_SETLKW, &lock_buffer) !=3D -1)
+      {
+	if (lseek64 (fd, 0, SEEK_END) !=3D (_off64_t)-1)
+	  write (fd, buf, size);
+	lock_buffer.l_type =3D F_UNLCK;
+	fcntl_worker (fd, F_SETLK, &lock_buffer);
+	break;
+      }
+  while (count++ < 1000
+	 && (errno =3D=3D EACCES || errno =3D=3D EAGAIN)
+	 && !usleep (1000));
+}
+
 extern "C" void
 updwtmp (const char *wtmp_file, const struct utmp *ut)
 {
-  /* Writing to wtmp must be atomic to prevent mixed up data. */
-  char mutex_name[CYG_MAX_PATH];
-  HANDLE mutex;
   int fd;

-  mutex =3D CreateMutex (NULL, FALSE, shared_name (mutex_name, "wtmp_mutex=
", 0));
-  if (mutex)
-    while (WaitForSingleObject (mutex, INFINITE) =3D=3D WAIT_ABANDONED)
-      ;
-  if ((fd =3D open (wtmp_file, O_WRONLY | O_APPEND | O_BINARY, 0)) >=3D 0)
+  if ((fd =3D open (wtmp_file, O_WRONLY | O_BINARY, 0)) >=3D 0)
     {
-      write (fd, ut, sizeof *ut);
+      locked_append (fd, ut, sizeof *ut);
       close (fd);
     }
-  if (mutex)
-    {
-      ReleaseMutex (mutex);
-      CloseHandle (mutex);
-    }
 }

 extern "C" void
@@ -2783,25 +2792,15 @@ pututline (struct utmp *ut)
 		ut->ut_type, ut->ut_pid, ut->ut_line, ut->ut_id);
   debug_printf ("ut->ut_user '%s', ut->ut_host '%s'\n",
 		ut->ut_user, ut->ut_host);
-  /* Read/write to utmp must be atomic to prevent overriding data
-     by concurrent processes. */
-  char mutex_name[CYG_MAX_PATH];
-  HANDLE mutex =3D CreateMutex (NULL, FALSE,
-			      shared_name (mutex_name, "utmp_mutex", 0));
-  if (mutex)
-    while (WaitForSingleObject (mutex, INFINITE) =3D=3D WAIT_ABANDONED)
-      ;
+
   struct utmp *u;
   if ((u =3D getutid (ut)))
-    lseek (utmp_fd, -sizeof *ut, SEEK_CUR);
-  else
-    lseek (utmp_fd, 0, SEEK_END);
-  write (utmp_fd, ut, sizeof *ut);
-  if (mutex)
     {
-      ReleaseMutex (mutex);
-      CloseHandle (mutex);
+      lseek (utmp_fd, -sizeof *ut, SEEK_CUR);
+      write (utmp_fd, ut, sizeof *ut);
     }
+  else
+    locked_append (utmp_fd, ut, sizeof *ut);
 }

 extern "C"

--=====================_1070695757==_--
