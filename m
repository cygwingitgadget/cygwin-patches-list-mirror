From: Mike Simons <msimons@moria.simons-clan.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] settimeofday ... attempt 2
Date: Tue, 20 Feb 2001 19:34:00 -0000
Message-id: <20010221021420.G16141@moria.simons-clan.com>
References: <20010219093133.F16141@moria.simons-clan.com> <20010219215508.C23483@redhat.com>
X-SW-Source: 2001-q1/msg00097.html

On Mon, Feb 19, 2001 at 09:55:08PM -0500, Christopher Faylor wrote:
> On Mon, Feb 19, 2001 at 09:31:33AM -0500, Mike Simons wrote:
> >  Let me know if there are any suggestions/problems...
> 
> See the contributing link at http://cygwin.com/ if you want to
> formally contribute this code.

  Thanks... 

  I can see I omitted a changelog entry, the -p on diff, and there is also
no IP sign over done as of now (but I think it's not needed for a change
of this size...).  If the IP sign over is needed in this case please say so.

from http://www.cygwin.com/contrib.html
]Please feel free to ask questions about any of this. We would love it
]if more people made useful contributions -- this can be one of the big
]advantages of free software; we all benefit from everyone else's work
]as well as our own...

  If you believe I've missed something else from the changes page please 
let me know, what is missing...

    TTFN,
      Mike

=====
  Here is the patch again with fixes format...

2001-02-18  Mike Simons  <msimons@moria.simons-clan.com>

        * times.cc (settimeofday): Replace function stub with working code.

msimons@truth:~/cygwin/src/winsup/cygwin$ cvs diff -up times.cc
Index: times.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/times.cc,v
retrieving revision 1.12
diff -u -p -r1.12 times.cc
--- times.cc    2000/10/28 05:41:43     1.12
+++ times.cc    2001/02/21 02:42:43
@@ -92,10 +92,29 @@ _times (struct tms * buf)

 /* settimeofday: BSD */
 extern "C" int
-settimeofday (const struct timeval *, const struct timezone *)
+settimeofday (const struct timeval *tv, const struct timezone *tz)
 {
-  set_errno (ENOSYS);
-  return -1;
+  SYSTEMTIME st;
+  struct tm *ptm;
+  int res;
+
+  tz = tz;                        /* silence warning about unused variable */
+
+  ptm = gmtime(&tv->tv_sec);
+  st.wYear         = ptm->tm_year + 1900;
+  st.wMonth        = ptm->tm_mon + 1;
+  st.wDayOfWeek    = ptm->tm_wday;
+  st.wDay          = ptm->tm_mday;
+  st.wHour         = ptm->tm_hour;
+  st.wMinute       = ptm->tm_min;
+  st.wSecond       = ptm->tm_sec;
+  st.wMilliseconds = tv->tv_usec / 1000;
+
+  res = !SetSystemTime(&st);
+
+  syscall_printf ("%d = settimeofday (%x, %x)", res, p, z);
+
+  return res;
 }

 /* timezone: standards? */
======================== END PATCH



==== notes on items from changes page.
How can I help out?

- Any changes you make should ideally be made to the current
    development sources.

  yes: code was checked out about 1 hour before diff made.

- If your change is going to be significant in terms of the size...
  you will have to sign over the copyright ownership ... your employer
  may also have to send us a disclaimer.

    If this is the problem it'll have to wait 4-6 months for shipping
  and handling.  Might have to wait for me to quit and rewrite the patch
  in a different way...

- you should probably join the cygwin-developers mailing list...

    no need: intend to fix things that are broke and affect me (nothing else)
  also sounded like a closed list from the mailing list page which would
  have been a hassle to subscribe.

- send a unified diff to the cygwin-patches list

  yes:

- send it to the cygwin-patches list in an email along with an
  explanation of what the change does.

  yes:

- include a ChangeLog entry

  nope: missed this one.

- diff -up

  nope: sent diff -u.  However, I can see no differnces between the
  two diffs for this patch.
