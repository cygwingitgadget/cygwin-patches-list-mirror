Return-Path: <SRS0=ML/7=CW=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 1256D3858D32
	for <cygwin-patches@cygwin.com>; Tue,  4 Jul 2023 18:42:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1256D3858D32
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 364IhJVr016101
	for <cygwin-patches@cygwin.com>; Tue, 4 Jul 2023 11:43:19 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-247-226.fiber.dynamic.sonic.net(50.1.247.226), claiming to be "[192.168.4.100]"
 via SMTP by m0.truegem.net, id smtpdy34DqF; Tue Jul  4 11:43:14 2023
Subject: Re: [PATCH v2] Cygwin: Make <sys/cpuset.h> safe for c89 compilations
To: cygwin-patches@cygwin.com
References: <20230704005141.5334-1-mark@maxrnd.com>
 <ZKQtr5+C7B+gLQtT@calimero.vinschen.de>
 <ZKQy5w2OlDmv/5iF@calimero.vinschen.de>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <d2d1c436-f3f9-8e67-1645-0a6d29741973@maxrnd.com>
Date: Tue, 4 Jul 2023 11:41:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <ZKQy5w2OlDmv/5iF@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Corinna Vinschen wrote:
> On Jul  4 16:33, Corinna Vinschen wrote:
>> On Jul  3 17:51, Mark Geisert wrote:
>>> Four modifications to include/sys/cpuset.h:
>>> * Change C++-style comments to C-style also supported by C++
>>> * Change "inline" to "__inline" on code lines
>>> * Add "#include <sys/cdefs.h>" to make sure __inline is defined
>>> * Don't declare loop variables on for-loop init clauses
>>>
>>> Tested by first reproducing the reported issue with home-grown test
>>> programs by compiling with gcc option "-std=c89", then compiling again
>>> using the modified <sys/cpuset.h>. Other "-std=" options tested too.
>>>
>>> Addresses: https://cygwin.com/pipermail/cygwin-patches/2023q3/012308.html
>>> Fixes: 315e5fbd99ec ("Cygwin: Fix type mismatch on sys/cpuset.h")
>>> Signed-off-by: Mark Geisert <mark@maxrnd.com>
>>>
>>> ---
>>>   winsup/cygwin/include/sys/cpuset.h | 49 ++++++++++++++++--------------
>>>   winsup/cygwin/release/3.4.7        |  3 ++
>>>   2 files changed, 30 insertions(+), 22 deletions(-)
>>
>> Pushed.
> 
> FYI, I missed to notice that you added the release message to the
> already existing 3.4.7 release.  I moved it into a new file for 3.4.8.

Thank you for cleaning up after my goof on the version.
Cheers & Regards,

..mark
