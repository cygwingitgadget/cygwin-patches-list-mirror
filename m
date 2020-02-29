Return-Path: <cygwin-patches-return-10148-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 53570 invoked by alias); 29 Feb 2020 18:10:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 53561 invoked by uid 89); 29 Feb 2020 18:10:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-4.0 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:485, HContent-Language:de-DE
X-HELO: mailout08.t-online.de
Received: from mailout08.t-online.de (HELO mailout08.t-online.de) (194.25.134.20) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 29 Feb 2020 18:10:05 +0000
Received: from fwd11.aul.t-online.de (fwd11.aul.t-online.de [172.20.27.152])	by mailout08.t-online.de (Postfix) with SMTP id 091A541E7429	for <cygwin-patches@cygwin.com>; Sat, 29 Feb 2020 19:10:02 +0100 (CET)
Received: from [192.168.178.26] (ZBm+OTZrghrV1ucm8-78jxw101ZbLGW7MqRJOznnAIuzRnK3gMCd8sgTg1Nzxqlgd4@[79.228.65.18]) by fwd11.t-online.de	with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)	esmtp id 1j86Yr-1CG1r60; Sat, 29 Feb 2020 19:10:01 +0100
Subject: Re: [PATCH v2 1/4] Cygwin: console: Add workaround for broken IL/DL in xterm mode.
From: =?UTF-8?Q?Hans-Bernhard_Br=c3=b6ker?= <HBBroeker@t-online.de>
To: cygwin-patches@cygwin.com
References: <20200226153302.584-1-takashi.yano@nifty.ne.jp> <20200226153302.584-2-takashi.yano@nifty.ne.jp> <05cca441-eb83-4600-90f3-bf82ec7a0190@dronecode.org.uk> <20200228111409.149929dcf710cabf99a879b3@nifty.ne.jp> <20200228133122.GG4045@calimero.vinschen.de> <cc657f02-e3a4-1880-34a2-dcf04d6e902a@t-online.de>
Message-ID: <ea1bcf99-d945-d06e-9be6-8a17d8fb166f@t-online.de>
Date: Sat, 29 Feb 2020 18:10:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <cc657f02-e3a4-1880-34a2-dcf04d6e902a@t-online.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00254.txt

One more important note: the current implementation has a potential 
buffer overrun issue, because it writes first, and only then checks 
whether that may have overrun the buffer.  And the check itself is off 
by one, too:

>    wpbuf[wpixput++] = x; \
>    if (wpixput > WPBUF_LEN) \
>     wpixput--; \

That's why my latest code snippet does it differently:

 >      if (ixput < WPBUF_LEN)
 >        {
 >          buf[ixput++] = x;
 >        }
