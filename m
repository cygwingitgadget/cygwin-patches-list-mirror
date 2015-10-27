Return-Path: <cygwin-patches-return-8266-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 64825 invoked by alias); 27 Oct 2015 01:16:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 64799 invoked by uid 89); 27 Oct 2015 01:16:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.4 required=5.0 tests=AWL,BAYES_99,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=no version=3.3.2
X-Spam-User: qpsmtpd, 3 recipients
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.9) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 27 Oct 2015 01:16:23 +0000
Received: from [192.168.1.100] ([96.51.88.197])	by shaw.ca with SMTP	id qss8ZCOCyT2voqss9ZqmMz; Mon, 26 Oct 2015 19:16:22 -0600
X-Authority-Analysis: v=2.1 cv=NrEbCZpJ c=1 sm=1 tr=0 a=0g8qPGUHxEvai5om+WudJQ==:117 a=0g8qPGUHxEvai5om+WudJQ==:17 a=IkcTkHD0fZMA:10 a=w_pzkKWiAAAA:8 a=AC0f813EADFEtAdlKj8A:9 a=fCqL-9VIFS1EnJ1w:21 a=ll5v4JDeg3zP7yCh:21 a=QEXdDO2ut3YA:10 a=P9_SNNk_cmIA:10
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: Bash unable to print epoch timestamp
References: <562A996C.9070904@SystematicSw.ab.ca> <562E643C.3090004@SystematicSw.ab.ca>
To: cygwin@cygwin.com, cygwin-patches@cygwin.com, corinna-cygwin@cygwin.com
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Message-ID: <562ED064.6050100@SystematicSw.ab.ca>
Date: Tue, 27 Oct 2015 01:16:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <562E643C.3090004@SystematicSw.ab.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfN6TRtpJDrv4UlatGPtBKW0GFSHqij9CskQ0oHrGPAmhTkFqCKaZAX5lhs9fzWozgS3LuQB4So8had7LIzsFzAuDuz5YzXcEh8VAaTsqDywoY+fHPKUUUvVKlaiLTHHU6M31AAJeqrqJaWuRF/aGyqVkMKmtHgw30ReoJ4Vi6xPcOZvZXCYTanBf0CaJlk3LiUYKvHm+DFFoCy1mgU9Mxm5yDr2WvPO4tOCsCKtz6BSsNCnneX7k6PeEq5UK7HWOmrfmPxX+jdNwVEz3oAmvuBs=
X-SW-Source: 2015-q4/txt/msg00019.txt.bz2

> -------- Forwarded Message --------
> Subject: Fwd: Re: Bash unable to print epoch timestamp
> Date: Fri, 23 Oct 2015 14:32:44 -0600
> From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
> Reply-To: Brian.Inglis@SystematicSw.ab.ca
> Organisation: Systematic Software
> To: corinna-cygwin@cygwin.com
>
> Already forwarded as below to cygwin and ...patches-allow...
> - should be HTML free and pass filters?

On 2015-10-26 11:34, Brian Inglis wrote:
> Third time lucky - pasting inline into email and resending to all previous lists.
>
> Please note that conversion into too-small buffer size in regression test may not have expected result!
>
> Tried to build with below and variants:
> gcc -D_REGRESSION_TEST -D_COMPILING_NEWLIB -Dsniprintf=snprintf -I/usr/src/cygwin-2.2.1-1.src/newlib-cygwin/winsup/cygwin/include -o strftime-s-test strftime.c
> gives undef refs for __cygwin_gettzname, __cygwin_gettzoffset, __get_current_time_locale, __tz_lock, __tz_unlock,
> _tzset_unlocked
>
> Build stc with std cmdline and current strftime works and does demo issue.

Sorry - redo with the file existing!

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

----- >8 ----- 8< -----
/* newlib/libc/time/strftime.c %s format STC */
#include <stdio.h>
#include <time.h>

int main( int argc, char **argv) {
     char ss[BUFSIZ]	= "";
     time_t tt		= time( NULL );
     struct tm *tp	= gmtime( &tt );
     tt			= mktime( tp );
     size_t st		= strftime( ss, sizeof ss, "%s", tp);
     int rc		= puts( ss );
     st			= strftime( ss, sizeof ss, "%T", tp);
     rc			= puts( ss );
     return rc;
}
----- >8 ----- 8< -----
--- a/newlib/ChangeLog	2015-08-20 03:39:23.000000000 -0600
+++ b/newlib/ChangeLog	2015-10-26 18:50:44.165368900 -0600
@@ -1,3 +1,8 @@
+2015-10-12  Brian Inglis  <Brian.Inglis@SystematicSw.ab.ca>
+
+	* libc/time/strftime.c (__strftime): add support for %s (seconds from
+	Unix epoch)
+
  2015-08-07  Stefan Wallentowitz  <stefan.wallentowitz@tum.de>
  
  	* libc/sys/or1k/mlock.c: Fix exception enable saving
--- a/newlib/libc/time/strftime.c	2015-08-20 03:39:24.000000000 -0600
+++ b/newlib/libc/time/strftime.c	2015-10-26 04:27:12.244016200 -0600
@@ -166,6 +166,10 @@ notations, the result is an empty string
  o %R
  The 24-hour time, to the minute.  Equivalent to "%H:%M". [tm_min, tm_hour]
  
+o %s
+The time elapsed, in seconds, since the start of the Unix epoch at
+1970-01-01 00:00:00 UTC.
+
  o %S
  The second, formatted with two digits (from `<<00>>' to `<<60>>').  The
  value 60 accounts for the occasional leap second. [tm_sec]
@@ -1109,6 +1113,74 @@ recurse:
  			  tim_p->tm_hour, tim_p->tm_min);
            CHECK_LENGTH ();
            break;
+	case CQ('s'):
+/*
+ * From:
+ * The Open Group Base Specifications Issue 7
+ * IEEE Std 1003.1, 2013 Edition
+ * Copyright (c) 2001-2013 The IEEE and The Open Group
+ * XBD Base Definitions
+ * 4. General Concepts
+ * 4.15 Seconds Since the Epoch
+ * A value that approximates the number of seconds that have elapsed since the
+ * Epoch. A Coordinated Universal Time name (specified in terms of seconds
+ * (tm_sec), minutes (tm_min), hours (tm_hour), days since January 1 of the year
+ * (tm_yday), and calendar year minus 1900 (tm_year)) is related to a time
+ * represented as seconds since the Epoch, according to the expression below.
+ * If the year is <1970 or the value is negative, the relationship is undefined.
+ * If the year is >=1970 and the value is non-negative, the value is related to a
+ * Coordinated Universal Time name according to the C-language expression, where
+ * tm_sec, tm_min, tm_hour, tm_yday, and tm_year are all integer types:
+ * tm_sec + tm_min*60 + tm_hour*3600 + tm_yday*86400 +
+ *     (tm_year-70)*31536000 + ((tm_year-69)/4)*86400 -
+ *     ((tm_year-1)/100)*86400 + ((tm_year+299)/400)*86400
+ * OR
+ * ((((tm_year-69)/4 - (tm_year-1)/100 + (tm_year+299)/400 +
+ *         (tm_year-70)*365 + tm_yday)*24 + tm_hour)*60 + tm_min)*60 + tm_sec
+ */
+/* modified from %z case by hoisting offset outside if block and initializing */
+	  {
+	    long offset;	/* offset < 0 => W of GMT, > 0 => E of GMT:
+	    offset = 0;	   subtract to get UTC */
+
+	    if (tim_p->tm_isdst >= 0)
+	      {
+		TZ_LOCK;
+		if (!tzset_called)
+		  {
+		    _tzset_unlocked ();
+		    tzset_called = 1;
+		  }
+
+#if defined (__CYGWIN__)
+		/* Cygwin must check if the application has been built with or
+		   without the extra tm members for backward compatibility, and
+		   then use either that or the old method fetching from tzinfo.
+		   Rather than pulling in the version check infrastructure, we
+		   just call a Cygwin function. */
+		extern long __cygwin_gettzoffset (const struct tm *tmp);
+		offset = __cygwin_gettzoffset (tim_p);
+#elif defined (__TM_GMTOFF)
+		offset = tim_p->__TM_GMTOFF;
+#else
+		__tzinfo_type *tz = __gettzinfo ();
+		/* The sign of this is exactly opposite the envvar TZ.  We
+		   could directly use the global _timezone for tm_isdst==0,
+		   but have to use __tzrule for daylight savings.  */
+		offset = -tz->__tzrule[tim_p->tm_isdst > 0].offset;
+#endif
+		TZ_UNLOCK;
+	      }
+	    len = snprintf (&s[count], maxsize - count, CQ("%lld"),
+			    (((((long long)tim_p->tm_year - 69)/4
+				- (tim_p->tm_year - 1)/100
+				+ (tim_p->tm_year + 299)/400
+				+ (tim_p->tm_year - 70)*365 + tim_p->tm_yday)*24
+			      + tim_p->tm_hour)*60 + tim_p->tm_min)*60
+			    + tim_p->tm_sec - offset);
+	    CHECK_LENGTH ();
+	  }
+          break;
  	case CQ('S'):
  #ifdef _WANT_C99_TIME_FORMATS
  	  if (alt != CQ('O') || !*alt_digits
@@ -1442,6 +1514,7 @@ const struct test  Vec0[] = {
  	{ CQ("%p"), 2+1, EXP(CQ("AM")) },
  	{ CQ("%r"), 11+1, EXP(CQ("09:53:47 AM")) },
  	{ CQ("%R"), 5+1, EXP(CQ("09:53")) },
+	{ CQ("%s"), 2+1, EXP(CQ("1230648827")) },
  	{ CQ("%S"), 2+1, EXP(CQ("47")) },
  	{ CQ("%t"), 1+1, EXP(CQ("\t")) },
  	{ CQ("%T"), 8+1, EXP(CQ("09:53:47")) },
@@ -1502,6 +1575,7 @@ const struct test  Vec1[] = {
  	{ CQ("%p"), 2+1, EXP(CQ("PM")) },
  	{ CQ("%r"), 11+1, EXP(CQ("11:01:13 PM")) },
  	{ CQ("%R"), 5+1, EXP(CQ("23:01")) },
+	{ CQ("%s"), 2+1, EXP(CQ("1215054073")) },
  	{ CQ("%S"), 2+1, EXP(CQ("13")) },
  	{ CQ("%t"), 1+1, EXP(CQ("\t")) },
  	{ CQ("%T"), 8+1, EXP(CQ("23:01:13")) },
