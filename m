From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] settimeofday ... attempt 1
Date: Mon, 19 Feb 2001 18:55:00 -0000
Message-id: <20010219215508.C23483@redhat.com>
References: <20010219093133.F16141@moria.simons-clan.com>
X-SW-Source: 2001-q1/msg00089.html

On Mon, Feb 19, 2001 at 09:31:33AM -0500, Mike Simons wrote:
>Morning all,
>
>  I am amazed at how well this library and tool chain works...
>
>  I have not attempted to build cygwin with the following patch.
>
>  I have built a ntpdate binary (from ntp-4.0.99j) for win95/98 
>which contains the code below in the ntp sources and that appears
>to correctly set the system time.  
>
>  Let me know if there are any suggestions/problems...

See the contributing link at http://cygwin.com/ if you want to
formally contribute this code.

cgf

>msimons@truth:~/cygwin/src/winsup/cygwin$ cvs diff -u times.cc
>Index: times.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/times.cc,v
>retrieving revision 1.12
>diff -u -r1.12 times.cc
>--- times.cc    2000/10/28 05:41:43     1.12
>+++ times.cc    2001/02/19 10:37:27
>@@ -92,10 +92,29 @@
>
> /* settimeofday: BSD */
> extern "C" int
>-settimeofday (const struct timeval *, const struct timezone *)
>+settimeofday (const struct timeval *tv, const struct timezone *tz)
> {
>-  set_errno (ENOSYS);
>-  return -1;
>+  SYSTEMTIME st;
>+  struct tm *ptm;
>+  int res;
>+
>+  tz = tz;
>+
>+  ptm = gmtime(&tv->tv_sec);
>+  st.wYear         = ptm->tm_year + 1900;
>+  st.wMonth        = ptm->tm_mon + 1;
>+  st.wDayOfWeek    = ptm->tm_wday;
>+  st.wDay          = ptm->tm_mday;
>+  st.wHour         = ptm->tm_hour;
>+  st.wMinute       = ptm->tm_min;
>+  st.wSecond       = ptm->tm_sec;
>+  st.wMilliseconds = tv->tv_usec / 1000;
>+
>+  res = !SetSystemTime(&st);
>+
>+  syscall_printf ("%d = settimeofday (%x, %x)", res, p, z);
>+
>+  return res;
> }
>
> /* timezone: standards? */

-- 
cgf@cygnus.com                        Red Hat, Inc.
http://sources.redhat.com/            http://www.redhat.com/
