Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id 303053858C55
 for <cygwin-patches@cygwin.com>; Thu, 14 Jul 2022 14:54:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 303053858C55
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MJmCV-1nwwM10eAz-00K7ji for <cygwin-patches@cygwin.com>; Thu, 14 Jul 2022
 16:54:12 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id B7713A80771; Thu, 14 Jul 2022 16:54:11 +0200 (CEST)
Date: Thu, 14 Jul 2022 16:54:11 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH rebase] Add support for Compact OS compression for Cygwin
Message-ID: <YtAuE1Po5QmnviT2@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <e281c355-1ea1-eefa-12d8-17f7538edb60@t-online.de>
 <Ys/u2QmY8E1s0hZd@calimero.vinschen.de>
 <ae3b7f6f-cb27-3ffa-3b47-300db32ffc25@t-online.de>
 <YtAoF7HvCTw177IB@calimero.vinschen.de>
 <f8f4e3af-c39b-415a-7d6e-5e9a7aa07162@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f8f4e3af-c39b-415a-7d6e-5e9a7aa07162@t-online.de>
X-Provags-ID: V03:K1:xaafs6bMk2vrFvQVFWQbWIQ/lLM9PoypI6QhVJnjWd7CX6vVf0f
 6CLx4QhgMR0gQDPmJpl2g3pS33OF/WEc01K9wFOWeF3HTg5poLxV0XzB+pE/t71cgoobVfy
 sjNBgJ+8Ro/2idgmsyEwfhXMw/Aktx25irhDovGStiux5fKojmHiMNRaECGTv47qjtCdJsA
 YLBht4RXTQ8soyqZEkaBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SLK4ik5EM64=:3dyLl/MtHFP0oJ6VxnhYeO
 +cDtywEebCgCknAivaweDQN7nPLdjUbaWoLUs1tfYfwXfZt13EwohFPG+tyz45Fp/ESRUPY6Q
 v7Zp9EVqB+bVeOWK9buXx7xKLp7nHfUs09NLLzJKmoZS/HwWBza49S51QdvAHsRUeUnC199+D
 r55ZUEAX8O1WzONdDh/dGexssHxKTmRwN0GDu+0jfeQG+XY4lzdntuIQwzuUmdDOcREPsLb3R
 CMIf2uIkEMSPHhCzfk+Rtws4ryxU0aW23Yi8n7A//y8apkziENsnaE8VT9cFGqCA+Pi1XAeks
 dygzp9o6CYH7/L2rAXosA1/+ovvsOl4nTs+QQZt3f+ImgNsbmlirU6qDQ9SPO4kk9a2hrtAU6
 CijdGVDnPlhkA1/FBUQHxbXUTeU2Vmc01ShKqT4fbDTXTYvYpSmJP1ZF3ifUjVO1t7opGSqMv
 k74VhR8/5YMPZWtzu410PmcxY9SygVUPyF5L6FCVHWgmKtNPvW1ydlpYFaXDcZw6rfSkNttwE
 /suvlr55qikfkg2+C4DPa8VPFaucq8E6VghdRm4elgBntNF0DvWOpuHlgOIbzH6CaLhAqMOT6
 fldWt3zRq3bVxaNKid1KALDed7ATpA2WOJF8nkQPlAYjy4PjgI6ncQo0Igws5WIfPnE4DgU3r
 XoVK04jhAJKZ8Tq2gzy1+wrlFScCLlAiCaslxn9WtJzWbZVWD6EW71L9S/Z1/AEdULyTovrmE
 JMeMC7j33yzwTxHhSoDJaSibSuiEdJCVsoEm55Xt+FbP5D2ePkoqKeR7wPI=
X-Spam-Status: No, score=-95.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_MSPIKE_H2,
 SPF_FAIL, SPF_HELO_NONE, TXREP,
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
X-List-Received-Date: Thu, 14 Jul 2022 14:54:16 -0000

On Jul 14 16:41, Christian Franke wrote:
> Corinna Vinschen wrote:
> > On Jul 14 14:12, Christian Franke wrote:
> > 
> > > > > +#endif
> > > > This ifdef still makes sense, of course ...
> > > Could possibly also be enhanced to __MSYS__ and msys1.dll.
> > Not sure this makes sense.  Does their installer support CompactOS?
> 
> No, AFIAK. Then only (nonexistent?) users who run 'compact /c /exe:lzx ...'
> manually on their installation would benefit.
> 
> 
> > > 
> > > > ... and on first glance, the
> > > > remainder of the patch LGTM.
> > > Thanks. Attached is an alternative patch with most ifdefs removed.
> > LGTM.  I'm not going to push it, yet, because... do you still want to
> > add the aforementioned MSYS support?  If not, I'll just go ahead.
> 
> Please go ahead. I don't want to add platform specific code not actually
> tested on that platform.

Pushed.


Thanks,
Corinna
