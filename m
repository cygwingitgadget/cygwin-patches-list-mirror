Return-Path: <cygwin-patches-return-9865-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10200 invoked by alias); 15 Dec 2019 18:50:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 10191 invoked by uid 89); 15 Dec 2019 18:50:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.4 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1 spammy=appearing
X-HELO: smtp-out-so.shaw.ca
Received: from smtp-out-so.shaw.ca (HELO smtp-out-so.shaw.ca) (64.59.136.138) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 15 Dec 2019 18:50:10 +0000
Received: from [192.168.1.114] ([24.64.172.44])	by shaw.ca with ESMTP	id gYxziN82V17ZDgYy0i1J1w; Sun, 15 Dec 2019 11:50:08 -0700
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Subject: Re: [PATCH] Cygwin: Provide more COM devices
Reply-To: Brian.Inglis@SystematicSw.ab.ca
To: cygwin-patches@cygwin.com
References: <87mudvwnrl.fsf@Rainer.invalid> <20191021081844.GH16240@calimero.vinschen.de> <87pniq7yvm.fsf@Rainer.invalid> <20191022071622.GM16240@calimero.vinschen.de> <87sgn4ai3n.fsf@Rainer.invalid> <871rt6rbvb.fsf@Rainer.invalid>
Openpgp: preference=signencrypt
Message-ID: <6db57733-0b63-54fc-3b2f-ff2c87b9dcd1@SystematicSw.ab.ca>
Date: Sun, 15 Dec 2019 18:50:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <871rt6rbvb.fsf@Rainer.invalid>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00136.txt.bz2

On 2019-12-14 11:38, Achim Gratz wrote:

[Sorry, thought I'd sent this, it was backgrounded!]

What are the distinctions between /dev/sd[a-c][a-z], /dev/sdd[a-z], and
/dev/sd[a-z] appearing in parts of devices.cc?

s[6] == 'd'?

Better:

>   if (len > 7 && len < 12 && s[7] == 'd'
-   if (len > 7 && len < 12 && s[7] == 'd'
+   if (DP_LEN < len && len <= DP_LEN + 4 && 'd' == s[DP_LEN - 1]
>       /* Generic check for /dev/sd[a-z] prefix */
>       && strncmp (s, DISK_PREFIX, DP_LEN) == 0
>       && s[DP_LEN] >= 'a' && s[DP_LEN] <= 'z')

There are 127 each cons,nst,pty,ptym,st,ttyS entries allocated for potential
devices, which will not exist on most systems.

Note that GPT supports 128 partitions per device.

Are there systems using more than 32 of any supported device?

Are there documented Windows I/O device addressing limits?

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
