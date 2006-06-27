Return-Path: <cygwin-patches-return-5901-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9327 invoked by alias); 27 Jun 2006 05:46:42 -0000
Received: (qmail 9291 invoked by uid 22791); 27 Jun 2006 05:46:41 -0000
X-Spam-Check-By: sourceware.org
Received: from okigate.oki.co.jp (HELO iscan1.intra.oki.co.jp) (202.226.91.194)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 27 Jun 2006 05:46:39 +0000
Received: from s24c53.dm1.oii.oki.co.jp (IDENT:root@localhost.localdomain [127.0.0.1]) 	by iscan1.intra.oki.co.jp (8.9.3/8.9.3) with ESMTP id OAA01689; 	Tue, 27 Jun 2006 14:46:36 +0900
Received: from [10.161.35.40] (suzuki611-note.ngo.okisoft.co.jp [10.161.35.40]) 	by s24c53.dm1.oii.oki.co.jp (8.11.6/8.11.2) with ESMTP id k5R5kar06101; 	Tue, 27 Jun 2006 14:46:36 +0900
Message-ID: <44A0C650.6060001@oki.com>
Date: Tue, 27 Jun 2006 05:46:00 -0000
From: SUZUKI Hisao <suzuki611@oki.com>
User-Agent: Thunderbird 1.5.0.4 (Macintosh/20060516)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: UTF-8 Cygwin
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00089.txt.bz2

# I should have posted this message to this list from the first.

I made a patch to cygwin1.dll to support UTF-8.

It allows you to use all of characters and file (or path) names
allowed in Windows, while keeping binary-compatibility with the
current Cygwin.  It is fairly perfect except for lack of locale
support etc.  So it may remind you of the good old BeOS.  See:

http://www.okisoft.co.jp/esc/utf8-cygwin/

--
SUZUKI Hisao
