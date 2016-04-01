Return-Path: <cygwin-patches-return-8541-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 62882 invoked by alias); 1 Apr 2016 22:53:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 62867 invoked by uid 89); 1 Apr 2016 22:53:15 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.9 required=5.0 tests=BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:589, overhaul, 2.5.0, Feature
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Fri, 01 Apr 2016 22:53:05 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 580EE6438E	for <cygwin-patches@cygwin.com>; Fri,  1 Apr 2016 22:53:04 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-17.rdu2.redhat.com [10.10.116.17])	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u31Mr3WZ014287	(version=TLSv1/SSLv3 cipher=AES256-SHA256 bits=256 verify=NO)	for <cygwin-patches@cygwin.com>; Fri, 1 Apr 2016 18:53:03 -0400
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/4] Various fixes for 2.5.0
Date: Fri, 01 Apr 2016 22:53:00 -0000
Message-Id: <1459551179-9404-1-git-send-email-yselkowi@redhat.com>
X-SW-Source: 2016-q2/txt/msg00016.txt.bz2

An assortment of unrelated patches discovered in the process of rebuilding
GCC with 2.5.0-0.10.

Yaakov Selkowitz (4):
  Feature test macros overhaul: Cygwin pthread.h
  cygwin/math: make isinf functions signed
  cygwin: update sysconf for new features
  winsup/utils: port getconf to 64-bit

 winsup/cygwin/include/pthread.h | 29 +++++++++++++++++++++--------
 winsup/cygwin/math/isinf.c      |  6 +++---
 winsup/cygwin/sysconf.cc        |  6 +++---
 winsup/utils/getconf.c          | 35 +++++++++++++++++++++++------------
 4 files changed, 50 insertions(+), 26 deletions(-)

-- 
2.7.4
