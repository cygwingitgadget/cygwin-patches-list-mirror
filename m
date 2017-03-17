Return-Path: <cygwin-patches-return-8715-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 92512 invoked by alias); 17 Mar 2017 18:37:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 92499 invoked by uid 89); 17 Mar 2017 18:36:59 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-9.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_3,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches, person, Hx-spam-relays-external:ESMTPA, H*F:D*org.uk
X-HELO: out1-smtp.messagingengine.com
Received: from out1-smtp.messagingengine.com (HELO out1-smtp.messagingengine.com) (66.111.4.25) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 17 Mar 2017 18:36:58 +0000
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])	by mailout.nyi.internal (Postfix) with ESMTP id 84F99207BA	for <cygwin-patches@cygwin.com>; Fri, 17 Mar 2017 14:36:57 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])  by compute6.internal (MEProxy); Fri, 17 Mar 2017 14:36:57 -0400
X-ME-Sender: <xms:ySzMWFH1ad7ME9PFH3TH7HJSZOO2xjrFsYCGSbfLKhKl1lO58torkQ>
Received: from [192.168.1.102] (unknown [86.141.128.75])	by mail.messagingengine.com (Postfix) with ESMTPA id 3B59624519	for <cygwin-patches@cygwin.com>; Fri, 17 Mar 2017 14:36:57 -0400 (EDT)
Subject: Re: [PATCH] Implement getloadavg()
References: <20170317175032.26780-1-jon.turney@dronecode.org.uk>
To: Cygwin Patches <cygwin-patches@cygwin.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <ab5ee525-c847-7834-5a52-5322a6f15aba@dronecode.org.uk>
Date: Fri, 17 Mar 2017 18:37:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170317175032.26780-1-jon.turney@dronecode.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2017-q1/txt/msg00056.txt.bz2

On 17/03/2017 17:50, Jon Turney wrote:
>  winsup/cygwin/Makefile.in              |   5 +-
>  winsup/cygwin/common.din               |   1 +
>  winsup/cygwin/fhandler_proc.cc         |  10 ++-
>  winsup/cygwin/include/cygwin/stdlib.h  |   4 +
>  winsup/cygwin/include/cygwin/version.h |   3 +-
>  winsup/cygwin/loadavg.cc               | 135 +++++++++++++++++++++++++++++++++
>  winsup/doc/posix.xml                   |   1 +
>  7 files changed, 154 insertions(+), 5 deletions(-)
>  create mode 100644 winsup/cygwin/loadavg.cc

Note that this doesn't build for x86 at the moment, due to an issue with 
pdh.h in w32api (See [1])

Furthermore, there are a few problems with this implementation:

The first time a process calls getloadavg(), it always gets 0 (so 'cat 
/proc/loadavg' always shows a load of 0).  This is a consequence of 
having no global state, and the fact that we can't measure %CPU 
instantaneously, only over an interval.

I'm not the only person on the internet who thinks that 
(%CPU*#cores)+PQL is they way to calculate a load value, and while this 
gives reasonable values when when the load is between 0 and (number of 
cores), the PQL seems to get unexpectedly large when CPU is saturated on 
an otherwise idle system.

e.g. if I saturate the CPU with tasks of "normal" priority, PQL goes to 
~20; saturate with tasks of "below normal" priority, PQL goes to ~5, but 
there isn't actually any real demand there; if the CPU saturating tasks 
are killed, load drops close to 0.  I don't know how to interpret that...

[1] https://sourceforge.net/p/mingw-w64/mailman/message/35727667/
