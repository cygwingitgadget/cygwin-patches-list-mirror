Return-Path: <cygwin-patches-return-2693-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9034 invoked by alias); 24 Jul 2002 05:23:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9019 invoked from network); 24 Jul 2002 05:23:28 -0000
Date: Tue, 23 Jul 2002 22:23:00 -0000
From: David MacMahon <cygwin@smartsc.com>
To: cygwin-patches@cygwin.com
Subject: time(time_t*) problem
Message-ID: <20020723223402.A2025@SmartSC.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q3/txt/msg00141.txt.bz2

Cygwin's implementation of the time(time_t*) function calls
to_time_t(FILETIME*) to compute the number of seconds since Jan 1 1970
from the number of 100ns since Jan 1 1601.  The to_time_t(FILETIME*)
function rounds the return value up or down to the nearest second.

This causes problems for programs like CVS that sleep until the next
second to ensure that subsequent file modifications will result in a
timestamp different from the pre-sleep time.

Because to_time_t() rounds up if the current time is more than half a
second past the beginning of the current second, time() can (and
approximately half of the time it will) return the "next though not yet
happening" second and CVS will think that it has waited long enough.
Unfortunately, it hasn't waited long enough and subsequent file
modifications that happen during the remainder of the current second
will result in modification times that are the same as the pre-sleep
time, thus defeating the purpose of the sleep.

The effects of this behavior can most readily be seen when running the
CVS regression test suite on a fast machine.  On a fast enough machine,
it is difficult to make it all the way through the test suite without
getting a failed test.  Examining the log file check.log reveals that
the test was expecting a CVS checkin message, but none was generated.
Further poking around reveals that the timestamp on the just modified
file is the same as the timestamp in the file's CVS/Entries entry.
FWIW, the only tests that should fail are test "168" and the binfiles
test that tries to do "admin -o" on a binary file.  Any other test that
fails will be fairly likely to succeed if the test is re-run.

Are there any programs that depend on the current behavior?  The only
reference I could find on the mailing lists was this one...

http://sources.redhat.com/ml/cygwin-patches/2002-q2/msg00308.html

...that talks about this behavior being done because of some purported
problems on FAT partitions, but I couldn't find any details about that
purported problem.  IMHO, to_time_t should *always* round down.  Below
is a patch that accomplishes that (sorry, I didn't do a Changelog
entry).  Of course, CSV could be patched (in src/subr.c:sleep_past()) to
sleep an extra second on Cygwin systems if this behavior is *really*
needed by Cygwin.

Dave

--- cygwin-1.3.12-2/winsup/cygwin/times.cc      2002-07-23 10:41:20.000000000 -0700
+++ cygwin-1.3.12-2-fix/winsup/cygwin/times.cc  2002-07-23 10:41:41.000000000 -0700
@@ -212,7 +212,6 @@
      stuffed into two long words.
      A time_t is the number of seconds since jan 1 1970.  */
 
-  long rem;
   long long x = ((long long) ptr->dwHighDateTime << 32) +
((unsigned)ptr->dwLowDateTime);
 
   /* pass "no time" as epoch */
@@ -220,10 +219,7 @@
     return 0;
 
   x -= FACTOR;                 /* number of 100ns between 1601 and 1970 */
-  rem = x % ((long long)NSPERSEC);
-  rem += (NSPERSEC / 2);
   x /= (long long) NSPERSEC;           /* number of 100ns in a second */
-  x += (long long) (rem / NSPERSEC);
   return x;
 }

-- 
David MacMahon, President
Smart Software Consulting
http://www.smartsc.com
