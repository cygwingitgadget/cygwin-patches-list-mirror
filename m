Return-Path: <cygwin-patches-return-8451-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28665 invoked by alias); 21 Mar 2016 17:16:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 28622 invoked by uid 89); 21 Mar 2016 17:16:10 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:1526, HTo:U*cygwin-patches
X-HELO: mail-qk0-f193.google.com
Received: from mail-qk0-f193.google.com (HELO mail-qk0-f193.google.com) (209.85.220.193) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Mon, 21 Mar 2016 17:16:00 +0000
Received: by mail-qk0-f193.google.com with SMTP id q184so7357608qkb.0        for <cygwin-patches@cygwin.com>; Mon, 21 Mar 2016 10:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to         :references:references:in-reply-to;        bh=IMgp474eSNQed2+vCw7LKsFxx1Yo4cX+omgpYmNCjXE=;        b=LvB8UbqtKYrin+kXg5MbBmxbnTgDh1OwrUwMkSwb/70tzP8rY0hQpssj6rhpNPyxjJ         tg3ZnB0bpPlcTDHxkcXyU0pGjdc7TY4piqZnEzSdvHG5FyB7zcEgfbcJU2gG+V3ohoHI         aBIrgN7ZXc7DVuLvFg/jIme/qEKTMCJRWGH1cnN7VsJp7EIQSZxkzVpfW0NaTrsmsHP9         r6SZEQk22kx13fCyI+j31jQYndQ8VtJT9x1pUtDmlUNg46V1J1QWQWgtzgiomkMpK0hD         bu+c4WOE3seCdOrs3VRQ0Kp6+GAvxMQ5MayA8vzwxa34LuLxtBSQa1kI5aPqihuF2BZZ         vQNg==
X-Gm-Message-State: AD7BkJIwyxt5eVeMnvbk/V0I7ocmcxi3MY7u/cn5x0YNtBK86s47Rh1CTU/SPYD1T7dKEA==
X-Received: by 10.55.71.66 with SMTP id u63mr41407991qka.67.1458580558591;        Mon, 21 Mar 2016 10:15:58 -0700 (PDT)
Received: from bronx.local.pefoley.com ([2001:470:7:ee7::2])        by smtp.gmail.com with ESMTPSA id n83sm12492145qhn.46.2016.03.21.10.15.57        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);        Mon, 21 Mar 2016 10:15:58 -0700 (PDT)
From: Peter Foley <pefoley2@pefoley.com>
To: cygwin-patches@cygwin.com
Cc: Peter Foley <pefoley2@pefoley.com>
Subject: [PATCH v2 3/5] Remove misleading indentation
Date: Mon, 21 Mar 2016 17:16:00 -0000
Message-Id: <1458580546-14484-3-git-send-email-pefoley2@pefoley.com>
In-Reply-To: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com>
References: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com>
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com> <1458409557-13156-4-git-send-email-pefoley2@pefoley.com> <20160320110319.GF25241@calimero.vinschen.de>
In-Reply-To: <20160320110319.GF25241@calimero.vinschen.de>
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00157.txt.bz2

GCC 6.0+ warns on misleading indentation, so fix it.

winsup/cygserver/ChangeLog
* sysv_msg.cc (msgsnd): Fix misleading indentation.
* sysv_msg.cc (msgrcv): Ditto.
* sysv_sem.cc (semop): Ditto.

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 winsup/cygserver/sysv_msg.cc | 6 ++++--
 winsup/cygserver/sysv_sem.cc | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/winsup/cygserver/sysv_msg.cc b/winsup/cygserver/sysv_msg.cc
index 217cc1d..9e90d05 100644
--- a/winsup/cygserver/sysv_msg.cc
+++ b/winsup/cygserver/sysv_msg.cc
@@ -733,7 +733,8 @@ msgsnd(struct thread *td, struct msgsnd_args *uap)
 			if (error != 0) {
 				DPRINTF(("msgsnd:  interrupted system call\n"));
 #ifdef __CYGWIN__
-			  if (error != EIDRM)
+			  if (error == EIDRM)
+                              goto done2;
 #endif /* __CYGWIN__ */
 				error = EINTR;
 				goto done2;
@@ -1089,7 +1090,8 @@ msgrcv(struct thread *td, struct msgrcv_args *uap)
 		if (error != 0) {
 			DPRINTF(("msgrcv:  interrupted system call\n"));
 #ifdef __CYGWIN__
-		    if (error != EIDRM)
+		    if (error == EIDRM)
+                        goto done2;
 #endif /* __CYGWIN__ */
 			error = EINTR;
 			goto done2;
diff --git a/winsup/cygserver/sysv_sem.cc b/winsup/cygserver/sysv_sem.cc
index e7ba48b..349322c 100644
--- a/winsup/cygserver/sysv_sem.cc
+++ b/winsup/cygserver/sysv_sem.cc
@@ -1177,7 +1177,8 @@ semop(struct thread *td, struct semop_args *uap)
 		 */
 		if (error != 0) {
 #ifdef __CYGWIN__
-		    if (error != EIDRM)
+		    if (error == EIDRM)
+                        goto done2;
 #endif /* __CYGWIN__ */
 			error = EINTR;
 			goto done2;
-- 
2.7.4
