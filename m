Return-Path: <cygwin-patches-return-8415-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 78550 invoked by alias); 17 Mar 2016 09:29:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 78195 invoked by uid 89); 17 Mar 2016 09:29:07 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,SPF_PASS,TVD_RCVD_IP autolearn=ham version=3.3.2 spammy=intermediate, HTo:U*cygwin-patches
X-HELO: glup.org
Received: from 216-15-121-172.c3-0.smr-ubr2.sbo-smr.ma.static.cable.rcn.com (HELO glup.org) (216.15.121.172) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Thu, 17 Mar 2016 09:29:04 +0000
Received: from [IPv6:2001:4830:1141:1:15:ab25:382e:7608] (unknown [IPv6:2001:4830:1141:1:15:ab25:382e:7608])	by glup.org (Postfix) with ESMTPSA id BD9D7854C4;	Thu, 17 Mar 2016 05:29:01 -0400 (EDT)
Authentication-Results: glup.org; dmarc=none header.from=glup.org
Subject: Re: [PATCH] Re: Cygwin select() issues and improvements
To: cygwin-patches@cygwin.com
References: <56C03624.1030703@glup.org> <20160215125703.GE8374@calimero.vinschen.de> <56C66DDE.9070509@glup.org> <20160219104641.GA5574@calimero.vinschen.de> <20160304085843.GB8296@calimero.vinschen.de> <56E5DD8D.7060302@glup.org> <20160314101257.GE3567@calimero.vinschen.de>
From: John Hood <cgull@glup.org>
Message-ID: <56EA78DC.3040201@glup.org>
Date: Thu, 17 Mar 2016 09:29:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <20160314101257.GE3567@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2016-q1/txt/msg00121.txt.bz2

On 3/14/2016 6:12 AM, Corinna Vinschen wrote:
> Hi John,
>
> On Mar 13 17:37, john hood wrote:
>> On 3/4/16 3:58 AM, Corinna Vinschen wrote:
>>> John,
>>>
>>>
>>> Ping?  I'd be interested to get your patches into Cygwin.  select
>>> really needs some kicking :)
>> Sorry to be so slow responding.  Here's a rebased, squashed,
>> changelog-ified patch,
> Thank you.  Uhm... I just don't understand why you squashed them into a
> single big patch.  Multiple independent smaller patches are better to
> handle, especially when looking for potential bugs later.
>
> Would you mind terribly to split them again?
i just looked at this, but I'm going to leave the patch as a single 
patch.  The patches in the original series are not completely 
independent of each other, it has a bug or two in the middle, and also 
some reversed edits.  The endpoint is known tested and working, but some 
of the intermediate commits aren't that well tested.  It *is* too big as 
a single commit-- but I think that's better than the original patch 
series from my development work, which I never intended to submit as-is 
anyway.

Regards,

   --jh
