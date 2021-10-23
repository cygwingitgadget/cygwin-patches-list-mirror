Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id 252043858416
 for <cygwin-patches@cygwin.com>; Sat, 23 Oct 2021 05:35:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 252043858416
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 19N5Z4uq030740
 for <cygwin-patches@cygwin.com>; Fri, 22 Oct 2021 22:35:04 -0700 (PDT)
 (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "[192.168.1.100]"
 via SMTP by m0.truegem.net, id smtpdpf3C6S; Fri Oct 22 22:34:59 2021
Subject: Re: [PATCH] Cygwin: Make native clipboard layout same for 32- and
 64-bit
To: cygwin-patches@cygwin.com
References: <20211007052237.7139-1-mark@maxrnd.com>
 <20211008185210.cac713f28dea727a1467cf94@nifty.ne.jp>
 <29514de9-0d19-0d22-b8e1-3bfbce11589b@cornell.edu>
 <7dd31f61-43a1-4e4d-2e1a-dc79606263d5@dronecode.org.uk>
 <037a8027-8969-df1e-ccb5-6a736578cec5@cornell.edu>
 <6de24f8c-bd21-cd4f-18ff-ece3fef85b89@maxrnd.com>
 <ee8b46bd-f8f4-85da-be25-233c3cb60c71@cornell.edu>
 <YXLUkU6Nc3qAXLyp@calimero.vinschen.de>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <12fea3e3-92ae-2a33-81ea-808bdcc20f2a@maxrnd.com>
Date: Fri, 22 Oct 2021 22:35:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <YXLUkU6Nc3qAXLyp@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Sat, 23 Oct 2021 05:35:07 -0000

Hi all,

Corinna Vinschen wrote:
> On Oct 11 08:11, Ken Brown wrote:
>> On 10/11/2021 2:13 AM, Mark Geisert wrote:
>>> It's just that after submitting the patch I realized that, if we really
>>> are going to support both Cygwin archs (x86_64 and i686), there is still
>>> the issue of different cygcb_t layouts between Cygwin versions being
>>> ignored.
>>>
>>> Specifically, the fhandler_clipboard::fstat routine can't tell which
>>> Cygwin environment has set the clipboard contents.  My original patch
>>> takes care of 32-bit and 64-bit, providing both are running Cygwin >=
>>> 3.3.0 (presumably).  What if it was a different version (pre 3.3.0) that
>>> set the contents?
>>
>> I wonder if this is worth the trouble.  Right now we have a problem in which
>> data written to /dev/clipboard in one arch can't be read in the other arch.
>> The fix will appear in Cygwin 3.3.0.  Do we really have to try to make the
>> fix apply retroactively in case the user updates one arch but not the other?
> 
> Just to close this up prior to the 3.3.0 release...
> 
> Given we never actually strived for 32<->64 bit interoperability, it's
> hard to argue why this should be different for the clipboard stuff.
> 
> Running 32 and 64 bit Cygwin versions in parallel doesn't actually make
> much sense for most people anyway, unless they explicitely develop for
> 32 and 64 bit systems under Cygwin.  From a productivity point of view
> there's no good reason to run more than one arch.
> 
> So I agree with Ken here.  It's probably not worth the trouble.

Sorry, I've been sidetracked for a bit.  I can agree with Ken too.  The only 
circumstance I could think of where multiple internal format support might be 
useful (to non-developers) was some user hanging on to an older Cygwin because it 
was needed to support something else (s/w or h/w) old and non-upgradeable. 
Doesn't seem very likely at this point.

I'll try to get the v2 patch out over this weekend.  Same end-result for same 
environments as the v1 patch, but incorporating all the comments I received.

To that end, does Jon's suggestion of /usr/include/sys/cygwin.h seem like the best 
location to define struct cygcb_t for use by both Cygwin and cygutils package?
Thanks much,

..mark
