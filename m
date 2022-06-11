Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com
 [210.131.2.81])
 by sourceware.org (Postfix) with ESMTPS id 5BB933939E15
 for <cygwin-patches@cygwin.com>; Sat, 11 Jun 2022 12:30:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 5BB933939E15
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 (ak044095.dynamic.ppp.asahi-net.or.jp [119.150.44.95])
 (authenticated)
 by conssluserg-02.nifty.com with ESMTP id 25BCToGv025416
 for <cygwin-patches@cygwin.com>; Sat, 11 Jun 2022 21:29:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 25BCToGv025416
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1654950591;
 bh=xBe6ZbnBkaSnxOVQe8BvbIphk5oFSrjLKJUGZOeQfRk=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=Hn1xe893VYVDsaNeZf1bIFnRCnj7QEwxGIwjGsFSPvQOhwFXyrrXX8VPUnGe/IC1t
 RewTy0lzniPN5tsewMBfOj3bGFOle1X7SkFIHYZLMZXWk1KPmEJU2Hz7jh+V3G6cvI
 2D7MAgGZxKeapQnD5/o/MX+cpj72MXwjt1OVo3KBYo2XQZ4GJlXfi7ITQA76lIGCku
 6LTkdNE9dhGtiKyt07WUlL6M+/OCtarvosqF+FQK33CFLGmMPby0HvNuVTu7LPSZz9
 WXHCmY/kZFg3SLQmefxk2okmlPJThJSJNle7mK0BAPbii7lKFrzet5FjSY4C77o+b8
 OPgs+6ZhyeLqA==
X-Nifty-SrcIP: [119.150.44.95]
Date: Sat, 11 Jun 2022 21:29:50 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 7/7] Cygwin: remove miscellaneous 32-bit code
Message-Id: <20220611212950.2fdc71e56243330266c4fc76@nifty.ne.jp>
In-Reply-To: <97cc06bf-913b-864f-673d-71dc8dfbc64c@cornell.edu>
References: <2de3539b-efc2-b6f1-b9e3-8429ecb24c0b@cornell.edu>
 <ce7de251-14d1-e54d-e2ef-5b67ad256a64@dronecode.org.uk>
 <c5bec956-6e71-083e-f3bf-f6b52726b218@cornell.edu>
 <YqIQX4HJ8lXveQdx@calimero.vinschen.de>
 <d4c98759c0e3d7fcc72e13566d7c00d71a52bb52.camel@cygwin.com>
 <97cc06bf-913b-864f-673d-71dc8dfbc64c@cornell.edu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00, BODY_8BITS,
 DKIM_SIGNED, DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Sat, 11 Jun 2022 12:30:09 -0000

On Thu, 9 Jun 2022 15:04:29 -0400
Ken Brown wrote:
> On 6/9/2022 12:00 PM, Yaakov Selkowitz wrote:
> > On Thu, 2022-06-09 at 17:23 +0200, Corinna Vinschen wrote:
> >> On May 29 17:26, Ken Brown wrote:
> >>> On 5/29/2022 9:39 AM, Jon Turney wrote:
> >>>> On 26/05/2022 20:17, Ken Brown wrote:
> >>>>>    winsup/cygwin/autoload.cc                | 136 ---------------------
> >>>>> --
> >>>>
> >>>> Looks good.
> >>>>
> >>>> I think that perhaps the stdcall decoration number n is unused on
> >>>> x86_64, so can be removed also in a followup?
> >>>
> >>> Thanks, I missed that.
> >>>
> >>> Also, I guess most or all of the uses of __stdcall and __cdecl can be
> >>> removed from the code.
> >>
> >> Yes, that's right, given there's only one calling convention on 64 bit.
> >>
> >> I have a minor objection in terms of this patch.
> >>
> >> When implementing support for AMD64, there were basically 2 problems to
> >> solve. One of them was to support 64 bit systems, the other one was to
> >> support AMD64.  At that time, only IA-64 and AMD64 64 bit systems
> >> existed, and since we never considered IA-64 to run Cygwin on, we
> >> subsumed all 64 bit code paths under the __x86_64__ macro.
> >>
> >> But should we *ever* support ARM64, as unlikely as it is, we have to
> >> make sure to find all the places where the code is specificially AMD64.
> >> That goes, for instance, for all places calling assembler code, or
> >> for exception handling accessing CPU registers, etc.
> >>
> >> I'm open to discussion, but I think the code being CPU-specific
> >> should still be enclosed into #ifdef __x86_64__ brackets, with an
> >> #else #error alternative.
> >>
> >> Right?  Wrong?  Useless complication?
> > 
> > Highly recommended.
> 
> OK, I'll make that change.

Isn't the _dll_crt0() code in dcrt0.cc also x86_64 specific?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
