Return-Path: <cygwin-patches-return-10045-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 121360 invoked by alias); 8 Feb 2020 17:13:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 121351 invoked by uid 89); 8 Feb 2020 17:13:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=22.01.2020, 22012020, para
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 08 Feb 2020 17:13:29 +0000
Received: from [192.168.178.41] ([188.108.121.114]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mbiak-1jVg5Y146I-00dC25 for <cygwin-patches@cygwin.com>; Sat, 08 Feb 2020 18:13:26 +0100
Subject: Re: [PATCH v2] Cygwin: pty: Introduce disable_pcon in environment CYGWIN.
To: cygwin-patches@cygwin.com
References: <20200121222329.69f71c847e97da78955735a7@nifty.ne.jp> <20200121132513.3654-1-takashi.yano@nifty.ne.jp> <20200122100651.GT20672@calimero.vinschen.de>
From: Thomas Wolff <towo@towo.net>
Message-ID: <a5724cea-edda-6ab9-fc7c-cbf3ad3091cc@towo.net>
Date: Sat, 08 Feb 2020 17:13:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200122100651.GT20672@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00151.txt

On 22.01.2020 11:06, Corinna Vinschen wrote:
> On Jan 21 22:25, Takashi Yano wrote:
>> - For programs which does not work properly with pseudo console,
>>    disable_pcon in environment CYGWIN is introduced. If disable_pcon
>>    is set, pseudo console support is disabled.
> Pushed.  I just fixed a missing </para> in the doc text.
>
Sorry I didn't notice this before. I think rather than having to decide 
and unconditionally switch on or off, a better approach would be to 
automatically enable pseudo console when forking a non-cygwin program 
only, or have that as a third option. (I think I had suggested this before.)
It's good we had pseudo console in unconditionally now for a while, as 
that apparently helped identifying a bunch of issues, but targetting it 
to where it's really needed would further help to avoid future trouble, 
including any performance issues as recently reported.
I'm willing to prepare a patch if desired, as I had implemented that 
condition already for my earlier "winpty injection" proposal.
Thomas
