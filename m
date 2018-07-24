Return-Path: <cygwin-patches-return-9140-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 48557 invoked by alias); 24 Jul 2018 05:28:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 48442 invoked by uid 89); 24 Jul 2018 05:28:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.2 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2 spammy=believed
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 24 Jul 2018 05:28:54 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id w6O5Sruj094598	for <cygwin-patches@cygwin.com>; Mon, 23 Jul 2018 22:28:53 -0700 (PDT)	(envelope-from mark@maxrnd.com)
Received: from 76-217-5-154.lightspeed.irvnca.sbcglobal.net(76.217.5.154), claiming to be "localhost.localdomain" via SMTP by m0.truegem.net, id smtpdTSZYfB; Mon Jul 23 22:28:46 2018
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH final] POSIX Asynchronous I/O support
Date: Tue, 24 Jul 2018 05:28:00 -0000
Message-Id: <20180724052833.1196-1-mark@maxrnd.com>
X-IsSubscribed: yes
X-SW-Source: 2018-q3/txt/msg00035.txt.bz2

This is believed to be the final patch set implementing POSIX AIO.  It
incorporates updates and fixes for all issues brought up over several
review cycles the last few months.  The implementation has been tested
with a couple different spot-check programs, as well as with iozone for
stress testing.  It's time to open it up for wider usage.
Thanks & Regards,

..mark
