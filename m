Return-Path: <cygwin-patches-return-9049-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 95930 invoked by alias); 19 Apr 2018 08:04:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 95406 invoked by uid 89); 19 Apr 2018 08:04:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.0 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2 spammy=requesting, asynchronous, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 19 Apr 2018 08:04:29 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id w3J84RYK056837	for <cygwin-patches@cygwin.com>; Thu, 19 Apr 2018 01:04:27 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 76-217-5-154.lightspeed.irvnca.sbcglobal.net(76.217.5.154), claiming to be "localhost.localdomain" via SMTP by m0.truegem.net, id smtpdiBfKGl; Thu Apr 19 01:04:25 2018
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 0/3] Posix asynchronous I/O support
Date: Thu, 19 Apr 2018 08:04:00 -0000
Message-Id: <20180419080402.10932-1-mark@maxrnd.com>
X-IsSubscribed: yes
X-SW-Source: 2018-q2/txt/msg00006.txt.bz2

This is the 2nd WIP patch set for AIO.  The string XXX marks issues
I'm specifically requesting comments on, but feel free to comment or
suggest changes on any of this code.

The code is working for both non-stress and stress situations I can
provoke with a test program I have.  The code only deals with disk
files at present.  I'd say the whole thing is 90% complete.  I will
address testing on the developers list shortly.
Thanks & Regards,

..mark
