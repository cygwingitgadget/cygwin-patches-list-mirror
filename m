Return-Path: <cygwin-patches-return-8767-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 102442 invoked by alias); 11 May 2017 14:05:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 102420 invoked by uid 89); 11 May 2017 14:05:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-23.9 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_SPAM,SPF_PASS autolearn=ham version=3.3.2 spammy=H*MI:sk:2017051, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mail-wm0-f45.google.com
Received: from mail-wm0-f45.google.com (HELO mail-wm0-f45.google.com) (74.125.82.45) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 11 May 2017 14:05:56 +0000
Received: by mail-wm0-f45.google.com with SMTP id b84so42623902wmh.0        for <cygwin-patches@cygwin.com>; Thu, 11 May 2017 07:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to         :references;        bh=wOcSC/AC4/H9kNfokt3qMI+G7bNWtFrjZ3fsA3UonmA=;        b=bZw9b9ZaFvM/N2U3xzupujZ2+ouT9DVihT8ZcTysaVGHvcJWtSyE3fROItDer3FnRh         pulnWv4NbrVpyY1BYXSgflJ20la0e+xYUeL9+dVHx+7nk4HYGcpCuYyjv2G7QCDo+qO2         nUrLDfljroIH+6KwRK3BYA4B0IwqkaSpPbz1CYWDGUcJ5WVRFcTUsQewUFMWC5gWtSvI         Rn85j2tO/gVMZ5vT5rilOYdRC7Qb7mbWTi18lmfVvEc68Fa4aCGQU7HkQEXK11VHgmtl         tezLTwp9YwT5gh3UEuTg66yC6FXrSeF/yCnl2D9STum8FxAmBVI+RAI9xL2/xflcb83z         BRBA==
X-Gm-Message-State: AODbwcBuFimmkIYD3ULKucjbg3Gxi/VPE1NezjyR/dP+A8UsPdVfjIQm	lZhEFd9qFiX/L59xalE=
X-Received: by 10.28.29.17 with SMTP id d17mr1164126wmd.90.1494511557262;        Thu, 11 May 2017 07:05:57 -0700 (PDT)
Received: from localhost.localdomain (vbo91-1-82-238-216-179.fbx.proxad.net. [82.238.216.179])        by smtp.gmail.com with ESMTPSA id k18sm305636wre.9.2017.05.11.07.05.56        for <cygwin-patches@cygwin.com>        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Thu, 11 May 2017 07:05:56 -0700 (PDT)
From: "Erik M. Bray" <erik.m.bray@gmail.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Ensure that a blocking send() on a socket returns (with success) if a signal is handled mid-transition and SA_RESTART is not set.
Date: Thu, 11 May 2017 14:05:00 -0000
Message-Id: <20170511140534.26860-2-erik.m.bray@gmail.com>
In-Reply-To: <20170511140534.26860-1-erik.m.bray@gmail.com>
References: <20170511140534.26860-1-erik.m.bray@gmail.com>
X-IsSubscribed: yes
X-SW-Source: 2017-q2/txt/msg00038.txt.bz2

---
 winsup/cygwin/fhandler_socket.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_socket.cc b/winsup/cygwin/fhandler_socket.cc
index f3d1d69..c7ed681 100644
--- a/winsup/cygwin/fhandler_socket.cc
+++ b/winsup/cygwin/fhandler_socket.cc
@@ -1851,7 +1851,7 @@ fhandler_socket::send_internal (struct _WSAMSG *wsamsg, int flags)
 	  if (get_socket_type () != SOCK_STREAM || ret < out_len)
 	    break;
 	}
-      else if (is_nonblocking () || err != WSAEWOULDBLOCK)
+      else if (is_nonblocking () || WSAGetLastError() != WSAEWOULDBLOCK)
 	break;
     }
 
-- 
2.8.3
