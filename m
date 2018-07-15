Return-Path: <cygwin-patches-return-9115-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 52072 invoked by alias); 15 Jul 2018 08:20:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 52047 invoked by uid 89); 15 Jul 2018 08:20:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.9 required=5.0 tests=AWL,BAYES_20,GIT_PATCH_2,KAM_LAZY_DOMAIN_SECURITY autolearn=ham version=3.3.2 spammy=Hx-languages-length:373, peoples, AIO, aio
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 15 Jul 2018 08:20:52 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id w6F8KoUm071067	for <cygwin-patches@cygwin.com>; Sun, 15 Jul 2018 01:20:50 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 76-217-5-154.lightspeed.irvnca.sbcglobal.net(76.217.5.154), claiming to be "localhost.localdomain" via SMTP by m0.truegem.net, id smtpdxEbrAJ; Sun Jul 15 01:20:45 2018
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH v3 0/3] POSIX Asynchronous I/O support
Date: Sun, 15 Jul 2018 08:20:00 -0000
Message-Id: <20180715082025.4920-1-mark@maxrnd.com>
X-IsSubscribed: yes
X-SW-Source: 2018-q3/txt/msg00010.txt.bz2

This is intended to be the final patch set implementing POSIX AIO.  The
string XXX marks issues I'm specifically requesting comments on.  I
think there are only two of these XXXs left, both in aio.cc.  Questions,
comments, or suggestions are all welcome.
Thanks & Regards,

..mark

----
"Hell is other peoples' code." -- Sartron
