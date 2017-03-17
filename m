Return-Path: <cygwin-patches-return-8713-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 100873 invoked by alias); 17 Mar 2017 17:40:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 99890 invoked by uid 89); 17 Mar 2017 17:40:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-25.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_LOW,RP_MATCHES_RCVD,SPF_PASS autolearn=ham version=3.3.2 spammy=D*pobox.com, danielsantospoboxcom, U*daniel.santos, daniel.santos@pobox.com
X-HELO: sasl.smtp.pobox.com
Received: from pb-smtp2.pobox.com (HELO sasl.smtp.pobox.com) (64.147.108.71) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 17 Mar 2017 17:40:04 +0000
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])	by pb-smtp2.pobox.com (Postfix) with ESMTP id E55C57569A;	Fri, 17 Mar 2017 13:40:03 -0400 (EDT)
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])	by pb-smtp2.pobox.com (Postfix) with ESMTP id B892075698;	Fri, 17 Mar 2017 13:40:03 -0400 (EDT)
Received: from localhost.localdomain (unknown [76.215.41.237])	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))	(No client certificate requested)	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CDFA175693;	Fri, 17 Mar 2017 13:40:01 -0400 (EDT)
From: Daniel Santos <daniel.santos@pobox.com>
To: cygwin-patches@cygwin.com
Cc: Daniel Santos <daniel.santos@pobox.com>
Subject: [PATCH] [base-files] Don't clobber prompt set in /etc/profile.d
Date: Fri, 17 Mar 2017 17:40:00 -0000
Message-Id: <20170317174409.8271-1-daniel.santos@pobox.com>
X-Pobox-Relay-ID: BFC41F44-0B38-11E7-9347-FC50AE2156B6-06139138!pb-smtp2.pobox.com
X-IsSubscribed: yes
X-SW-Source: 2017-q1/txt/msg00054.txt.bz2

When I build my own machine, I prefer to set my own default prompt in
/etc/profile.d.  This makes it easier on me, but still allows other
users to set whatever prompt they please.  This line in bash.bashrc
incorrectly clobbers whatever prompt is set in /etc/profile.d.

Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
---
 etc/defaults/etc/bash.bashrc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/etc/defaults/etc/bash.bashrc b/etc/defaults/etc/bash.bashrc
index 0f633fa..7fc78aa 100644
--- a/etc/defaults/etc/bash.bashrc
+++ b/etc/defaults/etc/bash.bashrc
@@ -27,7 +27,7 @@
 export EXECIGNORE="*.dll"
 
 # Set a default prompt of: user@host and current_directory
-PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n\$ '
+PS1="${PS1:-'\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n\$ '}"
 
 # Uncomment to use the terminal colours set in DIR_COLORS
 # eval "$(dircolors -b /etc/DIR_COLORS)"
-- 
2.11.0
