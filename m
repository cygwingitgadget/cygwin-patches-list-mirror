Return-Path: <cygwin-patches-return-6801-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6730 invoked by alias); 25 Oct 2009 20:26:01 -0000
Received: (qmail 6718 invoked by uid 22791); 25 Oct 2009 20:26:00 -0000
X-SWARE-Spam-Status: No, hits=-3.5 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out2.smtp.messagingengine.com (HELO out2.smtp.messagingengine.com) (66.111.4.26)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 25 Oct 2009 20:25:57 +0000
Received: from compute1.internal (compute1.internal [10.202.2.41]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id A186EBA1B5 	for <cygwin-patches@cygwin.com>; Sun, 25 Oct 2009 16:25:55 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])   by compute1.internal (MEProxy); Sun, 25 Oct 2009 16:25:55 -0400
Received: from [192.168.1.3] (user-0c6sbc4.cable.mindspring.com [24.110.45.132]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id 379D85BF9F; 	Sun, 25 Oct 2009 16:25:55 -0400 (EDT)
Message-ID: <4AE4B419.1060502@cwilson.fastmail.fm>
Date: Sun, 25 Oct 2009 20:26:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Sync pseudo-reloc.c, round #2
References: <4AE4A701.3050206@cwilson.fastmail.fm>
In-Reply-To: <4AE4A701.3050206@cwilson.fastmail.fm>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00132.txt.bz2

Charles Wilson wrote:

> Tested on mingw32 and cygwin.

It occurred to me that I hadn't explicitly tested the error path with
this new version, and sure enough, there's a slight problem.  Here's the
fix (relative to the previous patch):

--- pseudo-reloc.c.save	2009-10-25 15:45:43.595012200 -0400
+++ pseudo-reloc.c	2009-10-25 16:10:08.236212200 -0400
@@ -94,7 +94,7 @@
   wchar_t module[MAX_PATH];
   char * posix_module = NULL;
   static const char * UNKNOWN_MODULE = "<unknown module>: ";
-  static const char * CYGWIN_FAILURE_MSG = "Cygwin runtime failure: ";
+  static const char   CYGWIN_FAILURE_MSG[] = "Cygwin runtime failure: ";
   static const size_t CYGWIN_FAILURE_MSG_LEN = sizeof
(CYGWIN_FAILURE_MSG) - 1;
   DWORD len;
   DWORD done;
@@ -133,6 +133,8 @@
                  sizeof(UNKNOWN_MODULE), &done, NULL);
       WriteFile (errh, (PCVOID)buf, len, &done, NULL);
     }
+  WriteFile (errh, (PCVOID)"\n", 1, &done, NULL);
+
   cygwin_internal (CW_EXIT_PROCESS,
                    STATUS_ILLEGAL_DLL_PSEUDO_RELOCATION,
                    1);
