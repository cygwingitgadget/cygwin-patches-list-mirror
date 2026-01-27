Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 3990D4BA2E29; Tue, 27 Jan 2026 20:14:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3990D4BA2E29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1769544863;
	bh=o6+rs7GzyFIRQjX78NLe9xpbPSlPnUosqmKv5tYn1Do=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gMPRtywm2q3/PP66sRwIJ50EFfqwZKm7nZcrfeKrToQBrJUfEyfh/WeLvsf0wzUZy
	 aqLnmPYhd2GQsjcEJrUnqs+AJ3tjKuzpgEgnkvbwuItf+li+XxeU491sg4pVpsNXa+
	 uZlDvjXkVgU5pNsUPon88tWj5LTpy1/CiawRoNJ0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E7E1BA81CF5; Tue, 27 Jan 2026 21:14:20 +0100 (CET)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 1/2] Cygwin: gencat: update to latest from NetBSD
Date: Tue, 27 Jan 2026 21:14:19 +0100
Message-ID: <20260127201420.580616-1-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126120611.392483-1-corinna-cygwin@cygwin.com>
References: <20260126120611.392483-1-corinna-cygwin@cygwin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

NetBSD gencat version 1.37

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/utils/gencat.c | 430 ++++++++++++++++++++++++++++++------------
 1 file changed, 307 insertions(+), 123 deletions(-)

diff --git a/winsup/utils/gencat.c b/winsup/utils/gencat.c
index a583a884381f..b009b77c09b6 100644
--- a/winsup/utils/gencat.c
+++ b/winsup/utils/gencat.c
@@ -1,11 +1,6 @@
-/* ex:ts=4
- */
-
-/*	$NetBSD: gencat.c,v 1.18 2003/10/27 00:12:43 lukem Exp $	*/
+/*	$NetBSD: gencat.c,v 1.37 2026/01/26 15:40:33 christos Exp $	*/
 
-/*-
- * SPDX-License-Identifier: BSD-2-Clause-NetBSD AND MIT
- *
+/*
  * Copyright (c) 1996 The NetBSD Foundation, Inc.
  * All rights reserved.
  *
@@ -24,7 +19,7 @@
  * THIS SOFTWARE IS PROVIDED BY THE NETBSD FOUNDATION, INC. AND CONTRIBUTORS
  * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
  * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
- * PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE FOUNDATION OR CONTRIBUTORS
+ * PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE FOUNDATION OR CONTRIBUTORS 
  * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
  * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
  * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
@@ -34,6 +29,11 @@
  * POSSIBILITY OF SUCH DAMAGE.
  */
 
+#include <sys/cdefs.h>
+#if defined(__RCSID) && !defined(lint)
+__RCSID("$NetBSD: gencat.c,v 1.37 2026/01/26 15:40:33 christos Exp $");
+#endif
+
 /***********************************************************
 Copyright 1990, by Alfalfa Software Incorporated, Cambridge, Massachusetts.
 
@@ -66,18 +66,21 @@ up-to-date.  Many thanks.
 
 ******************************************************************/
 
-#include <sys/cdefs.h>
-__FBSDID("$FreeBSD$");
+#if HAVE_NBTOOL_CONFIG_H
+#include "nbtool_config.h"
+#endif
 
 #define _NLS_PRIVATE
 
 #include <sys/types.h>
 #include <sys/queue.h>
 
-#include <arpa/inet.h>		/* for htonl() */
+#include <netinet/in.h>	/* Needed by arpa/inet.h on NetBSD */
+#include <arpa/inet.h>	/* Needed for htonl() on POSIX systems */
 
 #include <ctype.h>
 #include <err.h>
+#include <errno.h>
 #include <fcntl.h>
 #include <limits.h>
 #include <nl_types.h>
@@ -86,26 +89,34 @@ __FBSDID("$FreeBSD$");
 #include <string.h>
 #include <unistd.h>
 
+#ifndef NL_SETMAX
+#define NL_SETMAX 255
+#endif
+#ifndef NL_MSGMAX
+#define NL_MSGMAX 2048
+#endif
+
 struct _msgT {
 	long    msgId;
 	char   *str;
-	LIST_ENTRY(_msgT) entries;
+        LIST_ENTRY(_msgT) entries;
 };
 
 struct _setT {
 	long    setId;
-	LIST_HEAD(msghead, _msgT) msghead;
-	LIST_ENTRY(_setT) entries;
+        LIST_HEAD(msghead, _msgT) msghead;
+        LIST_ENTRY(_setT) entries;
 };
 
-static LIST_HEAD(sethead, _setT) sethead;
+static LIST_HEAD(sethead, _setT) sethead = LIST_HEAD_INITIALIZER(sethead);
 static struct _setT *curSet;
 
+static const char *curfile;
 static char *curline = NULL;
 static long lineno = 0;
 
 static	char   *cskip(char *);
-static	void	error(const char *);
+__dead static	void	error(const char *);
 static	char   *get_line(int);
 static	char   *getmsg(int, char *, char);
 static	void	warning(const char *, const char *);
@@ -114,45 +125,35 @@ static	char   *xstrdup(const char *);
 static	void   *xmalloc(size_t);
 static	void   *xrealloc(void *, size_t);
 
-void	MCParse(int);
-void	MCReadCat(int);
-void	MCWriteCat(int);
-void	MCDelMsg(int);
-void	MCAddMsg(int, const char *);
-void	MCAddSet(int);
-void	MCDelSet(int);
-void	usage(void);
-int	main(int, char **);
-
-void
+static void	MCParse(int fd);
+static void	MCReadCat(int fd);
+static void	MCWriteCat(int fd);
+static void	MCDelMsg(int msgId);
+static void	MCAddMsg(int msgId, const char *msg);
+static void	MCAddSet(int setId);
+static void	MCDelSet(int setId);
+__dead static void	usage(void);
+
+#define CORRUPT			"corrupt message catalog"
+#define NOMEMORY		"out of memory"
+
+static void
 usage(void)
 {
-	fprintf(stderr, "usage: %s catfile msgfile ...\n", getprogname());
+	fprintf(stderr, "usage: %s catfile [msgfile|- ...]\n", getprogname());
 	exit(1);
 }
 
 int
-main(int argc, char **argv)
+main(int argc, char *argv[])
 {
 	int     ofd, ifd;
-	char	*catfile = NULL;
+	char   *catfile = NULL;
 	int     c;
+	int	updatecat = 0;
 
-#define DEPRECATEDMSG	1
-
-#ifdef DEPRECATEDMSG
-	while ((c = getopt(argc, argv, "new")) != -1) {
-#else
 	while ((c = getopt(argc, argv, "")) != -1) {
-#endif
 		switch (c) {
-#ifdef DEPRECATEDMSG
-		case 'n':
-			fprintf(stderr, "WARNING: Usage of \"-new\" argument is deprecated.\n");
-		case 'e':
-		case 'w':
-			break;
-#endif
 		case '?':
 		default:
 			usage();
@@ -162,21 +163,59 @@ main(int argc, char **argv)
 	argc -= optind;
 	argv += optind;
 
-	if (argc < 2) {
+	if (argc < 1) {
 		usage();
 		/* NOTREACHED */
 	}
 	catfile = *argv++;
 
-	for (; *argv; argv++) {
-		if ((ifd = open(*argv, O_RDONLY)) < 0)
-			err(1, "Unable to read %s", *argv);
-		MCParse(ifd);
-		close(ifd);
+	if ((catfile[0] == '-') && (catfile[1] == '\0')) {
+		ofd = STDOUT_FILENO;
+	} else {
+		ofd = open(catfile, O_WRONLY | O_CREAT | O_EXCL, 0666);
+		if (ofd < 0) {
+			if (errno == EEXIST) {
+				if ((ofd = open(catfile, O_RDWR)) < 0) {
+					err(1, "Unable to open %s", catfile);
+					/* NOTREACHED */
+				}
+			} else {
+				err(1, "Unable to create new %s", catfile);
+				/* NOTREACHED */
+			}
+			curfile = catfile;
+			updatecat = 1;
+			MCReadCat(ofd);
+			if (lseek(ofd, (off_t)0, SEEK_SET) == (off_t)-1) {
+				err(1, "Unable to seek on %s", catfile);
+				/* NOTREACHED */
+			}
+		}
+	}
+
+	if (argc < 2 || (((*argv)[0] == '-') && ((*argv)[1] == '\0'))) {
+		if (argc > 2)
+			usage();
+			/* NOTREACHED */
+		MCParse(STDIN_FILENO);
+	} else {
+		for (; *argv; argv++) {
+			if ((ifd = open(*argv, O_RDONLY)) < 0)
+				err(1, "Unable to read %s", *argv);
+			curfile = *argv;
+			lineno = 0;
+			MCParse(ifd);
+			close(ifd);
+		}
+	}
+
+	if (updatecat) {
+		if (ftruncate(ofd, 0) != 0) {
+			err(1, "Unable to truncate %s", catfile);
+			/* NOTREACHED */
+		}
 	}
 
-	if ((ofd = open(catfile, O_WRONLY | O_TRUNC | O_CREAT, 0666)) < 0)
-		err(1, "Unable to create a new %s", catfile);
 	MCWriteCat(ofd);
 	exit(0);
 }
@@ -184,19 +223,21 @@ main(int argc, char **argv)
 static void
 warning(const char *cptr, const char *msg)
 {
-	fprintf(stderr, "%s: %s on line %ld\n", getprogname(), msg, lineno);
-	fprintf(stderr, "%s\n", curline);
-	if (cptr) {
-		char   *tptr;
-		for (tptr = curline; tptr < cptr; ++tptr)
-			putc(' ', stderr);
-		fprintf(stderr, "^\n");
+	if (lineno) {
+		fprintf(stderr, "%s: %s on line %ld, %s\n",
+			getprogname(), msg, lineno, curfile);
+		fprintf(stderr, "%s\n", curline);
+		if (cptr) {
+			char   *tptr;
+			for (tptr = curline; tptr < cptr; ++tptr)
+				putc(' ', stderr);
+			fprintf(stderr, "^\n");
+		}
+	} else {
+		fprintf(stderr, "%s: %s, %s\n", getprogname(), msg, curfile);
 	}
 }
 
-#define	CORRUPT()	{ error("corrupt message catalog"); }
-#define	NOMEM()		{ error("out of memory"); }
-
 static void
 error(const char *msg)
 {
@@ -210,7 +251,7 @@ xmalloc(size_t len)
 	void   *p;
 
 	if ((p = malloc(len)) == NULL)
-		NOMEM();
+		errx(1, NOMEMORY);
 	return (p);
 }
 
@@ -218,7 +259,7 @@ static void *
 xrealloc(void *ptr, size_t size)
 {
 	if ((ptr = realloc(ptr, size)) == NULL)
-		NOMEM();
+		errx(1, NOMEMORY);
 	return (ptr);
 }
 
@@ -228,7 +269,7 @@ xstrdup(const char *str)
 	char *nstr;
 
 	if ((nstr = strdup(str)) == NULL)
-		NOMEM();
+		errx(1, NOMEMORY);
 	return (nstr);
 }
 
@@ -303,13 +344,15 @@ static char *
 getmsg(int fd, char *cptr, char quote)
 {
 	static char *msg = NULL;
-	static long msglen = 0;
-	long    clen, i;
+	static size_t msglen = 0;
+	size_t  clen, i;
+	int     in_quote = 0;
 	char   *tptr;
 
 	if (quote && *cptr == quote) {
 		++cptr;
-	}
+		in_quote = 1;
+	} 
 
 	clen = strlen(cptr) + 1;
 	if (clen > msglen) {
@@ -325,13 +368,28 @@ getmsg(int fd, char *cptr, char quote)
 		if (quote && *cptr == quote) {
 			char   *tmp;
 			tmp = cptr + 1;
-			if (*tmp && (!isspace((unsigned char) *tmp) || *wskip(tmp))) {
+			if (!in_quote) {
+				/* XXX hard error? */
 				warning(cptr, "unexpected quote character, ignoring");
 				*tptr++ = *cptr++;
 			} else {
-				*cptr = '\0';
+				cptr++;
+				/* don't use wskip() */
+				while (*cptr && isspace((unsigned char) *cptr))
+#ifndef _BACKWARDS_COMPAT
+					cptr++;
+#else
+					*tptr++ = *cptr++;
+#endif
+				/* XXX hard error? */
+				if (*cptr)
+					warning(tmp, "unexpected extra characters, ignoring");
+				in_quote = 0;
+#ifndef _BACKWARDS_COMPAT
+				break;
+#endif
 			}
-		} else
+		} else {
 			if (*cptr == '\\') {
 				++cptr;
 				switch (*cptr) {
@@ -344,22 +402,34 @@ getmsg(int fd, char *cptr, char quote)
 					msg = xrealloc(msg, msglen);
 					tptr = msg + i;
 					break;
-
-		#define	CASEOF(CS, CH)		\
-			case CS:		\
-				*tptr++ = CH;	\
-				++cptr;		\
-				break;		\
-
-				CASEOF('n', '\n');
-				CASEOF('t', '\t');
-				CASEOF('v', '\v');
-				CASEOF('b', '\b');
-				CASEOF('r', '\r');
-				CASEOF('f', '\f');
-				CASEOF('"', '"');
-				CASEOF('\\', '\\');
-
+				case 'n':
+					*tptr++ = '\n';
+					++cptr;
+					break;
+				case 't':
+					*tptr++ = '\t';
+					++cptr;
+					break;
+				case 'v':
+					*tptr++ = '\v';
+					++cptr;
+					break;
+				case 'b':
+					*tptr++ = '\b';
+					++cptr;
+					break;
+				case 'r':
+					*tptr++ = '\r';
+					++cptr;
+					break;
+				case 'f':
+					*tptr++ = '\f';
+					++cptr;
+					break;
+				case '\\':
+					*tptr++ = '\\';
+					++cptr;
+					break;
 				default:
 					if (quote && *cptr == quote) {
 						*tptr++ = *cptr++;
@@ -374,6 +444,7 @@ getmsg(int fd, char *cptr, char quote)
 							*tptr += (*cptr - '0');
 							++cptr;
 						}
+						++tptr;
 					} else {
 						warning(cptr, "unrecognized escape sequence");
 					}
@@ -382,20 +453,24 @@ getmsg(int fd, char *cptr, char quote)
 			} else {
 				*tptr++ = *cptr++;
 			}
+		}
 	}
+
+	if (in_quote)
+		warning(cptr, "unterminated quoted message, ignoring");
+
 	*tptr = '\0';
 	return (msg);
 }
 
-void
+static void
 MCParse(int fd)
 {
 	char   *cptr, *str;
-	int     setid, msgid = 0;
+	int	msgid = 0;
+	int     setid = 0;
 	char    quote = 0;
 
-	/* XXX: init sethead? */
-
 	while ((cptr = get_line(fd))) {
 		if (*cptr == '$') {
 			++cptr;
@@ -443,12 +518,25 @@ MCParse(int fd)
 			if (isdigit((unsigned char) *cptr)) {
 				msgid = atoi(cptr);
 				cptr = cskip(cptr);
-				cptr = wskip(cptr);
-				/* if (*cptr) ++cptr; */
+				if (*cptr) {
+					cptr = wskip(cptr);
+					if (!*cptr) {
+						MCAddMsg(msgid, "");
+						continue;
+					}
+				}
 			} else {
 				warning(cptr, "neither blank line nor start of a message id");
 				continue;
 			}
+			/*
+			 * If no set directive specified, all messages
+			 * shall be in default message set NL_SETD.
+			 */
+			if (setid == 0) {
+				setid = NL_SETD;
+				MCAddSet(setid);
+			}
 			/*
 			 * If we have a message ID, but no message,
 			 * then this means "delete this message id
@@ -464,6 +552,93 @@ MCParse(int fd)
 	}
 }
 
+static void
+MCReadCat(int fd)
+{
+	void   *msgcat;		/* message catalog data */
+	struct _nls_cat_hdr cat_hdr;
+	struct _nls_set_hdr *set_hdr;
+	struct _nls_msg_hdr *msg_hdr;
+	char   *strings;
+	ssize_t	n;
+	int	m, s;
+	int	msgno, setno;
+
+	n = read(fd, &cat_hdr, sizeof(cat_hdr));
+	if (n < (ssize_t)sizeof(cat_hdr)) {
+		if (n == 0)
+			return;		/* empty file */
+		else if (n == -1)
+			err(1, "header read");
+		else
+			errx(1, CORRUPT);
+	}
+	if (ntohl((uint32_t)cat_hdr.__magic) != _NLS_MAGIC)
+		errx(1, "%s: bad magic number (%#x)", CORRUPT, cat_hdr.__magic);
+
+	cat_hdr.__mem = ntohl(cat_hdr.__mem);
+
+	cat_hdr.__nsets = ntohl(cat_hdr.__nsets);
+	cat_hdr.__msg_hdr_offset = ntohl(cat_hdr.__msg_hdr_offset);
+	cat_hdr.__msg_txt_offset = ntohl(cat_hdr.__msg_txt_offset);
+	if ((cat_hdr.__mem < 0) ||
+	    (cat_hdr.__msg_hdr_offset < 0) ||
+	    (cat_hdr.__msg_txt_offset < 0) ||
+	    (cat_hdr.__mem < (int32_t)(cat_hdr.__nsets * sizeof(struct _nls_set_hdr))) ||
+	    (cat_hdr.__mem < cat_hdr.__msg_hdr_offset) ||
+	    (cat_hdr.__mem < cat_hdr.__msg_txt_offset))
+		errx(1, "%s: catalog header", CORRUPT);
+
+	msgcat = xmalloc(cat_hdr.__mem);
+
+	n = read(fd, msgcat, cat_hdr.__mem);
+	if (n < cat_hdr.__mem) {
+		if (n == -1)
+			err(1, "data read");
+		else
+			errx(1, CORRUPT);
+	}
+
+	set_hdr = (struct _nls_set_hdr *)msgcat;
+	msg_hdr = (struct _nls_msg_hdr *)((char *)msgcat +
+	    cat_hdr.__msg_hdr_offset);
+	strings = (char *)msgcat + cat_hdr.__msg_txt_offset;
+
+	setno = 0;
+	for (s = 0; s < cat_hdr.__nsets; s++, set_hdr++) {
+		set_hdr->__setno = ntohl(set_hdr->__setno);
+		if (set_hdr->__setno < setno)
+			errx(1, "%s: bad set number (%d)",
+		       	     CORRUPT, set_hdr->__setno);
+		setno = set_hdr->__setno;
+
+		MCAddSet(setno);
+
+		set_hdr->__nmsgs = ntohl(set_hdr->__nmsgs);
+		set_hdr->__index = ntohl(set_hdr->__index);
+		if (set_hdr->__nmsgs < 0 || set_hdr->__index < 0)
+			errx(1, "%s: set header", CORRUPT);
+
+		/* Get the data */
+		msgno = 0;
+		for (m = 0; m < set_hdr->__nmsgs; m++, msg_hdr++) {
+			msg_hdr->__msgno = ntohl(msg_hdr->__msgno);
+			msg_hdr->__offset = ntohl(msg_hdr->__offset);
+			if (msg_hdr->__msgno < msgno)
+				errx(1, "%s: bad message number (%d)",
+				     CORRUPT, msg_hdr->__msgno);
+		        if ((msg_hdr->__offset < 0) ||
+			    ((strings + msg_hdr->__offset) >
+			     ((char *)msgcat + cat_hdr.__mem)))
+				errx(1, "%s: message header", CORRUPT);
+
+			msgno = msg_hdr->__msgno;
+			MCAddMsg(msgno, strings + msg_hdr->__offset);
+		}
+	}
+	free(msgcat);
+}
+
 /*
  * Write message catalog.
  *
@@ -473,7 +648,7 @@ MCParse(int fd)
  * avoids additional housekeeping variables and/or a lot of seeks
  * that would otherwise be required.
  */
-void
+static void
 MCWriteCat(int fd)
 {
 	int     nsets;		/* number of sets */
@@ -496,12 +671,10 @@ MCWriteCat(int fd)
 	nmsgs = 0;
 	string_size = 0;
 
-	for (set = sethead.lh_first; set != NULL;
-	    set = set->entries.le_next) {
+	LIST_FOREACH(set, &sethead, entries) {
 		nsets++;
 
-		for (msg = set->msghead.lh_first; msg != NULL;
-		    msg = msg->entries.le_next) {
+		LIST_FOREACH(msg, &set->msghead, entries) {
 			nmsgs++;
 			string_size += strlen(msg->str) + 1;
 		}
@@ -535,9 +708,9 @@ MCWriteCat(int fd)
 	    nmsgs * sizeof(struct _nls_msg_hdr));
 
 	/* compute offsets for set & msg header tables and string pool */
-	set_hdr = (struct _nls_set_hdr *)(void *)((char *)msgcat +
+	set_hdr = (struct _nls_set_hdr *) ((char *) msgcat +
 	    sizeof(struct _nls_cat_hdr));
-	msg_hdr = (struct _nls_msg_hdr *)(void *)((char *)msgcat +
+	msg_hdr = (struct _nls_msg_hdr *) ((char *) msgcat +
 	    sizeof(struct _nls_cat_hdr) +
 	    nsets * sizeof(struct _nls_set_hdr));
 	strings = (char *) msgcat +
@@ -547,13 +720,11 @@ MCWriteCat(int fd)
 
 	msg_index = 0;
 	msg_offset = 0;
-	for (set = sethead.lh_first; set != NULL;
-	    set = set->entries.le_next) {
+	LIST_FOREACH(set, &sethead, entries) {
 
 		nmsgs = 0;
-		for (msg = set->msghead.lh_first; msg != NULL;
-		    msg = msg->entries.le_next) {
-			int     msg_len = strlen(msg->str) + 1;
+		LIST_FOREACH(msg, &set->msghead, entries) {
+			int32_t     msg_len = strlen(msg->str) + 1;
 
 			msg_hdr->__msgno = htonl(msg->msgId);
 			msg_hdr->__msglen = htonl(msg_len);
@@ -578,7 +749,7 @@ MCWriteCat(int fd)
 	write(fd, msgcat, msgcat_size);
 }
 
-void
+static void
 MCAddSet(int setId)
 {
 	struct _setT *p, *q;
@@ -592,9 +763,10 @@ MCAddSet(int setId)
 		/* NOTREACHED */
 	}
 
-	p = sethead.lh_first;
+	p = LIST_FIRST(&sethead);
 	q = NULL;
-	for (; p != NULL && p->setId < setId; q = p, p = p->entries.le_next);
+	for (; p != NULL && p->setId < setId; q = p, p = LIST_NEXT(p, entries))
+		continue;
 
 	if (p && p->setId == setId) {
 		;
@@ -615,7 +787,7 @@ MCAddSet(int setId)
 	curSet = p;
 }
 
-void
+static void
 MCAddMsg(int msgId, const char *str)
 {
 	struct _msgT *p, *q;
@@ -632,9 +804,10 @@ MCAddMsg(int msgId, const char *str)
 		/* NOTREACHED */
 	}
 
-	p = curSet->msghead.lh_first;
+	p = LIST_FIRST(&curSet->msghead);
 	q = NULL;
-	for (; p != NULL && p->msgId < msgId; q = p, p = p->entries.le_next);
+	for (; p != NULL && p->msgId < msgId; q = p, p = LIST_NEXT(p, entries))
+		continue;
 
 	if (p && p->msgId == msgId) {
 		free(p->str);
@@ -653,30 +826,39 @@ MCAddMsg(int msgId, const char *str)
 	p->str = xstrdup(str);
 }
 
-void
+static void
 MCDelSet(int setId)
 {
 	struct _setT *set;
 	struct _msgT *msg;
 
-	set = sethead.lh_first;
-	for (; set != NULL && set->setId < setId; set = set->entries.le_next);
+	if (setId <= 0) {
+		error("setId's must be greater than zero");
+		/* NOTREACHED */
+	}
+	if (setId > NL_SETMAX) {
+		error("setId exceeds limit");
+		/* NOTREACHED */
+	}
+
+	set = LIST_FIRST(&sethead);
+	for (; set != NULL && set->setId < setId; set = LIST_NEXT(set, entries))
+		continue;
 
 	if (set && set->setId == setId) {
-
-		msg = set->msghead.lh_first;
-		while (msg) {
-			free(msg->str);
+		LIST_REMOVE(set, entries);
+		while ((msg = LIST_FIRST(&set->msghead)) != NULL) {
 			LIST_REMOVE(msg, entries);
+			free(msg->str);
+			free(msg);
 		}
-
-		LIST_REMOVE(set, entries);
+		free(set);
 		return;
 	}
 	warning(NULL, "specified set doesn't exist");
 }
 
-void
+static void
 MCDelMsg(int msgId)
 {
 	struct _msgT *msg;
@@ -684,12 +866,14 @@ MCDelMsg(int msgId)
 	if (!curSet)
 		error("you can't delete a message before defining the set");
 
-	msg = curSet->msghead.lh_first;
-	for (; msg != NULL && msg->msgId < msgId; msg = msg->entries.le_next);
+	msg = LIST_FIRST(&curSet->msghead);
+	for (; msg != NULL && msg->msgId < msgId; msg = LIST_NEXT(msg, entries))
+		continue;
 
 	if (msg && msg->msgId == msgId) {
-		free(msg->str);
 		LIST_REMOVE(msg, entries);
+		free(msg->str);
+		free(msg);
 		return;
 	}
 	warning(NULL, "specified msg doesn't exist");
-- 
2.52.0

