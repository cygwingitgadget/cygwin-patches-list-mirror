Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id 0A0023857C68
 for <cygwin-patches@cygwin.com>; Tue,  8 Dec 2020 03:25:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 0A0023857C68
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=mark@maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 0B83PwPU034167
 for <cygwin-patches@cygwin.com>; Mon, 7 Dec 2020 19:25:58 -0800 (PST)
 (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "[192.168.1.100]"
 via SMTP by m0.truegem.net, id smtpd4XIIP1; Mon Dec  7 19:25:49 2020
Subject: Re: [PATCH] Cygwin: Allow to set SO_PEERCRED zero (v2)
To: cygwin-patches@cygwin.com
References: <20201207102936.1527-1-mark@maxrnd.com>
 <20201207153025.GJ5295@calimero.vinschen.de>
 <20201207153513.GK5295@calimero.vinschen.de>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <0dffe28e-1b11-3637-ade1-c005a554ce50@maxrnd.com>
Date: Mon, 7 Dec 2020 19:25:49 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <20201207153513.GK5295@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 08 Dec 2020 03:26:01 -0000

Hi Corinna,

Corinna Vinschen via Cygwin-patches wrote:
> On Dec  7 16:30, Corinna Vinschen via Cygwin-patches wrote:
>> On Dec  7 02:29, Mark Geisert wrote:
>>> The existing code errors as EINVAL any attempt to set a value for
>>> SO_PEERCRED via setsockopt() on an AF_UNIX/AF_LOCAL socket.  But to
>>> enable the workaround set_no_getpeereid behavior for Python one has
>>> to be able to set SO_PEERCRED to zero.  Ergo, this patch.  Python has
>>> no way to specify a NULL pointer for 'optval'.
>>>
>>> This v2 of patch allows the original working (i.e., allow NULL,0 for
>>> optval,optlen to mean turn off SO_PEERCRED) in addition to the new
>>> working described above.  The sense of the 'if' stmt is reversed for
>>> readability.
>>>
>>> ---
[...]
>>> -- 
>>> 2.29.2
>>
>> Pushed
> 
> I created new developer snapshots for testing.

I didn't phrase my comment somewhere about "future snapshot TBA" as I had 
intended.  I just meant some future snapshot, not that I was requesting one for 
this patch.  But thank you very much anyway.  I'll sort out with Marco whether the 
Python end of the OP's issue patch should go into pythonX.X-test or pythonX.X 
itself, separately.  BTW The whole set of Python tests might serve to test Cygwin 
in a manner we haven't seen|used yet...
Cheers,

..mark
