Return-Path: <cygwin-patches-return-9005-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 49227 invoked by alias); 19 Jan 2018 06:01:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 49216 invoked by uid 89); 19 Jan 2018 06:01:48 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-21.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,LIKELY_SPAM_BODY,SPF_HELO_PASS,TBC,T_RP_MATCHES_RCVD autolearn=ham version=3.3.2 spammy=
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 19 Jan 2018 06:01:45 +0000
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id C6E7981DEB	for <cygwin-patches@cygwin.com>; Fri, 19 Jan 2018 06:01:44 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-72.rdu2.redhat.com [10.10.120.72])	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C6BC5D6B2	for <cygwin-patches@cygwin.com>; Fri, 19 Jan 2018 06:01:43 +0000 (UTC)
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 2/3] cygwin: add catopen, catgets, catclose
Date: Fri, 19 Jan 2018 06:01:00 -0000
Message-Id: <20180119060135.14476-1-yselkowi@redhat.com>
In-Reply-To: <20180119055837.13016-1-yselkowi@redhat.com>
References: <20180119055837.13016-1-yselkowi@redhat.com>
X-SW-Source: 2018-q1/txt/msg00013.txt.bz2

The implementation is taken from FreeBSD with #ifdef __CYGWIN__ modifications.

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
 winsup/cygwin/Makefile.in              |   1 +
 winsup/cygwin/common.din               |   3 +
 winsup/cygwin/include/cygwin/version.h |   3 +-
 winsup/cygwin/include/nl_types.h       | 100 +++++++
 winsup/cygwin/libc/msgcat.c            | 478 +++++++++++++++++++++++++++++++++
 5 files changed, 584 insertions(+), 1 deletion(-)
 create mode 100644 winsup/cygwin/include/nl_types.h
 create mode 100644 winsup/cygwin/libc/msgcat.c

diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
index c1de26c1b..b75774ace 100644
--- a/winsup/cygwin/Makefile.in
+++ b/winsup/cygwin/Makefile.in
@@ -333,6 +333,7 @@ DLL_OFILES:= \
 	mktemp.o \
 	mmap.o \
 	msg.o \
+	msgcat.o \
 	mount.o \
 	net.o \
 	netdb.o \
diff --git a/winsup/cygwin/common.din b/winsup/cygwin/common.din
index 91f2915bf..6e8bf9185 100644
--- a/winsup/cygwin/common.din
+++ b/winsup/cygwin/common.din
@@ -274,6 +274,9 @@ catanh NOSIGFE
 catanhf NOSIGFE
 catanhl NOSIGFE
 catanl NOSIGFE
+catclose SIGFE
+catgets SIGFE
+catopen SIGFE
 cbrt NOSIGFE
 cbrtf NOSIGFE
 cbrtl NOSIGFE
diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
index aa7c14ec3..fa9137d05 100644
--- a/winsup/cygwin/include/cygwin/version.h
+++ b/winsup/cygwin/include/cygwin/version.h
@@ -493,12 +493,13 @@ details. */
   322: [w]scanf %m modifier.
   323: scanf %l[ conversion.
   324: Export sigtimedwait.
+  325: Export catclose, catgets, catopen.
 
   Note that we forgot to bump the api for ualarm, strtoll, strtoull,
   sigaltstack, sethostname. */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 324
+#define CYGWIN_VERSION_API_MINOR 325
 
 /* There is also a compatibity version number associated with the shared memory
    regions.  It is incremented when incompatible changes are made to the shared
diff --git a/winsup/cygwin/include/nl_types.h b/winsup/cygwin/include/nl_types.h
new file mode 100644
index 000000000..b9c06f6c3
--- /dev/null
+++ b/winsup/cygwin/include/nl_types.h
@@ -0,0 +1,100 @@
+/*	$NetBSD: nl_types.h,v 1.9 2000/10/03 19:53:32 sommerfeld Exp $	*/
+
+/*-
+ * SPDX-License-Identifier: BSD-2-Clause-NetBSD
+ *
+ * Copyright (c) 1996 The NetBSD Foundation, Inc.
+ * All rights reserved.
+ *
+ * This code is derived from software contributed to The NetBSD Foundation
+ * by J.T. Conklin.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE NETBSD FOUNDATION, INC. AND CONTRIBUTORS
+ * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
+ * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
+ * PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE FOUNDATION OR CONTRIBUTORS
+ * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGE.
+ *
+ * $FreeBSD$
+ */
+
+#ifndef _NL_TYPES_H_
+#define _NL_TYPES_H_
+
+#include <sys/cdefs.h>
+#include <sys/types.h>
+
+#ifdef _NLS_PRIVATE
+/*
+ * MESSAGE CATALOG FILE FORMAT.
+ *
+ * The NetBSD/FreeBSD message catalog format is similar to the format used by
+ * Svr4 systems.  The differences are:
+ *   * fixed byte order (big endian)
+ *   * fixed data field sizes
+ *
+ * A message catalog contains four data types: a catalog header, one
+ * or more set headers, one or more message headers, and one or more
+ * text strings.
+ */
+
+#define _NLS_MAGIC	0xff88ff89
+
+struct _nls_cat_hdr {
+	int32_t __magic;
+	int32_t __nsets;
+	int32_t __mem;
+	int32_t __msg_hdr_offset;
+	int32_t __msg_txt_offset;
+} ;
+
+struct _nls_set_hdr {
+	int32_t __setno;	/* set number: 0 < x <= NL_SETMAX */
+	int32_t __nmsgs;	/* number of messages in the set  */
+	int32_t __index;	/* index of first msg_hdr in msg_hdr table */
+} ;
+
+struct _nls_msg_hdr {
+	int32_t __msgno;	/* msg number: 0 < x <= NL_MSGMAX */
+	int32_t __msglen;
+	int32_t __offset;
+} ;
+
+#endif	/* _NLS_PRIVATE */
+
+#define	NL_SETD		0
+#define	NL_CAT_LOCALE	1
+
+typedef struct __nl_cat_d {
+	void	*__data;
+	int	__size;
+} *nl_catd;
+
+
+#ifndef _NL_ITEM_DECLARED
+typedef int nl_item;
+#define _NL_ITEM_DECLARED
+#endif
+
+__BEGIN_DECLS
+nl_catd  catopen(const char *, int);
+char    *catgets(nl_catd, int, int, const char *) __format_arg(4);
+int	 catclose(nl_catd);
+__END_DECLS
+
+#endif	/* _NL_TYPES_H_ */
diff --git a/winsup/cygwin/libc/msgcat.c b/winsup/cygwin/libc/msgcat.c
new file mode 100644
index 000000000..d6c5678e0
--- /dev/null
+++ b/winsup/cygwin/libc/msgcat.c
@@ -0,0 +1,478 @@
+/***********************************************************
+Copyright 1990, by Alfalfa Software Incorporated, Cambridge, Massachusetts.
+Copyright 2010, Gabor Kovesdan <gabor@FreeBSD.org>
+
+                        All Rights Reserved
+
+Permission to use, copy, modify, and distribute this software and its
+documentation for any purpose and without fee is hereby granted,
+provided that the above copyright notice appear in all copies and that
+both that copyright notice and this permission notice appear in
+supporting documentation, and that Alfalfa's name not be used in
+advertising or publicity pertaining to distribution of the software
+without specific, written prior permission.
+
+ALPHALPHA DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING
+ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL
+ALPHALPHA BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR
+ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
+WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
+ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
+SOFTWARE.
+
+If you make any modifications, bugfixes or other changes to this software
+we'd appreciate it if you could send a copy to us so we can keep things
+up-to-date.  Many thanks.
+				Kee Hinckley
+				Alfalfa Software, Inc.
+				267 Allston St., #3
+				Cambridge, MA 02139  USA
+				nazgul@alfalfa.com
+
+******************************************************************/
+
+#include <sys/cdefs.h>
+__FBSDID("$FreeBSD$");
+
+#define _NLS_PRIVATE
+
+#ifndef __CYGWIN__
+#include "namespace.h"
+#endif
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <sys/queue.h>
+
+#include <arpa/inet.h>		/* for ntohl() */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <nl_types.h>
+#include <pthread.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#ifndef __CYGWIN__
+#include "un-namespace.h"
+
+#include "../locale/xlocale_private.h"
+
+#define _DEFAULT_NLS_PATH "/usr/share/nls/%L/%N.cat:/usr/share/nls/%N/%L:/usr/local/share/nls/%L/%N.cat:/usr/local/share/nls/%N/%L"
+
+#define RLOCK(fail)	{ int ret;						\
+			  if (__isthreaded &&					\
+			      ((ret = _pthread_rwlock_rdlock(&rwlock)) != 0)) {	\
+				  errno = ret;					\
+				  return (fail);				\
+			  }}
+#define WLOCK(fail)	{ int ret;						\
+			  if (__isthreaded &&					\
+			      ((ret = _pthread_rwlock_wrlock(&rwlock)) != 0)) {	\
+				  errno = ret;					\
+				  return (fail);				\
+			  }}
+#define UNLOCK		{ if (__isthreaded)					\
+			      _pthread_rwlock_unlock(&rwlock); }
+
+static pthread_rwlock_t		 rwlock = PTHREAD_RWLOCK_INITIALIZER;
+#else
+
+#include "../locale/setlocale.h"
+#define SIZE_T_MAX __SIZE_MAX__
+#define _close close
+#define _open open
+#define _fstat fstat
+#define RLOCK(a)
+#define WLOCK(a)
+#define UNLOCK
+
+#define _DEFAULT_NLS_PATH "/usr/share/locale/%L/%N.cat:/usr/share/locale/%L/LC_MESSAGES/%N.cat:/usr/share/locale/%L/%N:/usr/share/locale/%L/LC_MESSAGES/%N:/usr/share/locale/%l/%N.cat:/usr/share/locale/%l/LC_MESSAGES/%N.cat:/usr/share/locale/%l/%N:/usr/share/locale/%l/LC_MESSAGES/%N"
+
+#endif
+
+#define	NLERR		((nl_catd) -1)
+#define NLRETERR(errc)  { errno = errc; return (NLERR); }
+#define SAVEFAIL(n, l, e)	{ WLOCK(NLERR);					\
+				  np = malloc(sizeof(struct catentry));		\
+				  if (np != NULL) {				\
+				  	np->name = strdup(n);			\
+					np->path = NULL;			\
+					np->catd = NLERR;			\
+					np->refcount = 0;			\
+					np->lang = (l == NULL) ? NULL :		\
+					    strdup(l);				\
+					np->caterrno = e;			\
+				  	SLIST_INSERT_HEAD(&cache, np, list);	\
+				  }						\
+				  UNLOCK;					\
+				  errno = e;					\
+				}
+
+static nl_catd load_msgcat(const char *, const char *, const char *);
+
+struct catentry {
+	SLIST_ENTRY(catentry)	 list;
+	char			*name;
+	char			*path;
+	int			 caterrno;
+	nl_catd			 catd;
+	char			*lang;
+	int			 refcount;
+};
+
+static SLIST_HEAD(listhead, catentry) cache =
+    SLIST_HEAD_INITIALIZER(cache);
+
+nl_catd
+catopen(const char *name, int type)
+{
+	struct stat sbuf;
+	struct catentry *np;
+	char *base, *cptr, *cptr1, *nlspath, *pathP, *pcode;
+	char *plang, *pter;
+	int saverr, spcleft;
+	const char *lang, *tmpptr;
+	char path[PATH_MAX];
+
+	/* sanity checking */
+	if (name == NULL || *name == '\0')
+		NLRETERR(EINVAL);
+
+	if (strchr(name, '/') != NULL)
+		/* have a pathname */
+		lang = NULL;
+	else {
+		if (type == NL_CAT_LOCALE)
+#ifdef __CYGWIN__
+			lang = __get_current_locale()->categories[LC_MESSAGES];
+#else
+			lang = querylocale(LC_MESSAGES_MASK, __get_locale());
+#endif
+		else
+			lang = getenv("LANG");
+
+		if (lang == NULL || *lang == '\0' || strlen(lang) > ENCODING_LEN ||
+		    (lang[0] == '.' &&
+		    (lang[1] == '\0' || (lang[1] == '.' && lang[2] == '\0'))) ||
+		    strchr(lang, '/') != NULL)
+			lang = "C";
+	}
+
+	/* Try to get it from the cache first */
+	RLOCK(NLERR);
+	SLIST_FOREACH(np, &cache, list) {
+		if ((strcmp(np->name, name) == 0) &&
+		    ((lang != NULL && np->lang != NULL &&
+		    strcmp(np->lang, lang) == 0) || (np->lang == lang))) {
+			if (np->caterrno != 0) {
+				/* Found cached failing entry */
+				UNLOCK;
+				NLRETERR(np->caterrno);
+			} else {
+				/* Found cached successful entry */
+				np->refcount++;
+				UNLOCK;
+				return (np->catd);
+			}
+		}
+	}
+	UNLOCK;
+
+	/* is it absolute path ? if yes, load immediately */
+	if (strchr(name, '/') != NULL)
+		return (load_msgcat(name, name, lang));
+
+	/* sanity checking */
+	if ((plang = cptr1 = strdup(lang)) == NULL)
+		return (NLERR);
+	if ((cptr = strchr(cptr1, '@')) != NULL)
+		*cptr = '\0';
+	pter = pcode = (char *)"";
+	if ((cptr = strchr(cptr1, '_')) != NULL) {
+		*cptr++ = '\0';
+		pter = cptr1 = cptr;
+	}
+	if ((cptr = strchr(cptr1, '.')) != NULL) {
+		*cptr++ = '\0';
+		pcode = cptr;
+	}
+
+	if ((nlspath = getenv("NLSPATH")) == NULL || issetugid())
+		nlspath = (char *)_DEFAULT_NLS_PATH;
+
+	if ((base = cptr = strdup(nlspath)) == NULL) {
+		saverr = errno;
+		free(plang);
+		errno = saverr;
+		return (NLERR);
+	}
+
+	while ((nlspath = strsep(&cptr, ":")) != NULL) {
+		pathP = path;
+		if (*nlspath) {
+			for (; *nlspath; ++nlspath) {
+				if (*nlspath == '%') {
+					switch (*(nlspath + 1)) {
+					case 'l':
+						tmpptr = plang;
+						break;
+					case 't':
+						tmpptr = pter;
+						break;
+					case 'c':
+						tmpptr = pcode;
+						break;
+					case 'L':
+						tmpptr = lang;
+						break;
+					case 'N':
+						tmpptr = (char *)name;
+						break;
+					case '%':
+						++nlspath;
+						/* FALLTHROUGH */
+					default:
+						if (pathP - path >=
+						    sizeof(path) - 1)
+							goto too_long;
+						*(pathP++) = *nlspath;
+						continue;
+					}
+					++nlspath;
+			put_tmpptr:
+					spcleft = sizeof(path) -
+						  (pathP - path) - 1;
+					if (strlcpy(pathP, tmpptr, spcleft) >=
+					    spcleft) {
+			too_long:
+						free(plang);
+						free(base);
+						SAVEFAIL(name, lang, ENAMETOOLONG);
+						NLRETERR(ENAMETOOLONG);
+					}
+					pathP += strlen(tmpptr);
+				} else {
+					if (pathP - path >= sizeof(path) - 1)
+						goto too_long;
+					*(pathP++) = *nlspath;
+				}
+			}
+			*pathP = '\0';
+			if (stat(path, &sbuf) == 0) {
+				free(plang);
+				free(base);
+				return (load_msgcat(path, name, lang));
+			}
+		} else {
+			tmpptr = (char *)name;
+			--nlspath;
+			goto put_tmpptr;
+		}
+	}
+	free(plang);
+	free(base);
+	SAVEFAIL(name, lang, ENOENT);
+	NLRETERR(ENOENT);
+}
+
+char *
+catgets(nl_catd catd, int set_id, int msg_id, const char *s)
+{
+	struct _nls_cat_hdr *cat_hdr;
+	struct _nls_msg_hdr *msg_hdr;
+	struct _nls_set_hdr *set_hdr;
+	int i, l, r, u;
+
+	if (catd == NULL || catd == NLERR) {
+		errno = EBADF;
+		/* LINTED interface problem */
+		return ((char *)s);
+	}
+
+	cat_hdr = (struct _nls_cat_hdr *)catd->__data;
+	set_hdr = (struct _nls_set_hdr *)(void *)((char *)catd->__data +
+	    sizeof(struct _nls_cat_hdr));
+
+	/* binary search, see knuth algorithm b */
+	l = 0;
+	u = ntohl((u_int32_t)cat_hdr->__nsets) - 1;
+	while (l <= u) {
+		i = (l + u) / 2;
+		r = set_id - ntohl((u_int32_t)set_hdr[i].__setno);
+
+		if (r == 0) {
+			msg_hdr = (struct _nls_msg_hdr *)
+			    (void *)((char *)catd->__data +
+			    sizeof(struct _nls_cat_hdr) +
+			    ntohl((u_int32_t)cat_hdr->__msg_hdr_offset));
+
+			l = ntohl((u_int32_t)set_hdr[i].__index);
+			u = l + ntohl((u_int32_t)set_hdr[i].__nmsgs) - 1;
+			while (l <= u) {
+				i = (l + u) / 2;
+				r = msg_id -
+				    ntohl((u_int32_t)msg_hdr[i].__msgno);
+				if (r == 0) {
+					return ((char *) catd->__data +
+					    sizeof(struct _nls_cat_hdr) +
+					    ntohl((u_int32_t)
+					    cat_hdr->__msg_txt_offset) +
+					    ntohl((u_int32_t)
+					    msg_hdr[i].__offset));
+				} else if (r < 0) {
+					u = i - 1;
+				} else {
+					l = i + 1;
+				}
+			}
+
+			/* not found */
+			goto notfound;
+
+		} else if (r < 0) {
+			u = i - 1;
+		} else {
+			l = i + 1;
+		}
+	}
+
+notfound:
+	/* not found */
+	errno = ENOMSG;
+	/* LINTED interface problem */
+	return ((char *)s);
+}
+
+static void
+catfree(struct catentry *np)
+{
+
+	if (np->catd != NULL && np->catd != NLERR) {
+		munmap(np->catd->__data, (size_t)np->catd->__size);
+		free(np->catd);
+	}
+	SLIST_REMOVE(&cache, np, catentry, list);
+	free(np->name);
+	free(np->path);
+	free(np->lang);
+	free(np);
+}
+
+int
+catclose(nl_catd catd)
+{
+	struct catentry *np;
+
+	/* sanity checking */
+	if (catd == NULL || catd == NLERR) {
+		errno = EBADF;
+		return (-1);
+	}
+
+	/* Remove from cache if not referenced any more */
+	WLOCK(-1);
+	SLIST_FOREACH(np, &cache, list) {
+		if (catd == np->catd) {
+			np->refcount--;
+			if (np->refcount == 0)
+				catfree(np);
+			break;
+		}
+	}
+	UNLOCK;
+	return (0);
+}
+
+/*
+ * Internal support functions
+ */
+
+static nl_catd
+load_msgcat(const char *path, const char *name, const char *lang)
+{
+	struct stat st;
+	nl_catd	catd;
+	struct catentry *np;
+	void *data;
+	int fd;
+
+	/* path/name will never be NULL here */
+
+	/*
+	 * One more try in cache; if it was not found by name,
+	 * it might still be found by absolute path.
+	 */
+	RLOCK(NLERR);
+	SLIST_FOREACH(np, &cache, list) {
+		if ((np->path != NULL) && (strcmp(np->path, path) == 0)) {
+			np->refcount++;
+			UNLOCK;
+			return (np->catd);
+		}
+	}
+	UNLOCK;
+
+	if ((fd = _open(path, O_RDONLY | O_CLOEXEC)) == -1) {
+		SAVEFAIL(name, lang, errno);
+		NLRETERR(errno);
+	}
+
+	if (_fstat(fd, &st) != 0) {
+		_close(fd);
+		SAVEFAIL(name, lang, EFTYPE);
+		NLRETERR(EFTYPE);
+	}
+
+	/*
+	 * If the file size cannot be held in size_t we cannot mmap()
+	 * it to the memory.  Probably, this will not be a problem given
+	 * that catalog files are usually small.
+	 */
+	if (st.st_size > SIZE_T_MAX) {
+		_close(fd);
+		SAVEFAIL(name, lang, EFBIG);
+		NLRETERR(EFBIG);
+	}
+
+	if ((data = mmap(0, (size_t)st.st_size, PROT_READ,
+	    MAP_FILE|MAP_SHARED, fd, (off_t)0)) == MAP_FAILED) {
+		int saved_errno = errno;
+		_close(fd);
+		SAVEFAIL(name, lang, saved_errno);
+		NLRETERR(saved_errno);
+	}
+	_close(fd);
+
+	if (ntohl((u_int32_t)((struct _nls_cat_hdr *)data)->__magic) !=
+	    _NLS_MAGIC) {
+		munmap(data, (size_t)st.st_size);
+		SAVEFAIL(name, lang, EFTYPE);
+		NLRETERR(EFTYPE);
+	}
+
+	if ((catd = malloc(sizeof (*catd))) == NULL) {
+		munmap(data, (size_t)st.st_size);
+		SAVEFAIL(name, lang, ENOMEM);
+		NLRETERR(ENOMEM);
+	}
+
+	catd->__data = data;
+	catd->__size = (int)st.st_size;
+
+	/* Caching opened catalog */
+	WLOCK(NLERR);
+	if ((np = malloc(sizeof(struct catentry))) != NULL) {
+		np->name = strdup(name);
+		np->path = strdup(path);
+		np->catd = catd;
+		np->lang = (lang == NULL) ? NULL : strdup(lang);
+		np->refcount = 1;
+		np->caterrno = 0;
+		SLIST_INSERT_HEAD(&cache, np, list);
+	}
+	UNLOCK;
+	return (catd);
+}
-- 
2.15.1
