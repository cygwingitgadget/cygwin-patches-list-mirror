Return-Path: <cygwin-patches-return-8290-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 126404 invoked by alias); 17 Dec 2015 18:05:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 126341 invoked by uid 89); 17 Dec 2015 18:05:32 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.9 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SCAM_SUBJECT,SPF_PASS autolearn=no version=3.3.2 spammy=435, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: mout.gmx.net
Received: from mout.gmx.net (HELO mout.gmx.net) (212.227.17.20) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Thu, 17 Dec 2015 18:05:31 +0000
Received: from virtualbox ([37.24.143.114]) by mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0MdoR7-1Zr6yo1tMr-00Pejh for <cygwin-patches@cygwin.com>; Thu, 17 Dec 2015 19:05:27 +0100
Date: Thu, 17 Dec 2015 18:05:00 -0000
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 2/2] Respect `db_home` setting even for the SYSTEM account
In-Reply-To: <cover.1450375424.git.johannes.schindelin@gmx.de>
Message-ID: <90c5b45fbe7c26e85e65d69d999b4118a2a89c5a.1450375424.git.johannes.schindelin@gmx.de>
References: <0Lg1Tn-1YnzUw0ScN-00pcgi@mail.gmx.com> <cover.1450375424.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-UI-Out-Filterresults: notjunk:1;V01:K0:E5lRXyJm2hU=:IS0UC7Bmusqd8TM6mAR19F 0x7U8WKFm5UcQEpdP1TURqHGLJYSY/xfOpRWcyrWqvNtdQnqOwNlL9BKLslHuiKm8dUH81Mcd bUf9EotampsB8u8F4eJuwKX1WNpdxRyVji17WHH3FX2C9aZRv6z1WAYOFPrWZRVjjUI42/7c8 SXNB4w4KS1dwuja2N6nSi1KywbNFv+OCJXX4SKuEKIWlJm5RQB6dCGf1NSJUq8c8O8yN89pKa A0wVo8RfeJJqBIzN/0i5P7Al49vrYwVb2Wi4nwL2TqNAjkvY1l2Vu1uaRYwiPzpy+MA4zvgC8 KRG7hVCHVp1N+H9mG1lLQSlNb3c5yfLGNg6FPIPf/TI0RHV+pI1OKHiR13mcUzOAkeFcC1JAr NbevXQPgfFnQPUqyKLXkeqbEjVq11s74pub9T8rVsTo2/7MSHRXNJnVnWYouNxUdTRNjoXMgW owDEE/E+NID1W2wQ8gA05sEC6EAM2oSm71tVEfUK0tXxwK6CHAt6p6jEG0NFvT5/Dy8kJBwqf diqwC2BZmt11j4ZVWw1t1J8DdHIiHe3spKW7IDgq5ZqvAoCgXjap9GZz0zAEuFE2SU5iCic9w 3bW+nQkY8CVdYKbicq/vvs/EsWuJ8YoZ/6m/BObqGnyndP1Hhdz8asUdreHc7QNecz3bIvyyG Auvf+jrA+sXxPGEHaNsSnNmVd/6XRxwcgW8Fl85eAoO0zCXP/npp9jVgcom42QP6qJZUdzT48 avzhckWHZ2SeDjbgOW5XKnIRVl4U9Qy06ryoIn33U7yJJ7FkyH38DdKBL9aCW5stRvp5yWl+D GRj9u9O
X-IsSubscribed: yes
X-SW-Source: 2015-q4/txt/msg00043.txt.bz2

We should not blindly set the home directory of the SYSTEM account to
/home/SYSTEM, especially not when that value disagrees with what is
configured via the `db_home` line in the `/etc/nsswitch.conf` file.

This fixes https://github.com/git-for-windows/git/issues/435

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 winsup/cygwin/uinfo.cc | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
index a5d6270..8c51b82 100644
--- a/winsup/cygwin/uinfo.cc
+++ b/winsup/cygwin/uinfo.cc
@@ -2129,7 +2129,11 @@ pwdgrp::fetch_account_from_windows (fetch_user_arg_t &arg, cyg_ldap *pldap)
 	 it to a well-known group here. */
       if (acc_type == SidTypeUser
 	  && (sid_sub_auth_count (sid) <= 3 || sid_id_auth (sid) == 11))
-	acc_type = SidTypeWellKnownGroup;
+	{
+	  acc_type = SidTypeWellKnownGroup;
+	  home = cygheap->pg.get_home (pldap, sid, dom, domain, name,
+				       fully_qualified_name);
+	}
       switch (acc_type)
       	{
 	case SidTypeUser:
-- 
2.6.3.windows.1.300.g1c25e49
