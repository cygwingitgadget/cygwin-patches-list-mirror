Return-Path: <cygwin-patches-return-5822-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22698 invoked by alias); 15 Apr 2006 16:12:58 -0000
Received: (qmail 22688 invoked by uid 22791); 15 Apr 2006 16:12:57 -0000
X-Spam-Check-By: sourceware.org
Received: from rwcrmhc12.comcast.net (HELO rwcrmhc12.comcast.net) (204.127.192.82)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 15 Apr 2006 16:12:55 +0000
Received: from rmailcenter76.comcast.net ([204.127.197.158])           by comcast.net (rwcrmhc12) with SMTP           id <20060415161254m12003oohse>; Sat, 15 Apr 2006 16:12:54 +0000
Received: from [24.10.241.225] by rmailcenter76.comcast.net; 	Sat, 15 Apr 2006 16:12:53 +0000
From: ericblake@comcast.net (Eric Blake)
To: cygwin-patches@cygwin.com
Subject: limits.h missing constants
Date: Sat, 15 Apr 2006 16:12:00 -0000
Message-Id: <041520061612.3774.44411B850002AC8100000EBE22064244130A050E040D0C079D0A@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Apr 11 2006)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="NextPart_Webmail_9m3u9jl4l_3774_1145117573_0"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00010.txt.bz2


--NextPart_Webmail_9m3u9jl4l_3774_1145117573_0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Content-length: 894

CVS gettext had a compilation warning due to a missing value
for CHARCLASS_NAME_MAX.  Cygwin regex currently only supports
char-class names of up to 6 characters (for example, "[:xdigit:]"),
but POSIX requires a minimum of 14 when locales are free to
define their own char-class names.  While I was at it, I
noticed that several of the limits.h constants that are required
to be the same across all platforms were missing or incorrect.
And we might as well publicize our limit for declaring ELOOP on
symlink chains, rather than keeping it hidden in path.h.

2006-04-15  Eric Blake  <ebb9@byu.net>

	* include/limits.h (_POSIX_*, _POSIX2_*, _XOPEN_*): Define missing
	standard constants, and correct invalid ones.
	(CHARCLASS_NAME_MAX): Define.
	(SYMLOOP_MAX): Define.
	* path.h (MAX_LINK_DEPTH): Define in terms of SYMLOOP_MAX.
	* regex/regcomp.c (p_b_cclass): Limit length of char class name.

--NextPart_Webmail_9m3u9jl4l_3774_1145117573_0
Content-Type: application/octet-stream; name="cygwin.patch"
Content-Transfer-Encoding: 7bit
Content-length: 3963

Index: include/limits.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/limits.h,v
retrieving revision 1.16
diff -u -p -r1.16 limits.h
--- include/limits.h	29 May 2005 10:05:56 -0000	1.16
+++ include/limits.h	15 Apr 2006 15:43:29 -0000
@@ -131,6 +131,12 @@ details. */
 /* Maximum length of a path component. */
 #define NAME_MAX 255
 
+/* Maximum depth of symlinks (after which ELOOP is issued).  */
+#define SYMLOOP_MAX 10
+
+/* Maximum length of a regex character class name. */
+#define CHARCLASS_NAME_MAX _POSIX2_CHARCLASS_NAME_MAX
+
 /* Max num groups for a user, value taken from NT documentation */
 /* Must match <sys/param.h> NGROUPS */
 #define NGROUPS_MAX 16
@@ -167,22 +173,54 @@ details. */
 /* These should never vary from one system type to another */
 /* They represent the minimum values that POSIX systems must support.
    POSIX-conforming apps must not require larger values. */
-#define	_POSIX_ARG_MAX		4096
-#define _POSIX_CHILD_MAX	6
+#define _POSIX_AIO_LISTIO_MAX	2
+#define _POSIX_AIO_MAX		1
+#define _POSIX_ARG_MAX		4096
+#define _POSIX_CHILD_MAX	25
+#define _POSIX_DELAYTIMER_MAX	32
+#define _POSIX_HOST_NAME_MAX	255
 #define _POSIX_LINK_MAX		8
+#define _POSIX_LOGIN_NAME_MAX	9
 #define _POSIX_MAX_CANON	255
 #define _POSIX_MAX_INPUT	255
+#define _POSIX_MQ_PRIO_MAX	32
 #define _POSIX_NAME_MAX		14
-#define _POSIX_NGROUPS_MAX	0
-#define _POSIX_OPEN_MAX		16
-#define _POSIX_PATH_MAX		255
+#define _POSIX_NGROUPS_MAX	8
+#define _POSIX_OPEN_MAX		20
+#define _POSIX_PATH_MAX		256
 #define _POSIX_PIPE_BUF		512
+#define _POSIX_RE_DUP_MAX	255
+#define _POSIX_RTSIG_MAX	8
+#define _POSIX_SEM_NSEMS_MAX	256
+#define _POSIX_SEM_VALUE_MAX	32767
+#define _POSIX_SIGQUEUE_MAX	32
 #define _POSIX_SSIZE_MAX	32767
 #define _POSIX_STREAM_MAX	8
-#define _POSIX_TZNAME_MAX       3
-#define _POSIX_RTSIG_MAX	8
+#define _POSIX_SS_REPL_MAX	4
+#define _POSIX_SYMLINK_MAX	255
+#define _POSIX_SYMLOOP_MAX	8
+#define _POSIX_THREAD_DESTRUCTOR_ITERATIONS	4
+#define _POSIX_THREAD_KEYS_MAX	128
+#define _POSIX_THREAD_THREADS_MAX	64
 #define _POSIX_TIMER_MAX	32
+#define _POSIX_TRACE_EVENT_NAME_MAX	30
+#define _POSIX_TRACE_NAME_MAX	8
+#define _POSIX_TRACE_SYS_MAX	8
+#define _POSIX_TRACE_USER_EVENT_MAX	32
 #define _POSIX_TTY_NAME_MAX	9
+#define _POSIX_TZNAME_MAX       6
+#define _POSIX2_BC_BASE_MAX	99
+#define _POSIX2_BC_DIM_MAX	2048
+#define _POSIX2_BC_SCALE_MAX	99
+#define _POSIX2_BC_STRING_MAX	1000
+#define _POSIX2_CHARCLASS_NAME_MAX	14
+#define _POSIX2_COLL_WEIGHTS_MAX	2
+#define _POSIX2_EXPR_NEST_MAX	32
+#define _POSIX2_LINE_MAX	2048
+#define _POSIX2_RE_DUP_MAX	255
+#define _XOPEN_IOV_MAX		16
+#define _XOPEN_NAME_MAX		255
+#define _XOPEN_PATH_MAX		1024
 
 #define RTSIG_MAX		_POSIX_RTSIG_MAX
 
Index: path.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.h,v
retrieving revision 1.88
diff -u -p -r1.88 path.h
--- path.h	28 Feb 2006 20:26:52 -0000	1.88
+++ path.h	15 Apr 2006 15:43:29 -0000
@@ -260,7 +260,7 @@ class path_conv
 #define SHORTCUT_HDR_SIZE       76
 
 /* Maximum depth of symlinks (after which ELOOP is issued).  */
-#define MAX_LINK_DEPTH 10
+#define MAX_LINK_DEPTH SYMLOOP_MAX
 int __stdcall slash_unc_prefix_p (const char *path) __attribute__ ((regparm(1)));
 
 enum fe_types
Index: regex/regcomp.c
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/regex/regcomp.c,v
retrieving revision 1.3
diff -u -p -r1.3 regcomp.c
--- regex/regcomp.c	30 Sep 2002 02:51:22 -0000	1.3
+++ regex/regcomp.c	15 Apr 2006 15:43:29 -0000
@@ -731,6 +731,11 @@ register cset *cs;
 	while (MORE() && isalpha(PEEK()))
 		NEXT();
 	len = p->next - sp;
+	if (len > CHARCLASS_NAME_MAX) {
+		/* oops, can't find it */
+		SETERROR(REG_ECTYPE);
+		return;
+	}
 	for (cp = cclasses; cp->name != NULL; cp++)
 		if (strncmp(cp->name, sp, len) == 0 && cp->name[len] == '\0')
 			break;

--NextPart_Webmail_9m3u9jl4l_3774_1145117573_0--
