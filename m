Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id 643143851C27
 for <cygwin-patches@cygwin.com>; Wed, 10 Jun 2020 04:37:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 643143851C27
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=mark@maxrnd.com
Received: from localhost (mark@localhost)
 by m0.truegem.net (8.12.11/8.12.11) with ESMTP id 05A4bCJL031661
 for <cygwin-patches@cygwin.com>; Tue, 9 Jun 2020 21:37:12 -0700 (PDT)
 (envelope-from mark@maxrnd.com)
X-Authentication-Warning: m0.truegem.net: mark owned process doing -bs
Date: Tue, 9 Jun 2020 21:37:12 -0700 (PDT)
From: Mark Geisert <mark@maxrnd.com>
X-X-Sender: mark@m0.truegem.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3 v3] Cygwin: tzcode resync: basics
In-Reply-To: <394b2ab3-f239-72a1-21b2-a28952137253@SystematicSw.ab.ca>
Message-ID: <Pine.BSF.4.63.2006092130070.1307@m0.truegem.net>
References: <20200522093253.995-1-mark@maxrnd.com>
 <20200522093253.995-2-mark@maxrnd.com>
 <20200525120634.GD6801@calimero.vinschen.de>
 <20200525154901.GG6801@calimero.vinschen.de>
 <bcff83ee-c3b6-0b99-90d6-650694562250@maxrnd.com>
 <20200526082736.GH6801@calimero.vinschen.de>
 <394b2ab3-f239-72a1-21b2-a28952137253@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 10 Jun 2020 04:37:18 -0000

Hi Brian,

On Tue, 9 Jun 2020, Brian Inglis wrote:
> On 2020-05-26 02:27, Corinna Vinschen wrote:
>> On May 26 00:09, Mark Geisert wrote:
>>> Corinna Vinschen wrote:
>>>>> On May 22 02:32, Mark Geisert wrote:
>>>> On May 25 14:06, Corinna Vinschen wrote:
>
> Hi folks,
>
> The tzcode package needs updated to get fixes into zic and zdump.
> Also tzdata was maintained by Yaakov.
>
> Corinna, would you like to keep tzcode co-maintained with Yaakov?
>
> Or Mark, would you like to ITA tzcode and/or tzdata to keep it in sync with the
> base code?
>
> Or would you like me to ITA tzcode and/or tzdata?
> I currently check tzdb weekly in cron to download updates for my own interests.
> I could add cygport builds to that job.

This "tzcode" patch I did was a one-shot task just getting some time zone 
handling code within the Cygwin DLL up to date.  I don't know if there's 
any overlap between what I worked on and the tzcode+tzdata packages.  Eh, 
just the internal binary copy of a particular tzdata file which should be 
kept up to date: /usr/share/zoneinfo/posixrules.  Dunno how often that 
changes though.

It's fine with me for you to take over both tzcode+tzdata if nobody else 
objects.  Sounds like you have a regular schedule for looking over updates 
which is more than I have :-).
Cheers,

..mark
