Return-Path: <cygwin-patches-return-9151-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 46727 invoked by alias); 25 Jul 2018 20:06:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 46679 invoked by uid 89); 25 Jul 2018 20:06:52 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-24.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=
X-HELO: mx1.redhat.com
Received: from mx3-rdu2.redhat.com (HELO mx1.redhat.com) (66.187.233.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 25 Jul 2018 20:06:51 +0000
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id D26C97D84D	for <cygwin-patches@cygwin.com>; Wed, 25 Jul 2018 20:06:49 +0000 (UTC)
Received: from yselkowitz.redhat.com (ovpn-122-107.rdu2.redhat.com [10.10.122.107])	by smtp.corp.redhat.com (Postfix) with ESMTPS id 966472156701	for <cygwin-patches@cygwin.com>; Wed, 25 Jul 2018 20:06:49 +0000 (UTC)
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/1] Cygwin: fpathconf: update _PC_ASYNC_IO return value
Date: Wed, 25 Jul 2018 20:06:00 -0000
Message-Id: <20180725200643.10750-2-yselkowi@redhat.com>
In-Reply-To: <20180725200643.10750-1-yselkowi@redhat.com>
References: <20180725200643.10750-1-yselkowi@redhat.com>
X-SW-Source: 2018-q3/txt/msg00046.txt.bz2

Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
---
 winsup/cygwin/fhandler.cc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/cygwin/fhandler.cc b/winsup/cygwin/fhandler.cc
index ded12cc44..22dbdb05d 100644
--- a/winsup/cygwin/fhandler.cc
+++ b/winsup/cygwin/fhandler.cc
@@ -1875,6 +1875,7 @@ fhandler_base::fpathconf (int v)
       set_errno (EINVAL);
       break;
     case _PC_ASYNC_IO:
+      return 1;
     case _PC_PRIO_IO:
       break;
     case _PC_SYNC_IO:
-- 
2.17.1
