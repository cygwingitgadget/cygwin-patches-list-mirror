Return-Path: <cygwin-patches-return-9903-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 51834 invoked by alias); 7 Jan 2020 15:34:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 51825 invoked by uid 89); 7 Jan 2020 15:34:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*Ad:U*cygwin-patches, HX-Received:a19, vendors
X-HELO: mail-lf1-f65.google.com
Received: from mail-lf1-f65.google.com (HELO mail-lf1-f65.google.com) (209.85.167.65) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 07 Jan 2020 15:34:43 +0000
Received: by mail-lf1-f65.google.com with SMTP id y1so23194lfb.6        for <cygwin-patches@cygwin.com>; Tue, 07 Jan 2020 07:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=alumni-chalmers-se.20150623.gappssmtp.com; s=20150623;        h=from:to:subject:date:message-id:mime-version         :content-transfer-encoding;        bh=Awtg7T7Scztf6BkXZHJ8zgF5/zy+uaRj4yAylXHdZlw=;        b=I8592+Pa5ofOa710kEiTE8YSgXmistk5+Uav0w6IVj9tI4NAz7zhfGg0MgcgBiHm4w         pnPCEeeYhEO7K2RkNOt6Ry7+NYBsQWergo/aap4VKYefb2Lq/Lm94AroIO6FZ1vdhIRV         5tv+PY+lPd8otAaK3dG6t5lBOptXBb/GAhNXf6MwcbMmGrAYn1jqN2ZHrYTSXZvqmNL9         zS6UAsqPmmYLnv0R8bAx22Dk3NJNnpmUVfXfR3E2svi/wir0nmygyXWAq0Sze0CAHh/o         ZyQDP66nXHQAMaJl2t8/+ufEbOnlWOUvOt/8jwFoaJVduJpTUaPQoa72UPfeLPX6ZUz9         ZFrQ==
Return-Path: <arseniy@alumni.chalmers.se>
Received: from tux-precision-3520.localnet ([62.119.168.113])        by smtp.gmail.com with ESMTPSA id x4sm29776838ljb.66.2020.01.07.07.34.39        for <cygwin-patches@cygwin.com>        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);        Tue, 07 Jan 2020 07:34:40 -0800 (PST)
From: Arseniy Lartsev <arseniy@alumni.chalmers.se>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Fixed crash on wine by adding NULL check after memchr
Date: Tue, 07 Jan 2020 15:34:00 -0000
Message-ID: <1870553.yxu1Ok4Nxh@tux-precision-3520>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00009.txt

This is not a joke, there are vendors out there who build software for cygwin
only. Besides, this NULL check is good to have anyway.
---
 winsup/cygwin/path.cc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index b5efd61b2..c8e73c64c 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -4307,6 +4307,8 @@ find_fast_cwd_pointer ()
   const uint8_t *use_cwd = rcall + 5 + offset;
   /* Find first `push %edi' instruction. */
   const uint8_t *pushedi = (const uint8_t *) memchr (use_cwd, 0x57, 32);
+  if (!pushedi)
+    return NULL;
   /* ...which should be followed by `mov crit-sect-addr,%edi' then
      `push %edi', or by just a single `push crit-sect-addr'. */
   const uint8_t *movedi = pushedi + 1;
-- 
2.17.1


