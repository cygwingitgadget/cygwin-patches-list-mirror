Return-Path: <cygwin-patches-return-10146-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23846 invoked by alias); 28 Feb 2020 21:00:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 23821 invoked by uid 89); 28 Feb 2020 21:00:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.4 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,GIT_PATCH_2,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=eyes, H*r:encrypted, H*M:1880
X-HELO: mailout01.t-online.de
Received: from mailout01.t-online.de (HELO mailout01.t-online.de) (194.25.134.80) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 28 Feb 2020 21:00:54 +0000
Received: from fwd37.aul.t-online.de (fwd37.aul.t-online.de [172.20.27.137])	by mailout01.t-online.de (Postfix) with SMTP id 3A87E42CE244	for <cygwin-patches@cygwin.com>; Fri, 28 Feb 2020 22:00:51 +0100 (CET)
Received: from [192.168.178.26] (S37k8ZZLrhhFexmzprV1zsad-FnK-DhdeNpS3nxYXbt4B+30gexYouh9TBnKZwxwE3@[79.228.65.18]) by fwd37.t-online.de	with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)	esmtp id 1j7mkS-0BubMe0; Fri, 28 Feb 2020 22:00:40 +0100
Subject: Re: [PATCH v2 1/4] Cygwin: console: Add workaround for broken IL/DL in xterm mode.
To: cygwin-patches@cygwin.com
References: <20200226153302.584-1-takashi.yano@nifty.ne.jp> <20200226153302.584-2-takashi.yano@nifty.ne.jp> <05cca441-eb83-4600-90f3-bf82ec7a0190@dronecode.org.uk> <20200228111409.149929dcf710cabf99a879b3@nifty.ne.jp> <20200228133122.GG4045@calimero.vinschen.de>
From: =?UTF-8?Q?Hans-Bernhard_Br=c3=b6ker?= <HBBroeker@t-online.de>
Message-ID: <cc657f02-e3a4-1880-34a2-dcf04d6e902a@t-online.de>
Date: Fri, 28 Feb 2020 21:00:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200228133122.GG4045@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00252.txt

Am 28.02.2020 um 14:31 schrieb Corinna Vinschen:
> [CC Hans]

Thanks.  I wasn't subscribed to -patches so far.  Will change that.

>> Hans,
>> as for making a patch for this issue, may I leave it to you
>> because you are already working on it?

My patch was meant only as a minimally-invasive stop-gap fix, because 
the new GCC refused to compile the code as-is (it triggers a 
-Werror...).  As such, sorry for hurting Brian's eyes. ;-)

I agree that this really should be an inline function.  I barely speak 
C++, but even I have glimpsed that multi-statement macros are rightfully 
frowned upon in C++ circles.

I believe a more C++-like implementation would have to encapsulate wpbuf 
and wpixput into a helper class.  This is what my _very_ rusty C++ 
allowed me to come up with:

// simple helper class to accumulate output in a buffer
// and send that to the console on request:
static class
{
private:
   unsigned char buf[WPBUF_LEN];
   int ixput;

public:
   inline void put(unsigned char x)
   {
     if (ixput < WPBUF_LEN)
       {
         buf[ixput++] = x;
       }
   };
   inline void empty() { ixput = 0; };
   inline void sendOut(HANDLE &handle, DWORD *wn) {
     WriteConsoleA (handle, buf, ixput, wn, 0);
   };
} wpbuf;

Using it works like this:

s/wpbuf_put/wpbuf.put/
s/wpixput = 0/wpbuf.empty()/
s/WriteConsoleA ( get_output_handle (), wpbuf, wpixput, \(&w*n\), 0 
/wpbuf.sendOut( get_output_handle (), \1/g

Yes, sendOut() is ugly --- I didn't manage to find out how this class 
could access get_output_handle() itself, so I had to let its callers 
deal with that.
