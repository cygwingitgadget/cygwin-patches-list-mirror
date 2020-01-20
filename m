Return-Path: <cygwin-patches-return-9961-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7989 invoked by alias); 20 Jan 2020 14:19:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 7980 invoked by uid 89); 20 Jan 2020 14:19:29 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.5 required=5.0 tests=AWL,BAYES_00,FORGED_SPF_HELO,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=no version=3.3.1 spammy=HX-Spam-Relays-External:sk:2020012, H*RU:sk:2020012, HX-Languages-Length:1377, our
X-HELO: re-prd-fep-046.btinternet.com
Received: from mailomta21-re.btinternet.com (HELO re-prd-fep-046.btinternet.com) (213.120.69.114) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 20 Jan 2020 14:19:19 +0000
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])          by re-prd-fep-046.btinternet.com with ESMTP          id <20200120141917.BSDZ22473.re-prd-fep-046.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;          Mon, 20 Jan 2020 14:19:17 +0000
Authentication-Results: btinternet.com;    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-OWM-Source-IP: 31.51.207.12 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.106] (31.51.207.12) by re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.337) (authenticated as jonturney@btinternet.com)        id 5DEE078D07373481; Mon, 20 Jan 2020 14:19:17 +0000
Subject: Re: [PATCH] Cygwin: pty: Introduce disable_pcon in environment CYGWIN.
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20200120025015.1520-1-takashi.yano@nifty.ne.jp> <20200120100646.GE20672@calimero.vinschen.de> <20200120214124.9da79990b75a658016cf34d7@nifty.ne.jp>
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <ed59eb98-8e59-f0d1-d1c3-9f44cb6cbee7@dronecode.org.uk>
Date: Mon, 20 Jan 2020 14:19:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200120214124.9da79990b75a658016cf34d7@nifty.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2020-q1/txt/msg00067.txt

On 20/01/2020 12:41, Takashi Yano wrote:
> Hi Corinna,
> 
> On Mon, 20 Jan 2020 11:06:46 +0100
> Corinna Vinschen wrote:
>> On Jan 20 11:50, Takashi Yano wrote:
>>> - For programs which does not work properly with pseudo console,
>>>    disable_pcon in environment CYGWIN is introduced. If disable_pcon
>>>    is set, pseudo console support is disabled.
>> Oh well, do we really need that?
> 
> This is, for example, needed to solve the issue reported in
> https://www.cygwin.com/ml/cygwin/2020-01/msg00147.html.
> 
> I looked into this problem, and found that cgdb read output of
> gdb from pty master and write it to ncurses. The output from
> pty master includes a lot of escape sequences which are generated
> by pseudo console, however, ncurses does not pass-through them
> and shows garbages. This is the cause of that issue.
> 
> cgdb is the only program do such things so far, however, there
> may be more programs which do not expect escape sequences read
> from pty.
> 
> There is no way to control pseudo console not to generate
> escape sequences, therefore, I proposed this patch.
> 

I think this may actually be an issue with cgdb being old.

The latest gdb enables "output styling" using ANSI escape sequences by 
default, but our cgdb can't handle them?

See: https://github.com/cgdb/cgdb/issues/211
