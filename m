Return-Path: <cygwin-patches-return-4475-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15096 invoked by alias); 5 Dec 2003 03:17:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15085 invoked from network); 5 Dec 2003 03:17:14 -0000
Message-Id: <3.0.5.32.20031204221654.0082c250@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Fri, 05 Dec 2003 03:17:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: Create Global Privilege
In-Reply-To: <20031202092639.GD1640@cygbert.vinschen.de>
References: <3.0.5.32.20031201225546.0082ce20@incoming.verizon.net>
 <20031129230722.GB6964@cygbert.vinschen.de>
 <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net>
 <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net>
 <3.0.5.32.20031126104557.00838210@incoming.verizon.net>
 <20031129230722.GB6964@cygbert.vinschen.de>
 <3.0.5.32.20031201225546.0082ce20@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1070612214==_"
X-SW-Source: 2003-q4/txt/msg00194.txt.bz2

--=====================_1070612214==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1345

At 10:26 AM 12/2/2003 +0100, Corinna Vinschen wrote:
>On Mon, Dec 01, 2003 at 10:55:46PM -0500, Pierre A. Humblet wrote:
>> Also, the utmp/wtmp functions use mutexes to insure safe access.
>> That creates two problems, particularly on servers:
>> - When users have private copies of Cygwin with different mounts,
>>   there can be several utmp/wtmp files. Having a global mutex isn't
>>   helpful.
>> - If the utmp/wtmp files are unique, a user may not be have the
>>   privilege to create a global mutex, so that no mutual protection
>>   is achieved.
>> Both problems could be solved very simply by using file locking.
>> Should I do that some day?
>
>Sure, go ahead.

Here it is.

In the case of wtmp, records are always appended.
A new function, "locked_append", avoids collisions.

In the case of utmp, if an entry for a tty already
exists, it is modified by the login/logout processes.
There is only one such process per tty, thus no
locking is required. If there is no entry for the tty,
a new one is safely created with the same 
"locked_append" function.

Because the lock is mandatory, reads of locked regions
will fail. The current code already handles that.

Pierre

2003-12-05  Pierre Humblet <pierre.humblet@ieee.org>

	* syscalls.cc (locked_append): New.
	(updwtmp): Remove mutex code and call locked_append.
	(pututline): Ditto.

--=====================_1070612214==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="syscalls.cc.diff"
Content-length: 2761

Index: syscalls.cc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.301
diff -u -p -r1.301 syscalls.cc
--- syscalls.cc	28 Nov 2003 20:55:58 -0000	1.301
+++ syscalls.cc	5 Dec 2003 03:10:55 -0000
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
+	&& fcntl_worker (fd, F_SETLK, &lock_buffer) !=3D -1)
+      {
+	if (lseek64 (fd, 0, SEEK_END) !=3D (_off64_t)-1)
+	  write (fd, buf, size);
+	lock_buffer.l_type =3D F_UNLCK;
+	fcntl_worker (fd, F_SETLK, &lock_buffer);
+	break;
+      }
+  while (count++ < 4
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

--=====================_1070612214==_--
