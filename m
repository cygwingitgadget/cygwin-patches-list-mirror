Return-Path: <cygwin-patches-return-9230-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 91189 invoked by alias); 24 Mar 2019 16:18:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 90537 invoked by uid 89); 24 Mar 2019 16:18:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.6 required=5.0 tests=AWL,BAYES_00,KAM_NUMSUBJECT,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1 spammy=explain
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.9) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 24 Mar 2019 16:17:59 +0000
Received: from [192.168.1.114] ([24.64.172.44])	by shaw.ca with ESMTP	id 85ophEtkVLdsa85oqhwGeF; Sun, 24 Mar 2019 10:17:57 -0600
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH] default ps -W process start time to system boot time when inaccessible, 0, -1
To: cygwin-patches@cygwin.com, Cygwin <cygwin@cygwin.com>
References: <20190323034522.9688-1-Brian.Inglis@SystematicSW.ab.ca> <87d0mh5x3u.fsf@Rainer.invalid> <20190323183653.GB3471@calimero.vinschen.de> <874l7tbfh6.fsf@Rainer.invalid> <4dfdfce1-245d-98fe-0c49-890ba8ec8dd4@SystematicSw.ab.ca> <874l7s65yv.fsf@Rainer.invalid>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Openpgp: preference=signencrypt
Message-ID: <bacddf44-e71b-08a2-9e93-0da8d98cc540@SystematicSw.ab.ca>
Date: Sun, 24 Mar 2019 16:18:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <874l7s65yv.fsf@Rainer.invalid>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q1/txt/msg00040.txt.bz2

On 2019-03-24 02:18, Achim Gratz wrote:
> Brian Inglis writes:
>> Are there non-startup system processes for which boot time is misleading?
>> If you need the truth use wmic, procexp64, or run ps in an elevated shell.
> 
> I don't seem to get my point across.  I'm fine with getting no start
> time value when that ps wasn't able to obtain that information.  If we
> have to use magic values to convey that information for one reason or
> another, then I'd rather opt for one that is obviously pulled out of
> thin air than for one that I have to compare to some other stuff before
> that becomes clear.

[Cross posting to Cygwin list as this is a more general discussion IMO]

Boot time is neither magic nor pulled out of thin air.
Checking *my* system processes using wmic queries and elevated powershell
scripts, the boot time is at most a few seconds off from process start times
from other sources.
I understand that other systems may run processes where that is not the case.
Please explain why you think this is misleadingly not useful, or where or which
processes have unvailable start times that are not very close to boot time.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
