Return-Path: <cygwin-patches-return-1709-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28897 invoked by alias); 16 Jan 2002 22:24:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28586 invoked from network); 16 Jan 2002 22:24:25 -0000
Message-ID: <177e01c19edc$88d9bf90$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <newlib-patches@sources.redhat.com>,
	<cygwin-patches@cygwin.com>
Subject: strptime
Date: Wed, 16 Jan 2002 14:24:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_177B_01C19F38.BBBDD610"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 16 Jan 2002 22:24:22.0910 (UTC) FILETIME=[8C6E09E0:01C19EDC]
X-SW-Source: 2002-q1/txt/msg00066.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_177B_01C19F38.BBBDD610
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 330

Herewith, one patch for each list.

Changelogs for quick glancing:
Newlib:
2002-01-17  Robert Collins  <rbtcollins@hotmail.com>

        * libc/include/time.h: Add prototype for strptime for Cygwin.

Cygwin:
2002-01-17  Robert Collins  <rbtcollins@hotmail.com>

        * times.cc: Run indent.
        Add strptime function.

Rob

------=_NextPart_000_177B_01C19F38.BBBDD610
Content-Type: application/octet-stream;
	name="strptime.newlibChangeLog"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="strptime.newlibChangeLog"
Content-length: 136

2002-01-17  Robert Collins  <rbtcollins@hotmail.com>=0A=
=0A=
        * libc/include/time.h: Add prototype for strptime for Cygwin.=0A=

------=_NextPart_000_177B_01C19F38.BBBDD610
Content-Type: application/octet-stream;
	name="strptime.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="strptime.patch"
Content-length: 771

Index: include/time.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/newlib/libc/include/time.h,v=0A=
retrieving revision 1.5=0A=
diff -u -p -r1.5 time.h=0A=
--- time.h	2001/04/19 15:54:47	1.5=0A=
+++ time.h	2002/01/16 22:17:51=0A=
@@ -62,6 +62,7 @@ struct tm *_EXFUN(gmtime_r,	(const time_=0A=
 struct tm *_EXFUN(localtime_r,	(const time_t *, struct tm *));=0A=
=20=0A=
 #ifdef __CYGWIN__=0A=
+char      *_EXFUN(strptime,     (const char *, const char *, struct tm *))=
;=0A=
 #ifndef __STRICT_ANSI__=0A=
 extern __IMPORT time_t _timezone;=0A=
 extern __IMPORT int _daylight;=0A=

------=_NextPart_000_177B_01C19F38.BBBDD610
Content-Type: application/octet-stream;
	name="cygstrptime.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cygstrptime.patch"
Content-length: 18439

Index: cygwin.din=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v=0A=
retrieving revision 1.37.2.4=0A=
diff -u -p -r1.37.2.4 cygwin.din=0A=
--- cygwin.din	2002/01/04 03:56:06	1.37.2.4=0A=
+++ cygwin.din	2002/01/16 22:12:34=0A=
@@ -777,6 +778,7 @@ strncpy=0A=
 _strncpy =3D strncpy=0A=
 strpbrk=0A=
 _strpbrk =3D strpbrk=0A=
+strptime=0A=
 strrchr=0A=
 _strrchr =3D strrchr=0A=
 strspn=0A=
Index: times.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/times.cc,v=0A=
retrieving revision 1.23.2.1=0A=
diff -u -p -r1.23.2.1 times.cc=0A=
--- times.cc	2002/01/15 12:52:52	1.23.2.1=0A=
+++ times.cc	2002/01/16 22:12:34=0A=
@@ -24,36 +24,41 @@ details. */=0A=
 #include "sync.h"=0A=
 #include "sigproc.h"=0A=
 #include "pinfo.h"=0A=
+#include <ctype.h>=0A=
=20=0A=
 #define FACTOR (0x19db1ded53e8000LL)=0A=
 #define NSPERSEC 10000000LL=0A=
=20=0A=
-static void __stdcall timeval_to_filetime (timeval *time, FILETIME *out);=
=0A=
+static void __stdcall timeval_to_filetime (timeval * time, FILETIME * out)=
;=0A=
=20=0A=
 /* Cygwin internal */=0A=
 static unsigned long long __stdcall=0A=
 __to_clock_t (FILETIME * src, int flag)=0A=
 {=0A=
-  unsigned long long total =3D ((unsigned long long) src->dwHighDateTime <=
< 32) + ((unsigned)src->dwLowDateTime);=0A=
-  syscall_printf ("dwHighDateTime %u, dwLowDateTime %u", src->dwHighDateTi=
me, src->dwLowDateTime);=0A=
+  unsigned long long total =3D=0A=
+    ((unsigned long long) src->dwHighDateTime << 32) +=0A=
+    ((unsigned) src->dwLowDateTime);=0A=
+  syscall_printf ("dwHighDateTime %u, dwLowDateTime %u", src->dwHighDateTi=
me,=0A=
+		  src->dwLowDateTime);=0A=
=20=0A=
   /* Convert into clock ticks - the total is in 10ths of a usec.  */=0A=
   if (flag)=0A=
     total -=3D FACTOR;=0A=
=20=0A=
   total /=3D (unsigned long long) (NSPERSEC / CLOCKS_PER_SEC);=0A=
-  syscall_printf ("total %08x %08x\n", (unsigned)(total>>32), (unsigned)(t=
otal));=0A=
+  syscall_printf ("total %08x %08x\n", (unsigned) (total >> 32),=0A=
+		  (unsigned) (total));=0A=
   return total;=0A=
 }=0A=
=20=0A=
 /* times: POSIX 4.5.2.1 */=0A=
 extern "C" clock_t=0A=
-times (struct tms * buf)=0A=
+times (struct tms *buf)=0A=
 {=0A=
   FILETIME creation_time, exit_time, kernel_time, user_time;=0A=
=20=0A=
   if (check_null_invalid_struct_errno (buf))=0A=
-    return ((clock_t) -1);=0A=
+    return ((clock_t) - 1);=0A=
=20=0A=
   DWORD ticks =3D GetTickCount ();=0A=
   /* Ticks is in milliseconds, convert to our ticks. Use long long to prev=
ent=0A=
@@ -65,8 +70,9 @@ times (struct tms * buf)=0A=
 		       &kernel_time, &user_time);=0A=
=20=0A=
       syscall_printf ("ticks %d, CLOCKS_PER_SEC %d", ticks, CLOCKS_PER_SEC=
);=0A=
-      syscall_printf ("user_time %d, kernel_time %d, creation_time %d, exi=
t_time %d",=0A=
-		      user_time, kernel_time, creation_time, exit_time);=0A=
+      syscall_printf=0A=
+	("user_time %d, kernel_time %d, creation_time %d, exit_time %d",=0A=
+	 user_time, kernel_time, creation_time, exit_time);=0A=
       buf->tms_stime =3D __to_clock_t (&kernel_time, 0);=0A=
       buf->tms_utime =3D __to_clock_t (&user_time, 0);=0A=
       timeval_to_filetime (&myself->rusage_children.ru_stime, &kernel_time=
);=0A=
@@ -85,11 +91,11 @@ times (struct tms * buf)=0A=
       buf->tms_cutime =3D 0;=0A=
     }=0A=
=20=0A=
-   return tc;=0A=
+  return tc;=0A=
 }=0A=
=20=0A=
 extern "C" clock_t=0A=
-_times (struct tms * buf)=0A=
+_times (struct tms *buf)=0A=
 {=0A=
   return times (buf);=0A=
 }=0A=
@@ -104,17 +110,17 @@ settimeofday (const struct timeval *tv,=20=0A=
=20=0A=
   tz =3D tz;			/* silence warning about unused variable */=0A=
=20=0A=
-  ptm =3D gmtime(&tv->tv_sec);=0A=
-  st.wYear	   =3D ptm->tm_year + 1900;=0A=
-  st.wMonth	   =3D ptm->tm_mon + 1;=0A=
-  st.wDayOfWeek    =3D ptm->tm_wday;=0A=
-  st.wDay	   =3D ptm->tm_mday;=0A=
-  st.wHour	   =3D ptm->tm_hour;=0A=
-  st.wMinute       =3D ptm->tm_min;=0A=
-  st.wSecond       =3D ptm->tm_sec;=0A=
+  ptm =3D gmtime (&tv->tv_sec);=0A=
+  st.wYear =3D ptm->tm_year + 1900;=0A=
+  st.wMonth =3D ptm->tm_mon + 1;=0A=
+  st.wDayOfWeek =3D ptm->tm_wday;=0A=
+  st.wDay =3D ptm->tm_mday;=0A=
+  st.wHour =3D ptm->tm_hour;=0A=
+  st.wMinute =3D ptm->tm_min;=0A=
+  st.wSecond =3D ptm->tm_sec;=0A=
   st.wMilliseconds =3D tv->tv_usec / 1000;=0A=
=20=0A=
-  res =3D !SetSystemTime(&st);=0A=
+  res =3D !SetSystemTime (&st);=0A=
=20=0A=
   syscall_printf ("%d =3D settimeofday (%x, %x)", res, tv, tz);=0A=
=20=0A=
@@ -126,26 +132,27 @@ extern "C" char *=0A=
 timezone ()=0A=
 {=0A=
 #ifdef _MT_SAFE=0A=
-  char *b=3D_reent_winsup()->timezone_buf;=0A=
+  char *b =3D _reent_winsup ()->timezone_buf;=0A=
 #else=0A=
-  static NO_COPY char b[20] =3D {0};=0A=
+  static NO_COPY char b[20] =3D { 0 };=0A=
 #endif=0A=
=20=0A=
-  tzset();=0A=
-  __small_sprintf (b,"GMT%+d:%02d", (int) (-_timezone / 3600), (int) (abs(=
_timezone / 60) % 60));=0A=
+  tzset ();=0A=
+  __small_sprintf (b, "GMT%+d:%02d", (int) (-_timezone / 3600),=0A=
+		   (int) (abs (_timezone / 60) % 60));=0A=
   return b;=0A=
 }=0A=
=20=0A=
 /* Cygwin internal */=0A=
 void __stdcall=0A=
-totimeval (struct timeval *dst, FILETIME *src, int sub, int flag)=0A=
+totimeval (struct timeval *dst, FILETIME * src, int sub, int flag)=0A=
 {=0A=
   long long x =3D __to_clock_t (src, flag);=0A=
=20=0A=
-  x *=3D (int) (1e6) / CLOCKS_PER_SEC; /* Turn x into usecs */=0A=
-  x -=3D (long long) sub * (int) (1e6);=0A=
+  x *=3D (int) (1e6) / CLOCKS_PER_SEC;	/* Turn x into usecs */=0A=
+  x -=3D (long long) sub *(int) (1e6);=0A=
=20=0A=
-  dst->tv_usec =3D x % (long long) (1e6); /* And split */=0A=
+  dst->tv_usec =3D x % (long long) (1e6);	/* And split */=0A=
   dst->tv_sec =3D x / (long long) (1e6);=0A=
 }=0A=
=20=0A=
@@ -165,7 +172,7 @@ gettimeofday (struct timeval *p, struct=20=0A=
=20=0A=
   if (z !=3D NULL)=0A=
     {=0A=
-      tzset();=0A=
+      tzset ();=0A=
       z->tz_minuteswest =3D _timezone / 60;=0A=
       z->tz_dsttime =3D _daylight;=0A=
     }=0A=
@@ -175,8 +182,7 @@ gettimeofday (struct timeval *p, struct=20=0A=
   return res;=0A=
 }=0A=
=20=0A=
-extern "C"=0A=
-int=0A=
+extern "C" int=0A=
 _gettimeofday (struct timeval *p, struct timezone *z)=0A=
 {=0A=
   return gettimeofday (p, z);=0A=
@@ -198,15 +204,13 @@ genf ()=0A=
   s.wMilliseconds =3D 0;=0A=
   SystemTimeToFileTime (&s, &f);=0A=
=20=0A=
-  small_printf ("FILE TIME is %08x%08x\n",=0A=
-	       f.dwHighDateTime,=0A=
-	       f.dwLowDateTime);=0A=
+  small_printf ("FILE TIME is %08x%08x\n", f.dwHighDateTime, f.dwLowDateTi=
me);=0A=
 }=0A=
 #endif=0A=
=20=0A=
 /* Cygwin internal */=0A=
 void=0A=
-time_t_to_filetime (time_t time_in, FILETIME *out)=0A=
+time_t_to_filetime (time_t time_in, FILETIME * out)=0A=
 {=0A=
   long long x =3D time_in * NSPERSEC + FACTOR;=0A=
   out->dwHighDateTime =3D x >> 32;=0A=
@@ -215,10 +219,10 @@ time_t_to_filetime (time_t time_in, FILE=0A=
=20=0A=
 /* Cygwin internal */=0A=
 static void __stdcall=0A=
-timeval_to_filetime (timeval *time_in, FILETIME *out)=0A=
+timeval_to_filetime (timeval * time_in, FILETIME * out)=0A=
 {=0A=
   long long x =3D time_in->tv_sec * NSPERSEC +=0A=
-			time_in->tv_usec * (NSPERSEC/1000000) + FACTOR;=0A=
+    time_in->tv_usec * (NSPERSEC / 1000000) + FACTOR;=0A=
   out->dwHighDateTime =3D x >> 32;=0A=
   out->dwLowDateTime =3D x;=0A=
 }=0A=
@@ -236,31 +240,31 @@ time_t_to_timeval (time_t in)=0A=
 /* Cygwin internal */=0A=
 /* Convert a Win32 time to "UNIX" format. */=0A=
 long __stdcall=0A=
-to_time_t (FILETIME *ptr)=0A=
+to_time_t (FILETIME * ptr)=0A=
 {=0A=
   /* A file time is the number of 100ns since jan 1 1601=0A=
      stuffed into two long words.=0A=
      A time_t is the number of seconds since jan 1 1970.  */=0A=
=20=0A=
   long rem;=0A=
-  long long x =3D ((long long) ptr->dwHighDateTime << 32) + ((unsigned)ptr=
->dwLowDateTime);=0A=
+  long long x =3D=0A=
+    ((long long) ptr->dwHighDateTime << 32) + ((unsigned) ptr->dwLowDateTi=
me);=0A=
=20=0A=
   /* pass "no time" as epoch */=0A=
   if (x =3D=3D 0)=0A=
     return 0;=0A=
=20=0A=
   x -=3D FACTOR;			/* number of 100ns between 1601 and 1970 */=0A=
-  rem =3D x % ((long long)NSPERSEC);=0A=
+  rem =3D x % ((long long) NSPERSEC);=0A=
   rem +=3D (NSPERSEC / 2);=0A=
-  x /=3D (long long) NSPERSEC;		/* number of 100ns in a second */=0A=
+  x /=3D (long long) NSPERSEC;	/* number of 100ns in a second */=0A=
   x +=3D (long long) (rem / NSPERSEC);=0A=
   return x;=0A=
 }=0A=
=20=0A=
 /* time: POSIX 4.5.1.1, C 4.12.2.4 */=0A=
 /* Return number of seconds since 00:00 UTC on jan 1, 1970 */=0A=
-extern "C"=0A=
-time_t=0A=
+extern "C" time_t=0A=
 time (time_t * ptr)=0A=
 {=0A=
   time_t res;=0A=
@@ -301,7 +305,7 @@ time (time_t * ptr)=0A=
=20=0A=
 #define isleap(y) ((((y) % 4) =3D=3D 0 && ((y) % 100) !=3D 0) || ((y) % 40=
0) =3D=3D 0)=0A=
=20=0A=
-#if 0 /* POSIX_LOCALTIME */=0A=
+#if 0				/* POSIX_LOCALTIME */=0A=
=20=0A=
 static _CONST int mon_lengths[2][MONSPERYEAR] =3D {=0A=
   {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31},=0A=
@@ -319,7 +323,7 @@ static _CONST int year_lengths[2] =3D {=0A=
  */=0A=
=20=0A=
 /* Cygwin internal */=0A=
-static struct tm * __stdcall=0A=
+static struct tm *__stdcall=0A=
 corelocaltime (const time_t * tim_p)=0A=
 {=0A=
   long days, rem;=0A=
@@ -327,9 +331,9 @@ corelocaltime (const time_t * tim_p)=0A=
   int yleap;=0A=
   _CONST int *ip;=0A=
 #ifdef _MT_SAFE=0A=
-  struct tm &localtime_buf=3D_reent_winsup()->_localtime_buf;=0A=
+  struct tm &localtime_buf =3D _reent_winsup ()->_localtime_buf;=0A=
 #else=0A=
-  static NO_COPY struct tm localtime_buf =3D {0};=0A=
+  static NO_COPY struct tm localtime_buf =3D { 0 };=0A=
 #endif=0A=
=20=0A=
   time_t tim =3D *tim_p;=0A=
@@ -379,7 +383,8 @@ corelocaltime (const time_t * tim_p)=0A=
 	  --y;=0A=
 	  yleap =3D isleap (y);=0A=
 	  days +=3D year_lengths[yleap];=0A=
-	} while (days < 0);=0A=
+	}=0A=
+      while (days < 0);=0A=
     }=0A=
=20=0A=
   res->tm_year =3D y - YEAR_BASE;=0A=
@@ -402,14 +407,13 @@ corelocaltime (const time_t * tim_p)=0A=
  * localtime takes a time_t (which is in UTC)=0A=
  * and formats it into a struct tm as a local time.=0A=
  */=0A=
-extern "C"=0A=
-struct tm *=0A=
-localtime (const time_t *tim_p)=0A=
+extern "C" struct tm *=0A=
+localtime (const time_t * tim_p)=0A=
 {=0A=
   time_t tim =3D *tim_p;=0A=
   struct tm *rtm;=0A=
=20=0A=
-  tzset();=0A=
+  tzset ();=0A=
=20=0A=
   tim -=3D _timezone;=0A=
=20=0A=
@@ -427,9 +431,8 @@ localtime (const time_t *tim_p)=0A=
  * gmtime takes a time_t (which is already in UTC)=0A=
  * and just puts it into a struct tm.=0A=
  */=0A=
-extern "C"=0A=
-struct tm *=0A=
-gmtime (const time_t *tim_p)=0A=
+extern "C" struct tm *=0A=
+gmtime (const time_t * tim_p)=0A=
 {=0A=
   time_t tim =3D *tim_p;=0A=
=20=0A=
@@ -445,8 +448,7 @@ gmtime (const time_t *tim_p)=0A=
 #endif /* POSIX_LOCALTIME */=0A=
=20=0A=
 /* utimes: standards? */=0A=
-extern "C"=0A=
-int=0A=
+extern "C" int=0A=
 utimes (const char *path, struct timeval *tvp)=0A=
 {=0A=
   int res =3D 0;=0A=
@@ -465,7 +467,7 @@ utimes (const char *path, struct timeval=0A=
   /* Note: It's not documented in MSDN that FILE_WRITE_ATTRIBUTES is=0A=
      sufficient to change the timestamps... */=0A=
   HANDLE h =3D CreateFileA (win32.get_win32 (),=0A=
-			  wincap.has_specific_access_rights () ?=0A=
+			  wincap.has_specific_access_rights ()?=0A=
 			  FILE_WRITE_ATTRIBUTES : GENERIC_WRITE,=0A=
 			  FILE_SHARE_READ | FILE_SHARE_WRITE,=0A=
 			  &sec_none_nih,=0A=
@@ -502,15 +504,14 @@ utimes (const char *path, struct timeval=0A=
       timeval_to_filetime (tvp + 1, &lastwrite);=0A=
=20=0A=
       debug_printf ("incoming lastaccess %08x %08x",=0A=
-		   tvp->tv_sec,=0A=
-		   tvp->tv_usec);=0A=
+		    tvp->tv_sec, tvp->tv_usec);=0A=
=20=0A=
 //      dump_filetime (lastaccess);=0A=
 //      dump_filetime (lastwrite);=0A=
=20=0A=
       /* FIXME: SetFileTime needs a handle with a write lock=0A=
-	 on the file whose time is being modified.  So calls to utime()=0A=
-	 fail for read only files.  */=0A=
+         on the file whose time is being modified.  So calls to utime()=0A=
+         fail for read only files.  */=0A=
=20=0A=
       if (!SetFileTime (h, 0, &lastaccess, &lastwrite))=0A=
 	{=0A=
@@ -522,14 +523,12 @@ utimes (const char *path, struct timeval=0A=
       CloseHandle (h);=0A=
     }=0A=
=20=0A=
-  syscall_printf ("%d =3D utimes (%s, %x); (h%d)",=0A=
-		  res, path, tvp, h);=0A=
+  syscall_printf ("%d =3D utimes (%s, %x); (h%d)", res, path, tvp, h);=0A=
   return res;=0A=
 }=0A=
=20=0A=
 /* utime: POSIX 5.6.6.1 */=0A=
-extern "C"=0A=
-int=0A=
+extern "C" int=0A=
 utime (const char *path, struct utimbuf *buf)=0A=
 {=0A=
   struct timeval tmp[2];=0A=
@@ -545,8 +544,7 @@ utime (const char *path, struct utimbuf=20=0A=
 }=0A=
=20=0A=
 /* ftime: standards? */=0A=
-extern "C"=0A=
-int=0A=
+extern "C" int=0A=
 ftime (struct timeb *tp)=0A=
 {=0A=
   struct timeval tv;=0A=
@@ -564,8 +562,188 @@ ftime (struct timeb *tp)=0A=
 }=0A=
=20=0A=
 /* obsolete, changed to cygwin_tzset when localtime.c was added - dj */=0A=
-extern "C"=0A=
-void=0A=
+extern "C" void=0A=
 cygwin_tzset ()=0A=
 {=0A=
+}=0A=
+=0A=
+static const char *days[] =3D=0A=
+  { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday",=0A=
+  "Saturday"=0A=
+};=0A=
+static const char *abbr_days[] =3D=0A=
+  { "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Say" };=0A=
+static const char *months[] =3D=0A=
+  { "January", "February", "March", "April", "May", "June",=0A=
+  "July", "August", "September", "October", "November", "December"=0A=
+};=0A=
+static const char *abbr_months[] =3D=0A=
+  { "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep" "Oct",=
=0A=
+  "Nov", "Dec"=0A=
+};=0A=
+=0A=
+/* strptime (SUSV2) */=0A=
+// FIXME: Implement the rest. (built to handle "%a %b %e %T %Y"=20=0A=
+extern "C" char *=0A=
+strptime (const char *buf, const char *format, struct tm *tm)=0A=
+{=0A=
+  // FIXME: Locale lookup for weeknames=0A=
+  // FIXME: check for tm validity=0A=
+  if (!tm)=0A=
+    return NULL;=0A=
+  const char *curr =3D format, *b =3D buf;=0A=
+  char f;=0A=
+  while ((f =3D *curr++))=0A=
+    {=0A=
+      if (isspace (f))=0A=
+	continue;=0A=
+      /* prime the scann buffer */=0A=
+      while (isspace (*b++));=0A=
+      --b;=0A=
+      if (f !=3D '%')=0A=
+	return NULL;=0A=
+=0A=
+      switch (f)=0A=
+	{=0A=
+	case 'a':=0A=
+	case 'A':=0A=
+	  {=0A=
+	    bool found =3D false;=0A=
+	    /* Day of the week in locale format, short or full */=0A=
+	    for (int i =3D 0; !found && i < 7; ++i)=0A=
+	      {=0A=
+		if (!strncmp (b, days[i], strlen (days[i])))=0A=
+		  {=0A=
+		    tm->tm_wday =3D i;=0A=
+		    b +=3D strlen (days[i]);=0A=
+		    found =3D true;=0A=
+		  }=0A=
+	      }=0A=
+	    for (int i =3D 0; !found && i < 7; ++i)=0A=
+	      {=0A=
+		if (!strncmp (b, abbr_days[i], strlen (abbr_days[i])))=0A=
+		  {=0A=
+		    tm->tm_wday =3D i;=0A=
+		    b +=3D strlen (abbr_days[i]);=0A=
+		    found =3D true;=0A=
+		  }=0A=
+	      }=0A=
+=0A=
+	    if (!found)=0A=
+	      return (char *) b;=0A=
+=0A=
+	  }=0A=
+	  break;=0A=
+	case 'b':=0A=
+	case 'B':=0A=
+	  {=0A=
+	    /* month in locale name, short or full */=0A=
+	    bool found =3D false;=0A=
+	    for (int i =3D 0; !found && i < 7; ++i)=0A=
+	      {=0A=
+		if (!strncmp (b, months[i], strlen (months[i])))=0A=
+		  {=0A=
+		    tm->tm_wday =3D i;=0A=
+		    b +=3D strlen (months[i]);=0A=
+		    found =3D true;=0A=
+		  }=0A=
+	      }=0A=
+	    for (int i =3D 0; !found && i < 7; ++i)=0A=
+	      {=0A=
+		if (!strncmp (b, abbr_months[i], strlen (abbr_months[i])))=0A=
+		  {=0A=
+		    tm->tm_wday =3D i;=0A=
+		    b +=3D strlen (abbr_months[i]);=0A=
+		    found =3D true;=0A=
+		  }=0A=
+	      }=0A=
+	    if (!found)=0A=
+	      return (char *) b;=0A=
+	  }=0A=
+	  break;=0A=
+	case 'd':=0A=
+	case 'e':=0A=
+	  {=0A=
+	    /* day of the month (1, 31) allowing leading 0's. */=0A=
+	    unsigned int temp;=0A=
+	    if (sscanf (b, "%u", &temp) !=3D 1)=0A=
+	      return (char *) b;=0A=
+	    if (0 < temp && temp < 32)=0A=
+	      {=0A=
+		tm->tm_mday =3D temp;=0A=
+		if (temp < 10)=0A=
+		  b +=3D 1;=0A=
+		else=0A=
+		  b +=3D 2;=0A=
+	      }=0A=
+	    else=0A=
+	      return (char *) b;=0A=
+	  }=0A=
+	  break;=0A=
+	case 'T':=0A=
+	  {=0A=
+	    /* Time: %H:%M:%S */=0A=
+	    char tempstr[3];=0A=
+	    int n =3D 0;=0A=
+	    while (isdigit (*b))=0A=
+	      {=0A=
+		tempstr[n++] =3D *b++;=0A=
+	      }=0A=
+	    if (*b !=3D ':')=0A=
+	      return (char *) (b - n);=0A=
+	    if (sscanf (tempstr, "%u", &tm->tm_hour) !=3D 1)=0A=
+	      return (char *) (b - n);=0A=
+	    if (0 < tm->tm_hour || tm->tm_hour > 23)=0A=
+	      return (char *) (b - n);=0A=
+	    ++b;=0A=
+	    n =3D 0;=0A=
+	    while (isdigit (*b))=0A=
+	      {=0A=
+		tempstr[n++] =3D *b++;=0A=
+	      }=0A=
+	    if (*b !=3D ':')=0A=
+	      return (char *) (b - n);=0A=
+	    if (sscanf (tempstr, "%u", &tm->tm_min) !=3D 1)=0A=
+	      return (char *) (b - n);=0A=
+	    if (0 < tm->tm_min || tm->tm_min > 59)=0A=
+	      return (char *) (b - n);=0A=
+	    ++b;=0A=
+	    n =3D 0;=0A=
+	    while (isdigit (*b))=0A=
+	      {=0A=
+		tempstr[n++] =3D *b++;=0A=
+	      }=0A=
+	    if (*b !=3D ':')=0A=
+	      return (char *) (b - n);=0A=
+	    if (sscanf (tempstr, "%u", &tm->tm_sec) !=3D 1)=0A=
+	      return (char *) (b - n);=0A=
+	    if (0 < tm->tm_sec || tm->tm_sec > 61)=0A=
+	      return (char *) (b - n);=0A=
+	    break;=0A=
+	  }=0A=
+	case 'Y':=0A=
+	  {=0A=
+	    /* four digit year */=0A=
+	    char tempstr[5];=0A=
+	    tempstr[4] =3D 0;=0A=
+	    for (int i =3D 0; i < 4; ++i)=0A=
+	      {=0A=
+		if (!isdigit (*b))=0A=
+		  return (char *) b;=0A=
+		tempstr[i] =3D *b++;=0A=
+	      }=0A=
+	    if (sscanf (tempstr, "%u", &tm->tm_year) !=3D 1)=0A=
+	      return (char *) b;=0A=
+	    tm->tm_year -=3D 1900;=0A=
+	    if (tm->tm_year < 0)=0A=
+	      return (char *) b;=0A=
+	    b +=3D 4;=0A=
+	  }=0A=
+	  break;=0A=
+	default:=0A=
+	  /* so people notice! */=0A=
+	  return NULL;=0A=
+	}=0A=
+    }=0A=
+  return (char *) b;=0A=
 }=0A=

------=_NextPart_000_177B_01C19F38.BBBDD610
Content-Type: application/octet-stream;
	name="strptime.cygwinChangeLog"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="strptime.cygwinChangeLog"
Content-length: 126

2002-01-17  Robert Collins  <rbtcollins@hotmail.com>=0A=
=0A=
        * times.cc: Run indent.=0A=
	Add strptime function.=0A=

------=_NextPart_000_177B_01C19F38.BBBDD610--
