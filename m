Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id 67D573858D28
 for <cygwin-patches@cygwin.com>; Mon, 11 Oct 2021 06:13:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 67D573858D28
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 19B6DmUD049939
 for <cygwin-patches@cygwin.com>; Sun, 10 Oct 2021 23:13:48 -0700 (PDT)
 (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "[192.168.1.100]"
 via SMTP by m0.truegem.net, id smtpdVV0585; Sun Oct 10 23:13:41 2021
Subject: Re: [PATCH] Cygwin: Make native clipboard layout same for 32- and
 64-bit
To: cygwin-patches@cygwin.com
References: <20211007052237.7139-1-mark@maxrnd.com>
 <20211008185210.cac713f28dea727a1467cf94@nifty.ne.jp>
 <29514de9-0d19-0d22-b8e1-3bfbce11589b@cornell.edu>
 <7dd31f61-43a1-4e4d-2e1a-dc79606263d5@dronecode.org.uk>
 <037a8027-8969-df1e-ccb5-6a736578cec5@cornell.edu>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <6de24f8c-bd21-cd4f-18ff-ece3fef85b89@maxrnd.com>
Date: Sun, 10 Oct 2021 23:13:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <037a8027-8969-df1e-ccb5-6a736578cec5@cornell.edu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.4
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
X-List-Received-Date: Mon, 11 Oct 2021 06:13:52 -0000

Ken Brown wrote:
> On 10/9/2021 10:29 AM, Jon Turney wrote:
[...]
>>> On 10/8/2021 5:52 AM, Takashi Yano wrote:
[...]

Thanks all for the comments; much appreciated.  They'll be factored into v2 in one 
form or another.  I pronounced my original patch "bad" not because of any problem 
with code operation or struct cygcb_t definition.  I used anonymous union and 
anonymous struct internally to mostly realize what Takashi suggested for layout, 
just naming the items cb_* rather than tv_* or other.  The code works as intended, 
32- and 64-bit.

It's just that after submitting the patch I realized that, if we really are going 
to support both Cygwin archs (x86_64 and i686), there is still the issue of 
different cygcb_t layouts between Cygwin versions being ignored.

Specifically, the fhandler_clipboard::fstat routine can't tell which Cygwin 
environment has set the clipboard contents.  My original patch takes care of 
32-bit and 64-bit, providing both are running Cygwin >= 3.3.0 (presumably).  What 
if it was a different version (pre 3.3.0) that set the contents?

So I'm working on a heuristic to identify which cygcb_t layout is present in the 
clipboard data.  This will hopefully distinguish between the 3 historical cygcb_t 
layouts as well as x86_64 differing from i686 for each one.
Stay tuned,

..mark
