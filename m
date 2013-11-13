Return-Path: <cygwin-patches-return-7908-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22594 invoked by alias); 13 Nov 2013 14:36:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 22569 invoked by uid 89); 13 Nov 2013 14:36:52 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.0 required=5.0 tests=AWL,BAYES_50,RDNS_NONE,URIBL_BLOCKED autolearn=no version=3.3.2
X-HELO: smtpout07.bt.lon5.cpcloud.co.uk
Received: from Unknown (HELO smtpout07.bt.lon5.cpcloud.co.uk) (65.20.0.127) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 13 Nov 2013 14:36:50 +0000
X-CTCH-RefID: str=0001.0A090203.52838E7A.005F,ss=1,re=0.100,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=28/97,refid=2.7.2:2013.11.13.93315:17:28.394,ip=86.139.177.183,rules=__MOZILLA_MSGID, __HAS_MSGID, __SANE_MSGID, __HAS_FROM, __USER_AGENT, __MOZILLA_USER_AGENT, __MIME_VERSION, __TO_MALFORMED_2, __CT, __CTYPE_HAS_BOUNDARY, __CTYPE_MULTIPART, __CTYPE_MULTIPART_MIXED, __BAT_BOUNDARY, __ANY_URI, __URI_NO_WWW, __URI_NO_PATH, BODY_SIZE_1700_1799, BODYTEXTP_SIZE_3000_LESS, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[183.177.139.86.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, RDNS_SUSP, BODY_SIZE_2000_LESS, BODY_SIZE_7000_LESS, MIME_TEXT_ONLY_MP_MIXED
X-CTCH-Spam: Unknown
Received: from [192.168.1.72] (86.139.177.183) by smtpout07.bt.lon5.cpcloud.co.uk (8.6.100.99.10223) (authenticated as jonturney@btinternet.com)        id 527ECDBB003DF6F6 for cygwin-patches@cygwin.com; Wed, 13 Nov 2013 14:36:42 +0000
Message-ID: <52838E8C.5060708@dronecode.org.uk>
Date: Wed, 13 Nov 2013 14:36:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
MIME-Version: 1.0
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: [PATCH] Prototype initstate() etc. if _XOPEN_SOURCE is defined appropriately
Content-Type: multipart/mixed; boundary="------------060404080306030707070909"
X-SW-Source: 2013-q4/txt/msg00004.txt.bz2

This is a multi-part message in MIME format.
--------------060404080306030707070909
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 372


Not sure if this is wanted, but mesa likes to compile with '-std=c99
D_XOPEN_SOURCE=500', which leads to exciting crashes on x86_64 because
initstate() is not prototyped.

2013-11-13  Jon TURNEY  <jon.turney@dronecode.org.uk>

	* include/cygwin/stdlib.h(initstate, random, setstate, srandom) :
	Prototype if not __STRICT_ANSI__ or _XOPEN_SOURCE is defined appropriately.

--------------060404080306030707070909
Content-Type: text/plain; charset=windows-1252;
 name="initstate_xopen_source.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="initstate_xopen_source.patch"
Content-length: 925

Index: cygwin/include/cygwin/stdlib.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/stdlib.h,v
retrieving revision 1.13
diff -u -u -p -r1.13 stdlib.h
--- cygwin/include/cygwin/stdlib.h	21 May 2013 19:04:49 -0000	1.13
+++ cygwin/include/cygwin/stdlib.h	13 Nov 2013 14:28:35 -0000
@@ -31,10 +31,14 @@ void	setprogname (const char *);
 char *realpath (const char *, char *);
 char *canonicalize_file_name (const char *);
 int unsetenv (const char *);
+#endif /*__STRICT_ANSI__*/
+#if !defined(__STRICT_ANSI__) || (_XOPEN_SOURCE >= 500) || (defined(_XOPEN_SOURCE) && defined(_XOPEN_SOURCE_EXTENDED))
 char *initstate (unsigned seed, char *state, size_t size);
 long random (void);
 char *setstate (const char *state);
 void srandom (unsigned);
+#endif
+#ifndef __STRICT_ANSI__
 char *ptsname (int);
 int ptsname_r(int, char *, size_t);
 int getpt (void);

--------------060404080306030707070909--
