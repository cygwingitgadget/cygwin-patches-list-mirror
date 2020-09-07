Return-Path: <Johannes.Schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by sourceware.org (Postfix) with ESMTPS id 09DE63861035
 for <cygwin-patches@cygwin.com>; Mon,  7 Sep 2020 21:08:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 09DE63861035
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=Johannes.Schindelin@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1599512887;
 bh=IDIzZJCj/KA6G0WCAT5FeltTwXvHEYW5540DnMFp6So=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=ipCJSRRZpr11TuM48nPtO5GtjigrIPAbUdfuihqm4an/n7EReoFojq2q/ZGQjeAPr
 02b9Ic5sVbCCZXMfPIFaG7FQKe2OY+yvLsTwzYmnUHAJzFm/wGNNjX7+2HLuso9+bT
 G9743UhsvSz5HWo3fum2KLP8rDOKtZst16qMm8r0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.169.176] ([89.1.215.223]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDhhN-1kMmsj4Ajv-00AnFw; Mon, 07
 Sep 2020 23:08:07 +0200
Date: Mon, 7 Sep 2020 23:08:03 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset
 == "UTF-8"
In-Reply-To: <20200907183659.5150b2a8f296e4df13b1df1c@nifty.ne.jp>
Message-ID: <nycvar.QRO.7.76.6.2009072252550.56@tvgsbejvaqbjf.bet>
References: <20200902195412.aa7f233231d893a7a065b691@nifty.ne.jp>
 <20200902152450.GJ4127@calimero.vinschen.de>
 <20200903012500.640e36573c67328fc3e1bc70@nifty.ne.jp>
 <20200902163836.GL4127@calimero.vinschen.de>
 <20200903175912.GP4127@calimero.vinschen.de>
 <20200904182149.18cd752eef58c67ee8d39135@nifty.ne.jp>
 <20200904124400.GQ4127@calimero.vinschen.de>
 <20200904235016.9c34d04e809b5ad9f2bdfdf3@nifty.ne.jp>
 <20200904192235.GW4127@calimero.vinschen.de>
 <20200905174301.adbb3c147122fbe0636a0d56@nifty.ne.jp>
 <20200907082633.GC4127@calimero.vinschen.de>
 <20200907183659.5150b2a8f296e4df13b1df1c@nifty.ne.jp>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WbyOtZoyjClUfRoByCxwpYKjcd7rkg6XB2UoQAoBm7oeM1hYicG
 trIjkUvibTCzOUv8Zqyc6JZRGIsgaFeJ7W9jkMC0/BR29PiwUCMhI6eRscSISz3OAin1jk1
 0zFCmpu4vPQqZNNu9IxtR/72egjBq01irpRPZvOEq/2ZDrrL7bW+TDVPKAe6n0LaT5GAyWc
 wTucxDngCeu0PVXwxXq5w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VwplGHcxQ3o=:3tFDdf5bVF2APXmbBM5ije
 u2KBa9gd3LoIIODMjOYJvo4AS+HZhyz4NXHuK+r2z6//sbAXoai65MEYOSJmkUKDTfKj7Ue16
 kZbEzLgUb0EUmoLdy3QTWF6ltFNiQqrZXM7QQfbpbxPKSXTz9cqxmYgjQwc9J7CE2M8nJRvbW
 kkFG0ufK3In74i6vATDNgP0yn7YcN+2rmxQqBK1Hzvp90ekQ7Yymek6pctoOOs/nwwDoXq/4k
 NpXkLKuzcGnZUKMrL2vOUeFvmSOhS55pYAEYdu9NAw7eKGE7tPvxFwNztnVanUgVkC2DGLwaK
 FpxSgQvdF+/iUj9Hrfb95KGRJXrVQQbGQfLoHzyNJq5aM1XA5oH2jsj6fSTgjB0vLqYIDniXs
 JYnxcxCoXDMAfYpXKD4Q2YUz/7NEtlQoq2qLGszStuaSDmZxCiALee78qKKP0+QGGTGbFhjzw
 41NN13G3CfIOE6NUEOYV+cRxNFIflESOIKF2WMcgxlK5Kwyd/zOjEW0wU/04QjAqlJdO2DgCR
 S/ax/BrckEg/Rutff1JPQblV4/zC+sO38RQ4+Yo96SH01oK7AKNnTMnGnS0G9LBLl2nI9SlEu
 E4uVXbZb5wRYYkCOUywkf+Aui+XvotBL3a1vEl1UrHMiUf8dZYBJxFa5bNWrMnk96Y9h2OlkQ
 KsWyUx7XDZJFzO8N/9ddRMB7GxwPzpbGOlxNjlQ75P90uwNHL59sB09Gm/wLsYEFqd0BcMdbn
 +JA8iED2J2Wrob/ASyZBksbqutEUXme71E48KyDPs92IJOaER3btFpLJgho6x3dGp9mLyjdci
 Te+cFwgyLipRkTqrKStQLrVVTDjQAjNPVPQOcrpRFgHa43Tq6VHYsw13ErYX8mGSwnZx16s7I
 ToUHVqnVzDUUJEeC8jOOTUSo97N4C+Z1FnvNQjcn7tgUuJSRS3KL/H+G5lcHQ8KlIqClWfR8I
 sgaWIOimPmWtETdllOrGFiGxaFy3+M2ViyOsStfIyqs5iA9jTiz3wSLbCl1rkFMv+Y6yBYpVs
 tAGrXkXtSsk72YG5plpMSfFXKIqD2ioV7naetQq7tfPkIBBmpvnu6C1LzSTIy96t9ruN8i+Ks
 lwPTu2Y/OUaN8AgMxarE1VT8NlYmFfNEUeFsx0NCT/XI6quRR/1C3C5MPVBn+a2g842MILceC
 cRGvr4mleQAwclprXsloHIQcvrcZvmAsUQkF8waZSQjMQZoGbqbolqJ9zs1paZWYS1xh6QmX1
 F+tvYuDDDjLfydFtu6AF22S9v1KOZUUEE092RxQ==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, FREEMAIL_FROM, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE,
 SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Mon, 07 Sep 2020 21:08:15 -0000

Hi,

On Mon, 7 Sep 2020, Takashi Yano via Cygwin-patches wrote:

> On Mon, 7 Sep 2020 10:26:33 +0200
> Corinna Vinschen wrote:
> > Hi Takashi,
> > On Sep  5 17:43, Takashi Yano via Cygwin-patches wrote:
> > > On Fri, 4 Sep 2020 21:22:35 +0200
> > > Corinna Vinschen wrote:
> > >
> > > > Btw., the main loop in
> > > > fhandler_pty_master::pty_master_fwd_thread() calls
> > > >
> > > >   char *buf =3D convert_mb_str (cygheap->locale.term_code_page,
> > > >                               &nlen, CP_UTF8, ptr, wlen);
> > > >                                      ^^^^^^^
> > > >   [...]
> > > >   WriteFile (to_master_cyg, ...
> > > >
> > > > But then, after the code breaks from that loop, it calls
> > > >
> > > >   char *buf =3D convert_mb_str (cygheap->locale.term_code_page, &n=
len,
> > > >                               GetConsoleOutputCP (), ptr, wlen);
> > > >                               ^^^^^^^^^^^^^^^^^^^^^
> > > >   [...]
> > > >   process_opost_output (to_master_cyg, ...
> > > >
> > > > process_opost_output then calls WriteFile on that to_master_cyg ha=
ndle,
> > > > just like the WriteFile call above.
> > > >
> > > > Is that really correct?  Shouldn't the second invocation use CP_UT=
F8 as
> > > > well?
> > >
> > > That is correct. The first conversion is for the case that pseudo
> > > console is enabled, and the second one is for the case that pseudo
> > > console is disabled.
> > >
> > > Pseudo console converts charset from console code page to UTF-8.
> > > Therefore, data read from from_slave is always UTF-8 when pseudo
> > > console is enabled. Moreover, OPOST processing is done in pseudo
> > > console, so write data simply by WriteFile() is enough.
> > >
> > > If pseudo console is disabled, cmd.exe and so on uses console
> > > code page, so the code page of data read from from_slave is
> > > GetConsoleOutputCP(). In this case, OPOST processing is necessary.
> >
> > This is really confusing me.  We never set the console codepage in the
> > old pty code before, it was just pipes transmitting bytes.  Why do we
> > suddenly have to handle native apps running in a console in this case?=
!?
>
> This is actually not related to pseudo console. In Japanese environment,
> cmd.exe output CP932 string by default. This caused gabled output in old
> cygwin such as 3.0.7. The code for the case that pseudo console is
> disabled is to fix this.

It is related to Pseudo Console insofar as it was slipped in as part of
the Pseudo Console patches.

And what Takashi reports as a bug fix is the underlying reason for the
tickets in MSYS2 (and elsewhere) that I mentioned.

In fact, I even suggested in
https://github.com/msys2/MSYS2-packages/issues/1974#issuecomment-685475967
to revert that change.

What Takashi describes as "correct behavior" unfortunately seems not to be
very common in practice, which is why I contend that from the users' point
of view, it could not matter less whether the console applications are
"correct" or not. From the point of view of users who have their `LANG`
set to something like `en_US.UTF-8`, the encoding was correct before, and
now it is no longer correct. And _that_ is the correctness users actually
care about.

Ciao,
Dscho
