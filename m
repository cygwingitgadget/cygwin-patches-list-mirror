Return-Path: <cygwin-patches-return-6098-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19844 invoked by alias); 21 May 2007 12:59:53 -0000
Received: (qmail 19806 invoked by uid 22791); 21 May 2007 12:59:45 -0000
X-Spam-Check-By: sourceware.org
Received: from rwcrmhc12.comcast.net (HELO rwcrmhc12.comcast.net) (216.148.227.152)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 21 May 2007 12:59:42 +0000
Received: from [192.168.0.103] (c-71-199-58-92.hsd1.ut.comcast.net[71.199.58.92])           by comcast.net (rwcrmhc12) with ESMTP           id <20070521125938m12006sngpe>; Mon, 21 May 2007 12:59:38 +0000
Message-ID: <465197C9.4060002@byu.net>
Date: Mon, 21 May 2007 12:59:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.10) Gecko/20070221 Thunderbird/1.5.0.10 Mnenhy/0.7.5.666
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: declare hsearch_r
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00044.txt.bz2

Cygwin already exports newlib's hsearch_r, but failed to declare it in
cygwin's replacement <search.h>.  This leads to unnecessary warnings when
compiling cygwin, at the point where newlib is trying to compile uses of
hsearch_r.

2007-05-21  Eric Blake  <ebb9@byu.net>

	* include/search.h (hsearch_r): Provide declaration.

Index: include/search.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/search.h,v
retrieving revision 1.2
diff -u -p -r1.2 search.h
--- include/search.h	27 Mar 2005 02:31:33 -0000	1.2
+++ include/search.h	21 May 2007 12:57:45 -0000
@@ -57,6 +57,7 @@ void  hdestroy (void);
 ENTRY *hsearch (ENTRY, ACTION);
 int hcreate_r (size_t, struct hsearch_data *);
 void hdestroy_r (struct hsearch_data *);
+int hsearch_r(ENTRY, ACTION, ENTRY **, struct hsearch_data *);
 void *tdelete (const void * __restrict, void ** __restrict,
 	       int (*) (const void *, const void *));
 void tdestroy (void *, void (*)(void *));

-- 
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
