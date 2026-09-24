Return-Path: <SRS0=kM7z=HQ=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo011.btinternet.com (btprdrgo011.btinternet.com [65.20.50.92])
	by sourceware.org (Postfix) with ESMTP id 3CAB24868BD3
	for <cygwin-patches@cygwin.com>; Thu, 24 Sep 2026 15:21:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3CAB24868BD3
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3CAB24868BD3
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.92
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790263275; cv=none;
	b=rA31bs3Bk1+b8CGkOtDrLHqhj2X7KDFy+B9xsvRwUgTAWD/ouqirlg3D92MR+2C3SmUv62XgwHg1QthebUBrxvjBXTN500znHhl0PfAN27yqPDJTUu/acdjNjNZcb7Sx9mvV9zj9FzgJxyBz+8uF8TPyVI2CYSebQPwGGHv9OCY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790263275; c=relaxed/simple;
	bh=hsNnCWgE3kCutpFw3fnf+bkDn7b4eW+0eMiQzPL8+H4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LWqA+Tqo8+q5l18H//ff0i18mM34eKxOVgVluap79tXrdqhsbwGiRD8U5v163rmo74TRp2SJJAYSJIgYxD+NHC3DFdbF/DQff2oZe3gI3zyh3A+nB24pZucDbqv5sozAvhAkI3QIzgEKne0HoGMigORf3t8an4zg923lvyhv4yc=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3CAB24868BD3
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A71613809D5ABCF
X-Originating-IP: [62.56.83.178]
X-OWM-Source-IP: 62.56.83.178
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTGa2jczxv+ZUGcONZSIG4MAQ0iB5uK9VfUl9u3LPd8S3jn1l7G+NTCuKOZddNktp24NdbRocIoeccYsqfVQIFZkH2+JGU9iEZp1ZmjXw4St5PaW0wgVklBopAIbV41+sT2QnRq8Nqibsr3WUu5rUo+Rf3CZHFjFup6vLuMzrDEjdz497TTSGUIkFyMccwizuLjtHYkFKlyJmkpnm5Try9Gu9WDXGP95kVv9u7rHh1izPoT/8eX9ySZTM5irp+JmFSm3KiJeduo08fQaoHxznaG0/vaoO0Ye7kcZI1VzfJ7cF3LbEwW8PkHfz3VEGZ5SOD+hd0+CaIJTNhYCZzqSU3pUr57Wmk93a5roW+CWnw2g7+EfGV6knWwTkyyrCGqqfZiCUFCSbqSFOVJILK9bQHxVNmsMZ7n7V3d+LxChb572tWP6fONa71Z8TII8z3IdjOG5pMV9jORlpopt1b3sx9tcVZpG17i7ys9t1dJY73YQnUXYPxBTCrqY6wkLq95hGzh8qU8jnartPgdaG6xXtPQMy4tRZh2S8+q6fhfdj85iJtPiv48ykE683ypR4WFJFgaUuiNB6p024JQO9UNV6xrOkByUbsC+McrnaYDfBex6qut98DZWh9Q4efQkbpuI3vJTd18LTF18FciUs0a5FRgddHFY85iO/agGABBMkvrMvg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from tambora (62.56.83.178) by btprdrgo011.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A71613809D5ABCF; Thu, 24 Sep 2026 16:21:11 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: Fix pinfo comparision operator which is ambiguous under C++20 rules
Date: Thu, 24 Sep 2026 16:21:06 +0100
Message-ID: <20260924152106.116672-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

../../../../src/winsup/cygwin/pinfo.cc:1254:27: error: C++20 says that these are ambiguous, even though the second is reversed: [-Werror]
In file included from /wip/cygwin/src/winsup/cygwin/local_includes/fhandler.h:10,
/wip/cygwin/src/winsup/cygwin/local_includes/pinfo.h:231:8: note: candidate 1: ‘bool pinfo::operator==(pinfo&) const’
/wip/cygwin/src/winsup/cygwin/local_includes/pinfo.h:231:8: note: candidate 2: ‘bool pinfo::operator==(pinfo&) const’ (reversed)

Notes:

Under C++20 rules, the compiler synthesizes a reversed candidate of this
operator. However, since neither is an exact match when two const
arguments are compared, an ambiguity error is reported.

Fix this by making the argument const. This makes the normal order
candidate an exact match under those circumstances, breaking the
ambiguity.
---
 winsup/cygwin/local_includes/pinfo.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/local_includes/pinfo.h b/winsup/cygwin/local_includes/pinfo.h
index fe8203fbc..f38393d99 100644
--- a/winsup/cygwin/local_includes/pinfo.h
+++ b/winsup/cygwin/local_includes/pinfo.h
@@ -228,7 +228,7 @@ public:
   void set_exit_code (DWORD n);
   _pinfo *operator -> () const {return procinfo;}
   bool operator == (pinfo *x) const {return x->procinfo == procinfo;}
-  bool operator == (pinfo &x) const {return x.procinfo == procinfo;}
+  bool operator == (const pinfo &x) const {return x.procinfo == procinfo;}
   bool operator == (_pinfo *x) const {return x == procinfo;}
   bool operator == (void *x) const {return procinfo == x;}
   _pinfo *operator * () const {return procinfo;}
-- 
2.51.0

