Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com
 [210.131.2.82])
 by sourceware.org (Postfix) with ESMTPS id 418BD3858405
 for <cygwin-patches@cygwin.com>; Sat, 11 Dec 2021 13:40:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 418BD3858405
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from Express5800-S70 (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id 1BBDeSri021973;
 Sat, 11 Dec 2021 22:40:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 1BBDeSri021973
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1639230028;
 bh=wwEPGYjeUrBSu0wkbiQ63QkikT8TsaHApuM3tgFfPOk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=iBRuNaIS+8U2ug315U6pESboeRjiPRKlHb/sIQjefkFD8uC/H8PMirv/pofbWxWew
 MOsVCNz5G95NW3vhxkVxkImbsXzRhabpXh7MFwzl0SlpogqT9bEUyLGpIvD0R5CUEg
 Zl/+L3k7agfoANmJLSiOp8wJseCNpqPSM1ANMFbeCEYcVAk5hySLAzNzGHIGO5sDrT
 99r52xNt21GehEHPcfNjF/pjuUF4fpmNq7sq9EzispMpHh1MWV8G7n8n6SweDto6vQ
 EnQC5TwHkNfqAVoAoumHkycnhAd8VjYJh6nFDEyi+ClA6wF/XaZ6ZDPZraGdJUi9vQ
 Vbv+MXBcI2azg==
X-Nifty-SrcIP: [110.4.221.123]
Date: Sat, 11 Dec 2021 22:40:30 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Reduce unecessary input transfer.
Message-Id: <20211211224030.bf6dc202f01bdd2f4eff32d9@nifty.ne.jp>
In-Reply-To: <nycvar.QRO.7.76.6.2112101152320.90@tvgsbejvaqbjf.bet>
References: <20210211090942.3955-1-takashi.yano@nifty.ne.jp>
 <nycvar.QRO.7.76.6.2112092345060.90@tvgsbejvaqbjf.bet>
 <20211210192040.71f88b263b8c20f2f61db310@nifty.ne.jp>
 <nycvar.QRO.7.76.6.2112101152320.90@tvgsbejvaqbjf.bet>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_PASS,
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
X-List-Received-Date: Sat, 11 Dec 2021 13:40:53 -0000

On Fri, 10 Dec 2021 12:12:44 +0100 (CET)
Johannes Schindelin wrote:
> On Fri, 10 Dec 2021, Takashi Yano wrote:
> > Could you please test if the following patch solves the issue?
> 
> It does!

It seems that you already apply this patch to msys2, however,
this is just an experimental patch to identify the cause of
the problem.

Please wait a while for actual patch.

> However, I am a bit frustrated because there is still a lot light-shedding
> to be done. In the current shape of the code, I do not even understand
> what it does, let alone why it works around the problem.
> 
> For example, why is there such a long `pcon` stuff going on? I am in the
> _disabled_ pseudo console mode, for starters. Like, why is there a
> `pcon_input_state`? And why has the `disable_pcon` code path changed at
> all (there was no need to touch it, was there)?
> 
> Also, `needs_xfer` clearly means `needs transfer`. What transfer? What's
> `masked`? And how does it differ from `mask`?
> 
> I fear that the pseudo console/non-pseudo console code currently has a
> lottery factor of 1. I spent a good part of three entire working days
> pouring over it, and I still do not understand it. Usually, a combination
> of reading the commit messages, reading the code, parsing
> function/variable names with a sprinkling of intuition gets me very far in
> understanding any kind of legacy code, but not here. And I do _a lot_ of
> legacy code hacking, as part of maintaining Git for Windows. The pseudo
> console code in Cygwin really is a class of its own in this regard.
> 
> And I have the very strong sense that it does not have to be that way.
> 
> I would really like it if the code in `fhandler_*` could see some tender,
> loving care, bringing clarity about, for example clearly distinguishing
> between the code paths that use pseudo console support vs not, and code
> paths regarding Cygwin processes vs not.
> 
> I mean, even if your diff below is short, I cannot review it. Not the
> context, not my study of three days of the surrounding code and the commit
> messages, none of that equips me with enough knowledge to even spot an
> obvious bug, because such a bug would still not be obvious to me.
> 
> I really hope that this can be fixed. Please let me know if there is
> anything I can do to help bring this about.

The current pty code is too complicated indeed. :(
It is very difficult to explain how it works.

Basically, pty has two pairs of pipes, one is for cygwin apps
(io_handle/output_handle), the other is for non-cygwin app (
io_handle_nat/output_handle_nat). This is because these pipe-
pairs are processed differently even without ConPTY.

Outputs to output_handle_nat is forwarded to output_handle by
pty_master_fwd_thread after appropriate processing.

Input from keyboard is switched between two input pipes, i.e.
io_handle and io_handle_nat. When the cygwin-app is activated,
input from keyboard is sent to io_handle, and when the non-
cygwin app is activated, input from keyboard is sent to
io_handle_nat. This switching is done based on switch_to_pcon_in
and pcon_input_state. The name of this variable and related
function is *pcon*, however, these are also used for non-cygwin
apps even without ConPTY by historical reason.

While non-cygwin app is activated, switch_to_pcon_in is true
and pcon_input_state == to_nat. However, if the cygwin-app is
started from non-cygwin app, input from keyboard should be sent
to io_handle. This is done using mask_switch_to_pcon_in(). By
this function, input is temporary sent to io_handle even if
switch_to_pcon_in is true.

The function transfer_input() is used to transfer type ahead
inupt between two input pipes, i.e. io_handle and io_handle_nat.
Masking switch_to_pcon_in state by mask_switch_to_pcon_in() is
done in read() and select(), so input while read() or select()
is NOT called is sent to io_handle_nat rather than io_handle
if switch_to_pcon_in is true. The bug to be fixed now is just
the case.

So, transferring input from io_handle_nat to io_handle solves
the issue in this case. The patch I have sent yesterday is to
add this missing action.

In addition, this problem does not occur if ConPTY is enabled.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
