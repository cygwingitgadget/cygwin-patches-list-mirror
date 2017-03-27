Return-Path: <cygwin-patches-return-8725-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 36402 invoked by alias); 27 Mar 2017 15:04:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 36163 invoked by uid 89); 27 Mar 2017 15:04:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-21.9 required=5.0 tests=AWL,BAYES_40,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=Turney, turney, Hx-languages-length:702, D*dronecode.org.uk
X-HELO: rgout05.bt.lon5.cpcloud.co.uk
Received: from rgout0504.bt.lon5.cpcloud.co.uk (HELO rgout05.bt.lon5.cpcloud.co.uk) (65.20.0.225) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 27 Mar 2017 15:04:31 +0000
X-OWM-Source-IP: 86.141.129.47 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-Junkmail-Premium-Raw: score=8/50,refid=2.7.2:2016.12.19.183017:17:8.707,ip=,rules=NO_URI_FOUND, NO_CTA_URI_FOUND, NO_MESSAGE_ID, TO_MALFORMED, NO_URI_HTTPS
Received: from localhost.localdomain (86.141.129.47) by rgout05.bt.lon5.cpcloud.co.uk (9.0.019.13-1) (authenticated as jonturney@btinternet.com)        id 58482E590B22BA86; Mon, 27 Mar 2017 16:04:30 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] declaration of ppoll() by poll.h should be guarded by _GNU_SOURCE
Date: Mon, 27 Mar 2017 15:04:00 -0000
Message-Id: <20170327150411.143276-1-jon.turney@dronecode.org.uk>
X-SW-Source: 2017-q1/txt/msg00066.txt.bz2

Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
---
 winsup/cygwin/include/sys/poll.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/winsup/cygwin/include/sys/poll.h b/winsup/cygwin/include/sys/poll.h
index 8228278..0da4c3f 100644
--- a/winsup/cygwin/include/sys/poll.h
+++ b/winsup/cygwin/include/sys/poll.h
@@ -39,9 +39,11 @@ struct pollfd {
 typedef unsigned int nfds_t;
 
 extern int poll __P ((struct pollfd *fds, nfds_t nfds, int timeout));
+#if __GNU_VISIBLE
 extern int ppoll __P ((struct pollfd *fds, nfds_t nfds,
 		       const struct timespec *timeout_ts,
 		       const sigset_t *sigmask));
+#endif
 
 __END_DECLS
 
-- 
2.8.3
