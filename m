Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id 95B113857C76
 for <cygwin-patches@cygwin.com>; Wed, 26 Aug 2020 17:33:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 95B113857C76
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MvbJw-1kQrhF0YTu-00sd9e; Wed, 26 Aug 2020 19:33:47 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 585C6A83A75; Wed, 26 Aug 2020 19:33:45 +0200 (CEST)
Date: Wed, 26 Aug 2020 19:33:45 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fix incorrect code page when setting console title on
 Win10
Message-ID: <20200826173345.GO3272@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,
 Takashi Yano <takashi.yano@nifty.ne.jp>
References: <tencent_DEAF96B572731C3B3E524F22CCAC86D3AD07@qq.com>
 <20200826090625.GN3272@calimero.vinschen.de>
 <nycvar.QRO.7.76.6.2008260919460.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.2008260919460.56@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:QdwvYFdJGk6+s9GnRPraGrsCiwSeTtuQ9SQDU5s9Je0Ouw2bCXw
 V/k1+qoXN3Mpu7JbybSfAq/tBOp8UKJBLhQh5vpXdqqgzut0jXmz6u3gVcB1lcu+LrFyHaP
 4SK53uuMsIYXCJw3YKEELiT1ZSnpzcDzprer/7w3Y8wG20ZJ+77d6lPviHh2MsRKNvWdti6
 xZ3VovZF8A2SS9vTYd8hQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1Qvf6szX5iw=:icM4uwEqq6sKwlyAkKj8zO
 IJ1kRJdlpfPPZ0YOyu+6VxYx9OZfeomJuie/k0fl+ODEG/oegItX5s2x2JM0Mdtr0olsZfVus
 bwsVRlH7Wz1iEJViaBd+3ZQsm5yBgSWHI/5Hi6nV6NTr+Bj2rtoVYKhpWLSkWfKxLMOkd5PZU
 kW7/Y46W/5DaecTmMcrxNGPZkFh5ZSBpy2jXgqa4oRfZIrr+Gk0H55re1E5HS3W92lSaK4USX
 BFv089W+fEHrWuC+jZztqEb6nrFo9HfCiTQgQ9EzNakROgAEzJ0lpisACaF3MMjCfxVZhsMdJ
 Z1zih+S5OTi3mvCDXCgcIs6+9zsKVqUC7kJ1dAmu9IWai/mu1QKUSo322KeKSnQX4gOv2lihc
 5Ffp9HPLFyoyWmXpVl5Nta1LZ1TVLG5lPcKSJnu9jGi9BQ2hlNhdU9XlcADGiowUKC2UogzvL
 QrDSUnzn8nxaQnZ+SJa/ifATrU0sGpqsZdy6dALmg9JqSuqccAtt5/hLdigFVrl+tZ0U3I66b
 8ON7ocqHUviT+6hq5Dn4lFyzdi2lUB0kFf2gEU67LM/yKUG0xaSEROJ7P9GWSbWQH4FugXf/c
 wW1bDJ0eVRyjPEPngB5EWIUmCybwKyhDw9rf0PIJUZ/klkz/HpDqehCU4mRN6v8GuGyq42cpl
 PmY9+cRPczzGA/+b9VOiBo6n6P7+coAetvKFQMumxOK8fSkfAXtYHs9S5TWkJoynGcjId0FFE
 VjeMRpiyMO3XfC7PjLZCGeDYZuHMUyWbumDuVzCnXW1JGIc2yO5E/k9o3gKBmzM0j6OZfluVU
 EQcCfHs/8SuNFzS8cRPXMpS/riyXrA6+5TqF2xdwLQluWeALaDqutICo5yh3lEXq4K/7kKTRP
 4pY1unB10jJtYUBZJ1pg==
X-Spam-Status: No, score=-98.3 required=5.0 tests=BAYES_00, BODY_8BITS,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, KAM_NUMSUBJECT, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Wed, 26 Aug 2020 17:33:53 -0000

On Aug 26 09:30, Johannes Schindelin wrote:
> Hi Corinna,
> 
> On Wed, 26 Aug 2020, Corinna Vinschen wrote:
> 
> > On Aug 26 16:43, 宫大汉 via Cygwin-patches wrote:
> > > When Cygwin sets console titles on Win10 (has_con_24bit_colors &amp;&amp; !con_is_legacy),
> > > `WriteConsoleA` is used and causes an error if:
> > > 1. the environment variable of `LANG` is `***.UTF-8`
> > > 2. and the code page of console.exe is not UTF-8
> > > &nbsp; 1. e.g. on my Computer, it's GB2312, for Chinese text
> > >
> > >
> > > I've done some tests on msys2 and details are on https://github.com/git-for-windows/git/issues/2738,
> > > and I filed a PR of https://github.com/git-for-windows/msys2-runtime/pull/25.
> 
> Just in case you want to have a look at it, you can download the patch via
> https://github.com/git-for-windows/msys2-runtime/commit/334f52a53a2e6b7f560b0e8810b9f672ebb3ad24.patch
> 
> FWIW my original reviewer comment was: "why not fix wpbuf.send() in the
> first place?" but after having a good look around, that method seemed to
> be called from so many places that I "got cold feet" of that approach.
> 
> For one, I saw at least one caller that wants to send Escape sequences,
> and I have no idea whether it is a good idea to do that in the `*W()`
> version of the `WriteConsole()` function.

Yes, it is.  There's no good reason to use the A functions, actually.
They are just wrappers calling the W functions and WriteConsoleW
evaluates ESC sequences just fine (just given as UTF-16 chars).

> So the real question from my side is: how to address properly the many
> uses of `WriteConsoleA()` (which breaks all kinds of encodings in many
> situations because Windows' idea of the current code page and Cygwin's
> idea of the current locale are pretty often at odds).
> 
> The patch discussed here circumvents one of those call sites.
> 
> However, even though there have not been any callers of `WriteConsoleA()`
> in Cygwin v3.0.7 (but four callers of `WriteConsoleW()` which I suspect
> were converted to `*A()` calls in v3.1.0 by the Pseudo Console patches),
> there are now a whopping 15 callers of that `*A()` function in Cygwin
> v3.1.7. See here:
> [...]
> That cannot be intentional, can it? We should always thrive to use the
> `*W()` functions so that we can be sure that the expected encoding is
> used, right?

Takashi?  Any reason to use WriteConsoleA rather than WriteConsoleW?  If
at all, WriteConsoleA should only be used if it's 100% safe to assume
that the buffer only contains ASCII chars < 127.


Thanks,
Corinna
