Return-Path: <cygwin-patches-return-4596-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22720 invoked by alias); 12 Mar 2004 00:23:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22704 invoked from network); 12 Mar 2004 00:23:38 -0000
Date: Fri, 12 Mar 2004 00:23:00 -0000
To: cygwin-patches@cygwin.com
Subject: [Patch] src/winsup/mingw/include/process.h __STRICT_ANSI__
Message-Id: <VA.00000f1a.01b89c9b@thesoftwaresource.com>
From: Brian Keener <bkeener@thesoftwaresource.com>
Reply-To: bkeener@thesoftwaresource.com
X-SW-Source: 2004-q1/txt/msg00086.txt.bz2

I notice when trying to compile the #endif got left behind.  Sure you found it by 
now.

bk

2004-03-11  Brian Keener  <bkeener@thesoftwaresource.com>

        * include/process.h:  Remove the #endif associated with removal of
        __STRICT_ANSI__ guard from non-ANSI header.

Index: ./src/src/winsup/mingw/include/process.h
===================================================================
RCS file: /cvs/src/src/winsup/mingw/include/process.h,v
retrieving revision 1.5
diff -p -2 -r1.5 process.h
*** ./src/src/winsup/mingw/include/process.h   11 Mar 2004 09:41:08 -0000      1.5
--- ./src/src/winsup/mingw/include/process.h   11 Mar 2004 21:49:28 -0000
*************** _CRTIMP int __cdecl spawnvpe (int, const
*** 153,156 ****
  
  #endif       /* _PROCESS H_ not defined */
- 
- #endif       /* Not __STRICT_ANSI__ */
--- 153,154 ----



