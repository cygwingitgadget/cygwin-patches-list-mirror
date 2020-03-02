Return-Path: <cygwin-patches-return-10164-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 125301 invoked by alias); 2 Mar 2020 23:06:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 125284 invoked by uid 89); 2 Mar 2020 23:06:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.2 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,GIT_PATCH_2,RCVD_IN_DNSWL_NONE,SPOOFED_FREEMAIL autolearn=ham version=3.3.1 spammy=
X-HELO: mailout03.t-online.de
Received: from mailout03.t-online.de (HELO mailout03.t-online.de) (194.25.134.81) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 02 Mar 2020 23:06:03 +0000
Received: from fwd29.aul.t-online.de (fwd29.aul.t-online.de [172.20.26.134])	by mailout03.t-online.de (Postfix) with SMTP id 59F5B4255C1B	for <cygwin-patches@cygwin.com>; Tue,  3 Mar 2020 00:06:01 +0100 (CET)
Received: from [192.168.178.26] (JTMpFYZEZhsC77jPm0D4qybw0M-sxvMACA+8DO5xC5SEhlxSusKMmrRuzyEvA1ugDr@[79.228.65.18]) by fwd29.t-online.de	with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)	esmtp id 1j8u8M-3YxcZ60; Tue, 3 Mar 2020 00:05:58 +0100
Subject: [PATCH 0/1] Handle wpbuf in a more C++ style
To: cygwin-patches@cygwin.com
From: =?UTF-8?Q?Hans-Bernhard_Br=c3=b6ker?= <HBBroeker@t-online.de>
X-Forwarded-Message-Id:
Message-ID: <c8bbdeb0-e983-cb29-1148-5fa4a6d51383@t-online.de>
Date: Mon, 02 Mar 2020 23:06:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00270.txt

Replace a relatively C-styled co-dependent pair of variables, a #define, 
and an inline function by a helper class containing their relation, 
because that is more in the C++ style.

Hans-Bernhard Broeker (1):
   Collect handling of wpixput and wpbuf into a helper class.

  winsup/cygwin/fhandler_console.cc | 135 ++++++++++++++++--------------
  1 file changed, 70 insertions(+), 65 deletions(-)

-- 
2.21.0
