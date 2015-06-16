Return-Path: <cygwin-patches-return-8175-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 65081 invoked by alias); 16 Jun 2015 16:27:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 65069 invoked by uid 89); 16 Jun 2015 16:27:49 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.2 required=5.0 tests=AWL,BAYES_20,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,RP_MATCHES_RCVD autolearn=no version=3.3.2
X-HELO: mailout12.t-online.de
Received: from mailout12.t-online.de (HELO mailout12.t-online.de) (194.25.134.22) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Tue, 16 Jun 2015 16:27:47 +0000
Received: from fwd32.aul.t-online.de (fwd32.aul.t-online.de [172.20.26.144])	by mailout12.t-online.de (Postfix) with SMTP id E48E610438C	for <cygwin-patches@cygwin.com>; Tue, 16 Jun 2015 18:27:43 +0200 (CEST)
Received: from [192.168.2.103] (T5I4poZOQhPWlXxTGvkxWv8ItAyxc2jCbMRyUrbMZzL7wPV6vfEmnjHngt6+Xy2wTr@[84.180.90.102]) by fwd32.t-online.de	with (TLSv1.2:ECDHE-RSA-AES256-SHA encrypted)	esmtp id 1Z4tiA-4Vr70S0; Tue, 16 Jun 2015 18:27:42 +0200
Message-ID: <55804E7D.3060504@t-online.de>
Date: Tue, 16 Jun 2015 16:27:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:36.0) Gecko/20100101 Firefox/36.0 SeaMonkey/2.33.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Hide sethostname() in unistd.h
Content-Type: multipart/mixed; boundary="------------060301020600010204070407"
X-IsSubscribed: yes
X-SW-Source: 2015-q2/txt/msg00076.txt.bz2

This is a multi-part message in MIME format.
--------------060301020600010204070407
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 214

Found during an experimental build of busybox:

The sethostname() prototype in /usr/include/sys/unistd.h is enabled also 
on Cygwin.
It should be disabled because Cygwin does not provide this function.

Christian


--------------060301020600010204070407
Content-Type: text/x-patch;
 name="unistd-sethostname.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="unistd-sethostname.patch"
Content-length: 750

2015-06-16  Christian Franke  <franke@computer.org>

	* libc/include/sys/unistd.h (sethostname): Hide prototype on Cygwin.

diff --git a/newlib/libc/include/sys/unistd.h b/newlib/libc/include/sys/unistd.h
index eb26921..6131b5c 100644
--- a/newlib/libc/include/sys/unistd.h
+++ b/newlib/libc/include/sys/unistd.h
@@ -169,7 +169,7 @@ int     _EXFUN(setgid, (gid_t __gid ));
 #if defined(__CYGWIN__)
 int	_EXFUN(setgroups, (int ngroups, const gid_t *grouplist ));
 #endif
-#if __BSD_VISIBLE || (defined(_XOPEN_SOURCE) && __XSI_VISIBLE < 500)
+#if !defined(__CYGWIN__) && (__BSD_VISIBLE || (defined(_XOPEN_SOURCE) && __XSI_VISIBLE < 500))
 int	_EXFUN(sethostname, (const char *, size_t));
 #endif
 int     _EXFUN(setpgid, (pid_t __pid, pid_t __pgid ));

--------------060301020600010204070407--
