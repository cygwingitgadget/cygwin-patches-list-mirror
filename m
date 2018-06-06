Return-Path: <cygwin-patches-return-9086-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 92366 invoked by alias); 6 Jun 2018 15:46:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 92211 invoked by uid 89); 6 Jun 2018 15:46:11 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-12.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GIT_PATCH_3,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.2 spammy=H*r:may, H*r:forged, H*MI:edu, H*Ad:U*cygwin-patches
X-HELO: limerock04.mail.cornell.edu
Received: from limerock04.mail.cornell.edu (HELO limerock04.mail.cornell.edu) (128.84.13.244) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 06 Jun 2018 15:46:10 +0000
X-CornellRouted: This message has been Routed already.
Received: from authusersmtp.mail.cornell.edu (granite4.serverfarm.cornell.edu [10.16.197.9])	by limerock04.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id w56Fk7Pm031774;	Wed, 6 Jun 2018 11:46:08 -0400
Received: from nothing.nyroc.rr.com (mta-68-175-129-7.twcny.rr.com [68.175.129.7] (may be forged))	(authenticated bits=0)	by authusersmtp.mail.cornell.edu (8.14.4/8.12.10) with ESMTP id w56Fjxgb006086	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);	Wed, 6 Jun 2018 11:46:06 -0400
From: Ken Brown <kbrown@cornell.edu>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 0/6] Implement clearenv
Date: Wed, 06 Jun 2018 15:46:00 -0000
Message-Id: <20180606154559.6828-1-kbrown@cornell.edu>
X-PMX-Cornell-Gauge: Gauge=XXXXX
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
X-IsSubscribed: yes
X-SW-Source: 2018-q2/txt/msg00043.txt.bz2

This is a followup to https://cygwin.com/ml/cygwin/2018-05/msg00334.html.

In this patch series I attempt to implement the glibc extension
clearenv(). I also implement glibc's notion of environ==NULL being
shorthand for an empty environment.

v2: In patch 2 I've tried harder to fix all the cases in which
environ==NULL could be a problem.  I did this by grepping the sources
for 'cur_environ' and '__cygwin_environ', but it's still possible that
I missed something.

I've also incorporated the changes suggested by Corinna and Yaakov.

Ken Brown (6):
  Cygwin: Clarify some code in environ.cc
  Cygwin: Allow the environment pointer to be NULL
  Cygwin: Implement the GNU extension clearenv
  Cygwin: Remove workaround in environ.cc
  Cygwin: Document clearenv and bump API minor
  Bump Cygwin DLL version to 2.11.0

 winsup/cygwin/common.din                 |  1 +
 winsup/cygwin/environ.cc                 | 56 +++++++++++++++++++-----
 winsup/cygwin/include/cygwin/stdlib.h    |  3 ++
 winsup/cygwin/include/cygwin/version.h   |  7 +--
 winsup/cygwin/pinfo.cc                   |  7 +--
 winsup/cygwin/release/{2.10.1 => 2.11.0} |  1 +
 winsup/doc/new-features.xml              | 20 +++++++++
 winsup/doc/posix.xml                     |  1 +
 8 files changed, 80 insertions(+), 16 deletions(-)
 rename winsup/cygwin/release/{2.10.1 => 2.11.0} (97%)

-- 
2.17.0
