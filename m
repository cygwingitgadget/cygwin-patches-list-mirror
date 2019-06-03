Return-Path: <cygwin-patches-return-9426-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 76885 invoked by alias); 3 Jun 2019 18:31:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 76872 invoked by uid 89); 3 Jun 2019 18:31:52 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-26.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3 autolearn=ham version=3.3.1 spammy=H*F:U*cygwin, HContent-Transfer-Encoding:8bit
X-HELO: smtp01.domein-it.com
Received: from smtp01.domein-it.com (HELO smtp01.domein-it.com) (84.244.140.49) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 03 Jun 2019 18:31:42 +0000
Received: by smtp01.domein-it.com (Postfix, from userid 1000)	id 563EE8086D92; Mon,  3 Jun 2019 20:31:40 +0200 (CEST)
Received: from ferret.domein-it.nl (unknown [92.48.232.148])	by smtp01.domein-it.com (Postfix) with ESMTP id 1A1238086D8C	for <cygwin-patches@cygwin.com>; Mon,  3 Jun 2019 20:31:39 +0200 (CEST)
Received: from 80-112-22-40.cable.dynamic.v4.ziggo.nl ([80.112.22.40]:54050 helo=[192.168.1.10])	by ferret.domein-it.nl with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)	(Exim 4.91)	(envelope-from <cygwin@wijen.net>)	id 1hXrk8-0001yj-KG	for cygwin-patches@cygwin.com; Mon, 03 Jun 2019 20:31:36 +0200
From: Ben <cygwin@wijen.net>
Subject: [PATCH] mkdir: alway check-for-existence
To: cygwin-patches@cygwin.com
Message-ID: <60c1e83d-59f1-6b7a-80e8-05bf41cc6947@wijen.net>
Date: Mon, 03 Jun 2019 18:31:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Domein-IT-MailScanner-Information: Please contact the ISP for more information
X-Domein-IT-MailScanner-ID: 1hXrk8-0001yj-KG
X-Domein-IT-MailScanner: Found to be clean
X-Domein-IT-MailScanner-SpamCheck:
X-Domein-IT-MailScanner-From: cygwin@wijen.net
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00133.txt.bz2

When using either CreateDirectory or NtCreateFile when creating a directory
that already exists, these functions return: ERROR_ALREADY_EXISTS

However when using these function to create a directory (and all its 
parents)
a normal use would be to start with mkdir(â/câ) which translates to âC:\â
for which both of these functions return âERROR_ACCESS_DENIEDâ

We could call NtCreateFile with 'FILE_OPEN_IF' instead of 'FILE_CREATE' but
since that's an internal function we better always check for existence
ourselves.

Signed-off-by: Ben Wijen <ben@wijen.net>
---
 Â winsup/cygwin/dir.cc | 4 +++-
 Â 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/dir.cc b/winsup/cygwin/dir.cc
index f43eae461..b757851d5 100644
--- a/winsup/cygwin/dir.cc
+++ b/winsup/cygwin/dir.cc
@@ -331,8 +331,10 @@ mkdir (const char *dir, mode_t mode)
 Â Â Â  Â Â  debug_printf ("got %d error from build_fh_name", fh->error ());
 Â Â Â  Â Â  set_errno (fh->error ());
 Â Â Â  Â }
+Â Â Â Â Â  else if (fh->exists ())
+Â Â  Â set_errno (EEXIST);
 Â Â Â Â Â Â  else if (has_dot_last_component (dir, true))
-Â Â  Â set_errno (fh->exists () ? EEXIST : ENOENT);
+Â Â  Â set_errno (ENOENT);
 Â Â Â Â Â Â  else if (!fh->mkdir (mode))
 Â Â Â  Â res = 0;
 Â Â Â Â Â Â  delete fh;

-- 
2.21.0

