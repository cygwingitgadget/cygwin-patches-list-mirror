Return-Path: <cygwin-patches-return-1738-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19838 invoked by alias); 18 Jan 2002 13:14:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19824 invoked from network); 18 Jan 2002 13:14:17 -0000
Message-ID: <911C684A29ACD311921800508B7293BA037D2A6E@cnmail>
From: Mark Bradshaw <bradshaw@staff.crosswalk.com>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>, 
	newlib-patches@sources.redhat.com
Subject: roken strptime addition to cygwin
Date: Fri, 18 Jan 2002 05:14:00 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C1A021.DFCCA420"
X-SW-Source: 2002-q1/txt/msg00095.txt.bz2

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C1A021.DFCCA420
Content-Type: text/plain;
	charset="iso-8859-1"
Content-length: 695

Thanks to Robert and Chuck for behind the scenes help.

Here's the strptime addition to cygwin that's been discussed.  The source
comes from:
http://ftp.uninett.no/pub/OpenBSD/src/kerberosIV/src/lib/roken/strptime.c

It's copyright isn't as restrictive as the BSD's, so it won't be a problem
for inclusion.  This also includes a header change for newlib.

====================================

Newlib:
2002-01-18  Mark Bradshaw  <bradshaw@staff.crosswalk.com>

        * libc/include/time.h: Add prototype for strptime for Cygwin.

Cygwin:
2002-01-18  Mark Bradshaw  <bradshaw@staff.crosswalk.com>

        * times.cc: Add strptime function, and supporting functions.
	  * cygwin.din: strptime


------_=_NextPart_000_01C1A021.DFCCA420
Content-Type: application/octet-stream;
	name="times.cc.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="times.cc.diff"
Content-length: 10219

Index: src/winsup/cygwin/times.cc=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/cygwin/times.cc,v=0A=
retrieving revision 1.24=0A=
diff -u -p -r1.24 times.cc=0A=
--- times.cc	2002/01/14 20:39:59	1.24=0A=
+++ times.cc	2002/01/18 12:48:14=0A=
@@ -24,6 +24,7 @@ details. */=0A=
 #include "sync.h"=0A=
 #include "sigproc.h"=0A=
 #include "pinfo.h"=0A=
+#include <ctype.h>=0A=
=20=0A=
 #define FACTOR (0x19db1ded53e8000LL)=0A=
 #define NSPERSEC 10000000LL=0A=
@@ -569,3 +570,401 @@ void=0A=
 cygwin_tzset ()=0A=
 {=0A=
 }=0A=
+=0A=
+static const char *abb_weekdays[] =3D {=0A=
+    "Sun",=0A=
+    "Mon",=0A=
+    "Tue",=0A=
+    "Wed",=0A=
+    "Thu",=0A=
+    "Fri",=0A=
+    "Sat",=0A=
+    NULL=0A=
+};=0A=
+=0A=
+static const char *full_weekdays[] =3D {=0A=
+    "Sunday",=0A=
+    "Monday",=0A=
+    "Tuesday",=0A=
+    "Wednesday",=0A=
+    "Thursday",=0A=
+    "Friday",=0A=
+    "Saturday",=0A=
+    NULL=0A=
+};=0A=
+=0A=
+static const char *abb_month[] =3D {=0A=
+    "Jan",=0A=
+    "Feb",=0A=
+    "Mar",=0A=
+    "Apr",=0A=
+    "May",=0A=
+    "Jun",=0A=
+    "Jul",=0A=
+    "Aug",=0A=
+    "Sep",=0A=
+    "Oct",=0A=
+    "Nov",=0A=
+    "Dec",=0A=
+    NULL=0A=
+};=0A=
+=0A=
+static const char *full_month[] =3D {=0A=
+    "January",=0A=
+    "February",=0A=
+    "Mars",=0A=
+    "April",=0A=
+    "May",=0A=
+    "June",=0A=
+    "July",=0A=
+    "August",=0A=
+    "September",=0A=
+    "October",=0A=
+    "November",=0A=
+    "December",=0A=
+    NULL,=0A=
+};=0A=
+=0A=
+static const char *ampm[] =3D {=0A=
+    "am",=0A=
+    "pm",=0A=
+    NULL=0A=
+};=0A=
+=0A=
+/*=0A=
+ * tm_year is relative this year=20=0A=
+ */=0A=
+const int tm_year_base =3D 1900;=0A=
+=0A=
+/*=0A=
+ * Return TRUE iff `year' was a leap year.=0A=
+ * Needed for strptime.=0A=
+ */=0A=
+static int=0A=
+is_leap_year (int year)=0A=
+{=0A=
+    return (year % 4) =3D=3D 0 && ((year % 100) !=3D 0 || (year % 400) =3D=
=3D 0);=0A=
+}=0A=
+=0A=
+/* Needed for strptime. */=0A=
+static int=0A=
+match_string (const char **buf, const char **strs)=0A=
+{=0A=
+    int i =3D 0;=0A=
+=0A=
+    for (i =3D 0; strs[i] !=3D NULL; ++i) {=0A=
+	int len =3D strlen (strs[i]);=0A=
+=0A=
+	if (strncasecmp (*buf, strs[i], len) =3D=3D 0) {=0A=
+	    *buf +=3D len;=0A=
+	    return i;=0A=
+	}=0A=
+    }=0A=
+    return -1;=0A=
+}=0A=
+=0A=
+/* Needed for strptime. */=0A=
+static int=0A=
+first_day (int year)=0A=
+{=0A=
+    int ret =3D 4;=0A=
+=0A=
+    for (; year > 1970; --year)=0A=
+	ret =3D (ret + 365 + is_leap_year (year) ? 1 : 0) % 7;=0A=
+    return ret;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Set `timeptr' given `wnum' (week number [0, 53])=0A=
+ * Needed for strptime=0A=
+ */=0A=
+=0A=
+static void=0A=
+set_week_number_sun (struct tm *timeptr, int wnum)=0A=
+{=0A=
+    int fday =3D first_day (timeptr->tm_year + tm_year_base);=0A=
+=0A=
+    timeptr->tm_yday =3D wnum * 7 + timeptr->tm_wday - fday;=0A=
+    if (timeptr->tm_yday < 0) {=0A=
+	timeptr->tm_wday =3D fday;=0A=
+	timeptr->tm_yday =3D 0;=0A=
+    }=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Set `timeptr' given `wnum' (week number [0, 53])=0A=
+ * Needed for strptime=0A=
+ */=0A=
+=0A=
+static void=0A=
+set_week_number_mon (struct tm *timeptr, int wnum)=0A=
+{=0A=
+    int fday =3D (first_day (timeptr->tm_year + tm_year_base) + 6) % 7;=0A=
+=0A=
+    timeptr->tm_yday =3D wnum * 7 + (timeptr->tm_wday + 6) % 7 - fday;=0A=
+    if (timeptr->tm_yday < 0) {=0A=
+	timeptr->tm_wday =3D (fday + 1) % 7;=0A=
+	timeptr->tm_yday =3D 0;=0A=
+    }=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Set `timeptr' given `wnum' (week number [0, 53])=0A=
+ * Needed for strptime=0A=
+ */=0A=
+static void=0A=
+set_week_number_mon4 (struct tm *timeptr, int wnum)=0A=
+{=0A=
+    int fday =3D (first_day (timeptr->tm_year + tm_year_base) + 6) % 7;=0A=
+    int offset =3D 0;=0A=
+=0A=
+    if (fday < 4)=0A=
+	offset +=3D 7;=0A=
+=0A=
+    timeptr->tm_yday =3D offset + (wnum - 1) * 7 + timeptr->tm_wday - fday=
;=0A=
+    if (timeptr->tm_yday < 0) {=0A=
+	timeptr->tm_wday =3D fday;=0A=
+	timeptr->tm_yday =3D 0;=0A=
+    }=0A=
+}=0A=
+=0A=
+/* strptime: roken */=0A=
+extern "C"=0A=
+char *=0A=
+strptime (const char *buf, const char *format, struct tm *timeptr)=0A=
+{=0A=
+    char c;=0A=
+=0A=
+    for (; (c =3D *format) !=3D '\0'; ++format) {=0A=
+	char *s;=0A=
+	int ret;=0A=
+=0A=
+	if (isspace (c)) {=0A=
+	    while (isspace (*buf))=0A=
+		++buf;=0A=
+	} else if (c =3D=3D '%' && format[1] !=3D '\0') {=0A=
+	    c =3D *++format;=0A=
+	    if (c =3D=3D 'E' || c =3D=3D 'O')=0A=
+		c =3D *++format;=0A=
+	    switch (c) {=0A=
+	    case 'A' :=0A=
+		ret =3D match_string (&buf, full_weekdays);=0A=
+		if (ret < 0)=0A=
+		    return NULL;=0A=
+		timeptr->tm_wday =3D ret;=0A=
+		break;=0A=
+	    case 'a' :=0A=
+		ret =3D match_string (&buf, abb_weekdays);=0A=
+		if (ret < 0)=0A=
+		    return NULL;=0A=
+		timeptr->tm_wday =3D ret;=0A=
+		break;=0A=
+	    case 'B' :=0A=
+		ret =3D match_string (&buf, full_month);=0A=
+		if (ret < 0)=0A=
+		    return NULL;=0A=
+		timeptr->tm_mon =3D ret;=0A=
+		break;=0A=
+	    case 'b' :=0A=
+	    case 'h' :=0A=
+		ret =3D match_string (&buf, abb_month);=0A=
+		if (ret < 0)=0A=
+		    return NULL;=0A=
+		timeptr->tm_mon =3D ret;=0A=
+		break;=0A=
+	    case 'C' :=0A=
+		ret =3D strtol (buf, &s, 10);=0A=
+		if (s =3D=3D buf)=0A=
+		    return NULL;=0A=
+		timeptr->tm_year =3D (ret * 100) - tm_year_base;=0A=
+		buf =3D s;=0A=
+		break;=0A=
+	    case 'c' :=0A=
+		abort ();=0A=
+	    case 'D' :		/* %m/%d/%y */=0A=
+		s =3D strptime (buf, "%m/%d/%y", timeptr);=0A=
+		if (s =3D=3D NULL)=0A=
+		    return NULL;=0A=
+		buf =3D s;=0A=
+		break;=0A=
+	    case 'd' :=0A=
+	    case 'e' :=0A=
+		ret =3D strtol (buf, &s, 10);=0A=
+		if (s =3D=3D buf)=0A=
+		    return NULL;=0A=
+		timeptr->tm_mday =3D ret;=0A=
+		buf =3D s;=0A=
+		break;=0A=
+	    case 'H' :=0A=
+	    case 'k' :=0A=
+		ret =3D strtol (buf, &s, 10);=0A=
+		if (s =3D=3D buf)=0A=
+		    return NULL;=0A=
+		timeptr->tm_hour =3D ret;=0A=
+		buf =3D s;=0A=
+		break;=0A=
+	    case 'I' :=0A=
+	    case 'l' :=0A=
+		ret =3D strtol (buf, &s, 10);=0A=
+		if (s =3D=3D buf)=0A=
+		    return NULL;=0A=
+		if (ret =3D=3D 12)=0A=
+		    timeptr->tm_hour =3D 0;=0A=
+		else=0A=
+		    timeptr->tm_hour =3D ret;=0A=
+		buf =3D s;=0A=
+		break;=0A=
+	    case 'j' :=0A=
+		ret =3D strtol (buf, &s, 10);=0A=
+		if (s =3D=3D buf)=0A=
+		    return NULL;=0A=
+		timeptr->tm_yday =3D ret - 1;=0A=
+		buf =3D s;=0A=
+		break;=0A=
+	    case 'm' :=0A=
+		ret =3D strtol (buf, &s, 10);=0A=
+		if (s =3D=3D buf)=0A=
+		    return NULL;=0A=
+		timeptr->tm_mon =3D ret - 1;=0A=
+		buf =3D s;=0A=
+		break;=0A=
+	    case 'M' :=0A=
+		ret =3D strtol (buf, &s, 10);=0A=
+		if (s =3D=3D buf)=0A=
+		    return NULL;=0A=
+		timeptr->tm_min =3D ret;=0A=
+		buf =3D s;=0A=
+		break;=0A=
+	    case 'n' :=0A=
+		if (*buf =3D=3D '\n')=0A=
+		    ++buf;=0A=
+		else=0A=
+		    return NULL;=0A=
+		break;=0A=
+	    case 'p' :=0A=
+		ret =3D match_string (&buf, ampm);=0A=
+		if (ret < 0)=0A=
+		    return NULL;=0A=
+		if (timeptr->tm_hour =3D=3D 0) {=0A=
+		    if (ret =3D=3D 1)=0A=
+			timeptr->tm_hour =3D 12;=0A=
+		} else=0A=
+		    timeptr->tm_hour +=3D 12;=0A=
+		break;=0A=
+	    case 'r' :		/* %I:%M:%S %p */=0A=
+		s =3D strptime (buf, "%I:%M:%S %p", timeptr);=0A=
+		if (s =3D=3D NULL)=0A=
+		    return NULL;=0A=
+		buf =3D s;=0A=
+		break;=0A=
+	    case 'R' :		/* %H:%M */=0A=
+		s =3D strptime (buf, "%H:%M", timeptr);=0A=
+		if (s =3D=3D NULL)=0A=
+		    return NULL;=0A=
+		buf =3D s;=0A=
+		break;=0A=
+	    case 'S' :=0A=
+		ret =3D strtol (buf, &s, 10);=0A=
+		if (s =3D=3D buf)=0A=
+		    return NULL;=0A=
+		timeptr->tm_sec =3D ret;=0A=
+		buf =3D s;=0A=
+		break;=0A=
+	    case 't' :=0A=
+		if (*buf =3D=3D '\t')=0A=
+		    ++buf;=0A=
+		else=0A=
+		    return NULL;=0A=
+		break;=0A=
+	    case 'T' :		/* %H:%M:%S */=0A=
+	    case 'X' :=0A=
+		s =3D strptime (buf, "%H:%M:%S", timeptr);=0A=
+		if (s =3D=3D NULL)=0A=
+		    return NULL;=0A=
+		buf =3D s;=0A=
+		break;=0A=
+	    case 'u' :=0A=
+		ret =3D strtol (buf, &s, 10);=0A=
+		if (s =3D=3D buf)=0A=
+		    return NULL;=0A=
+		timeptr->tm_wday =3D ret - 1;=0A=
+		buf =3D s;=0A=
+		break;=0A=
+	    case 'w' :=0A=
+		ret =3D strtol (buf, &s, 10);=0A=
+		if (s =3D=3D buf)=0A=
+		    return NULL;=0A=
+		timeptr->tm_wday =3D ret;=0A=
+		buf =3D s;=0A=
+		break;=0A=
+	    case 'U' :=0A=
+		ret =3D strtol (buf, &s, 10);=0A=
+		if (s =3D=3D buf)=0A=
+		    return NULL;=0A=
+		set_week_number_sun (timeptr, ret);=0A=
+		buf =3D s;=0A=
+		break;=0A=
+	    case 'V' :=0A=
+		ret =3D strtol (buf, &s, 10);=0A=
+		if (s =3D=3D buf)=0A=
+		    return NULL;=0A=
+		set_week_number_mon4 (timeptr, ret);=0A=
+		buf =3D s;=0A=
+		break;=0A=
+	    case 'W' :=0A=
+		ret =3D strtol (buf, &s, 10);=0A=
+		if (s =3D=3D buf)=0A=
+		    return NULL;=0A=
+		set_week_number_mon (timeptr, ret);=0A=
+		buf =3D s;=0A=
+		break;=0A=
+	    case 'x' :=0A=
+		s =3D strptime (buf, "%Y:%m:%d", timeptr);=0A=
+		if (s =3D=3D NULL)=0A=
+		    return NULL;=0A=
+		buf =3D s;=0A=
+		break;=0A=
+	    case 'y' :=0A=
+		ret =3D strtol (buf, &s, 10);=0A=
+		if (s =3D=3D buf)=0A=
+		    return NULL;=0A=
+		if (ret < 70)=0A=
+		    timeptr->tm_year =3D 100 + ret;=0A=
+		else=0A=
+		    timeptr->tm_year =3D ret;=0A=
+		buf =3D s;=0A=
+		break;=0A=
+	    case 'Y' :=0A=
+		ret =3D strtol (buf, &s, 10);=0A=
+		if (s =3D=3D buf)=0A=
+		    return NULL;=0A=
+		timeptr->tm_year =3D ret - tm_year_base;=0A=
+		buf =3D s;=0A=
+		break;=0A=
+	    case 'Z' :=0A=
+		abort ();=0A=
+	    case '\0' :=0A=
+		--format;=0A=
+		/* FALLTHROUGH */=0A=
+	    case '%' :=0A=
+		if (*buf =3D=3D '%')=0A=
+		    ++buf;=0A=
+		else=0A=
+		    return NULL;=0A=
+		break;=0A=
+	    default :=0A=
+		if (*buf =3D=3D '%' || *++buf =3D=3D c)=0A=
+		    ++buf;=0A=
+		else=0A=
+		    return NULL;=0A=
+		break;=0A=
+	    }=0A=
+	} else {=0A=
+	    if (*buf =3D=3D c)=0A=
+		++buf;=0A=
+	    else=0A=
+		return NULL;=0A=
+	}=0A=
+    }=0A=
+    return (char *)buf;=0A=
+}=0A=
\ No newline at end of file=0A=

------_=_NextPart_000_01C1A021.DFCCA420
Content-Type: application/octet-stream;
	name="time.h.diff"
Content-Disposition: attachment;
	filename="time.h.diff"
Content-length: 584

Index: src/newlib/libc/include/time.h
===================================================================
RCS file: /cvs/src/src/newlib/libc/include/time.h,v
retrieving revision 1.5
diff -u -p -r1.5 time.h
--- time.h	2001/04/19 15:54:47	1.5
+++ time.h	2002/01/18 12:48:07
@@ -62,6 +62,7 @@ struct tm *_EXFUN(gmtime_r,	(const time_
 struct tm *_EXFUN(localtime_r,	(const time_t *, struct tm *));
 
 #ifdef __CYGWIN__
+char      *_EXFUN(strptime,     (const char *, const char *, struct tm *));
 #ifndef __STRICT_ANSI__
 extern __IMPORT time_t _timezone;
 extern __IMPORT int _daylight;
------_=_NextPart_000_01C1A021.DFCCA420
Content-Type: application/octet-stream;
	name="cygwin.din.diff"
Content-Disposition: attachment;
	filename="cygwin.din.diff"
Content-length: 406

Index: src/winsup/cygwin/cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.42
diff -u -p -r1.42 cygwin.din
--- cygwin.din	2002/01/17 10:39:36	1.42
+++ cygwin.din	2002/01/18 12:48:13
@@ -779,6 +779,7 @@ strncpy
 _strncpy = strncpy
 strpbrk
 _strpbrk = strpbrk
+strptime
 strrchr
 _strrchr = strrchr
 strspn
------_=_NextPart_000_01C1A021.DFCCA420
Content-Type: application/octet-stream;
	name="strptime.Changelog"
Content-Disposition: attachment;
	filename="strptime.Changelog"
Content-length: 304

Newlib:
2002-01-18  Mark Bradshaw  <bradshaw@staff.crosswalk.com>

        * libc/include/time.h: Add prototype for strptime for Cygwin.

Cygwin:
2002-01-18  Mark Bradshaw  <bradshaw@staff.crosswalk.com>

        * times.cc: Add strptime function, and supporting functions.
        * cygwin.din: strptime
------_=_NextPart_000_01C1A021.DFCCA420--
