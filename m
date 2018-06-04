Return-Path: <cygwin-patches-return-9067-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 116481 invoked by alias); 4 Jun 2018 19:36:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 115470 invoked by uid 89); 4 Jun 2018 19:36:17 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-7.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=H*r:8.12.10, UD:xml, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: limerock02.mail.cornell.edu
Received: from limerock02.mail.cornell.edu (HELO limerock02.mail.cornell.edu) (128.84.13.242) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 04 Jun 2018 19:36:15 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite4.serverfarm.cornell.edu [10.16.197.9])	by limerock02.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id w54JaDka030226;	Mon, 4 Jun 2018 15:36:13 -0400
Received: from nothing.nyroc.rr.com (mta-68-175-129-7.twcny.rr.com [68.175.129.7] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id w54Ja674027599	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);	Mon, 4 Jun 2018 15:36:12 -0400
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/5] Implement clearenv
Date: Mon, 04 Jun 2018 19:36:00 -0000
Message-Id: <20180604193607.17088-1-kbrown@cornell.edu>
X-PMX-Cornell-Gauge: Gauge=XXXXX
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
X-IsSubscribed: yes
X-SW-Source: 2018-q2/txt/msg00024.txt.bz2

This is a followup to https://cygwin.com/ml/cygwin/2018-05/msg00334.html.

In this patch series I attempt to implement the glibc extension
clearenv().  I also implement glibc's notion of environ==NULL being
shorthand for an empty environment.

Two questions:

1. I haven't yet absorbed what SIGFE means.  I arbitrarily decorated
   clearenv with SIGFE rather than NOSIGFE in common.din, but I don't
   know if that's right.

2. I guarded the declaration of clearenv() with __GNU_VISIBLE, but
   again I'm not sure about this.  On the one hand, clearenv() is a
   GNU extension, so __GNU_VISIBLE would seem to be the right guard.
   On the other hand, glibc declares clearenv() if _DEFAULT_SOURCE is
   defined, so maybe the guard should be relaxed if our goal is to
   emulate Linux.

Yaakov?

Ken Brown (5):
  Cygwin: Clarify some code in environ.cc
  Cygwin: Allow the environment pointer to be NULL
  Cygwin: Implement the GNU extension clearenv
  Cygwin: Remove workaround in environ.cc
  Cygwin: Document clearenv

 winsup/cygwin/common.din               |  1 +
 winsup/cygwin/environ.cc               | 45 ++++++++++++++++++++++----
 winsup/cygwin/include/cygwin/stdlib.h  |  1 +
 winsup/cygwin/include/cygwin/version.h |  3 +-
 winsup/cygwin/release/2.10.1           |  1 +
 winsup/doc/posix.xml                   |  1 +
 6 files changed, 44 insertions(+), 8 deletions(-)

-- 
2.17.0
