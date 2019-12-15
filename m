Return-Path: <cygwin-patches-return-9863-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29813 invoked by alias); 15 Dec 2019 06:03:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 29803 invoked by uid 89); 15 Dec 2019 06:03:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.4 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1 spammy=canada, Canada, H*f:sk:871rt6r, H*i:sk:871rt6r
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.137) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 15 Dec 2019 06:03:56 +0000
Received: from [192.168.1.114] ([24.64.172.44])	by shaw.ca with ESMTP	id gN0SiVI1URnrKgN0TiftcG; Sat, 14 Dec 2019 23:03:54 -0700
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH] Cygwin: Provide more COM devices
To: cygwin-patches@cygwin.com
References: <87mudvwnrl.fsf@Rainer.invalid> <20191021081844.GH16240@calimero.vinschen.de> <87pniq7yvm.fsf@Rainer.invalid> <20191022071622.GM16240@calimero.vinschen.de> <87sgn4ai3n.fsf@Rainer.invalid> <871rt6rbvb.fsf@Rainer.invalid>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Openpgp: preference=signencrypt
Message-ID: <adcab3cf-3162-f692-e4f5-2dceb8401869@SystematicSw.ab.ca>
Date: Sun, 15 Dec 2019 06:03:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <871rt6rbvb.fsf@Rainer.invalid>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00134.txt.bz2

On 2019-12-14 11:38, Achim Gratz wrote:

s[6] == 'd'?

>   if (len > 7 && len < 12 && s[7] == 'd'
-   if (len > 7 && len < 12 && s[7] == 'd'
+   if (len > 7 && len < 12 && s[DP_LEN - 1] == 'd'
>       /* Generic check for /dev/sd[a-z] prefix */
>       && strncmp (s, DISK_PREFIX, DP_LEN) == 0
>       && s[DP_LEN] >= 'a' && s[DP_LEN] <= 'z')

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
