Return-Path: <cygwin-patches-return-9906-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 35092 invoked by alias); 12 Jan 2020 11:21:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 35081 invoked by uid 89); 12 Jan 2020 11:21:07 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_2,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=Speed, HX-Spam-Relays-External:209.85.221.67, H*RU:209.85.221.67, HTo:U*cygwin-patches
X-HELO: mail-wr1-f67.google.com
Received: from mail-wr1-f67.google.com (HELO mail-wr1-f67.google.com) (209.85.221.67) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 12 Jan 2020 11:21:05 +0000
Received: by mail-wr1-f67.google.com with SMTP id y17so5798580wrh.5        for <cygwin-patches@cygwin.com>; Sun, 12 Jan 2020 03:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=gmail.com; s=20161025;        h=subject:to:references:from:message-id:date:user-agent:mime-version         :in-reply-to:content-transfer-encoding;        bh=gOB4Qmypja66E+gSO62XADkDpJLUzv/YRPWB5w7af04=;        b=snJvFz4CCwmFF+w+pe0++1gNRZDn/YazpNgYCyKdtqHWa64/85dGE1m35ATy544EFa         f1l2rYGH0vhjATD1y2ffGfrghBQP5wGg8rZcQaPPB84HQDAmC7XMcemS2KQzBZbomRxk         w2++fCkCk9SrWVCZRY6Saous9H5AtOMr/iOoZPktzV/Y8NHxvqre3UJOK5z1rhgpayYJ         5QKnd0qRm0vZWiqGinyXkBjUq5E0gqFMGaSwpxi///Z7Z3VumTpE2Rsal8aKy43Y01ba         D4j3TmqPNLmco8IqO/izl1BC8xfA6LsiXkydn+/MRxHkw4ZEPjiJLTT/UIWaPuy12DZH         QCdg==
Return-Path: <marco.atzeri@gmail.com>
Received: from ?IPv6:2003:ee:6727:2e01:45c5:df20:ab41:5758? (p200300EE67272E0145C5DF20AB415758.dip0.t-ipconnect.de. [2003:ee:6727:2e01:45c5:df20:ab41:5758])        by smtp.gmail.com with ESMTPSA id b10sm10451343wrt.90.2020.01.12.03.21.01        for <cygwin-patches@cygwin.com>        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);        Sun, 12 Jan 2020 03:21:02 -0800 (PST)
Subject: Re: [PATCH] Cygwin: select: Speed up select() call for pty, pipe and fifo.
To: cygwin-patches@cygwin.com
References: <20200106143834.1994-1-takashi.yano@nifty.ne.jp>
From: Marco Atzeri <marco.atzeri@gmail.com>
Message-ID: <15efba6e-a26c-50a3-ecde-1ff98764dee6@gmail.com>
Date: Sun, 12 Jan 2020 11:21:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200106143834.1994-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00012.txt

Am 06.01.2020 um 15:38 schrieb Takashi Yano:
> - The slowing down issue of X11 forwarding using ssh -Y, reported
>    in https://www.cygwin.com/ml/cygwin/2019-12/msg00295.html,
>    is due to the change of select() code for pty in the commit
>    915fcd0ae8d83546ce135131cd25bf6795d97966. cygthread::detach()
>    takes at most about 10msec because Sleep() is used in the thread.
>    For this issue, this patch uses cygwait() instead of Sleep() and
>    introduces an event to abort the wait. For not only pty, but pipe
>    and fifo also have the same problem potentially, so this patch
>    applies same strategy to them as well.
> ---
>   winsup/cygwin/select.cc | 15 ++++++++++++---
>   winsup/cygwin/select.h  |  1 +
>   2 files changed, 13 insertions(+), 3 deletions(-)
> 

I see a substantial improvement in responsiveness
also with local X-server.

