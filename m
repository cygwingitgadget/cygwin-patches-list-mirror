Return-Path: <cygwin-patches-return-8420-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 63360 invoked by alias); 19 Mar 2016 17:46:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 63169 invoked by uid 89); 19 Mar 2016 17:46:17 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:1740, warns, HTo:U*cygwin-patches, morning
X-HELO: mail-qk0-f194.google.com
Received: from mail-qk0-f194.google.com (HELO mail-qk0-f194.google.com) (209.85.220.194) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Sat, 19 Mar 2016 17:46:16 +0000
Received: by mail-qk0-f194.google.com with SMTP id s5so4937713qkd.2        for <cygwin-patches@cygwin.com>; Sat, 19 Mar 2016 10:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to         :references;        bh=RyflqYdg4DZJQuSvL+yhyhLIgjWwJCAepO+nwmpgF2g=;        b=cc6910alqxoA0KUqzCi8+wnZA6xuQuQepQhF5h6DGd2hAW9cyPxHb4LkAKVbFJDeUV         Me6J0girakn9U0FAPZN7VJEL//lYnTEWljgcWhCF+/W78DTmKMVeglilWrRABOg4pbmc         ToPtTHakQwUUdg01HRedIRl8Vr9Q42slRxSRlLyg/CAQRHshexb3h6IO33+hcIjbWoU7         yRZO9k0NrkH/Jqn6OE/9r+zG4AfzxSllz79r0tCKPRJNw2cxwQ75hLzDfwtuKfE2sASB         eIREioFz6Qk3Uukcg+MT8diFUVRJtahLOxGvrWTHd+kCtXwVesyoci/3NWInISRRkehl         gfWQ==
X-Gm-Message-State: AD7BkJJteYftRZ8pdr20+m24dilxThOReWwDSRI8BqUx4MH4dPMtktEK0Wh7J0fPA2Zxbg==
X-Received: by 10.55.221.200 with SMTP id u69mr30406478qku.0.1458409574564;        Sat, 19 Mar 2016 10:46:14 -0700 (PDT)
Received: from bronx.local.pefoley.com (foleype-1-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:ee7::2])        by smtp.gmail.com with ESMTPSA id 78sm8582720qgt.1.2016.03.19.10.46.13        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);        Sat, 19 Mar 2016 10:46:14 -0700 (PDT)
From: Peter Foley <pefoley2@pefoley.com>
To: cygwin-patches@cygwin.com
Cc: Peter Foley <pefoley2@pefoley.com>
Subject: [PATCH 04/11] Remove misleading indentation
Date: Sat, 19 Mar 2016 17:46:00 -0000
Message-Id: <1458409557-13156-4-git-send-email-pefoley2@pefoley.com>
In-Reply-To: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com>
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com>
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00129.txt.bz2

GCC 6.0+ warns on misleading indentation, so fix it.

winsup/cygserver/ChangeLog
* sysv_msg.cc (msgsnd): Fix misleading indentation.
* sysv_msg.cc (msgrcv): Ditto.
* sysv_sem.cc (semop): Ditto.
winsup/cygwing/ChangeLog
* syscalls.cc (getpriority): Fix misleading indentation.

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 winsup/cygserver/sysv_msg.cc | 4 ++--
 winsup/cygserver/sysv_sem.cc | 2 +-
 winsup/cygwin/syscalls.cc    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/winsup/cygserver/sysv_msg.cc b/winsup/cygserver/sysv_msg.cc
index 217cc1d..fefc750 100644
--- a/winsup/cygserver/sysv_msg.cc
+++ b/winsup/cygserver/sysv_msg.cc
@@ -736,7 +736,7 @@ msgsnd(struct thread *td, struct msgsnd_args *uap)
 			  if (error != EIDRM)
 #endif /* __CYGWIN__ */
 				error = EINTR;
-				goto done2;
+			  goto done2;
 			}
 
 			/*
@@ -1092,7 +1092,7 @@ msgrcv(struct thread *td, struct msgrcv_args *uap)
 		    if (error != EIDRM)
 #endif /* __CYGWIN__ */
 			error = EINTR;
-			goto done2;
+		    goto done2;
 		}
 
 		/*
diff --git a/winsup/cygserver/sysv_sem.cc b/winsup/cygserver/sysv_sem.cc
index e7ba48b..751190a 100644
--- a/winsup/cygserver/sysv_sem.cc
+++ b/winsup/cygserver/sysv_sem.cc
@@ -1180,7 +1180,7 @@ semop(struct thread *td, struct semop_args *uap)
 		    if (error != EIDRM)
 #endif /* __CYGWIN__ */
 			error = EINTR;
-			goto done2;
+		    goto done2;
 		}
 		DPRINTF(("semop:  good morning!\n"));
 	}
diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 3dd6af1..15fb8ce 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -3838,7 +3838,7 @@ getpriority (int which, id_t who)
 	  case PRIO_USER:
 	    if ((uid_t) who == p->uid && p->nice < nice)
 	      nice = p->nice;
-	      break;
+	    break;
 	  }
     }
 out:
-- 
2.7.4
