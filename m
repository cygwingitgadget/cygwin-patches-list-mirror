Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id 6D8033851C39
 for <cygwin-patches@cygwin.com>; Mon, 20 Jul 2020 15:41:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 6D8033851C39
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MPGNn-1kBcII3cvF-00PfQ9 for <cygwin-patches@cygwin.com>; Mon, 20 Jul 2020
 17:41:39 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 46288A82B92; Mon, 20 Jul 2020 17:41:39 +0200 (CEST)
Date: Mon, 20 Jul 2020 17:41:39 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: mmap: fix mapping beyond EOF on 64 bit
Message-ID: <20200720154139.GL16360@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200720133442.11432-1-kbrown@cornell.edu>
 <20200720142303.GJ16360@calimero.vinschen.de>
 <ceb31948-ec43-3bf1-a164-53b54828535f@cornell.edu>
 <3d3597af-7bb8-bc83-2522-9282566f80b8@cornell.edu>
 <d1ac7543-34a2-90c6-07b4-96d90142df34@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1ac7543-34a2-90c6-07b4-96d90142df34@cornell.edu>
X-Provags-ID: V03:K1:2ayEuq8TAQZZ9NqpYt8diMZwtscmKueOgPpVFmBTqyW2puBnDy3
 EiTE9NJDuNY/gBQK2yfttmrvE9d4OZ4QeWBvalhErIbOe8wBNGsVDf7Od9eenUNHlFiX5rF
 onz8Nof00/F6rvjp7xGpNgf/FcxLlpsWDg4YURFwR89zZw1bHIcrIUC9etkdd3Qv1DuEoOL
 RHbNIBfEWRYA7JbGi57RQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zpQRCAqHQtU=:z7R7nWqgiE+JENpX8Zi6XZ
 AY6Qu3J5Fr4oIScnHLHBltKzvpLlmp1blAM/YLoHlxaNmfhIhiLy7mUhIoAZPhGho6MNbM8Yl
 KTQuff9uglkItNaRjVNhdWUpdH022jL/otvaFomwQESO07/XAbb9My/DQZOsy5+F9Hk7CgczZ
 2FXcDH4HMBl51G13POs8fYLWsXnUwbaVEMFsF52Qazt5MoMWSjAQ3cGovRXbmaVAnLwJ8Qsw0
 RH3/U8OJmWn0LqqoVgrxLrq+Uv48tM8vFvastPgtiEZYi7NfymyDLRsAH7xGl1HGV68I+MEGQ
 bz+tXpEkfckBCTDI7fdjjpfn4O7k//JFaoCkoB+HK6ntL6fU4Oc1zFGpgdukX/LPxDhxNCcFb
 wcXFiVc5Tb+nJMw6N8MCJjPWImbG8YVcCw57QZkAbdjvTFhPUA33l7YEd1C1LemiUEvYDS4Kq
 JUcI+g5FP+fBlxbPnUqFlKBm8e/wQsI9jzYXAjHPFIYJPmXUHUZMIclh+JahsliLD5aMnZ0MS
 qcO4ZHxNA5YrnX61/FfHCwBSgenG6ze2m1l6ehzcZm9RPwke9Mz4UuByGLTVkPkdStV/jblTd
 kMPfFfG3lrvSy9anyU9wL8CzyEnFufB9cZ4Vo+vwsc2jco4GIgiRgu4ZHhdxPiWOmeNN15an+
 quFu3czZk+Hk8vwSxPh1xSmZiTZF1FFQgdNJwHwryffA9OznYfpJYbmTRIBKTitkzwLGD9Uyp
 NBp3vzTKkNSAe0g1w2gn3s+GLH62brsjr2J7p3n1Taa8PiDJPdbpMXm0LGPxmFqIHMXXL0Bv6
 dbYvS7wWJGsrP09tJyAUL0h75z5bjH8GMoondtASFapVBHjCrwHUyaRxqBoN7dQ7a6cB4AMm7
 PsRf/BGZSXRqMN0hQAxg==
X-Spam-Status: No, score=-102.9 required=5.0 tests=BAYES_00, BODY_8BITS,
 GIT_PATCH_0, GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Mon, 20 Jul 2020 15:41:44 -0000

On Jul 20 10:58, Ken Brown via Cygwin-patches wrote:
> On 7/20/2020 10:49 AM, Ken Brown via Cygwin-patches wrote:
> > On 7/20/2020 10:43 AM, Ken Brown via Cygwin-patches wrote:
> > > On 7/20/2020 10:23 AM, Corinna Vinschen wrote:
> > > > On Jul 20 09:34, Ken Brown via Cygwin-patches wrote:
> > > > > Commit 605bdcd410384dda6db66b9b8cd19e863702e1bb enabled mapping beyond
> > > > > EOF in 64 bit environments.  But the variable 'orig_len' did not get
> > > > > rounded up to a multiple of 64K.  This rounding was done on 32 bit
> > > > > only.  Fix this by rounding up orig_len on 64 bit, in the same place
> > > > > where 'len' is rounded up.
> > > > > 
> > > > > One consequence of this bug is that orig_len could be slightly smaller
> > > > > than len.  Since these are both unsigned values, the statement
> > > > > 'orig_len -= len' would then cause orig_len to be huge, and mmap would
> > > > > fail with errno EFBIG.
> > > > > 
> > > > > I observed this failure while debugging the problem reported in
> > > > > 
> > > > >    https://sourceware.org/pipermail/cygwin/2020-July/245557.html.
> > > > > 
> > > > > The failure can be seen by running the test case in that report under
> > > > > gdb or strace.
> > > > > ---
> > > > >   winsup/cygwin/mmap.cc | 1 +
> > > > >   1 file changed, 1 insertion(+)
> > > > > 
> > > > > diff --git a/winsup/cygwin/mmap.cc b/winsup/cygwin/mmap.cc
> > > > > index feb9e5d0e..a08d00f83 100644
> > > > > --- a/winsup/cygwin/mmap.cc
> > > > > +++ b/winsup/cygwin/mmap.cc
> > > > > @@ -1144,6 +1144,7 @@ go_ahead:
> > > > >        ends in, but there's nothing at all we can do about that. */
> > > > >   #ifdef __x86_64__
> > > > >         len = roundup2 (len, wincap.allocation_granularity ());
> > > > > +      orig_len = roundup2 (orig_len, wincap.allocation_granularity ());
> > > > 
> > > > Wouldn't it be simpler to just check for
> > > > 
> > > > -      if (orig_len - len)
> > > > +      if (orig_len > len)
> > > > 
> > > > in the code following this #if/#else/#endif snippet?
> > > 
> > > I don't think so, because we also want to use the rounded-up value
> > > of orig_len further down when we set sigbus_page_len
> > 
> > Actually we first modify orig_len in 'orig_len -= len;' and then use it
> > to set sigbus_page_len.  In any case, I think it needs to be rounded up
> > before being used.

Oh, right.  Now I see what you mean.  At this point orig_len is still
the actual exact size of the file.  We only can create the SIGBUS
pages starting the next allocation granularity, so, yeah, it makes
sense to align orig_size to allocation granularity here.

> If you agree, maybe I should modify the commit message to make this point clear.

Might make sense, yeah.

While looking into this, I found another bug.  The valid_page_len
is wrong on 32 bit systems as well.  That was supposed to be the
remainder of the allocation granularity sized block the file's EOF
is part of, but

  valid_page_len = orig_len % pagesize;

is the size of the file's map within that 64K block, not the size of the
remainder.  That should have been

  valid_page_len = pagesize - orig_len % pagesize;

so this didn't work correctly either.

Ultimately, I wonder if we really should keep all the 32 bit OS stuff
in.  The number of real 32 bit systems (not WOW64) is dwindling fast.
Keeping all the AT_ROUND_TO_PAGE stuff in just for what? 2%? of the
systems is really not worth it, I guess.

Feel free to apply this patch.


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
