Return-Path: <cygwin-patches-return-2038-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 3762 invoked by alias); 9 Apr 2002 19:52:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3725 invoked from network); 9 Apr 2002 19:52:30 -0000
Message-ID: <911C684A29ACD311921800508B7293BA037D2E76@cnmail>
From: Mark Bradshaw <bradshaw@staff.crosswalk.com>
To: "'newlib@sources.redhat.com'" <newlib@sources.redhat.com>, 
	cygwin-patches@cygwin.com
Subject: patch: strptime
Date: Tue, 09 Apr 2002 12:52:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C1E000.0DFA8BF0"
X-SW-Source: 2002-q2/txt/msg00022.txt.bz2

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C1E000.0DFA8BF0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-length: 1093

This is a resubmission of a Cygwin patch made a couple months back.  Corinna
asked that I move the strptime addition from cygwin over into newlib as a
more logical location, but I forgot to do it til I was reminded recently.
The previous patch was un-applied in Cygwin, but not in newlib, so this
patch changes newlib's time.h to correct the previous patch.

Corinna asked that the strptime stuff be put in strftime.c so that some
constants weren't duplicated, but the organization just didn't make sense.
I went ahead and kept it in a separate file.

The original source for this comes from
http://ftp.uninett.no/pub/OpenBSD/src/kerberosIV/src/lib/roken/strptime.c.  


==================

For newlib:
2002-04-09  Mark Bradshaw  <bradshaw@staff.crosswalk.com>
        * libc/include/time.h: Fix strptime declaration.
        * libc/time/Makefile.am: Add strptime.c and strptime.def.
        * libc/time/strptime.c: New file.

For cygwin:
2002-04-09  Mark Bradshaw  <bradshaw@staff.crosswalk.com>

	  * cygwin.din: Add strptime.
	  * include/cygwin/version.h: Increment minor version number.


------_=_NextPart_000_01C1E000.0DFA8BF0
Content-Type: application/octet-stream;
	name="newlib.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="newlib.diff"
Content-length: 13262

diff -ubBpNr orig/libc/include/time.h new/libc/include/time.h=0A=
--- orig/libc/include/time.h	Fri Jan 18 11:25:50 2002=0A=
+++ new/libc/include/time.h	Tue Apr  9 15:04:34 2002=0A=
@@ -55,6 +55,7 @@ struct tm *_EXFUN(gmtime,   (const time_=0A=
 struct tm *_EXFUN(localtime,(const time_t *_timer));=0A=
 #endif=0A=
 size_t	   _EXFUN(strftime, (char *_s, size_t _maxsize, const char *_fmt, c=
onst struct tm *_t));=0A=
+char      *_EXFUN(strptime,     (const char *, const char *, struct tm *))=
;=0A=
=20=0A=
 char	  *_EXFUN(asctime_r,	(const struct tm *, char *));=0A=
 char	  *_EXFUN(ctime_r,	(const time_t *, char *));=0A=
@@ -62,7 +63,6 @@ struct tm *_EXFUN(gmtime_r,	(const time_=0A=
 struct tm *_EXFUN(localtime_r,	(const time_t *, struct tm *));=0A=
=20=0A=
 #ifdef __CYGWIN__=0A=
-char      *_EXFUN(strptime,     (const char *, const char *, struct tm *))=
;=0A=
 #ifndef __STRICT_ANSI__=0A=
 extern __IMPORT time_t _timezone;=0A=
 extern __IMPORT int _daylight;=0A=
diff -ubBpNr orig/libc/time/Makefile.am new/libc/time/Makefile.am=0A=
--- orig/libc/time/Makefile.am	Thu Dec 13 18:50:10 2001=0A=
+++ new/libc/time/Makefile.am	Mon Apr  8 16:38:55 2002=0A=
@@ -17,6 +17,7 @@ LIB_SOURCES =3D \=0A=
 	lcltime_r.c	\=0A=
 	mktime.c	\=0A=
 	strftime.c  	\=0A=
+	strptime.c  	\=0A=
 	time.c=0A=
=20=0A=
 libtime_la_LDFLAGS =3D -Xcompiler -nostdlib=0A=
@@ -42,6 +43,7 @@ CHEWOUT_FILES =3D \=0A=
 	lcltime.def	\=0A=
 	mktime.def	\=0A=
 	strftime.def	\=0A=
+	strptime.def	\=0A=
 	time.def=0A=
=20=0A=
 SUFFIXES =3D .def=0A=
diff -ubBpNr orig/libc/time/strptime.c new/libc/time/strptime.c=0A=
--- orig/libc/time/strptime.c	Wed Dec 31 19:00:00 1969=0A=
+++ new/libc/time/strptime.c	Tue Apr  9 14:34:06 2002=0A=
@@ -0,0 +1,437 @@=0A=
+/*=0A=
+ * Copyright (c) 1999 Kungliga Tekniska H=F6gskolan=0A=
+ * (Royal Institute of Technology, Stockholm, Sweden).=20=0A=
+ * All rights reserved.=20=0A=
+ *=0A=
+ * Redistribution and use in source and binary forms, with or without=20=
=0A=
+ * modification, are permitted provided that the following conditions=20=
=0A=
+ * are met:=20=0A=
+ *=0A=
+ * 1. Redistributions of source code must retain the above copyright=20=0A=
+ *    notice, this list of conditions and the following disclaimer.=20=0A=
+ *=0A=
+ * 2. Redistributions in binary form must reproduce the above copyright=20=
=0A=
+ *    notice, this list of conditions and the following disclaimer in the=
=20=0A=
+ *    documentation and/or other materials provided with the distribution.=
=20=0A=
+ *=0A=
+ * 3. Neither the name of KTH nor the names of its contributors may be=0A=
+ *    used to endorse or promote products derived from this software witho=
ut=0A=
+ *    specific prior written permission.=0A=
+ *=0A=
+ * THIS SOFTWARE IS PROVIDED BY KTH AND ITS CONTRIBUTORS ``AS IS'' AND ANY=
=0A=
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE=0A=
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR=0A=
+ * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL KTH OR ITS CONTRIBUTORS BE=0A=
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR=0A=
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF=0A=
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR=0A=
+ * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,=
=0A=
+ * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR=
=0A=
+ * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF=
=0A=
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. */=0A=
+=0A=
+#include <stddef.h>=0A=
+#include <stdio.h>=0A=
+#include <time.h>=0A=
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
+//extern "C"=0A=
+char *=0A=
+//strptime (const char *buf, const char *format, struct tm *timeptr)=0A=
+_DEFUN (strptime, (buf, format, timeptr),=0A=
+	_CONST char *buf _AND=0A=
+	_CONST char *format _AND=0A=
+	struct tm *timeptr)=0A=
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

------_=_NextPart_000_01C1E000.0DFA8BF0
Content-Type: application/octet-stream;
	name="cygwin.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cygwin.diff"
Content-length: 852

diff -ubBpNr orig/cygwin.din new/cygwin.din=0A=
--- orig/cygwin.din	Thu Mar  7 10:41:22 2002=0A=
+++ new/cygwin.din	Tue Apr  9 15:32:40 2002=0A=
@@ -967,6 +967,8 @@ pclose=0A=
 _pclose =3D pclose=0A=
 strftime=0A=
 _strftime =3D strftime=0A=
+strptime=0A=
+_strptime =3D strptime=0A=
 setgrent=0A=
 _setgrent =3D setgrent=0A=
 cuserid=0A=
diff -ubBpNr orig/include/cygwin/version.h new/include/cygwin/version.h=0A=
--- orig/include/cygwin/version.h	Thu Mar  7 10:41:24 2002=0A=
+++ new/include/cygwin/version.h	Tue Apr  9 15:28:07 2002=0A=
@@ -44,7 +44,7 @@ details. */=0A=
   /* The current cygwin version is 1.3.6 */=0A=
=20=0A=
 #define CYGWIN_VERSION_DLL_MAJOR 1003=0A=
-#define CYGWIN_VERSION_DLL_MINOR 11=0A=
+#define CYGWIN_VERSION_DLL_MINOR 12=0A=
=20=0A=
       /* Major numbers before CYGWIN_VERSION_DLL_EPOCH are=0A=
 	 incompatible. */=0A=

------_=_NextPart_000_01C1E000.0DFA8BF0--
