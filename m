Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id 02A6E38708D0
 for <cygwin-patches@cygwin.com>; Fri, 22 May 2020 09:33:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 02A6E38708D0
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=mark@maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 04M9XAYO026034;
 Fri, 22 May 2020 02:33:10 -0700 (PDT) (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdLZlfyV; Fri May 22 02:33:05 2020
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/3 v3] Cygwin: tzcode resync: imports
Date: Fri, 22 May 2020 02:32:52 -0700
Message-Id: <20200522093253.995-3-mark@maxrnd.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200522093253.995-1-mark@maxrnd.com>
References: <20200522093253.995-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.6 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, SCC_5_SHORT_WORD_LINES,
 SPF_HELO_NONE, SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Fri, 22 May 2020 09:33:21 -0000

Import most recent NetBSD localtime.c, private.h, and tzfile.h.  An
empty namespace.h suffices for Cygwin.

---
 winsup/cygwin/tzcode/localtime.c | 2493 ++++++++++++++++++++++++++++++
 winsup/cygwin/tzcode/namespace.h |    0
 winsup/cygwin/tzcode/private.h   |  795 ++++++++++
 winsup/cygwin/tzcode/tzfile.h    |  174 +++
 4 files changed, 3462 insertions(+)
 create mode 100644 winsup/cygwin/tzcode/localtime.c
 create mode 100644 winsup/cygwin/tzcode/namespace.h
 create mode 100644 winsup/cygwin/tzcode/private.h
 create mode 100644 winsup/cygwin/tzcode/tzfile.h

diff --git a/winsup/cygwin/tzcode/localtime.c b/winsup/cygwin/tzcode/localtime.c
new file mode 100644
index 000000000..a4d02a4c7
--- /dev/null
+++ b/winsup/cygwin/tzcode/localtime.c
@@ -0,0 +1,2493 @@
+/*	$NetBSD: localtime.c,v 1.122 2019/07/03 15:50:16 christos Exp $	*/
+
+/* Convert timestamp from time_t to struct tm.  */
+
+/*
+** This file is in the public domain, so clarified as of
+** 1996-06-05 by Arthur David Olson.
+*/
+
+#include <sys/cdefs.h>
+#if defined(LIBC_SCCS) && !defined(lint)
+#if 0
+static char	elsieid[] = "@(#)localtime.c	8.17";
+#else
+__RCSID("$NetBSD: localtime.c,v 1.122 2019/07/03 15:50:16 christos Exp $");
+#endif
+#endif /* LIBC_SCCS and not lint */
+
+/*
+** Leap second handling from Bradley White.
+** POSIX-style TZ environment variable handling from Guy Harris.
+*/
+
+/*LINTLIBRARY*/
+
+#include "namespace.h"
+#include <assert.h>
+#define LOCALTIME_IMPLEMENTATION
+#include "private.h"
+
+#include "tzfile.h"
+#include <fcntl.h>
+
+#if NETBSD_INSPIRED
+# define NETBSD_INSPIRED_EXTERN
+#else
+# define NETBSD_INSPIRED_EXTERN static
+#endif
+
+#if defined(__weak_alias)
+__weak_alias(daylight,_daylight)
+__weak_alias(tzname,_tzname)
+#endif
+
+#ifndef TZ_ABBR_MAX_LEN
+#define TZ_ABBR_MAX_LEN	16
+#endif /* !defined TZ_ABBR_MAX_LEN */
+
+#ifndef TZ_ABBR_CHAR_SET
+#define TZ_ABBR_CHAR_SET \
+	"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 :+-._"
+#endif /* !defined TZ_ABBR_CHAR_SET */
+
+#ifndef TZ_ABBR_ERR_CHAR
+#define TZ_ABBR_ERR_CHAR	'_'
+#endif /* !defined TZ_ABBR_ERR_CHAR */
+
+/*
+** SunOS 4.1.1 headers lack O_BINARY.
+*/
+
+#ifdef O_BINARY
+#define OPEN_MODE	(O_RDONLY | O_BINARY | O_CLOEXEC)
+#endif /* defined O_BINARY */
+#ifndef O_BINARY
+#define OPEN_MODE	(O_RDONLY | O_CLOEXEC)
+#endif /* !defined O_BINARY */
+
+#ifndef WILDABBR
+/*
+** Someone might make incorrect use of a time zone abbreviation:
+**	1.	They might reference tzname[0] before calling tzset (explicitly
+**		or implicitly).
+**	2.	They might reference tzname[1] before calling tzset (explicitly
+**		or implicitly).
+**	3.	They might reference tzname[1] after setting to a time zone
+**		in which Daylight Saving Time is never observed.
+**	4.	They might reference tzname[0] after setting to a time zone
+**		in which Standard Time is never observed.
+**	5.	They might reference tm.TM_ZONE after calling offtime.
+** What's best to do in the above cases is open to debate;
+** for now, we just set things up so that in any of the five cases
+** WILDABBR is used. Another possibility: initialize tzname[0] to the
+** string "tzname[0] used before set", and similarly for the other cases.
+** And another: initialize tzname[0] to "ERA", with an explanation in the
+** manual page of what this "time zone abbreviation" means (doing this so
+** that tzname[0] has the "normal" length of three characters).
+*/
+#define WILDABBR	"   "
+#endif /* !defined WILDABBR */
+
+static const char	wildabbr[] = WILDABBR;
+
+static const char	gmt[] = "GMT";
+
+/*
+** The DST rules to use if TZ has no rules and we can't load TZDEFRULES.
+** Default to US rules as of 2017-05-07.
+** POSIX does not specify the default DST rules;
+** for historical reasons, US rules are a common default.
+*/
+#ifndef TZDEFRULESTRING
+#define TZDEFRULESTRING ",M3.2.0,M11.1.0"
+#endif
+
+struct ttinfo {				/* time type information */
+	int_fast32_t	tt_utoff;	/* UT offset in seconds */
+	bool		tt_isdst;	/* used to set tm_isdst */
+	int		tt_desigidx;	/* abbreviation list index */
+	bool		tt_ttisstd;	/* transition is std time */
+	bool		tt_ttisut;	/* transition is UT */
+};
+
+struct lsinfo {				/* leap second information */
+	time_t		ls_trans;	/* transition time */
+	int_fast64_t	ls_corr;	/* correction to apply */
+};
+
+#define SMALLEST(a, b)	(((a) < (b)) ? (a) : (b))
+#define BIGGEST(a, b)	(((a) > (b)) ? (a) : (b))
+
+#ifdef TZNAME_MAX
+#define MY_TZNAME_MAX	TZNAME_MAX
+#endif /* defined TZNAME_MAX */
+#ifndef TZNAME_MAX
+#define MY_TZNAME_MAX	255
+#endif /* !defined TZNAME_MAX */
+
+#define state __state
+struct state {
+	int		leapcnt;
+	int		timecnt;
+	int		typecnt;
+	int		charcnt;
+	bool		goback;
+	bool		goahead;
+	time_t		ats[TZ_MAX_TIMES];
+	unsigned char	types[TZ_MAX_TIMES];
+	struct ttinfo	ttis[TZ_MAX_TYPES];
+	char		chars[/*CONSTCOND*/BIGGEST(BIGGEST(TZ_MAX_CHARS + 1,
+				sizeof gmt), (2 * (MY_TZNAME_MAX + 1)))];
+	struct lsinfo	lsis[TZ_MAX_LEAPS];
+
+	/* The time type to use for early times or if no transitions.
+	   It is always zero for recent tzdb releases.
+	   It might be nonzero for data from tzdb 2018e or earlier.  */
+	int defaulttype;
+};
+
+enum r_type {
+  JULIAN_DAY,		/* Jn = Julian day */
+  DAY_OF_YEAR,		/* n = day of year */
+  MONTH_NTH_DAY_OF_WEEK	/* Mm.n.d = month, week, day of week */
+};
+
+struct rule {
+	enum r_type	r_type;		/* type of rule */
+	int		r_day;		/* day number of rule */
+	int		r_week;		/* week number of rule */
+	int		r_mon;		/* month number of rule */
+	int_fast32_t	r_time;		/* transition time of rule */
+};
+
+static struct tm *gmtsub(struct state const *, time_t const *, int_fast32_t,
+			 struct tm *);
+static bool increment_overflow(int *, int);
+static bool increment_overflow_time(time_t *, int_fast32_t);
+static bool normalize_overflow32(int_fast32_t *, int *, int);
+static struct tm *timesub(time_t const *, int_fast32_t, struct state const *,
+			  struct tm *);
+static bool typesequiv(struct state const *, int, int);
+static bool tzparse(char const *, struct state *, bool);
+
+static timezone_t gmtptr;
+
+#ifndef TZ_STRLEN_MAX
+#define TZ_STRLEN_MAX 255
+#endif /* !defined TZ_STRLEN_MAX */
+
+static char		lcl_TZname[TZ_STRLEN_MAX + 1];
+static int		lcl_is_set;
+
+
+#if !defined(__LIBC12_SOURCE__)
+timezone_t __lclptr;
+#ifdef _REENTRANT
+rwlock_t __lcl_lock = RWLOCK_INITIALIZER;
+#endif
+#endif
+
+/*
+** Section 4.12.3 of X3.159-1989 requires that
+**	Except for the strftime function, these functions [asctime,
+**	ctime, gmtime, localtime] return values in one of two static
+**	objects: a broken-down time structure and an array of char.
+** Thanks to Paul Eggert for noting this.
+*/
+
+static struct tm	tm;
+
+#if !HAVE_POSIX_DECLS || TZ_TIME_T || defined(__NetBSD__)
+# if !defined(__LIBC12_SOURCE__)
+
+__aconst char *		tzname[2] = {
+	(__aconst char *)__UNCONST(wildabbr),
+	(__aconst char *)__UNCONST(wildabbr)
+};
+
+# else
+
+extern __aconst char *	tzname[2];
+
+# endif /* __LIBC12_SOURCE__ */
+
+# if USG_COMPAT
+#  if !defined(__LIBC12_SOURCE__)
+long 			timezone = 0;
+int			daylight = 0;
+#  else
+extern int		daylight;
+extern long		timezone __RENAME(__timezone13);
+#  endif /* __LIBC12_SOURCE__ */
+# endif /* defined USG_COMPAT */
+
+# ifdef ALTZONE
+long			altzone = 0;
+# endif /* defined ALTZONE */
+#endif /* !HAVE_POSIX_DECLS */
+
+/* Initialize *S to a value based on UTOFF, ISDST, and DESIGIDX.  */
+static void
+init_ttinfo(struct ttinfo *s, int_fast32_t utoff, bool isdst, int desigidx)
+{
+	s->tt_utoff = utoff;
+	s->tt_isdst = isdst;
+	s->tt_desigidx = desigidx;
+	s->tt_ttisstd = false;
+	s->tt_ttisut = false;
+}
+
+static int_fast32_t
+detzcode(const char *const codep)
+{
+	int_fast32_t result;
+	int	i;
+	int_fast32_t one = 1;
+	int_fast32_t halfmaxval = one << (32 - 2);
+	int_fast32_t maxval = halfmaxval - 1 + halfmaxval;
+	int_fast32_t minval = -1 - maxval;
+
+	result = codep[0] & 0x7f;
+	for (i = 1; i < 4; ++i)
+		result = (result << 8) | (codep[i] & 0xff);
+
+	if (codep[0] & 0x80) {
+	  /* Do two's-complement negation even on non-two's-complement machines.
+	     If the result would be minval - 1, return minval.  */
+	    result -= !TWOS_COMPLEMENT(int_fast32_t) && result != 0;
+	    result += minval;
+	}
+ 	return result;
+}
+
+static int_fast64_t
+detzcode64(const char *const codep)
+{
+	int_fast64_t result;
+	int	i;
+	int_fast64_t one = 1;
+	int_fast64_t halfmaxval = one << (64 - 2);
+	int_fast64_t maxval = halfmaxval - 1 + halfmaxval;
+	int_fast64_t minval = -TWOS_COMPLEMENT(int_fast64_t) - maxval;
+
+	result = codep[0] & 0x7f;
+	for (i = 1; i < 8; ++i)
+		result = (result << 8) | (codep[i] & 0xff);
+
+	if (codep[0] & 0x80) {
+	  /* Do two's-complement negation even on non-two's-complement machines.
+	     If the result would be minval - 1, return minval.  */
+	  result -= !TWOS_COMPLEMENT(int_fast64_t) && result != 0;
+	  result += minval;
+	}
+ 	return result;
+}
+
+#include <stdio.h>
+
+const char *
+tzgetname(const timezone_t sp, int isdst)
+{
+	int i;
+	const char *name = NULL;
+	for (i = 0; i < sp->typecnt; ++i) {
+		const struct ttinfo *const ttisp = &sp->ttis[i];
+		if (ttisp->tt_isdst == isdst)
+			name = &sp->chars[ttisp->tt_desigidx];
+	}
+	if (name != NULL)
+		return name;
+	errno = ESRCH;
+	return NULL;
+}
+
+long
+tzgetgmtoff(const timezone_t sp, int isdst)
+{
+	int i;
+	long l = -1;
+	for (i = 0; i < sp->typecnt; ++i) {
+		const struct ttinfo *const ttisp = &sp->ttis[i];
+
+		if (ttisp->tt_isdst == isdst) {
+			l = ttisp->tt_utoff;
+		}
+	}
+	if (l == -1)
+		errno = ESRCH;
+	return l;
+}
+
+static void
+scrub_abbrs(struct state *sp)
+{
+	int i;
+
+	/*
+	** First, replace bogus characters.
+	*/
+	for (i = 0; i < sp->charcnt; ++i)
+		if (strchr(TZ_ABBR_CHAR_SET, sp->chars[i]) == NULL)
+			sp->chars[i] = TZ_ABBR_ERR_CHAR;
+	/*
+	** Second, truncate long abbreviations.
+	*/
+	for (i = 0; i < sp->typecnt; ++i) {
+		const struct ttinfo * const	ttisp = &sp->ttis[i];
+		char *cp = &sp->chars[ttisp->tt_desigidx];
+
+		if (strlen(cp) > TZ_ABBR_MAX_LEN &&
+			strcmp(cp, GRANDPARENTED) != 0)
+				*(cp + TZ_ABBR_MAX_LEN) = '\0';
+	}
+}
+
+static void
+update_tzname_etc(const struct state *sp, const struct ttinfo *ttisp)
+{
+#if HAVE_TZNAME
+	tzname[ttisp->tt_isdst] = __UNCONST(&sp->chars[ttisp->tt_desigidx]);
+#endif
+#if USG_COMPAT
+	if (!ttisp->tt_isdst)
+		timezone = - ttisp->tt_utoff;
+#endif
+#ifdef ALTZONE
+	if (ttisp->tt_isdst)
+	    altzone = - ttisp->tt_utoff;
+#endif /* defined ALTZONE */
+}
+
+static void
+settzname(void)
+{
+	timezone_t const	sp = __lclptr;
+	int			i;
+
+#if HAVE_TZNAME
+	tzname[0] = tzname[1] =
+	    (__aconst char *) __UNCONST(sp ? wildabbr : gmt);
+#endif
+#if USG_COMPAT
+	daylight = 0;
+	timezone = 0;
+#endif
+#ifdef ALTZONE
+	altzone = 0;
+#endif /* defined ALTZONE */
+	if (sp == NULL) {
+		return;
+	}
+	/*
+	** And to get the latest time zone abbreviations into tzname. . .
+	*/
+	for (i = 0; i < sp->typecnt; ++i)
+		update_tzname_etc(sp, &sp->ttis[i]);
+
+	for (i = 0; i < sp->timecnt; ++i) {
+		const struct ttinfo * const ttisp = &sp->ttis[sp->types[i]];
+		update_tzname_etc(sp, ttisp);
+#if USG_COMPAT
+		if (ttisp->tt_isdst)
+			daylight = 1;
+#endif
+	}
+}
+
+static bool
+differ_by_repeat(const time_t t1, const time_t t0)
+{
+	if (TYPE_BIT(time_t) - TYPE_SIGNED(time_t) < SECSPERREPEAT_BITS)
+		return 0;
+	return (int_fast64_t)t1 - (int_fast64_t)t0 == SECSPERREPEAT;
+}
+
+union input_buffer {
+	/* The first part of the buffer, interpreted as a header.  */
+	struct tzhead tzhead;
+
+	/* The entire buffer.  */
+	char buf[2 * sizeof(struct tzhead) + 2 * sizeof (struct state)
+	  + 4 * TZ_MAX_TIMES];
+};
+
+/* TZDIR with a trailing '/' rather than a trailing '\0'.  */
+static char const tzdirslash[sizeof TZDIR] = TZDIR "/";
+
+/* Local storage needed for 'tzloadbody'.  */
+union local_storage {
+	/* The results of analyzing the file's contents after it is opened.  */
+	struct file_analysis {
+		/* The input buffer.  */
+		union input_buffer u;
+
+		/* A temporary state used for parsing a TZ string in the file.  */
+		struct state st;
+	} u;
+
+	/* The file name to be opened.  */
+	char fullname[/*CONSTCOND*/BIGGEST(sizeof (struct file_analysis),
+	    sizeof tzdirslash + 1024)];
+};
+
+/* Load tz data from the file named NAME into *SP.  Read extended
+   format if DOEXTEND.  Use *LSP for temporary storage.  Return 0 on
+   success, an errno value on failure.  */
+static int
+tzloadbody(char const *name, struct state *sp, bool doextend,
+  union local_storage *lsp)
+{
+	int			i;
+	int			fid;
+	int			stored;
+	ssize_t			nread;
+	bool			doaccess;
+	union input_buffer	*up = &lsp->u.u;
+	size_t			tzheadsize = sizeof(struct tzhead);
+
+	sp->goback = sp->goahead = false;
+
+	if (! name) {
+		name = TZDEFAULT;
+		if (! name)
+			return EINVAL;
+	}
+
+	if (name[0] == ':')
+		++name;
+#ifdef SUPPRESS_TZDIR
+	/* Do not prepend TZDIR.  This is intended for specialized
+	   applications only, due to its security implications.  */
+	doaccess = true;
+#else
+	doaccess = name[0] == '/';
+#endif
+	if (!doaccess) {
+		char const *dot;
+		size_t namelen = strlen(name);
+		if (sizeof lsp->fullname - sizeof tzdirslash <= namelen)
+			return ENAMETOOLONG;
+
+		/* Create a string "TZDIR/NAME".  Using sprintf here
+		   would pull in stdio (and would fail if the
+		   resulting string length exceeded INT_MAX!).  */
+		memcpy(lsp->fullname, tzdirslash, sizeof tzdirslash);
+		strcpy(lsp->fullname + sizeof tzdirslash, name);
+
+		/* Set doaccess if NAME contains a ".." file name
+		   component, as such a name could read a file outside
+		   the TZDIR virtual subtree.  */
+		for (dot = name; (dot = strchr(dot, '.')) != NULL; dot++)
+		  if ((dot == name || dot[-1] == '/') && dot[1] == '.'
+		      && (dot[2] == '/' || !dot[2])) {
+		    doaccess = true;
+		    break;
+		  }
+
+		name = lsp->fullname;
+	}
+	if (doaccess && access(name, R_OK) != 0)
+		return errno;
+
+	fid = open(name, OPEN_MODE);
+	if (fid < 0)
+		return errno;
+	nread = read(fid, up->buf, sizeof up->buf);
+	if (nread < (ssize_t)tzheadsize) {
+		int err = nread < 0 ? errno : EINVAL;
+		close(fid);
+		return err;
+	}
+	if (close(fid) < 0)
+		return errno;
+	for (stored = 4; stored <= 8; stored *= 2) {
+		int_fast32_t ttisstdcnt = detzcode(up->tzhead.tzh_ttisstdcnt);
+		int_fast32_t ttisutcnt = detzcode(up->tzhead.tzh_ttisutcnt);
+		int_fast64_t prevtr = 0;
+		int_fast32_t prevcorr = 0;
+		int_fast32_t leapcnt = detzcode(up->tzhead.tzh_leapcnt);
+		int_fast32_t timecnt = detzcode(up->tzhead.tzh_timecnt);
+		int_fast32_t typecnt = detzcode(up->tzhead.tzh_typecnt);
+		int_fast32_t charcnt = detzcode(up->tzhead.tzh_charcnt);
+		char const *p = up->buf + tzheadsize;
+		/* Although tzfile(5) currently requires typecnt to be nonzero,
+		   support future formats that may allow zero typecnt
+		   in files that have a TZ string and no transitions.  */
+		if (! (0 <= leapcnt && leapcnt < TZ_MAX_LEAPS
+		       && 0 <= typecnt && typecnt < TZ_MAX_TYPES
+		       && 0 <= timecnt && timecnt < TZ_MAX_TIMES
+		       && 0 <= charcnt && charcnt < TZ_MAX_CHARS
+		       && (ttisstdcnt == typecnt || ttisstdcnt == 0)
+		       && (ttisutcnt == typecnt || ttisutcnt == 0)))
+		  return EINVAL;
+		if ((size_t)nread
+		    < (tzheadsize		/* struct tzhead */
+		       + timecnt * stored	/* ats */
+		       + timecnt		/* types */
+		       + typecnt * 6		/* ttinfos */
+		       + charcnt		/* chars */
+		       + leapcnt * (stored + 4)	/* lsinfos */
+		       + ttisstdcnt		/* ttisstds */
+		       + ttisutcnt))		/* ttisuts */
+		  return EINVAL;
+		sp->leapcnt = leapcnt;
+		sp->timecnt = timecnt;
+		sp->typecnt = typecnt;
+		sp->charcnt = charcnt;
+
+		/* Read transitions, discarding those out of time_t range.
+		   But pretend the last transition before TIME_T_MIN
+		   occurred at TIME_T_MIN.  */
+		timecnt = 0;
+		for (i = 0; i < sp->timecnt; ++i) {
+			int_fast64_t at
+			  = stored == 4 ? detzcode(p) : detzcode64(p);
+			sp->types[i] = at <= TIME_T_MAX;
+			if (sp->types[i]) {
+				time_t attime
+				    = ((TYPE_SIGNED(time_t) ?
+				    at < TIME_T_MIN : at < 0)
+				    ? TIME_T_MIN : (time_t)at);
+				if (timecnt && attime <= sp->ats[timecnt - 1]) {
+					if (attime < sp->ats[timecnt - 1])
+						return EINVAL;
+					sp->types[i - 1] = 0;
+					timecnt--;
+				}
+				sp->ats[timecnt++] = attime;
+			}
+			p += stored;
+		}
+
+		timecnt = 0;
+		for (i = 0; i < sp->timecnt; ++i) {
+			unsigned char typ = *p++;
+			if (sp->typecnt <= typ)
+			  return EINVAL;
+			if (sp->types[i])
+				sp->types[timecnt++] = typ;
+		}
+		sp->timecnt = timecnt;
+		for (i = 0; i < sp->typecnt; ++i) {
+			struct ttinfo *	ttisp;
+			unsigned char isdst, desigidx;
+
+			ttisp = &sp->ttis[i];
+			ttisp->tt_utoff = detzcode(p);
+			p += 4;
+			isdst = *p++;
+			if (! (isdst < 2))
+				return EINVAL;
+			ttisp->tt_isdst = isdst;
+			desigidx = *p++;
+			if (! (desigidx < sp->charcnt))
+				return EINVAL;
+			ttisp->tt_desigidx = desigidx;
+		}
+		for (i = 0; i < sp->charcnt; ++i)
+			sp->chars[i] = *p++;
+		sp->chars[i] = '\0';	/* ensure '\0' at end */
+
+		/* Read leap seconds, discarding those out of time_t range.  */
+		leapcnt = 0;
+		for (i = 0; i < sp->leapcnt; ++i) {
+			int_fast64_t tr = stored == 4 ? detzcode(p) :
+			    detzcode64(p);
+			int_fast32_t corr = detzcode(p + stored);
+			p += stored + 4;
+			/* Leap seconds cannot occur before the Epoch.  */
+			if (tr < 0)
+				return EINVAL;
+			if (tr <= TIME_T_MAX) {
+		    /* Leap seconds cannot occur more than once per UTC month,
+		       and UTC months are at least 28 days long (minus 1
+		       second for a negative leap second).  Each leap second's
+		       correction must differ from the previous one's by 1
+		       second.  */
+				if (tr - prevtr < 28 * SECSPERDAY - 1
+				    || (corr != prevcorr - 1
+				    && corr != prevcorr + 1))
+					  return EINVAL;
+
+				sp->lsis[leapcnt].ls_trans =
+				    (time_t)(prevtr = tr);
+				sp->lsis[leapcnt].ls_corr = prevcorr = corr;
+				leapcnt++;
+			}
+		}
+		sp->leapcnt = leapcnt;
+
+		for (i = 0; i < sp->typecnt; ++i) {
+			struct ttinfo *	ttisp;
+
+			ttisp = &sp->ttis[i];
+			if (ttisstdcnt == 0)
+				ttisp->tt_ttisstd = false;
+			else {
+				if (*p != true && *p != false)
+				  return EINVAL;
+				ttisp->tt_ttisstd = *p++;
+			}
+		}
+		for (i = 0; i < sp->typecnt; ++i) {
+			struct ttinfo *	ttisp;
+
+			ttisp = &sp->ttis[i];
+			if (ttisutcnt == 0)
+				ttisp->tt_ttisut = false;
+			else {
+				if (*p != true && *p != false)
+						return EINVAL;
+				ttisp->tt_ttisut = *p++;
+			}
+		}
+		/*
+		** If this is an old file, we're done.
+		*/
+		if (up->tzhead.tzh_version[0] == '\0')
+			break;
+		nread -= p - up->buf;
+		memmove(up->buf, p, (size_t)nread);
+	}
+	if (doextend && nread > 2 &&
+		up->buf[0] == '\n' && up->buf[nread - 1] == '\n' &&
+		sp->typecnt + 2 <= TZ_MAX_TYPES) {
+			struct state *ts = &lsp->u.st;
+
+			up->buf[nread - 1] = '\0';
+			if (tzparse(&up->buf[1], ts, false)) {
+
+			  /* Attempt to reuse existing abbreviations.
+			     Without this, America/Anchorage would be right on
+			     the edge after 2037 when TZ_MAX_CHARS is 50, as
+			     sp->charcnt equals 40 (for LMT AST AWT APT AHST
+			     AHDT YST AKDT AKST) and ts->charcnt equals 10
+			     (for AKST AKDT).  Reusing means sp->charcnt can
+			     stay 40 in this example.  */
+			  int gotabbr = 0;
+			  int charcnt = sp->charcnt;
+			  for (i = 0; i < ts->typecnt; i++) {
+			    char *tsabbr = ts->chars + ts->ttis[i].tt_desigidx;
+			    int j;
+			    for (j = 0; j < charcnt; j++)
+			      if (strcmp(sp->chars + j, tsabbr) == 0) {
+				ts->ttis[i].tt_desigidx = j;
+				gotabbr++;
+				break;
+			      }
+			    if (! (j < charcnt)) {
+			      size_t tsabbrlen = strlen(tsabbr);
+			      if (j + tsabbrlen < TZ_MAX_CHARS) {
+				strcpy(sp->chars + j, tsabbr);
+				charcnt = (int_fast32_t)(j + tsabbrlen + 1);
+				ts->ttis[i].tt_desigidx = j;
+				gotabbr++;
+			      }
+			    }
+			  }
+			  if (gotabbr == ts->typecnt) {
+			    sp->charcnt = charcnt;
+
+			    /* Ignore any trailing, no-op transitions generated
+			       by zic as they don't help here and can run afoul
+			       of bugs in zic 2016j or earlier.  */
+			    while (1 < sp->timecnt
+				   && (sp->types[sp->timecnt - 1]
+				       == sp->types[sp->timecnt - 2]))
+			      sp->timecnt--;
+
+			    for (i = 0; i < ts->timecnt; i++)
+			      if (sp->timecnt == 0
+				  || sp->ats[sp->timecnt - 1] < ts->ats[i])
+				break;
+			    while (i < ts->timecnt
+				   && sp->timecnt < TZ_MAX_TIMES) {
+			      sp->ats[sp->timecnt] = ts->ats[i];
+			      sp->types[sp->timecnt] = (sp->typecnt
+							+ ts->types[i]);
+			      sp->timecnt++;
+			      i++;
+			    }
+			    for (i = 0; i < ts->typecnt; i++)
+			      sp->ttis[sp->typecnt++] = ts->ttis[i];
+			  }
+			}
+	}
+	if (sp->typecnt == 0)
+	  return EINVAL;
+	if (sp->timecnt > 1) {
+		for (i = 1; i < sp->timecnt; ++i)
+			if (typesequiv(sp, sp->types[i], sp->types[0]) &&
+				differ_by_repeat(sp->ats[i], sp->ats[0])) {
+					sp->goback = true;
+					break;
+				}
+		for (i = sp->timecnt - 2; i >= 0; --i)
+			if (typesequiv(sp, sp->types[sp->timecnt - 1],
+				sp->types[i]) &&
+				differ_by_repeat(sp->ats[sp->timecnt - 1],
+				sp->ats[i])) {
+					sp->goahead = true;
+					break;
+		}
+	}
+
+	/* Infer sp->defaulttype from the data.  Although this default
+	   type is always zero for data from recent tzdb releases,
+	   things are trickier for data from tzdb 2018e or earlier.
+
+	   The first set of heuristics work around bugs in 32-bit data
+	   generated by tzdb 2013c or earlier.  The workaround is for
+	   zones like Australia/Macquarie where timestamps before the
+	   first transition have a time type that is not the earliest
+	   standard-time type.  See:
+	   https://mm.icann.org/pipermail/tz/2013-May/019368.html */
+	/*
+	** If type 0 is unused in transitions,
+	** it's the type to use for early times.
+	*/
+	for (i = 0; i < sp->timecnt; ++i)
+		if (sp->types[i] == 0)
+			break;
+	i = i < sp->timecnt ? -1 : 0;
+	/*
+	** Absent the above,
+	** if there are transition times
+	** and the first transition is to a daylight time
+	** find the standard type less than and closest to
+	** the type of the first transition.
+	*/
+	if (i < 0 && sp->timecnt > 0 && sp->ttis[sp->types[0]].tt_isdst) {
+		i = sp->types[0];
+		while (--i >= 0)
+			if (!sp->ttis[i].tt_isdst)
+				break;
+	}
+	/* The next heuristics are for data generated by tzdb 2018e or
+	   earlier, for zones like EST5EDT where the first transition
+	   is to DST.  */
+	/*
+	** If no result yet, find the first standard type.
+	** If there is none, punt to type zero.
+	*/
+	if (i < 0) {
+		i = 0;
+		while (sp->ttis[i].tt_isdst)
+			if (++i >= sp->typecnt) {
+				i = 0;
+				break;
+			}
+	}
+	/* A simple 'sp->defaulttype = 0;' would suffice here if we
+	   didn't have to worry about 2018e-or-earlier data.  Even
+	   simpler would be to remove the defaulttype member and just
+	   use 0 in its place.  */
+	sp->defaulttype = i;
+
+	return 0;
+}
+
+/* Load tz data from the file named NAME into *SP.  Read extended
+   format if DOEXTEND.  Return 0 on success, an errno value on failure.  */
+static int
+tzload(char const *name, struct state *sp, bool doextend)
+{
+	union local_storage *lsp = malloc(sizeof *lsp);
+	if (!lsp)
+		return errno;
+	else {
+		int err = tzloadbody(name, sp, doextend, lsp);
+		free(lsp);
+		return err;
+	}
+}
+
+static bool
+typesequiv(const struct state *sp, int a, int b)
+{
+	bool result;
+
+	if (sp == NULL ||
+		a < 0 || a >= sp->typecnt ||
+		b < 0 || b >= sp->typecnt)
+			result = false;
+	else {
+		const struct ttinfo *	ap = &sp->ttis[a];
+		const struct ttinfo *	bp = &sp->ttis[b];
+		result = (ap->tt_utoff == bp->tt_utoff
+			  && ap->tt_isdst == bp->tt_isdst
+			  && ap->tt_ttisstd == bp->tt_ttisstd
+			  && ap->tt_ttisut == bp->tt_ttisut
+			  && (strcmp(&sp->chars[ap->tt_desigidx],
+				     &sp->chars[bp->tt_desigidx])
+			      == 0));
+	}
+	return result;
+}
+
+static const int	mon_lengths[2][MONSPERYEAR] = {
+	{ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 },
+	{ 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }
+};
+
+static const int	year_lengths[2] = {
+	DAYSPERNYEAR, DAYSPERLYEAR
+};
+
+/*
+** Given a pointer into a timezone string, scan until a character that is not
+** a valid character in a time zone abbreviation is found.
+** Return a pointer to that character.
+*/
+
+static ATTRIBUTE_PURE const char *
+getzname(const char *strp)
+{
+	char	c;
+
+	while ((c = *strp) != '\0' && !is_digit(c) && c != ',' && c != '-' &&
+		c != '+')
+			++strp;
+	return strp;
+}
+
+/*
+** Given a pointer into an extended timezone string, scan until the ending
+** delimiter of the time zone abbreviation is located.
+** Return a pointer to the delimiter.
+**
+** As with getzname above, the legal character set is actually quite
+** restricted, with other characters producing undefined results.
+** We don't do any checking here; checking is done later in common-case code.
+*/
+
+static ATTRIBUTE_PURE const char *
+getqzname(const char *strp, const int delim)
+{
+	int	c;
+
+	while ((c = *strp) != '\0' && c != delim)
+		++strp;
+	return strp;
+}
+
+/*
+** Given a pointer into a timezone string, extract a number from that string.
+** Check that the number is within a specified range; if it is not, return
+** NULL.
+** Otherwise, return a pointer to the first character not part of the number.
+*/
+
+static const char *
+getnum(const char *strp, int *const nump, const int min, const int max)
+{
+	char	c;
+	int	num;
+
+	if (strp == NULL || !is_digit(c = *strp)) {
+		errno = EINVAL;
+		return NULL;
+	}
+	num = 0;
+	do {
+		num = num * 10 + (c - '0');
+		if (num > max) {
+			errno = EOVERFLOW;
+			return NULL;	/* illegal value */
+		}
+		c = *++strp;
+	} while (is_digit(c));
+	if (num < min) {
+		errno = EINVAL;
+		return NULL;		/* illegal value */
+	}
+	*nump = num;
+	return strp;
+}
+
+/*
+** Given a pointer into a timezone string, extract a number of seconds,
+** in hh[:mm[:ss]] form, from the string.
+** If any error occurs, return NULL.
+** Otherwise, return a pointer to the first character not part of the number
+** of seconds.
+*/
+
+static const char *
+getsecs(const char *strp, int_fast32_t *const secsp)
+{
+	int	num;
+
+	/*
+	** 'HOURSPERDAY * DAYSPERWEEK - 1' allows quasi-Posix rules like
+	** "M10.4.6/26", which does not conform to Posix,
+	** but which specifies the equivalent of
+	** "02:00 on the first Sunday on or after 23 Oct".
+	*/
+	strp = getnum(strp, &num, 0, HOURSPERDAY * DAYSPERWEEK - 1);
+	if (strp == NULL)
+		return NULL;
+	*secsp = num * (int_fast32_t) SECSPERHOUR;
+	if (*strp == ':') {
+		++strp;
+		strp = getnum(strp, &num, 0, MINSPERHOUR - 1);
+		if (strp == NULL)
+			return NULL;
+		*secsp += num * SECSPERMIN;
+		if (*strp == ':') {
+			++strp;
+			/* 'SECSPERMIN' allows for leap seconds.  */
+			strp = getnum(strp, &num, 0, SECSPERMIN);
+			if (strp == NULL)
+				return NULL;
+			*secsp += num;
+		}
+	}
+	return strp;
+}
+
+/*
+** Given a pointer into a timezone string, extract an offset, in
+** [+-]hh[:mm[:ss]] form, from the string.
+** If any error occurs, return NULL.
+** Otherwise, return a pointer to the first character not part of the time.
+*/
+
+static const char *
+getoffset(const char *strp, int_fast32_t *const offsetp)
+{
+	bool neg = false;
+
+	if (*strp == '-') {
+		neg = true;
+		++strp;
+	} else if (*strp == '+')
+		++strp;
+	strp = getsecs(strp, offsetp);
+	if (strp == NULL)
+		return NULL;		/* illegal time */
+	if (neg)
+		*offsetp = -*offsetp;
+	return strp;
+}
+
+/*
+** Given a pointer into a timezone string, extract a rule in the form
+** date[/time]. See POSIX section 8 for the format of "date" and "time".
+** If a valid rule is not found, return NULL.
+** Otherwise, return a pointer to the first character not part of the rule.
+*/
+
+static const char *
+getrule(const char *strp, struct rule *const rulep)
+{
+	if (*strp == 'J') {
+		/*
+		** Julian day.
+		*/
+		rulep->r_type = JULIAN_DAY;
+		++strp;
+		strp = getnum(strp, &rulep->r_day, 1, DAYSPERNYEAR);
+	} else if (*strp == 'M') {
+		/*
+		** Month, week, day.
+		*/
+		rulep->r_type = MONTH_NTH_DAY_OF_WEEK;
+		++strp;
+		strp = getnum(strp, &rulep->r_mon, 1, MONSPERYEAR);
+		if (strp == NULL)
+			return NULL;
+		if (*strp++ != '.')
+			return NULL;
+		strp = getnum(strp, &rulep->r_week, 1, 5);
+		if (strp == NULL)
+			return NULL;
+		if (*strp++ != '.')
+			return NULL;
+		strp = getnum(strp, &rulep->r_day, 0, DAYSPERWEEK - 1);
+	} else if (is_digit(*strp)) {
+		/*
+		** Day of year.
+		*/
+		rulep->r_type = DAY_OF_YEAR;
+		strp = getnum(strp, &rulep->r_day, 0, DAYSPERLYEAR - 1);
+	} else	return NULL;		/* invalid format */
+	if (strp == NULL)
+		return NULL;
+	if (*strp == '/') {
+		/*
+		** Time specified.
+		*/
+		++strp;
+		strp = getoffset(strp, &rulep->r_time);
+	} else	rulep->r_time = 2 * SECSPERHOUR;	/* default = 2:00:00 */
+	return strp;
+}
+
+/*
+** Given a year, a rule, and the offset from UT at the time that rule takes
+** effect, calculate the year-relative time that rule takes effect.
+*/
+
+static int_fast32_t
+transtime(const int year, const struct rule *const rulep,
+	  const int_fast32_t offset)
+{
+	bool	leapyear;
+	int_fast32_t value;
+	int	i;
+	int		d, m1, yy0, yy1, yy2, dow;
+
+	INITIALIZE(value);
+	leapyear = isleap(year);
+	switch (rulep->r_type) {
+
+	case JULIAN_DAY:
+		/*
+		** Jn - Julian day, 1 == January 1, 60 == March 1 even in leap
+		** years.
+		** In non-leap years, or if the day number is 59 or less, just
+		** add SECSPERDAY times the day number-1 to the time of
+		** January 1, midnight, to get the day.
+		*/
+		value = (rulep->r_day - 1) * SECSPERDAY;
+		if (leapyear && rulep->r_day >= 60)
+			value += SECSPERDAY;
+		break;
+
+	case DAY_OF_YEAR:
+		/*
+		** n - day of year.
+		** Just add SECSPERDAY times the day number to the time of
+		** January 1, midnight, to get the day.
+		*/
+		value = rulep->r_day * SECSPERDAY;
+		break;
+
+	case MONTH_NTH_DAY_OF_WEEK:
+		/*
+		** Mm.n.d - nth "dth day" of month m.
+		*/
+
+		/*
+		** Use Zeller's Congruence to get day-of-week of first day of
+		** month.
+		*/
+		m1 = (rulep->r_mon + 9) % 12 + 1;
+		yy0 = (rulep->r_mon <= 2) ? (year - 1) : year;
+		yy1 = yy0 / 100;
+		yy2 = yy0 % 100;
+		dow = ((26 * m1 - 2) / 10 +
+			1 + yy2 + yy2 / 4 + yy1 / 4 - 2 * yy1) % 7;
+		if (dow < 0)
+			dow += DAYSPERWEEK;
+
+		/*
+		** "dow" is the day-of-week of the first day of the month. Get
+		** the day-of-month (zero-origin) of the first "dow" day of the
+		** month.
+		*/
+		d = rulep->r_day - dow;
+		if (d < 0)
+			d += DAYSPERWEEK;
+		for (i = 1; i < rulep->r_week; ++i) {
+			if (d + DAYSPERWEEK >=
+				mon_lengths[leapyear][rulep->r_mon - 1])
+					break;
+			d += DAYSPERWEEK;
+		}
+
+		/*
+		** "d" is the day-of-month (zero-origin) of the day we want.
+		*/
+		value = d * SECSPERDAY;
+		for (i = 0; i < rulep->r_mon - 1; ++i)
+			value += mon_lengths[leapyear][i] * SECSPERDAY;
+		break;
+	}
+
+	/*
+	** "value" is the year-relative time of 00:00:00 UT on the day in
+	** question. To get the year-relative time of the specified local
+	** time on that day, add the transition time and the current offset
+	** from UT.
+	*/
+	return value + rulep->r_time + offset;
+}
+
+/*
+** Given a POSIX section 8-style TZ string, fill in the rule tables as
+** appropriate.
+*/
+
+static bool
+tzparse(const char *name, struct state *sp, bool lastditch)
+{
+	const char *	stdname;
+	const char *	dstname;
+	size_t		stdlen;
+	size_t		dstlen;
+	size_t		charcnt;
+	int_fast32_t	stdoffset;
+	int_fast32_t	dstoffset;
+	char *		cp;
+	bool		load_ok;
+
+	dstname = NULL; /* XXX gcc */
+	stdname = name;
+	if (lastditch) {
+		stdlen = sizeof gmt - 1;
+		name += stdlen;
+		stdoffset = 0;
+	} else {
+		if (*name == '<') {
+			name++;
+			stdname = name;
+			name = getqzname(name, '>');
+			if (*name != '>')
+			  return false;
+			stdlen = name - stdname;
+			name++;
+		} else {
+			name = getzname(name);
+			stdlen = name - stdname;
+		}
+		if (!stdlen)
+			return false;
+		name = getoffset(name, &stdoffset);
+		if (name == NULL)
+			return false;
+	}
+	charcnt = stdlen + 1;
+	if (sizeof sp->chars < charcnt)
+		return false;
+	load_ok = tzload(TZDEFRULES, sp, false) == 0;
+	if (!load_ok)
+		sp->leapcnt = 0;		/* so, we're off a little */
+	if (*name != '\0') {
+		if (*name == '<') {
+			dstname = ++name;
+			name = getqzname(name, '>');
+			if (*name != '>')
+				return false;
+			dstlen = name - dstname;
+			name++;
+		} else {
+			dstname = name;
+			name = getzname(name);
+			dstlen = name - dstname; /* length of DST abbr. */
+		}
+		if (!dstlen)
+		  return false;
+		charcnt += dstlen + 1;
+		if (sizeof sp->chars < charcnt)
+		  return false;
+		if (*name != '\0' && *name != ',' && *name != ';') {
+			name = getoffset(name, &dstoffset);
+			if (name == NULL)
+			  return false;
+		} else	dstoffset = stdoffset - SECSPERHOUR;
+		if (*name == '\0' && !load_ok)
+			name = TZDEFRULESTRING;
+		if (*name == ',' || *name == ';') {
+			struct rule	start;
+			struct rule	end;
+			int		year;
+			int		yearlim;
+			int		timecnt;
+			time_t		janfirst;
+			int_fast32_t janoffset = 0;
+			int yearbeg;
+
+			++name;
+			if ((name = getrule(name, &start)) == NULL)
+				return false;
+			if (*name++ != ',')
+				return false;
+			if ((name = getrule(name, &end)) == NULL)
+				return false;
+			if (*name != '\0')
+				return false;
+			sp->typecnt = 2;	/* standard time and DST */
+			/*
+			** Two transitions per year, from EPOCH_YEAR forward.
+			*/
+			init_ttinfo(&sp->ttis[0], -stdoffset, false, 0);
+			init_ttinfo(&sp->ttis[1], -dstoffset, true, 
+			    (int)(stdlen + 1));
+			sp->defaulttype = 0;
+			timecnt = 0;
+			janfirst = 0;
+			yearbeg = EPOCH_YEAR;
+
+			do {
+			  int_fast32_t yearsecs
+			    = year_lengths[isleap(yearbeg - 1)] * SECSPERDAY;
+			  yearbeg--;
+			  if (increment_overflow_time(&janfirst, -yearsecs)) {
+			    janoffset = -yearsecs;
+			    break;
+			  }
+			} while (EPOCH_YEAR - YEARSPERREPEAT / 2 < yearbeg);
+
+			yearlim = yearbeg + YEARSPERREPEAT + 1;
+			for (year = yearbeg; year < yearlim; year++) {
+				int_fast32_t
+				  starttime = transtime(year, &start, stdoffset),
+				  endtime = transtime(year, &end, dstoffset);
+				int_fast32_t
+				  yearsecs = (year_lengths[isleap(year)]
+					      * SECSPERDAY);
+				bool reversed = endtime < starttime;
+				if (reversed) {
+					int_fast32_t swap = starttime;
+					starttime = endtime;
+					endtime = swap;
+				}
+				if (reversed
+				    || (starttime < endtime
+					&& (endtime - starttime
+					    < (yearsecs
+					       + (stdoffset - dstoffset))))) {
+					if (TZ_MAX_TIMES - 2 < timecnt)
+						break;
+					sp->ats[timecnt] = janfirst;
+					if (! increment_overflow_time
+					    (&sp->ats[timecnt],
+					     janoffset + starttime))
+					  sp->types[timecnt++] = !reversed;
+					sp->ats[timecnt] = janfirst;
+					if (! increment_overflow_time
+					    (&sp->ats[timecnt],
+					     janoffset + endtime)) {
+					  sp->types[timecnt++] = reversed;
+					  yearlim = year + YEARSPERREPEAT + 1;
+					}
+				}
+				if (increment_overflow_time
+				    (&janfirst, janoffset + yearsecs))
+					break;
+				janoffset = 0;
+			}
+			sp->timecnt = timecnt;
+			if (! timecnt) {
+				sp->ttis[0] = sp->ttis[1];
+				sp->typecnt = 1;	/* Perpetual DST.  */
+			} else if (YEARSPERREPEAT < year - yearbeg)
+				sp->goback = sp->goahead = true;
+		} else {
+			int_fast32_t	theirstdoffset;
+			int_fast32_t	theirdstoffset;
+			int_fast32_t	theiroffset;
+			bool		isdst;
+			int		i;
+			int		j;
+
+			if (*name != '\0')
+				return false;
+			/*
+			** Initial values of theirstdoffset and theirdstoffset.
+			*/
+			theirstdoffset = 0;
+			for (i = 0; i < sp->timecnt; ++i) {
+				j = sp->types[i];
+				if (!sp->ttis[j].tt_isdst) {
+					theirstdoffset =
+						- sp->ttis[j].tt_utoff;
+					break;
+				}
+			}
+			theirdstoffset = 0;
+			for (i = 0; i < sp->timecnt; ++i) {
+				j = sp->types[i];
+				if (sp->ttis[j].tt_isdst) {
+					theirdstoffset =
+						- sp->ttis[j].tt_utoff;
+					break;
+				}
+			}
+			/*
+			** Initially we're assumed to be in standard time.
+			*/
+			isdst = false;
+			theiroffset = theirstdoffset;
+			/*
+			** Now juggle transition times and types
+			** tracking offsets as you do.
+			*/
+			for (i = 0; i < sp->timecnt; ++i) {
+				j = sp->types[i];
+				sp->types[i] = sp->ttis[j].tt_isdst;
+				if (sp->ttis[j].tt_ttisut) {
+					/* No adjustment to transition time */
+				} else {
+					/*
+					** If daylight saving time is in
+					** effect, and the transition time was
+					** not specified as standard time, add
+					** the daylight saving time offset to
+					** the transition time; otherwise, add
+					** the standard time offset to the
+					** transition time.
+					*/
+					/*
+					** Transitions from DST to DDST
+					** will effectively disappear since
+					** POSIX provides for only one DST
+					** offset.
+					*/
+					if (isdst && !sp->ttis[j].tt_ttisstd) {
+						sp->ats[i] += (time_t)
+						    (dstoffset - theirdstoffset);
+					} else {
+						sp->ats[i] += (time_t)
+						    (stdoffset - theirstdoffset);
+					}
+				}
+				theiroffset = -sp->ttis[j].tt_utoff;
+				if (sp->ttis[j].tt_isdst)
+					theirstdoffset = theiroffset;
+				else	theirdstoffset = theiroffset;
+			}
+			/*
+			** Finally, fill in ttis.
+			*/
+			init_ttinfo(&sp->ttis[0], -stdoffset, false, 0);
+			init_ttinfo(&sp->ttis[1], -dstoffset, true,
+			    (int)(stdlen + 1));
+			sp->typecnt = 2;
+			sp->defaulttype = 0;
+		}
+	} else {
+		dstlen = 0;
+		sp->typecnt = 1;		/* only standard time */
+		sp->timecnt = 0;
+		init_ttinfo(&sp->ttis[0], -stdoffset, false, 0);
+		init_ttinfo(&sp->ttis[1], 0, false, 0);
+		sp->defaulttype = 0;
+	}
+	sp->charcnt = (int)charcnt;
+	cp = sp->chars;
+	(void) memcpy(cp, stdname, stdlen);
+	cp += stdlen;
+	*cp++ = '\0';
+	if (dstlen != 0) {
+		(void) memcpy(cp, dstname, dstlen);
+		*(cp + dstlen) = '\0';
+	}
+	return true;
+}
+
+static void
+gmtload(struct state *const sp)
+{
+	if (tzload(gmt, sp, true) != 0)
+		(void) tzparse(gmt, sp, true);
+}
+
+static int
+zoneinit(struct state *sp, char const *name)
+{
+	if (name && ! name[0]) {
+		/*
+		** User wants it fast rather than right.
+		*/
+		sp->leapcnt = 0;		/* so, we're off a little */
+		sp->timecnt = 0;
+		sp->typecnt = 1;
+		sp->charcnt = 0;
+		sp->goback = sp->goahead = false;
+		init_ttinfo(&sp->ttis[0], 0, false, 0);
+		strcpy(sp->chars, gmt);
+		sp->defaulttype = 0;
+		return 0;
+	} else {
+		int err = tzload(name, sp, true);
+		if (err != 0 && name && name[0] != ':' &&
+		    tzparse(name, sp, false))
+			err = 0;
+		if (err == 0)
+			scrub_abbrs(sp);
+		return err;
+	}
+}
+ 
+static void
+tzsetlcl(char const *name)
+{
+	struct state *sp = __lclptr;
+	int lcl = name ? strlen(name) < sizeof lcl_TZname : -1;
+	if (lcl < 0 ? lcl_is_set < 0
+	    : 0 < lcl_is_set && strcmp(lcl_TZname, name) == 0)
+		return;
+
+	if (! sp)
+		__lclptr = sp = malloc(sizeof *__lclptr);
+	if (sp) {
+		if (zoneinit(sp, name) != 0)
+			zoneinit(sp, "");
+		if (0 < lcl)
+			strcpy(lcl_TZname, name);
+	}
+	settzname();
+	lcl_is_set = lcl;
+}
+
+#ifdef STD_INSPIRED
+void
+tzsetwall(void)
+{
+	rwlock_wrlock(&__lcl_lock);
+	tzsetlcl(NULL);
+	rwlock_unlock(&__lcl_lock);
+}
+#endif
+
+void
+tzset_unlocked(void)
+{
+	tzsetlcl(getenv("TZ"));
+}
+
+void
+tzset(void)
+{
+	rwlock_wrlock(&__lcl_lock);
+	tzset_unlocked();
+	rwlock_unlock(&__lcl_lock);
+}
+
+static void
+gmtcheck(void)
+{
+	static bool gmt_is_set;
+	rwlock_wrlock(&__lcl_lock);
+	if (! gmt_is_set) {
+		gmtptr = malloc(sizeof *gmtptr);
+		if (gmtptr)
+			gmtload(gmtptr);
+		gmt_is_set = true;
+	}
+	rwlock_unlock(&__lcl_lock);
+}
+
+#if NETBSD_INSPIRED
+
+timezone_t
+tzalloc(const char *name)
+{
+	timezone_t sp = malloc(sizeof *sp);
+	if (sp) {
+		int err = zoneinit(sp, name);
+		if (err != 0) {
+			free(sp);
+			errno = err;
+			return NULL;
+		}
+	}
+	return sp;
+}
+
+void
+tzfree(timezone_t sp)
+{
+	free(sp);
+}
+
+/*
+** NetBSD 6.1.4 has ctime_rz, but omit it because POSIX says ctime and
+** ctime_r are obsolescent and have potential security problems that
+** ctime_rz would share.  Callers can instead use localtime_rz + strftime.
+**
+** NetBSD 6.1.4 has tzgetname, but omit it because it doesn't work
+** in zones with three or more time zone abbreviations.
+** Callers can instead use localtime_rz + strftime.
+*/
+
+#endif
+
+/*
+** The easy way to behave "as if no library function calls" localtime
+** is to not call it, so we drop its guts into "localsub", which can be
+** freely called. (And no, the PANS doesn't require the above behavior,
+** but it *is* desirable.)
+**
+** If successful and SETNAME is nonzero,
+** set the applicable parts of tzname, timezone and altzone;
+** however, it's OK to omit this step if the timezone is POSIX-compatible,
+** since in that case tzset should have already done this step correctly.
+** SETNAME's type is intfast32_t for compatibility with gmtsub,
+** but it is actually a boolean and its value should be 0 or 1.
+*/
+
+/*ARGSUSED*/
+static struct tm *
+localsub(struct state const *sp, time_t const *timep, int_fast32_t setname,
+	 struct tm *const tmp)
+{
+	const struct ttinfo *	ttisp;
+	int			i;
+	struct tm *		result;
+	const time_t			t = *timep;
+
+	if (sp == NULL) {
+		/* Don't bother to set tzname etc.; tzset has already done it.  */
+		return gmtsub(gmtptr, timep, 0, tmp);
+	}
+	if ((sp->goback && t < sp->ats[0]) ||
+		(sp->goahead && t > sp->ats[sp->timecnt - 1])) {
+			time_t			newt = t;
+			time_t		seconds;
+			time_t		years;
+
+			if (t < sp->ats[0])
+				seconds = sp->ats[0] - t;
+			else	seconds = t - sp->ats[sp->timecnt - 1];
+			--seconds;
+			years = (time_t)((seconds / SECSPERREPEAT + 1) * YEARSPERREPEAT);
+			seconds = (time_t)(years * AVGSECSPERYEAR);
+			if (t < sp->ats[0])
+				newt += seconds;
+			else	newt -= seconds;
+			if (newt < sp->ats[0] ||
+				newt > sp->ats[sp->timecnt - 1]) {
+				errno = EINVAL;
+				return NULL;	/* "cannot happen" */
+			}
+			result = localsub(sp, &newt, setname, tmp);
+			if (result) {
+				int_fast64_t newy;
+
+				newy = result->tm_year;
+				if (t < sp->ats[0])
+					newy -= years;
+				else	newy += years;
+				if (! (INT_MIN <= newy && newy <= INT_MAX)) {
+					errno = EOVERFLOW;
+					return NULL;
+				}
+				result->tm_year = (int)newy;
+			}
+			return result;
+	}
+	if (sp->timecnt == 0 || t < sp->ats[0]) {
+		i = sp->defaulttype;
+	} else {
+		int	lo = 1;
+		int	hi = sp->timecnt;
+
+		while (lo < hi) {
+			int	mid = (lo + hi) / 2;
+
+			if (t < sp->ats[mid])
+				hi = mid;
+			else	lo = mid + 1;
+		}
+		i = (int) sp->types[lo - 1];
+	}
+	ttisp = &sp->ttis[i];
+	/*
+	** To get (wrong) behavior that's compatible with System V Release 2.0
+	** you'd replace the statement below with
+	**	t += ttisp->tt_utoff;
+	**	timesub(&t, 0L, sp, tmp);
+	*/
+	result = timesub(&t, ttisp->tt_utoff, sp, tmp);
+	if (result) {
+		result->tm_isdst = ttisp->tt_isdst;
+#ifdef TM_ZONE
+		result->TM_ZONE = __UNCONST(&sp->chars[ttisp->tt_desigidx]);
+#endif /* defined TM_ZONE */
+		if (setname)
+			update_tzname_etc(sp, ttisp);
+	}
+	return result;
+}
+
+#if NETBSD_INSPIRED
+
+struct tm *
+localtime_rz(timezone_t sp, time_t const *timep, struct tm *tmp)
+{
+	return localsub(sp, timep, 0, tmp);
+}
+
+#endif
+
+static struct tm *
+localtime_tzset(time_t const *timep, struct tm *tmp, bool setname)
+{
+	rwlock_wrlock(&__lcl_lock);
+	if (setname || !lcl_is_set)
+		tzset_unlocked();
+	tmp = localsub(__lclptr, timep, setname, tmp);
+	rwlock_unlock(&__lcl_lock);
+	return tmp;
+}
+
+struct tm *
+localtime(const time_t *timep)
+{
+	return localtime_tzset(timep, &tm, true);
+}
+
+struct tm *
+localtime_r(const time_t * __restrict timep, struct tm *tmp)
+{
+	return localtime_tzset(timep, tmp, true);
+}
+
+/*
+** gmtsub is to gmtime as localsub is to localtime.
+*/
+
+static struct tm *
+gmtsub(struct state const *sp, const time_t *timep, int_fast32_t offset,
+       struct tm *tmp)
+{
+	struct tm *	result;
+
+	result = timesub(timep, offset, gmtptr, tmp);
+#ifdef TM_ZONE
+	/*
+	** Could get fancy here and deliver something such as
+	** "+xx" or "-xx" if offset is non-zero,
+	** but this is no time for a treasure hunt.
+	*/
+	if (result)
+		result->TM_ZONE = offset ? __UNCONST(wildabbr) : gmtptr ?
+		    gmtptr->chars : __UNCONST(gmt);
+#endif /* defined TM_ZONE */
+	return result;
+}
+
+
+/*
+** Re-entrant version of gmtime.
+*/
+
+struct tm *
+gmtime_r(const time_t *timep, struct tm *tmp)
+{
+	gmtcheck();
+	return gmtsub(NULL, timep, 0, tmp);
+}
+
+struct tm *
+gmtime(const time_t *timep)
+{
+	return gmtime_r(timep, &tm);
+}
+#ifdef STD_INSPIRED
+
+struct tm *
+offtime(const time_t *timep, long offset)
+{
+	gmtcheck();
+	return gmtsub(gmtptr, timep, (int_fast32_t)offset, &tm);
+}
+
+struct tm *
+offtime_r(const time_t *timep, long offset, struct tm *tmp)
+{
+	gmtcheck();
+	return gmtsub(NULL, timep, (int_fast32_t)offset, tmp);
+}
+
+#endif /* defined STD_INSPIRED */
+
+#if TZ_TIME_T
+
+# if USG_COMPAT
+#  define daylight 0
+#  define timezone 0
+# endif
+# ifndef ALTZONE
+#  define altzone 0
+# endif
+ 
+/* Convert from the underlying system's time_t to the ersatz time_tz,
+   which is called 'time_t' in this file.  Typically, this merely
+   converts the time's integer width.  On some platforms, the system
+   time is local time not UT, or uses some epoch other than the POSIX
+   epoch.
+
+   Although this code appears to define a function named 'time' that
+   returns time_t, the macros in private.h cause this code to actually
+   define a function named 'tz_time' that returns tz_time_t.  The call
+   to sys_time invokes the underlying system's 'time' function.  */
+ 
+time_t
+time(time_t *p)
+{
+  time_t r = sys_time(0);
+  if (r != (time_t) -1) {
+    int_fast32_t offset = EPOCH_LOCAL ? (daylight ? timezone : altzone) : 0;
+    if (increment_overflow32(&offset, -EPOCH_OFFSET)
+	|| increment_overflow_time (&r, offset)) {
+      errno = EOVERFLOW;
+      r = -1;
+    }
+  }
+  if (p)
+    *p = r;
+  return r;
+}
+#endif
+
+/*
+** Return the number of leap years through the end of the given year
+** where, to make the math easy, the answer for year zero is defined as zero.
+*/
+static int
+leaps_thru_end_of_nonneg(int y)
+{
+	return y / 4 - y / 100 + y / 400;
+}
+
+static int ATTRIBUTE_PURE
+leaps_thru_end_of(const int y)
+{
+	return (y < 0
+		? -1 - leaps_thru_end_of_nonneg(-1 - y)
+		: leaps_thru_end_of_nonneg(y));
+}
+
+static struct tm *
+timesub(const time_t *timep, int_fast32_t offset,
+    const struct state *sp, struct tm *tmp)
+{
+	const struct lsinfo *	lp;
+	time_t			tdays;
+	int			idays;	/* unsigned would be so 2003 */
+	int_fast64_t		rem;
+	int			y;
+	const int *		ip;
+	int_fast64_t		corr;
+	int			hit;
+	int			i;
+
+	corr = 0;
+	hit = false;
+	i = (sp == NULL) ? 0 : sp->leapcnt;
+	while (--i >= 0) {
+		lp = &sp->lsis[i];
+		if (*timep >= lp->ls_trans) {
+			corr = lp->ls_corr;
+			hit = (*timep == lp->ls_trans
+			       && (i == 0 ? 0 : lp[-1].ls_corr) < corr);
+			break;
+		}
+	}
+	y = EPOCH_YEAR;
+	tdays = (time_t)(*timep / SECSPERDAY);
+	rem = *timep % SECSPERDAY;
+	while (tdays < 0 || tdays >= year_lengths[isleap(y)]) {
+		int		newy;
+		time_t	tdelta;
+		int	idelta;
+		int	leapdays;
+
+		tdelta = tdays / DAYSPERLYEAR;
+		if (! ((! TYPE_SIGNED(time_t) || INT_MIN <= tdelta)
+		       && tdelta <= INT_MAX))
+			goto out_of_range;
+		_DIAGASSERT(__type_fit(int, tdelta));
+		idelta = (int)tdelta;
+		if (idelta == 0)
+			idelta = (tdays < 0) ? -1 : 1;
+		newy = y;
+		if (increment_overflow(&newy, idelta))
+			goto out_of_range;
+		leapdays = leaps_thru_end_of(newy - 1) -
+			leaps_thru_end_of(y - 1);
+		tdays -= ((time_t) newy - y) * DAYSPERNYEAR;
+		tdays -= leapdays;
+		y = newy;
+	}
+	/*
+	** Given the range, we can now fearlessly cast...
+	*/
+	idays = (int) tdays;
+	rem += offset - corr;
+	while (rem < 0) {
+		rem += SECSPERDAY;
+		--idays;
+	}
+	while (rem >= SECSPERDAY) {
+		rem -= SECSPERDAY;
+		++idays;
+	}
+	while (idays < 0) {
+		if (increment_overflow(&y, -1))
+			goto out_of_range;
+		idays += year_lengths[isleap(y)];
+	}
+	while (idays >= year_lengths[isleap(y)]) {
+		idays -= year_lengths[isleap(y)];
+		if (increment_overflow(&y, 1))
+			goto out_of_range;
+	}
+	tmp->tm_year = y;
+	if (increment_overflow(&tmp->tm_year, -TM_YEAR_BASE))
+		goto out_of_range;
+	tmp->tm_yday = idays;
+	/*
+	** The "extra" mods below avoid overflow problems.
+	*/
+	tmp->tm_wday = EPOCH_WDAY +
+		((y - EPOCH_YEAR) % DAYSPERWEEK) *
+		(DAYSPERNYEAR % DAYSPERWEEK) +
+		leaps_thru_end_of(y - 1) -
+		leaps_thru_end_of(EPOCH_YEAR - 1) +
+		idays;
+	tmp->tm_wday %= DAYSPERWEEK;
+	if (tmp->tm_wday < 0)
+		tmp->tm_wday += DAYSPERWEEK;
+	tmp->tm_hour = (int) (rem / SECSPERHOUR);
+	rem %= SECSPERHOUR;
+	tmp->tm_min = (int) (rem / SECSPERMIN);
+	/*
+	** A positive leap second requires a special
+	** representation. This uses "... ??:59:60" et seq.
+	*/
+	tmp->tm_sec = (int) (rem % SECSPERMIN) + hit;
+	ip = mon_lengths[isleap(y)];
+	for (tmp->tm_mon = 0; idays >= ip[tmp->tm_mon]; ++(tmp->tm_mon))
+		idays -= ip[tmp->tm_mon];
+	tmp->tm_mday = (int) (idays + 1);
+	tmp->tm_isdst = 0;
+#ifdef TM_GMTOFF
+	tmp->TM_GMTOFF = offset;
+#endif /* defined TM_GMTOFF */
+	return tmp;
+out_of_range:
+	errno = EOVERFLOW;
+	return NULL;
+}
+
+char *
+ctime(const time_t *timep)
+{
+/*
+** Section 4.12.3.2 of X3.159-1989 requires that
+**	The ctime function converts the calendar time pointed to by timer
+**	to local time in the form of a string. It is equivalent to
+**		asctime(localtime(timer))
+*/
+	struct tm *tmp = localtime(timep);
+	return tmp ? asctime(tmp) : NULL;
+}
+
+char *
+ctime_r(const time_t *timep, char *buf)
+{
+	struct tm mytm;
+	struct tm *tmp = localtime_r(timep, &mytm);
+	return tmp ? asctime_r(tmp, buf) : NULL;
+}
+
+char *
+ctime_rz(const timezone_t sp, const time_t * timep, char *buf)
+{
+	struct tm	mytm, *rtm;
+
+	rtm = localtime_rz(sp, timep, &mytm);
+	if (rtm == NULL)
+		return NULL;
+	return asctime_r(rtm, buf);
+}
+
+/*
+** Adapted from code provided by Robert Elz, who writes:
+**	The "best" way to do mktime I think is based on an idea of Bob
+**	Kridle's (so its said...) from a long time ago.
+**	It does a binary search of the time_t space. Since time_t's are
+**	just 32 bits, its a max of 32 iterations (even at 64 bits it
+**	would still be very reasonable).
+*/
+
+#ifndef WRONG
+#define WRONG	((time_t)-1)
+#endif /* !defined WRONG */
+
+/*
+** Normalize logic courtesy Paul Eggert.
+*/
+
+static bool
+increment_overflow(int *ip, int j)
+{
+	int const	i = *ip;
+
+	/*
+	** If i >= 0 there can only be overflow if i + j > INT_MAX
+	** or if j > INT_MAX - i; given i >= 0, INT_MAX - i cannot overflow.
+	** If i < 0 there can only be overflow if i + j < INT_MIN
+	** or if j < INT_MIN - i; given i < 0, INT_MIN - i cannot overflow.
+	*/
+	if ((i >= 0) ? (j > INT_MAX - i) : (j < INT_MIN - i))
+		return true;
+	*ip += j;
+	return false;
+}
+
+static bool
+increment_overflow32(int_fast32_t *const lp, int const m)
+{
+	int_fast32_t const l = *lp;
+
+	if ((l >= 0) ? (m > INT_FAST32_MAX - l) : (m < INT_FAST32_MIN - l))
+		return true;
+	*lp += m;
+	return false;
+}
+
+static bool
+increment_overflow_time(time_t *tp, int_fast32_t j)
+{
+	/*
+	** This is like
+	** 'if (! (TIME_T_MIN <= *tp + j && *tp + j <= TIME_T_MAX)) ...',
+	** except that it does the right thing even if *tp + j would overflow.
+	*/
+	if (! (j < 0
+	       ? (TYPE_SIGNED(time_t) ? TIME_T_MIN - j <= *tp : -1 - j < *tp)
+	       : *tp <= TIME_T_MAX - j))
+		return true;
+	*tp += j;
+	return false;
+}
+
+static bool
+normalize_overflow(int *const tensptr, int *const unitsptr, const int base)
+{
+	int	tensdelta;
+
+	tensdelta = (*unitsptr >= 0) ?
+		(*unitsptr / base) :
+		(-1 - (-1 - *unitsptr) / base);
+	*unitsptr -= tensdelta * base;
+	return increment_overflow(tensptr, tensdelta);
+}
+
+static bool
+normalize_overflow32(int_fast32_t *tensptr, int *unitsptr, int base)
+{
+	int	tensdelta;
+
+	tensdelta = (*unitsptr >= 0) ?
+		(*unitsptr / base) :
+		(-1 - (-1 - *unitsptr) / base);
+	*unitsptr -= tensdelta * base;
+	return increment_overflow32(tensptr, tensdelta);
+}
+
+static int
+tmcomp(const struct tm *const atmp,
+       const struct tm *const btmp)
+{
+	int	result;
+
+	if (atmp->tm_year != btmp->tm_year)
+		return atmp->tm_year < btmp->tm_year ? -1 : 1;
+	if ((result = (atmp->tm_mon - btmp->tm_mon)) == 0 &&
+		(result = (atmp->tm_mday - btmp->tm_mday)) == 0 &&
+		(result = (atmp->tm_hour - btmp->tm_hour)) == 0 &&
+		(result = (atmp->tm_min - btmp->tm_min)) == 0)
+			result = atmp->tm_sec - btmp->tm_sec;
+	return result;
+}
+
+static time_t
+time2sub(struct tm *const tmp,
+	 struct tm *(*funcp)(struct state const *, time_t const *,
+			     int_fast32_t, struct tm *),
+	 struct state const *sp,
+ 	 const int_fast32_t offset,
+	 bool *okayp,
+	 bool do_norm_secs)
+{
+	int			dir;
+	int			i, j;
+	int			saved_seconds;
+	int_fast32_t		li;
+	time_t			lo;
+	time_t			hi;
+#ifdef NO_ERROR_IN_DST_GAP
+	time_t			ilo;
+#endif
+	int_fast32_t		y;
+	time_t			newt;
+	time_t			t;
+	struct tm		yourtm, mytm;
+
+	*okayp = false;
+	yourtm = *tmp;
+#ifdef NO_ERROR_IN_DST_GAP
+again:
+#endif
+	if (do_norm_secs) {
+		if (normalize_overflow(&yourtm.tm_min, &yourtm.tm_sec,
+		    SECSPERMIN))
+			goto out_of_range;
+	}
+	if (normalize_overflow(&yourtm.tm_hour, &yourtm.tm_min, MINSPERHOUR))
+		goto out_of_range;
+	if (normalize_overflow(&yourtm.tm_mday, &yourtm.tm_hour, HOURSPERDAY))
+		goto out_of_range;
+	y = yourtm.tm_year;
+	if (normalize_overflow32(&y, &yourtm.tm_mon, MONSPERYEAR))
+		goto out_of_range;
+	/*
+	** Turn y into an actual year number for now.
+	** It is converted back to an offset from TM_YEAR_BASE later.
+	*/
+	if (increment_overflow32(&y, TM_YEAR_BASE))
+		goto out_of_range;
+	while (yourtm.tm_mday <= 0) {
+		if (increment_overflow32(&y, -1))
+			goto out_of_range;
+		li = y + (1 < yourtm.tm_mon);
+		yourtm.tm_mday += year_lengths[isleap(li)];
+	}
+	while (yourtm.tm_mday > DAYSPERLYEAR) {
+		li = y + (1 < yourtm.tm_mon);
+		yourtm.tm_mday -= year_lengths[isleap(li)];
+		if (increment_overflow32(&y, 1))
+			goto out_of_range;
+	}
+	for ( ; ; ) {
+		i = mon_lengths[isleap(y)][yourtm.tm_mon];
+		if (yourtm.tm_mday <= i)
+			break;
+		yourtm.tm_mday -= i;
+		if (++yourtm.tm_mon >= MONSPERYEAR) {
+			yourtm.tm_mon = 0;
+			if (increment_overflow32(&y, 1))
+				goto out_of_range;
+		}
+	}
+	if (increment_overflow32(&y, -TM_YEAR_BASE))
+		goto out_of_range;
+	if (! (INT_MIN <= y && y <= INT_MAX))
+		goto out_of_range;
+	yourtm.tm_year = (int)y;
+	if (yourtm.tm_sec >= 0 && yourtm.tm_sec < SECSPERMIN)
+		saved_seconds = 0;
+	else if (y + TM_YEAR_BASE < EPOCH_YEAR) {
+		/*
+		** We can't set tm_sec to 0, because that might push the
+		** time below the minimum representable time.
+		** Set tm_sec to 59 instead.
+		** This assumes that the minimum representable time is
+		** not in the same minute that a leap second was deleted from,
+		** which is a safer assumption than using 58 would be.
+		*/
+		if (increment_overflow(&yourtm.tm_sec, 1 - SECSPERMIN))
+			goto out_of_range;
+		saved_seconds = yourtm.tm_sec;
+		yourtm.tm_sec = SECSPERMIN - 1;
+	} else {
+		saved_seconds = yourtm.tm_sec;
+		yourtm.tm_sec = 0;
+	}
+	/*
+	** Do a binary search (this works whatever time_t's type is).
+	*/
+	lo = TIME_T_MIN;
+	hi = TIME_T_MAX;
+#ifdef NO_ERROR_IN_DST_GAP
+	ilo = lo;
+#endif
+	for ( ; ; ) {
+		t = lo / 2 + hi / 2;
+		if (t < lo)
+			t = lo;
+		else if (t > hi)
+			t = hi;
+		if (! funcp(sp, &t, offset, &mytm)) {
+			/*
+			** Assume that t is too extreme to be represented in
+			** a struct tm; arrange things so that it is less
+			** extreme on the next pass.
+			*/
+			dir = (t > 0) ? 1 : -1;
+		} else	dir = tmcomp(&mytm, &yourtm);
+		if (dir != 0) {
+			if (t == lo) {
+				if (t == TIME_T_MAX)
+					goto out_of_range;
+				++t;
+				++lo;
+			} else if (t == hi) {
+				if (t == TIME_T_MIN)
+					goto out_of_range;
+				--t;
+				--hi;
+			}
+#ifdef NO_ERROR_IN_DST_GAP
+			if (ilo != lo && lo - 1 == hi && yourtm.tm_isdst < 0 &&
+			    do_norm_secs) {
+				for (i = sp->typecnt - 1; i >= 0; --i) {
+					for (j = sp->typecnt - 1; j >= 0; --j) {
+						time_t off;
+						if (sp->ttis[j].tt_isdst ==
+						    sp->ttis[i].tt_isdst)
+							continue;
+						off = sp->ttis[j].tt_utoff -
+						    sp->ttis[i].tt_utoff;
+						yourtm.tm_sec += off < 0 ?
+						    -off : off;
+						goto again;
+					}
+				}
+			}
+#endif
+			if (lo > hi)
+				goto invalid;
+			if (dir > 0)
+				hi = t;
+			else	lo = t;
+			continue;
+		}
+#if defined TM_GMTOFF && ! UNINIT_TRAP
+		if (mytm.TM_GMTOFF != yourtm.TM_GMTOFF
+		    && (yourtm.TM_GMTOFF < 0
+			? (-SECSPERDAY <= yourtm.TM_GMTOFF
+			   && (mytm.TM_GMTOFF <=
+			       (/*CONSTCOND*/SMALLEST (INT_FAST32_MAX, LONG_MAX)
+				+ yourtm.TM_GMTOFF)))
+			: (yourtm.TM_GMTOFF <= SECSPERDAY
+			   && ((/*CONSTCOND*/BIGGEST (INT_FAST32_MIN, LONG_MIN)
+				+ yourtm.TM_GMTOFF)
+			       <= mytm.TM_GMTOFF)))) {
+		  /* MYTM matches YOURTM except with the wrong UT offset.
+		     YOURTM.TM_GMTOFF is plausible, so try it instead.
+		     It's OK if YOURTM.TM_GMTOFF contains uninitialized data,
+		     since the guess gets checked.  */
+		  time_t altt = t;
+		  int_fast32_t diff = (int_fast32_t)
+		      (mytm.TM_GMTOFF - yourtm.TM_GMTOFF);
+		  if (!increment_overflow_time(&altt, diff)) {
+		    struct tm alttm;
+		    if (! funcp(sp, &altt, offset, &alttm)
+			&& alttm.tm_isdst == mytm.tm_isdst
+			&& alttm.TM_GMTOFF == yourtm.TM_GMTOFF
+			&& tmcomp(&alttm, &yourtm)) {
+		      t = altt;
+		      mytm = alttm;
+		    }
+		  }
+		}
+#endif
+		if (yourtm.tm_isdst < 0 || mytm.tm_isdst == yourtm.tm_isdst)
+			break;
+		/*
+		** Right time, wrong type.
+		** Hunt for right time, right type.
+		** It's okay to guess wrong since the guess
+		** gets checked.
+		*/
+		if (sp == NULL)
+			goto invalid;
+		for (i = sp->typecnt - 1; i >= 0; --i) {
+			if (sp->ttis[i].tt_isdst != yourtm.tm_isdst)
+				continue;
+			for (j = sp->typecnt - 1; j >= 0; --j) {
+				if (sp->ttis[j].tt_isdst == yourtm.tm_isdst)
+					continue;
+				newt = (time_t)(t + sp->ttis[j].tt_utoff -
+				    sp->ttis[i].tt_utoff);
+				if (! funcp(sp, &newt, offset, &mytm))
+					continue;
+				if (tmcomp(&mytm, &yourtm) != 0)
+					continue;
+				if (mytm.tm_isdst != yourtm.tm_isdst)
+					continue;
+				/*
+				** We have a match.
+				*/
+				t = newt;
+				goto label;
+			}
+		}
+		goto invalid;
+	}
+label:
+	newt = t + saved_seconds;
+	if ((newt < t) != (saved_seconds < 0))
+		goto out_of_range;
+	t = newt;
+	if (funcp(sp, &t, offset, tmp)) {
+		*okayp = true;
+		return t;
+	}
+out_of_range:
+	errno = EOVERFLOW;
+	return WRONG;
+invalid:
+	errno = EINVAL;
+	return WRONG;
+}
+
+static time_t
+time2(struct tm * const	tmp,
+      struct tm *(*funcp)(struct state const *, time_t const *,
+			  int_fast32_t, struct tm *),
+      struct state const *sp,
+      const int_fast32_t offset,
+      bool *okayp)
+{
+	time_t	t;
+
+	/*
+	** First try without normalization of seconds
+	** (in case tm_sec contains a value associated with a leap second).
+	** If that fails, try with normalization of seconds.
+	*/
+	t = time2sub(tmp, funcp, sp, offset, okayp, false);
+	return *okayp ? t : time2sub(tmp, funcp, sp, offset, okayp, true);
+}
+
+static time_t
+time1(struct tm *const tmp,
+      struct tm *(*funcp) (struct state const *, time_t const *,
+			   int_fast32_t, struct tm *),
+      struct state const *sp,
+      const int_fast32_t offset)
+{
+	time_t			t;
+	int			samei, otheri;
+	int			sameind, otherind;
+	int			i;
+	int			nseen;
+	int			save_errno;
+	char				seen[TZ_MAX_TYPES];
+	unsigned char			types[TZ_MAX_TYPES];
+	bool				okay;
+
+	if (tmp == NULL) {
+		errno = EINVAL;
+		return WRONG;
+	}
+	if (tmp->tm_isdst > 1)
+		tmp->tm_isdst = 1;
+	save_errno = errno;
+	t = time2(tmp, funcp, sp, offset, &okay);
+	if (okay) {
+		errno = save_errno;
+		return t;
+	}
+	if (tmp->tm_isdst < 0)
+#ifdef PCTS
+		/*
+		** POSIX Conformance Test Suite code courtesy Grant Sullivan.
+		*/
+		tmp->tm_isdst = 0;	/* reset to std and try again */
+#else
+		return t;
+#endif /* !defined PCTS */
+	/*
+	** We're supposed to assume that somebody took a time of one type
+	** and did some math on it that yielded a "struct tm" that's bad.
+	** We try to divine the type they started from and adjust to the
+	** type they need.
+	*/
+	if (sp == NULL) {
+		errno = EINVAL;
+		return WRONG;
+	}
+	for (i = 0; i < sp->typecnt; ++i)
+		seen[i] = false;
+	nseen = 0;
+	for (i = sp->timecnt - 1; i >= 0; --i)
+		if (!seen[sp->types[i]]) {
+			seen[sp->types[i]] = true;
+			types[nseen++] = sp->types[i];
+		}
+	for (sameind = 0; sameind < nseen; ++sameind) {
+		samei = types[sameind];
+		if (sp->ttis[samei].tt_isdst != tmp->tm_isdst)
+			continue;
+		for (otherind = 0; otherind < nseen; ++otherind) {
+			otheri = types[otherind];
+			if (sp->ttis[otheri].tt_isdst == tmp->tm_isdst)
+				continue;
+			tmp->tm_sec += (int)(sp->ttis[otheri].tt_utoff -
+					sp->ttis[samei].tt_utoff);
+			tmp->tm_isdst = !tmp->tm_isdst;
+			t = time2(tmp, funcp, sp, offset, &okay);
+			if (okay) {
+				errno = save_errno;
+				return t;
+			}
+			tmp->tm_sec -= (int)(sp->ttis[otheri].tt_utoff -
+					sp->ttis[samei].tt_utoff);
+			tmp->tm_isdst = !tmp->tm_isdst;
+		}
+	}
+	errno = EOVERFLOW;
+	return WRONG;
+}
+
+static time_t
+mktime_tzname(timezone_t sp, struct tm *tmp, bool setname)
+{
+	if (sp)
+		return time1(tmp, localsub, sp, setname);
+	else {
+		gmtcheck();
+		return time1(tmp, gmtsub, gmtptr, 0);
+	}
+}
+
+#if NETBSD_INSPIRED
+
+time_t
+mktime_z(timezone_t sp, struct tm *const tmp)
+{
+	return mktime_tzname(sp, tmp, false);
+}
+
+#endif
+
+time_t
+mktime(struct tm *tmp)
+{
+	time_t t;
+
+	rwlock_wrlock(&__lcl_lock);
+	tzset_unlocked();
+	t = mktime_tzname(__lclptr, tmp, true);
+	rwlock_unlock(&__lcl_lock);
+	return t;
+}
+
+#ifdef STD_INSPIRED
+
+time_t
+timelocal_z(const timezone_t sp, struct tm *const tmp)
+{
+	if (tmp != NULL)
+		tmp->tm_isdst = -1;	/* in case it wasn't initialized */
+	return mktime_z(sp, tmp);
+}
+
+time_t
+timelocal(struct tm *tmp)
+{
+	if (tmp != NULL)
+		tmp->tm_isdst = -1;	/* in case it wasn't initialized */
+	return mktime(tmp);
+}
+
+time_t
+timegm(struct tm *tmp)
+{
+
+	return timeoff(tmp, 0);
+}
+
+time_t
+timeoff(struct tm *tmp, long offset)
+{
+	if (tmp)
+		tmp->tm_isdst = 0;
+	gmtcheck();
+	return time1(tmp, gmtsub, gmtptr, (int_fast32_t)offset);
+}
+
+#endif /* defined STD_INSPIRED */
+
+/*
+** XXX--is the below the right way to conditionalize??
+*/
+
+#ifdef STD_INSPIRED
+
+/*
+** IEEE Std 1003.1 (POSIX) says that 536457599
+** shall correspond to "Wed Dec 31 23:59:59 UTC 1986", which
+** is not the case if we are accounting for leap seconds.
+** So, we provide the following conversion routines for use
+** when exchanging timestamps with POSIX conforming systems.
+*/
+
+static int_fast64_t
+leapcorr(const timezone_t sp, time_t t)
+{
+	struct lsinfo const * lp;
+	int		i;
+
+	i = sp->leapcnt;
+	while (--i >= 0) {
+		lp = &sp->lsis[i];
+		if (t >= lp->ls_trans)
+			return lp->ls_corr;
+	}
+	return 0;
+}
+
+NETBSD_INSPIRED_EXTERN time_t
+time2posix_z(timezone_t sp, time_t t)
+{
+	return (time_t)(t - leapcorr(sp, t));
+}
+
+time_t
+time2posix(time_t t)
+{
+	rwlock_wrlock(&__lcl_lock);
+	if (!lcl_is_set)
+		tzset_unlocked();
+	if (__lclptr)
+		t = (time_t)(t - leapcorr(__lclptr, t));
+	rwlock_unlock(&__lcl_lock);
+	return t;
+}
+
+NETBSD_INSPIRED_EXTERN time_t
+posix2time_z(timezone_t sp, time_t t)
+{
+	time_t	x;
+	time_t	y;
+
+	/*
+	** For a positive leap second hit, the result
+	** is not unique. For a negative leap second
+	** hit, the corresponding time doesn't exist,
+	** so we return an adjacent second.
+	*/
+	x = (time_t)(t + leapcorr(sp, t));
+	y = (time_t)(x - leapcorr(sp, x));
+	if (y < t) {
+		do {
+			x++;
+			y = (time_t)(x - leapcorr(sp, x));
+		} while (y < t);
+		x -= y != t;
+	} else if (y > t) {
+		do {
+			--x;
+			y = (time_t)(x - leapcorr(sp, x));
+		} while (y > t);
+		x += y != t;
+	}
+	return x;
+}
+
+time_t
+posix2time(time_t t)
+{
+	rwlock_wrlock(&__lcl_lock);
+	if (!lcl_is_set)
+		tzset_unlocked();
+	if (__lclptr)
+		t = posix2time_z(__lclptr, t);
+	rwlock_unlock(&__lcl_lock);
+	return t;
+}
+
+#endif /* defined STD_INSPIRED */
diff --git a/winsup/cygwin/tzcode/namespace.h b/winsup/cygwin/tzcode/namespace.h
new file mode 100644
index 000000000..e69de29bb
diff --git a/winsup/cygwin/tzcode/private.h b/winsup/cygwin/tzcode/private.h
new file mode 100644
index 000000000..830750ad5
--- /dev/null
+++ b/winsup/cygwin/tzcode/private.h
@@ -0,0 +1,795 @@
+/* Private header for tzdb code.  */
+
+/*	$NetBSD: private.h,v 1.55 2019/04/04 22:03:23 christos Exp $	*/
+
+#ifndef PRIVATE_H
+#define PRIVATE_H
+
+/* NetBSD defaults */
+#define TM_GMTOFF	tm_gmtoff
+#define TM_ZONE		tm_zone
+#define STD_INSPIRED	1
+#define HAVE_LONG_DOUBLE 1
+
+/* For when we build zic as a host tool. */
+#if HAVE_NBTOOL_CONFIG_H
+#include "nbtool_config.h"
+#endif
+
+/*
+** This file is in the public domain, so clarified as of
+** 1996-06-05 by Arthur David Olson.
+*/
+
+/*
+** This header is for use ONLY with the time conversion code.
+** There is no guarantee that it will remain unchanged,
+** or that it will remain at all.
+** Do NOT copy it to any system include directory.
+** Thank you!
+*/
+
+/*
+** zdump has been made independent of the rest of the time
+** conversion package to increase confidence in the verification it provides.
+** You can use zdump to help in verifying other implementations.
+** To do this, compile with -DUSE_LTZ=0 and link without the tz library.
+*/
+#ifndef USE_LTZ
+# define USE_LTZ 1
+#endif
+
+/* This string was in the Factory zone through version 2016f.  */
+#define GRANDPARENTED	"Local time zone must be set--see zic manual page"
+
+/*
+** Defaults for preprocessor symbols.
+** You can override these in your C compiler options, e.g. '-DHAVE_GETTEXT=1'.
+*/
+
+#ifndef HAVE_DECL_ASCTIME_R
+#define HAVE_DECL_ASCTIME_R 1
+#endif
+
+#if !defined HAVE_GENERIC && defined __has_extension
+# if __has_extension(c_generic_selections)
+#  define HAVE_GENERIC 1
+# else
+#  define HAVE_GENERIC 0
+# endif
+#endif
+/* _Generic is buggy in pre-4.9 GCC.  */
+#if !defined HAVE_GENERIC && defined __GNUC__
+# define HAVE_GENERIC (4 < __GNUC__ + (9 <= __GNUC_MINOR__))
+#endif
+#ifndef HAVE_GENERIC
+# define HAVE_GENERIC (201112 <= __STDC_VERSION__)
+#endif
+
+#ifndef HAVE_GETTEXT
+#define HAVE_GETTEXT		0
+#endif /* !defined HAVE_GETTEXT */
+
+#ifndef HAVE_INCOMPATIBLE_CTIME_R
+#define HAVE_INCOMPATIBLE_CTIME_R	0
+#endif
+
+#ifndef HAVE_LINK
+#define HAVE_LINK		1
+#endif /* !defined HAVE_LINK */
+
+#ifndef HAVE_POSIX_DECLS
+#define HAVE_POSIX_DECLS 1
+#endif
+
+#ifndef HAVE_STDBOOL_H
+#define HAVE_STDBOOL_H (199901 <= __STDC_VERSION__)
+#endif
+
+#ifndef HAVE_STRDUP
+#define HAVE_STRDUP 1
+#endif
+
+#ifndef HAVE_STRTOLL
+#define HAVE_STRTOLL 1
+#endif
+
+#ifndef HAVE_SYMLINK
+#define HAVE_SYMLINK		1
+#endif /* !defined HAVE_SYMLINK */
+
+#ifndef HAVE_SYS_STAT_H
+#define HAVE_SYS_STAT_H		1
+#endif /* !defined HAVE_SYS_STAT_H */
+
+#ifndef HAVE_SYS_WAIT_H
+#define HAVE_SYS_WAIT_H		1
+#endif /* !defined HAVE_SYS_WAIT_H */
+
+#ifndef HAVE_UNISTD_H
+#define HAVE_UNISTD_H		1
+#endif /* !defined HAVE_UNISTD_H */
+
+#ifndef HAVE_UTMPX_H
+#define HAVE_UTMPX_H		1
+#endif /* !defined HAVE_UTMPX_H */
+
+#ifndef NETBSD_INSPIRED
+# define NETBSD_INSPIRED 1
+#endif
+
+#if HAVE_INCOMPATIBLE_CTIME_R
+#define asctime_r _incompatible_asctime_r
+#define ctime_r _incompatible_ctime_r
+#endif /* HAVE_INCOMPATIBLE_CTIME_R */
+
+/* Enable tm_gmtoff, tm_zone, and environ on GNUish systems.  */
+#define _GNU_SOURCE 1
+/* Fix asctime_r on Solaris 11.  */
+#define _POSIX_PTHREAD_SEMANTICS 1
+/* Enable strtoimax on pre-C99 Solaris 11.  */
+#define __EXTENSIONS__ 1
+
+/* To avoid having 'stat' fail unnecessarily with errno == EOVERFLOW,
+   enable large files on GNUish systems ...  */
+#ifndef _FILE_OFFSET_BITS
+# define _FILE_OFFSET_BITS 64
+#endif
+/* ... and on AIX ...  */
+#define _LARGE_FILES 1
+/* ... and enable large inode numbers on Mac OS X 10.5 and later.  */
+#define _DARWIN_USE_64_BIT_INODE 1
+
+/*
+** Nested includes
+*/
+
+#ifndef __NetBSD__
+/* Avoid clashes with NetBSD by renaming NetBSD's declarations.  */
+#define localtime_rz sys_localtime_rz
+#define mktime_z sys_mktime_z
+#define posix2time_z sys_posix2time_z
+#define time2posix_z sys_time2posix_z
+#define timezone_t sys_timezone_t
+#define tzalloc sys_tzalloc
+#define tzfree sys_tzfree
+#include <time.h>
+#undef localtime_rz
+#undef mktime_z
+#undef posix2time_z
+#undef time2posix_z
+#undef timezone_t
+#undef tzalloc
+#undef tzfree
+#else
+#include "time.h"
+#endif
+
+#include <sys/types.h>	/* for time_t */
+#include <string.h>
+#include <limits.h>	/* for CHAR_BIT et al. */
+#include <stdlib.h>
+
+#include <errno.h>
+
+#ifndef ENAMETOOLONG
+# define ENAMETOOLONG EINVAL
+#endif
+#ifndef ENOTSUP
+# define ENOTSUP EINVAL
+#endif
+#ifndef EOVERFLOW
+# define EOVERFLOW EINVAL
+#endif
+
+#if HAVE_GETTEXT
+#include <libintl.h>
+#endif /* HAVE_GETTEXT */
+
+#if HAVE_UNISTD_H
+#include <unistd.h>	/* for R_OK, and other POSIX goodness */
+#endif /* HAVE_UNISTD_H */
+
+#ifndef HAVE_STRFTIME_L
+# if _POSIX_VERSION < 200809
+#  define HAVE_STRFTIME_L 0
+# else
+#  define HAVE_STRFTIME_L 1
+# endif
+#endif
+
+#ifndef USG_COMPAT
+# ifndef _XOPEN_VERSION
+#  define USG_COMPAT 0
+# else
+#  define USG_COMPAT 1
+# endif
+#endif
+
+#ifndef HAVE_TZNAME
+# if _POSIX_VERSION < 198808 && !USG_COMPAT
+#  define HAVE_TZNAME 0
+# else
+#  define HAVE_TZNAME 1
+# endif
+#endif
+
+#ifndef R_OK
+#define R_OK	4
+#endif /* !defined R_OK */
+
+/* Unlike <ctype.h>'s isdigit, this also works if c < 0 | c > UCHAR_MAX. */
+#define is_digit(c) ((unsigned)(c) - '0' <= 9)
+
+/*
+** Define HAVE_STDINT_H's default value here, rather than at the
+** start, since __GLIBC__ and INTMAX_MAX's values depend on
+** previously-included files.  glibc 2.1 and Solaris 10 and later have
+** stdint.h, even with pre-C99 compilers.
+*/
+#ifndef HAVE_STDINT_H
+#define HAVE_STDINT_H \
+   (199901 <= __STDC_VERSION__ \
+    || 2 < __GLIBC__ + (1 <= __GLIBC_MINOR__)	\
+    || __CYGWIN__ || INTMAX_MAX)
+#endif /* !defined HAVE_STDINT_H */
+
+#if HAVE_STDINT_H
+#include <stdint.h>
+#endif /* !HAVE_STDINT_H */
+
+#ifndef HAVE_INTTYPES_H
+# define HAVE_INTTYPES_H HAVE_STDINT_H
+#endif
+#if HAVE_INTTYPES_H
+# include <inttypes.h>
+#endif
+
+/* Pre-C99 GCC compilers define __LONG_LONG_MAX__ instead of LLONG_MAX.  */
+#ifdef __LONG_LONG_MAX__
+# ifndef LLONG_MAX
+#  define LLONG_MAX __LONG_LONG_MAX__
+# endif
+# ifndef LLONG_MIN
+#  define LLONG_MIN (-1 - LLONG_MAX)
+# endif
+#endif
+
+#ifndef INT_FAST64_MAX
+# ifdef LLONG_MAX
+typedef long long	int_fast64_t;
+#  define INT_FAST64_MIN LLONG_MIN
+#  define INT_FAST64_MAX LLONG_MAX
+# else
+#  if LONG_MAX >> 31 < 0xffffffff
+Please use a compiler that supports a 64-bit integer type (or wider);
+you may need to compile with "-DHAVE_STDINT_H".
+#  endif
+typedef long		int_fast64_t;
+#  define INT_FAST64_MIN LONG_MIN
+#  define INT_FAST64_MAX LONG_MAX
+# endif
+#endif
+
+#ifndef PRIdFAST64
+# if INT_FAST64_MAX == LLONG_MAX
+#  define PRIdFAST64 "lld"
+# else
+#  define PRIdFAST64 "ld"
+# endif
+#endif
+
+#ifndef SCNdFAST64
+# define SCNdFAST64 PRIdFAST64
+#endif
+
+#ifndef INT_FAST32_MAX
+# if INT_MAX >> 31 == 0
+typedef long int_fast32_t;
+#  define INT_FAST32_MAX LONG_MAX
+#  define INT_FAST32_MIN LONG_MIN
+# else
+typedef int int_fast32_t;
+#  define INT_FAST32_MAX INT_MAX
+#  define INT_FAST32_MIN INT_MIN
+# endif
+#endif
+
+#ifndef INTMAX_MAX
+# ifdef LLONG_MAX
+typedef long long intmax_t;
+#  if HAVE_STRTOLL
+#   define strtoimax strtoll
+#  endif
+#  define INTMAX_MAX LLONG_MAX
+#  define INTMAX_MIN LLONG_MIN
+# else
+typedef long intmax_t;
+#  define INTMAX_MAX LONG_MAX
+#  define INTMAX_MIN LONG_MIN
+# endif
+# ifndef strtoimax
+#  define strtoimax strtol
+# endif
+#endif
+
+#ifndef PRIdMAX
+# if INTMAX_MAX == LLONG_MAX
+#  define PRIdMAX "lld"
+# else
+#  define PRIdMAX "ld"
+# endif
+#endif
+
+#ifndef UINT_FAST64_MAX
+# if defined ULLONG_MAX || defined __LONG_LONG_MAX__
+typedef unsigned long long uint_fast64_t;
+# else
+#  if ULONG_MAX >> 31 >> 1 < 0xffffffff
+Please use a compiler that supports a 64-bit integer type (or wider);
+you may need to compile with "-DHAVE_STDINT_H".
+#  endif
+typedef unsigned long	uint_fast64_t;
+# endif
+#endif
+
+#ifndef UINTMAX_MAX
+# if defined ULLONG_MAX || defined __LONG_LONG_MAX__
+typedef unsigned long long uintmax_t;
+# else
+typedef unsigned long uintmax_t;
+# endif
+#endif
+
+#ifndef PRIuMAX
+# if defined ULLONG_MAX || defined __LONG_LONG_MAX__
+#  define PRIuMAX "llu"
+# else
+#  define PRIuMAX "lu"
+# endif
+#endif
+
+#ifndef INT32_MAX
+#define INT32_MAX 0x7fffffff
+#endif /* !defined INT32_MAX */
+#ifndef INT32_MIN
+#define INT32_MIN (-1 - INT32_MAX)
+#endif /* !defined INT32_MIN */
+
+#ifndef SIZE_MAX
+#define SIZE_MAX ((size_t) -1)
+#endif
+
+#if 3 <= __GNUC__
+# define ATTRIBUTE_CONST __attribute__ ((__const__))
+# define ATTRIBUTE_MALLOC __attribute__ ((__malloc__))
+# define ATTRIBUTE_PURE __attribute__ ((__pure__))
+# define ATTRIBUTE_FORMAT(spec) __attribute__ ((__format__ spec))
+#else
+# define ATTRIBUTE_CONST /* empty */
+# define ATTRIBUTE_MALLOC /* empty */
+# define ATTRIBUTE_PURE /* empty */
+# define ATTRIBUTE_FORMAT(spec) /* empty */
+#endif
+
+#if !defined _Noreturn && __STDC_VERSION__ < 201112
+# if 2 < __GNUC__ + (8 <= __GNUC_MINOR__)
+#  define _Noreturn __attribute__ ((__noreturn__))
+# else
+#  define _Noreturn
+# endif
+#endif
+
+#if __STDC_VERSION__ < 199901 && !defined restrict
+# define restrict /* empty */
+#endif
+
+/*
+** Workarounds for compilers/systems.
+*/
+
+#ifndef EPOCH_LOCAL
+# define EPOCH_LOCAL 0
+#endif
+#ifndef EPOCH_OFFSET
+# define EPOCH_OFFSET 0
+#endif
+#ifndef RESERVE_STD_EXT_IDS
+# define RESERVE_STD_EXT_IDS 0
+#endif
+
+/* If standard C identifiers with external linkage (e.g., localtime)
+   are reserved and are not already being renamed anyway, rename them
+   as if compiling with '-Dtime_tz=time_t'.  */
+#if !defined time_tz && RESERVE_STD_EXT_IDS && USE_LTZ
+# define time_tz time_t
+#endif
+
+/*
+** Compile with -Dtime_tz=T to build the tz package with a private
+** time_t type equivalent to T rather than the system-supplied time_t.
+** This debugging feature can test unusual design decisions
+** (e.g., time_t wider than 'long', or unsigned time_t) even on
+** typical platforms.
+*/
+#if defined time_tz || EPOCH_LOCAL || EPOCH_OFFSET != 0
+# define TZ_TIME_T 1
+#else
+# define TZ_TIME_T 0
+#endif
+
+#if TZ_TIME_T
+# ifdef LOCALTIME_IMPLEMENTATION
+static time_t sys_time(time_t *x) { return time(x); }
+# endif
+
+typedef time_tz tz_time_t;
+
+# undef  ctime
+# define ctime tz_ctime
+# undef  ctime_r
+# define ctime_r tz_ctime_r
+# undef  difftime
+# define difftime tz_difftime
+# undef  gmtime
+# define gmtime tz_gmtime
+# undef  gmtime_r
+# define gmtime_r tz_gmtime_r
+# undef  localtime
+# define localtime tz_localtime
+# undef  localtime_r
+# define localtime_r tz_localtime_r
+# undef  localtime_rz
+# define localtime_rz tz_localtime_rz
+# undef  mktime
+# define mktime tz_mktime
+# undef  mktime_z
+# define mktime_z tz_mktime_z
+# undef  offtime
+# define offtime tz_offtime
+# undef  posix2time
+# define posix2time tz_posix2time
+# undef  posix2time_z
+# define posix2time_z tz_posix2time_z
+# undef  strftime
+# define strftime tz_strftime
+# undef  time
+# define time tz_time
+# undef  time2posix
+# define time2posix tz_time2posix
+# undef  time2posix_z
+# define time2posix_z tz_time2posix_z
+# undef  time_t
+# define time_t tz_time_t
+# undef  timegm
+# define timegm tz_timegm
+# undef  timelocal
+# define timelocal tz_timelocal
+# undef  timeoff
+# define timeoff tz_timeoff
+# undef  tzalloc
+# define tzalloc tz_tzalloc
+# undef  tzfree
+# define tzfree tz_tzfree
+# undef  tzset
+# define tzset tz_tzset
+# undef  tzsetwall
+# define tzsetwall tz_tzsetwall
+# if HAVE_STRFTIME_L
+#  undef  strftime_l
+#  define strftime_l tz_strftime_l
+# endif
+# if HAVE_TZNAME
+#  undef  tzname
+#  define tzname tz_tzname
+# endif
+# if USG_COMPAT
+#  undef  daylight
+#  define daylight tz_daylight
+#  undef  timezone
+#  define timezone tz_timezone
+# endif
+# ifdef ALTZONE
+#  undef  altzone
+#  define altzone tz_altzone
+# endif
+
+char *ctime(time_t const *);
+char *ctime_r(time_t const *, char *);
+double difftime(time_t, time_t) ATTRIBUTE_CONST;
+size_t strftime(char *restrict, size_t, char const *restrict,
+		struct tm const *restrict);
+# if HAVE_STRFTIME_L
+size_t strftime_l(char *restrict, size_t, char const *restrict,
+		  struct tm const *restrict, locale_t);
+# endif
+struct tm *gmtime(time_t const *);
+struct tm *gmtime_r(time_t const *restrict, struct tm *restrict);
+struct tm *localtime(time_t const *);
+struct tm *localtime_r(time_t const *restrict, struct tm *restrict);
+time_t mktime(struct tm *);
+time_t time(time_t *);
+void tzset(void);
+#endif
+
+#if !HAVE_DECL_ASCTIME_R && !defined asctime_r
+extern char *asctime_r(struct tm const *restrict, char *restrict);
+#endif
+
+#ifndef HAVE_DECL_ENVIRON
+# if defined environ || defined __USE_GNU
+#  define HAVE_DECL_ENVIRON 1
+# else
+#  define HAVE_DECL_ENVIRON 0
+# endif
+#endif
+
+#if !HAVE_DECL_ENVIRON
+extern char **environ;
+#endif
+
+#if TZ_TIME_T || !HAVE_POSIX_DECLS
+# if HAVE_TZNAME
+extern char *tzname[];
+# endif
+# if USG_COMPAT
+extern long timezone;
+extern int daylight;
+# endif
+#endif
+
+#ifdef ALTZONE
+extern long altzone;
+#endif
+
+/*
+** The STD_INSPIRED functions are similar, but most also need
+** declarations if time_tz is defined.
+*/
+
+#ifdef STD_INSPIRED
+# if TZ_TIME_T || !defined tzsetwall
+void tzsetwall(void);
+# endif
+# if TZ_TIME_T || !defined offtime
+struct tm *offtime(time_t const *, long);
+# endif
+# if TZ_TIME_T || !defined timegm
+time_t timegm(struct tm *);
+# endif
+# if TZ_TIME_T || !defined timelocal
+time_t timelocal(struct tm *);
+# endif
+# if TZ_TIME_T || !defined timeoff
+time_t timeoff(struct tm *, long);
+# endif
+# if TZ_TIME_T || !defined time2posix
+time_t time2posix(time_t);
+# endif
+# if TZ_TIME_T || !defined posix2time
+time_t posix2time(time_t);
+# endif
+#endif
+
+/* Infer TM_ZONE on systems where this information is known, but suppress
+   guessing if NO_TM_ZONE is defined.  Similarly for TM_GMTOFF.  */
+#if (defined __GLIBC__ \
+     || defined __FreeBSD__ || defined __NetBSD__ || defined __OpenBSD__ \
+     || (defined __APPLE__ && defined __MACH__))
+# if !defined TM_GMTOFF && !defined NO_TM_GMTOFF
+#  define TM_GMTOFF tm_gmtoff
+# endif
+# if !defined TM_ZONE && !defined NO_TM_ZONE
+#  define TM_ZONE tm_zone
+# endif
+#endif
+
+/*
+** Define functions that are ABI compatible with NetBSD but have
+** better prototypes.  NetBSD 6.1.4 defines a pointer type timezone_t
+** and labors under the misconception that 'const timezone_t' is a
+** pointer to a constant.  This use of 'const' is ineffective, so it
+** is not done here.  What we call 'struct state' NetBSD calls
+** 'struct __state', but this is a private name so it doesn't matter.
+*/
+#ifndef __NetBSD__
+#if NETBSD_INSPIRED
+typedef struct state *timezone_t;
+struct tm *localtime_rz(timezone_t restrict, time_t const *restrict,
+			struct tm *restrict);
+time_t mktime_z(timezone_t restrict, struct tm *restrict);
+timezone_t tzalloc(char const *);
+void tzfree(timezone_t);
+# ifdef STD_INSPIRED
+#  if TZ_TIME_T || !defined posix2time_z
+time_t posix2time_z(timezone_t __restrict, time_t) ATTRIBUTE_PURE;
+#  endif
+#  if TZ_TIME_T || !defined time2posix_z
+time_t time2posix_z(timezone_t __restrict, time_t) ATTRIBUTE_PURE;
+#  endif
+# endif
+#endif
+#endif
+
+/*
+** Finally, some convenience items.
+*/
+
+#if HAVE_STDBOOL_H
+# include <stdbool.h>
+#else
+# define true 1
+# define false 0
+# define bool int
+#endif
+
+#define TYPE_BIT(type)	(sizeof (type) * CHAR_BIT)
+#define TYPE_SIGNED(type) (/*CONSTCOND*/((type) -1) < 0)
+#define TWOS_COMPLEMENT(t) (/*CONSTCOND*/(t) ~ (t) 0 < 0)
+
+/* Max and min values of the integer type T, of which only the bottom
+   B bits are used, and where the highest-order used bit is considered
+   to be a sign bit if T is signed.  */
+#define MAXVAL(t, b) /*LINTED*/					\
+  ((t) (((t) 1 << ((b) - 1 - TYPE_SIGNED(t)))			\
+	- 1 + ((t) 1 << ((b) - 1 - TYPE_SIGNED(t)))))
+#define MINVAL(t, b)						\
+  ((t) (TYPE_SIGNED(t) ? - TWOS_COMPLEMENT(t) - MAXVAL(t, b) : 0))
+
+/* The extreme time values, assuming no padding.  */
+#define TIME_T_MIN_NO_PADDING MINVAL(time_t, TYPE_BIT(time_t))
+#define TIME_T_MAX_NO_PADDING MAXVAL(time_t, TYPE_BIT(time_t))
+
+/* The extreme time values.  These are macros, not constants, so that
+   any portability problem occur only when compiling .c files that use
+   the macros, which is safer for applications that need only zdump and zic.
+   This implementation assumes no padding if time_t is signed and
+   either the compiler lacks support for _Generic or time_t is not one
+   of the standard signed integer types.  */
+#if HAVE_GENERIC
+# define TIME_T_MIN \
+    _Generic((time_t) 0, \
+	     signed char: SCHAR_MIN, short: SHRT_MIN, \
+	     int: INT_MIN, long: LONG_MIN, long long: LLONG_MIN, \
+	     default: TIME_T_MIN_NO_PADDING)
+# define TIME_T_MAX \
+    (TYPE_SIGNED(time_t) \
+     ? _Generic((time_t) 0, \
+		signed char: SCHAR_MAX, short: SHRT_MAX, \
+		int: INT_MAX, long: LONG_MAX, long long: LLONG_MAX, \
+		default: TIME_T_MAX_NO_PADDING)			    \
+     : (time_t) -1)
+#else
+# define TIME_T_MIN TIME_T_MIN_NO_PADDING
+# define TIME_T_MAX TIME_T_MAX_NO_PADDING
+#endif
+
+/*
+** 302 / 1000 is log10(2.0) rounded up.
+** Subtract one for the sign bit if the type is signed;
+** add one for integer division truncation;
+** add one more for a minus sign if the type is signed.
+*/
+#define INT_STRLEN_MAXIMUM(type) \
+	((TYPE_BIT(type) - TYPE_SIGNED(type)) * 302 / 1000 + \
+	1 + TYPE_SIGNED(type))
+
+/*
+** INITIALIZE(x)
+*/
+
+#if defined(__GNUC__) || defined(__lint__)
+# define INITIALIZE(x)	((x) = 0)
+#else
+# define INITIALIZE(x)
+#endif
+
+#ifndef UNINIT_TRAP
+# define UNINIT_TRAP 0
+#endif
+
+/*
+** For the benefit of GNU folk...
+** '_(MSGID)' uses the current locale's message library string for MSGID.
+** The default is to use gettext if available, and use MSGID otherwise.
+*/
+
+#if HAVE_GETTEXT
+#define _(msgid) gettext(msgid)
+#else /* !HAVE_GETTEXT */
+#define _(msgid) msgid
+#endif /* !HAVE_GETTEXT */
+
+#if !defined TZ_DOMAIN && defined HAVE_GETTEXT
+# define TZ_DOMAIN "tz"
+#endif
+
+#if HAVE_INCOMPATIBLE_CTIME_R
+#undef asctime_r
+#undef ctime_r
+char *asctime_r(struct tm const *, char *);
+char *ctime_r(time_t const *, char *);
+#endif /* HAVE_INCOMPATIBLE_CTIME_R */
+
+/* Handy macros that are independent of tzfile implementation.  */
+
+#define YEARSPERREPEAT		400	/* years before a Gregorian repeat */
+
+#define SECSPERMIN	60
+#define MINSPERHOUR	60
+#define HOURSPERDAY	24
+#define DAYSPERWEEK	7
+#define DAYSPERNYEAR	365
+#define DAYSPERLYEAR	366
+#define SECSPERHOUR	(SECSPERMIN * MINSPERHOUR)
+#define SECSPERDAY	((int_fast32_t) SECSPERHOUR * HOURSPERDAY)
+#define MONSPERYEAR	12
+
+#define TM_SUNDAY	0
+#define TM_MONDAY	1
+#define TM_TUESDAY	2
+#define TM_WEDNESDAY	3
+#define TM_THURSDAY	4
+#define TM_FRIDAY	5
+#define TM_SATURDAY	6
+
+#define TM_JANUARY	0
+#define TM_FEBRUARY	1
+#define TM_MARCH	2
+#define TM_APRIL	3
+#define TM_MAY		4
+#define TM_JUNE		5
+#define TM_JULY		6
+#define TM_AUGUST	7
+#define TM_SEPTEMBER	8
+#define TM_OCTOBER	9
+#define TM_NOVEMBER	10
+#define TM_DECEMBER	11
+
+#define TM_YEAR_BASE	1900
+
+#define EPOCH_YEAR	1970
+#define EPOCH_WDAY	TM_THURSDAY
+
+#define isleap(y) (((y) % 4) == 0 && (((y) % 100) != 0 || ((y) % 400) == 0))
+
+/*
+** Since everything in isleap is modulo 400 (or a factor of 400), we know that
+**	isleap(y) == isleap(y % 400)
+** and so
+**	isleap(a + b) == isleap((a + b) % 400)
+** or
+**	isleap(a + b) == isleap(a % 400 + b % 400)
+** This is true even if % means modulo rather than Fortran remainder
+** (which is allowed by C89 but not by C99 or later).
+** We use this to avoid addition overflow problems.
+*/
+
+#define isleap_sum(a, b)	isleap((a) % 400 + (b) % 400)
+
+
+/*
+** The Gregorian year averages 365.2425 days, which is 31556952 seconds.
+*/
+
+#define AVGSECSPERYEAR		31556952L
+#define SECSPERREPEAT \
+  ((int_fast64_t) YEARSPERREPEAT * (int_fast64_t) AVGSECSPERYEAR)
+#define SECSPERREPEAT_BITS	34	/* ceil(log2(SECSPERREPEAT)) */
+
+#ifdef _LIBC
+#include "reentrant.h"
+extern struct __state *__lclptr;
+#if defined(__LIBC12_SOURCE__)
+#define tzset_unlocked __tzset_unlocked
+#else
+#define tzset_unlocked __tzset_unlocked50
+#endif
+
+void tzset_unlocked(void);
+#ifdef _REENTRANT
+extern rwlock_t __lcl_lock;
+#endif
+#endif
+
+#endif /* !defined PRIVATE_H */
diff --git a/winsup/cygwin/tzcode/tzfile.h b/winsup/cygwin/tzcode/tzfile.h
new file mode 100644
index 000000000..5c7a22239
--- /dev/null
+++ b/winsup/cygwin/tzcode/tzfile.h
@@ -0,0 +1,174 @@
+/*	$NetBSD: tzfile.h,v 1.10 2019/07/03 15:49:21 christos Exp $	*/
+
+#ifndef _TZFILE_H_
+#define _TZFILE_H_
+
+/*
+** This file is in the public domain, so clarified as of
+** 1996-06-05 by Arthur David Olson.
+*/
+
+/*
+** This header is for use ONLY with the time conversion code.
+** There is no guarantee that it will remain unchanged,
+** or that it will remain at all.
+** Do NOT copy it to any system include directory.
+** Thank you!
+*/
+
+/*
+** Information about time zone files.
+*/
+
+#ifndef TZDIR		/* Time zone object file directory */
+#define TZDIR		"/usr/share/zoneinfo"
+#endif /* !defined TZDIR */
+
+#ifndef TZDEFAULT
+#define TZDEFAULT	"/etc/localtime"
+#endif /* !defined TZDEFAULT */
+
+#ifndef TZDEFRULES
+#define TZDEFRULES	"posixrules"
+#endif /* !defined TZDEFRULES */
+
+
+/* See Internet RFC 8536 for more details about the following format.  */
+
+/*
+** Each file begins with. . .
+*/
+
+#define	TZ_MAGIC	"TZif"
+
+struct tzhead {
+	char	tzh_magic[4];		/* TZ_MAGIC */
+	char	tzh_version[1];		/* '\0' or '2' or '3' as of 2013 */
+	char	tzh_reserved[15];	/* reserved; must be zero */
+	char	tzh_ttisutcnt[4];	/* coded number of trans. time flags */
+	char	tzh_ttisstdcnt[4];	/* coded number of trans. time flags */
+	char	tzh_leapcnt[4];		/* coded number of leap seconds */
+	char	tzh_timecnt[4];		/* coded number of transition times */
+	char	tzh_typecnt[4];		/* coded number of local time types */
+	char	tzh_charcnt[4];		/* coded number of abbr. chars */
+};
+
+/*
+** . . .followed by. . .
+**
+**	tzh_timecnt (char [4])s		coded transition times a la time(2)
+**	tzh_timecnt (unsigned char)s	types of local time starting at above
+**	tzh_typecnt repetitions of
+**		one (char [4])		coded UT offset in seconds
+**		one (unsigned char)	used to set tm_isdst
+**		one (unsigned char)	that's an abbreviation list index
+**	tzh_charcnt (char)s		'\0'-terminated zone abbreviations
+**	tzh_leapcnt repetitions of
+**		one (char [4])		coded leap second transition times
+**		one (char [4])		total correction after above
+**	tzh_ttisstdcnt (char)s		indexed by type; if 1, transition
+**					time is standard time, if 0,
+**					transition time is local (wall clock)
+**					time; if absent, transition times are
+**					assumed to be local time
+**	tzh_ttisutcnt (char)s		indexed by type; if 1, transition
+**					time is UT, if 0, transition time is
+**					local time; if absent, transition
+**					times are assumed to be local time.
+**					When this is 1, the corresponding
+**					std/wall indicator must also be 1.
+*/
+
+/*
+** If tzh_version is '2' or greater, the above is followed by a second instance
+** of tzhead and a second instance of the data in which each coded transition
+** time uses 8 rather than 4 chars,
+** then a POSIX-TZ-environment-variable-style string for use in handling
+** instants after the last transition time stored in the file
+** (with nothing between the newlines if there is no POSIX representation for
+** such instants).
+**
+** If tz_version is '3' or greater, the above is extended as follows.
+** First, the POSIX TZ string's hour offset may range from -167
+** through 167 as compared to the POSIX-required 0 through 24.
+** Second, its DST start time may be January 1 at 00:00 and its stop
+** time December 31 at 24:00 plus the difference between DST and
+** standard time, indicating DST all year.
+*/
+
+/*
+** In the current implementation, "tzset()" refuses to deal with files that
+** exceed any of the limits below.
+*/
+
+#ifndef TZ_MAX_TIMES
+#define TZ_MAX_TIMES	2000
+#endif /* !defined TZ_MAX_TIMES */
+
+#ifndef TZ_MAX_TYPES
+/* This must be at least 17 for Europe/Samara and Europe/Vilnius.  */
+#define TZ_MAX_TYPES	256 /* Limited by what (unsigned char)'s can hold */
+#endif /* !defined TZ_MAX_TYPES */
+
+#ifndef TZ_MAX_CHARS
+#define TZ_MAX_CHARS	50	/* Maximum number of abbreviation characters */
+				/* (limited by what unsigned chars can hold) */
+#endif /* !defined TZ_MAX_CHARS */
+
+#ifndef TZ_MAX_LEAPS
+#define TZ_MAX_LEAPS	50	/* Maximum number of leap second corrections */
+#endif /* !defined TZ_MAX_LEAPS */
+
+#define SECSPERMIN	60
+#define MINSPERHOUR	60
+#define HOURSPERDAY	24
+#define DAYSPERWEEK	7
+#define DAYSPERNYEAR	365
+#define DAYSPERLYEAR	366
+#define SECSPERHOUR	(SECSPERMIN * MINSPERHOUR)
+#define SECSPERDAY	((int_fast32_t) SECSPERHOUR * HOURSPERDAY)
+#define MONSPERYEAR	12
+
+#define TM_SUNDAY	0
+#define TM_MONDAY	1
+#define TM_TUESDAY	2
+#define TM_WEDNESDAY	3
+#define TM_THURSDAY	4
+#define TM_FRIDAY	5
+#define TM_SATURDAY	6
+
+#define TM_JANUARY	0
+#define TM_FEBRUARY	1
+#define TM_MARCH	2
+#define TM_APRIL	3
+#define TM_MAY		4
+#define TM_JUNE		5
+#define TM_JULY		6
+#define TM_AUGUST	7
+#define TM_SEPTEMBER	8
+#define TM_OCTOBER	9
+#define TM_NOVEMBER	10
+#define TM_DECEMBER	11
+
+#define TM_YEAR_BASE	1900
+
+#define EPOCH_YEAR	1970
+#define EPOCH_WDAY	TM_THURSDAY
+
+#define isleap(y) (((y) % 4) == 0 && (((y) % 100) != 0 || ((y) % 400) == 0))
+
+/*
+** Since everything in isleap is modulo 400 (or a factor of 400), we know that
+**	isleap(y) == isleap(y % 400)
+** and so
+**	isleap(a + b) == isleap((a + b) % 400)
+** or
+**	isleap(a + b) == isleap(a % 400 + b % 400)
+** This is true even if % means modulo rather than Fortran remainder
+** (which is allowed by C89 but not C99).
+** We use this to avoid addition overflow problems.
+*/
+
+#define isleap_sum(a, b)	isleap((a) % 400 + (b) % 400)
+
+#endif /* !defined _TZFILE_H_ */
-- 
2.21.0

