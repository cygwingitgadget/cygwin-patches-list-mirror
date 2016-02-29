Return-Path: <cygwin-patches-return-8359-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 73352 invoked by alias); 29 Feb 2016 07:12:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 73316 invoked by uid 89); 29 Feb 2016 07:12:54 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.5 required=5.0 tests=AWL,BAYES_20,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2 spammy=H*F:U*mail, 12,7, 2.7.0, insertion
X-HELO: vae.croxnet.de
Received: from vae.croxnet.de (HELO vae.croxnet.de) (136.243.225.97) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Mon, 29 Feb 2016 07:12:53 +0000
Received: from localhost (localhost [127.0.0.1])	by vae.croxnet.de (Postfix) with ESMTP id AF6AC1B03CF0	for <cygwin-patches@cygwin.com>; Mon, 29 Feb 2016 08:11:37 +0100 (CET)
Received: from vae.croxnet.de ([127.0.0.1])	by localhost (vae.croxnet.de [127.0.0.1]) (amavisd-new, port 10024)	with ESMTP id cCHM87T_xiiz for <cygwin-patches@cygwin.com>;	Mon, 29 Feb 2016 08:11:37 +0100 (CET)
Received: from [192.168.177.24] (ip4d159a2d.dynamic.kabel-deutschland.de [77.21.154.45])	by vae.croxnet.de (Postfix) with ESMTPSA id 719C71B03CEE	for <cygwin-patches@cygwin.com>; Mon, 29 Feb 2016 08:11:36 +0100 (CET)
From: Patrick Bendorf <mail@patrick-bendorf.de>
Subject: [PATCH] ccwrap: fix build with non-english locale set
To: cygwin-patches@cygwin.com
Message-ID: <56D3EF72.20504@patrick-bendorf.de>
Date: Mon, 29 Feb 2016 07:12:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101 Thunderbird/38.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00065.txt.bz2

/winsup/
* ccwrap: fix build with non-english locale set
---
  winsup/ccwrap | 1 +
  1 file changed, 1 insertion(+)

diff --git a/winsup/ccwrap b/winsup/ccwrap
index 7580e7a..ef83085 100755
--- a/winsup/ccwrap
+++ b/winsup/ccwrap
@@ -12,6 +12,7 @@ if ($ARGV[0] ne '++') {
      $cxx = 1;
  }
  die "$0: $ccorcxx environment variable does not exist\n" unless exists 
$ENV{$ccorcxx};
+$ENV{'LANG'} = 'C.UTF-8';
  my @compiler = split ' ', $ENV{$ccorcxx};
  if ("@ARGV" !~ / -nostdinc/o) {
      my $fd;
--
2.7.0
