Return-Path: <cygwin-patches-return-4285-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15023 invoked by alias); 9 Oct 2003 08:55:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15013 invoked from network); 9 Oct 2003 08:55:04 -0000
Date: Thu, 09 Oct 2003 08:55:00 -0000
From: Yitzchak Scott-Thoennes <sthoenna@efn.org>
To: cygwin-patches@cygwin.com
Subject: mman.h still has MAP_FAILED as caddr_t
Message-ID: <20031009085447.GC3032@efn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: bs"d
X-SW-Source: 2003-q4/txt/msg00004.txt.bz2

The prototypes for mmap, etc. were recently changed from using caddr_t
to void *, as called for by SUSV3, but MAP_FAILED wasn't changed.
SUSV3 doesn't specifically say anything about how MAP_FAILED should
be defined, but other platforms I've seen have a (void *) cast.

--- include/sys/mman.h.orig	2003-09-20 13:32:09.000000000 -0700
+++ include/sys/mman.h	2003-10-09 01:30:46.735724800 -0700
@@ -31,7 +31,7 @@
 #define MAP_ANONYMOUS 0x20
 #define MAP_ANON MAP_ANONYMOUS
 
-#define MAP_FAILED ((caddr_t)-1)
+#define MAP_FAILED ((void *)-1)
 
 /*
  * Flags for msync.
