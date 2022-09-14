Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
	by sourceware.org (Postfix) with ESMTPS id CAF673858D1E;
	Wed, 14 Sep 2022 02:52:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org CAF673858D1E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=systematicsw.ab.ca
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
	by cmsmtp with ESMTP
	id Y9pNo75dcSp39YIW1oJQwT; Wed, 14 Sep 2022 02:52:41 +0000
Received: from BWINGLISD.cg.shawcable.net. ([184.64.124.72])
	by cmsmtp with ESMTP
	id YIW0o9xvGUAunYIW0omFTT; Wed, 14 Sep 2022 02:52:41 +0000
X-Authority-Analysis: v=2.4 cv=JLIoDuGb c=1 sm=1 tr=0 ts=632141f9
 a=oHm12aVswOWz6TMtn9zYKg==:117 a=oHm12aVswOWz6TMtn9zYKg==:17
 a=r77TgQKjGQsHNAKrUKIA:9 a=9pJ1AMZdf05kdrFBZ94A:9 a=QEXdDO2ut3YA:10
 a=Cs6KjGMHNyW6j4wEKIQA:9 a=B2y7HmGcmWMA:10
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: Cygwin Patches <cygwin-patches@cygwin.com>,
	Cygwin Patches <Cygwin-Patches@Cygwin.com>
Cc: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: [PATCH 1/3] strftime.c(__strftime): add %i, %q, %v, tests; tweak %Z docs
Date: Tue, 13 Sep 2022 20:52:34 -0600
Message-Id: <20220914025236.54080-2-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220914025236.54080-1-Brian.Inglis@SystematicSW.ab.ca>
References: <20220914025236.54080-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.37.2"
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfM23VLGQFvuNfKqBdw8DaV4pOsO8L9Jt+0ygNR9cfCZB2BXyCF8MXIL0YZNhEgVViKWsqMXh1U4DlZ/f7SSDC2LvJD44ZIU+VuE3DoLOp7la9pn8yZzl
 UKgAsqaEq+qVKiuTNgxtF192jhMigqdKRh9Zxa6M5aMScdxityPacQ4pbQiMGlDUzlaJKTbNINWCGfRaU55Jw4lLjZi1pCQ/mHH1ZuLH1rX5R86LxmkDebUK
 AdORPd1AQhUi4GFB/QfYH1EIoRQoxwDlE/zxGcycHGWaA/1qgXI4xipBOeOJt1iSb+PCaraa5pTswgzMdcNi5A==
X-Spam-Status: No, score=-1169.8 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_NONE,SPF_NONE,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------2.37.2
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


newlib/libc/time/strftime.c(__strftime):
%i year in century [00..99] Synonym for "%y". Non-POSIX extension. [tm_year]
%q GNU quarter of the year (from `<<1>>' to `<<4>>') [tm_mon]
%v OSX/Ruby VMS/Oracle date "%d-%b-%Y". Non-POSIX extension. [tm_mday, tm_mon, tm_year]
%Z clarify current time zone *abbreviation* not "name" [tm_isdst]
---
 newlib/libc/time/strftime.c | 67 +++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 3 deletions(-)


--------------2.37.2
Content-Type: text/x-patch; name="0001-strftime.c-__strftime-add-i-q-v-tests-tweak-Z-docs.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-strftime.c-__strftime-add-i-q-v-tests-tweak-Z-docs.patch"

diff --git a/newlib/libc/time/strftime.c b/newlib/libc/time/strftime.c
index 9c884dca9766..d434c0d0233c 100644
--- a/newlib/libc/time/strftime.c
+++ b/newlib/libc/time/strftime.c
@@ -128,6 +128,9 @@ o %I
 The hour (on a 12-hour clock), formatted with two digits (from
 `<<01>>' to `<<12>>'). [tm_hour]
 
+o %i
+Synonym for "%y". Non-POSIX extension. [tm_year]
+
 o %j
 The count of days in the year, formatted with three digits
 (from `<<001>>' to `<<366>>'). [tm_yday]
@@ -161,6 +164,10 @@ the current locale. [tm_hour]
 o %P
 Same as '<<%p>>', but in lowercase.  This is a GNU extension. [tm_hour]
 
+o %q
+Quarter of the year (from `<<1>>' to `<<4>>'), with January starting
+the first quarter. This is a GNU extension. [tm_mon]
+
 o %r
 Replaced by the time in a.m. and p.m. notation.  In the "C" locale this
 is equivalent to "%I:%M:%S %p".  In locales which don't define a.m./p.m.
@@ -198,6 +205,10 @@ The week number, where weeks start on Monday, week 1 contains January 4th,
 and earlier days are in the previous year.  Formatted with two digits
 (from `<<01>>' to `<<53>>').  See also <<%G>>. [tm_year, tm_wday, tm_yday]
 
+o %v
+A string representing the OSX/Ruby VMS/Oracle date format, in the form
+`<<"%d-%b-%Y">>'. Non-POSIX extension. [tm_mday, tm_mon, tm_year]
+
 o %w
 The weekday as a number, 0-based from Sunday (from `<<0>>' to `<<6>>').
 [tm_wday]
@@ -235,9 +246,9 @@ savings offset for the current timezone. The offset is determined from
 the TZ environment variable, as if by calling tzset(). [tm_isdst]
 
 o %Z
-The time zone name.  If tm_isdst is negative, no output is generated.
-Otherwise, the time zone name is based on the TZ environment variable,
-as if by calling tzset(). [tm_isdst]
+The current time zone abbreviation. If tm_isdst is negative, no output
+is generated. Otherwise, the time zone abbreviation is based on the TZ
+environment variable, as if by calling tzset(). [tm_isdst]
 
 o %%
 A single character, `<<%>>'.
@@ -1086,6 +1097,11 @@ recurse:
 		return 0;
 	    }
 	  break;
+	case CQ('q'):	/* GNU quarter year */
+	  len = snprintf (&s[count], maxsize - count, CQ("%.1d"),
+			  tim_p->tm_mon / 3 + 1);
+	  CHECK_LENGTH ();
+	  break;
 	case CQ('R'):
           len = snprintf (&s[count], maxsize - count, CQ("%.2d:%.2d"),
 			  tim_p->tm_hour, tim_p->tm_min);
@@ -1241,6 +1257,36 @@ recurse:
             CHECK_LENGTH ();
 	  }
           break;
+	case CQ('v'):	/* OSX/Ruby extension VMS/Oracle date format */
+	  { /* %v is equivalent to "%d-%b-%Y", flags and width can change year
+	       format. Recurse to avoid need to replicate %b and %Y formation. */
+	    CHAR fmtbuf[32], *fmt = fmtbuf;
+	    STRCPY (fmt, CQ("%d-%b-%"));
+	    fmt += strlen (fmt);
+	    if (pad) /* '0' or '+' */
+	      *fmt++ = pad;
+	    else
+	      *fmt++ = '+';
+	    if (!pad)
+	      width = 10;
+	    if (width < 6)
+	      width = 6;
+	    width -= 6;
+	    if (width)
+	      {
+		len = snprintf (fmt, fmtbuf + 32 - fmt, CQ("%lu"), width);
+		if (len > 0)
+		  fmt += len;
+	      }
+	    STRCPY (fmt, CQ("Y"));
+	    len = __strftime (&s[count], maxsize - count, fmtbuf, tim_p,
+			      locale, era_info, alt_digits);
+	    if (len > 0)
+	      count += len;
+	    else
+	      return 0;
+	  }
+	  break;
 	case CQ('w'):
 #ifdef _WANT_C99_TIME_FORMATS
 	  if (alt == CQ('O') && *alt_digits)
@@ -1270,6 +1316,7 @@ recurse:
             CHECK_LENGTH ();
 	  }
 	  break;
+	case CQ('i'):	/* Non-POSIX extension. */
 	case CQ('y'):
 	    {
 #ifdef _WANT_C99_TIME_FORMATS
@@ -1524,6 +1571,7 @@ const struct test  Vec0[] = {
 	{ CQ("%h"), 3+1, EXP(CQ("Dec")) },
 	{ CQ("%H"), 2+1, EXP(CQ("09")) },
 	{ CQ("%I"), 2+1, EXP(CQ("09")) },
+	{ CQ("%i"), 2+1, EXP(CQ("08")) },
 	{ CQ("%j"), 3+1, EXP(CQ("365")) },
 	{ CQ("%k"), 2+1, EXP(CQ(" 9")) },
 	{ CQ("%l"), 2+1, EXP(CQ(" 9")) },
@@ -1531,6 +1579,7 @@ const struct test  Vec0[] = {
 	{ CQ("%M"), 2+1, EXP(CQ("53")) },
 	{ CQ("%n"), 1+1, EXP(CQ("\n")) },
 	{ CQ("%p"), 2+1, EXP(CQ("AM")) },
+	{ CQ("%q"), 1+1, EXP(CQ("4")) },
 	{ CQ("%r"), 11+1, EXP(CQ("09:53:47 AM")) },
 	{ CQ("%R"), 5+1, EXP(CQ("09:53")) },
 	{ CQ("%s"), 2+1, EXP(CQ("1230648827")) },
@@ -1540,6 +1589,7 @@ const struct test  Vec0[] = {
 	{ CQ("%u"), 1+1, EXP(CQ("2")) },
 	{ CQ("%U"), 2+1, EXP(CQ("52")) },
 	{ CQ("%V"), 2+1, EXP(CQ("01")) },
+	{ CQ("%v"), 11+1, EXP(CQ("30-Dec-2008")) },
 	{ CQ("%w"), 1+1, EXP(CQ("2")) },
 	{ CQ("%W"), 2+1, EXP(CQ("52")) },
 	{ CQ("%x"), 8+1, EXP(CQ("12/30/08")) },
@@ -1585,6 +1635,7 @@ const struct test  Vec1[] = {
 	{ CQ("%h"), 3+1, EXP(CQ("Jul")) },
 	{ CQ("%H"), 2+1, EXP(CQ("23")) },
 	{ CQ("%I"), 2+1, EXP(CQ("11")) },
+	{ CQ("%i"), 2+1, EXP(CQ("08")) },
 	{ CQ("%j"), 3+1, EXP(CQ("184")) },
 	{ CQ("%k"), 2+1, EXP(CQ("23")) },
 	{ CQ("%l"), 2+1, EXP(CQ("11")) },
@@ -1592,6 +1643,7 @@ const struct test  Vec1[] = {
 	{ CQ("%M"), 2+1, EXP(CQ("01")) },
 	{ CQ("%n"), 1+1, EXP(CQ("\n")) },
 	{ CQ("%p"), 2+1, EXP(CQ("PM")) },
+	{ CQ("%q"), 1+1, EXP(CQ("3")) },
 	{ CQ("%r"), 11+1, EXP(CQ("11:01:13 PM")) },
 	{ CQ("%R"), 5+1, EXP(CQ("23:01")) },
 	{ CQ("%s"), 2+1, EXP(CQ("1215054073")) },
@@ -1601,6 +1653,7 @@ const struct test  Vec1[] = {
 	{ CQ("%u"), 1+1, EXP(CQ("3")) },
 	{ CQ("%U"), 2+1, EXP(CQ("26")) },
 	{ CQ("%V"), 2+1, EXP(CQ("27")) },
+	{ CQ("%v"), 11+1, EXP(CQ("02-Jul-2008")) },
 	{ CQ("%w"), 1+1, EXP(CQ("3")) },
 	{ CQ("%W"), 2+1, EXP(CQ("26")) },
 	{ CQ("%x"), 8+1, EXP(CQ("07/02/08")) },
@@ -1662,6 +1715,8 @@ const struct test  Vecyr0[] = {
 	{ CQ("%c"), OUTSIZE, EXP(CQ("Wed Jul  2 23:01:13 ")YEAR) },
 	{ CQ("%D"), OUTSIZE, EXP(CQ("07/02/")Year) },
 	{ CQ("%F"), OUTSIZE, EXP(YEAR CQ("-07-02")) },
+	{ CQ("%i"), OUTSIZE, EXP(Year) },
+	{ CQ("%v"), OUTSIZE, EXP(CQ("02-Jul-")YEAR) },
 	{ CQ("%x"), OUTSIZE, EXP(CQ("07/02/")Year) },
 	{ CQ("%y"), OUTSIZE, EXP(Year) },
 	{ CQ("%Y"), OUTSIZE, EXP(YEAR) },
@@ -1708,6 +1763,8 @@ const struct test  Vecyr1[] = {
 	{ CQ("%c"), OUTSIZE, EXP(CQ("Wed Jul  2 23:01:13 ")YEAR) },
 	{ CQ("%D"), OUTSIZE, EXP(CQ("07/02/")Year) },
 	{ CQ("%F"), OUTSIZE, EXP(YEAR CQ("-07-02")) },
+	{ CQ("%i"), OUTSIZE, EXP(Year) },
+	{ CQ("%v"), OUTSIZE, EXP(CQ("02-Jul-")YEAR) },
 	{ CQ("%x"), OUTSIZE, EXP(CQ("07/02/")Year) },
 	{ CQ("%y"), OUTSIZE, EXP(Year) },
 	{ CQ("%Y"), OUTSIZE, EXP(YEAR) },
@@ -1745,6 +1802,8 @@ const struct test  Vecyrzp[] = {
 	{ CQ("%c"), OUTSIZE, EXP(CQ("Wed Jul  2 23:01:60 ")YEAR) },
 	{ CQ("%D"), OUTSIZE, EXP(CQ("07/02/")Year) },
 	{ CQ("%F"), OUTSIZE, EXP(YEAR CQ("-07-02")) },
+	{ CQ("%i"), OUTSIZE, EXP(Year) },
+	{ CQ("%v"), OUTSIZE, EXP(CQ("02-Jul-")YEAR) },
 	{ CQ("%x"), OUTSIZE, EXP(CQ("07/02/")Year) },
 	{ CQ("%y"), OUTSIZE, EXP(Year) },
 	{ CQ("%Y"), OUTSIZE, EXP(YEAR) },
@@ -1780,6 +1839,8 @@ const struct test  Vecyrzn[] = {
 	{ CQ("%c"), OUTSIZE, EXP(CQ("Wed Jul  2 23:01:00 ")YEAR) },
 	{ CQ("%D"), OUTSIZE, EXP(CQ("07/02/")Year) },
 	{ CQ("%F"), OUTSIZE, EXP(YEAR CQ("-07-02")) },
+	{ CQ("%i"), OUTSIZE, EXP(Year) },
+	{ CQ("%v"), OUTSIZE, EXP(CQ("02-Jul-")YEAR) },
 	{ CQ("%x"), OUTSIZE, EXP(CQ("07/02/")Year) },
 	{ CQ("%y"), OUTSIZE, EXP(Year) },
 	{ CQ("%Y"), OUTSIZE, EXP(YEAR) },

--------------2.37.2--


