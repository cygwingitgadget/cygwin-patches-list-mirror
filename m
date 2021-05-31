Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id 09E8F3857807
 for <cygwin-patches@cygwin.com>; Mon, 31 May 2021 08:02:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 09E8F3857807
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M2NqA-1lpH2q0wLG-003wxl for <cygwin-patches@cygwin.com>; Mon, 31 May 2021
 10:02:42 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id A2AA7A80705; Mon, 31 May 2021 10:02:40 +0200 (CEST)
Date: Mon, 31 May 2021 10:02:40 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: respect PC_SYM_FOLLOW and PC_SYM_NOFOLLOW_REP
 with inner links
Message-ID: <YLSYIC/yYFz2IdMS@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <alpine.BSO.2.21.2105291322180.30039@resin.csoft.net>
 <alpine.BSO.2.21.2105291600460.30039@resin.csoft.net>
 <alpine.BSO.2.21.2105292259570.30039@resin.csoft.net>
 <alpine.BSO.2.21.2105301213380.30039@resin.csoft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.BSO.2.21.2105301213380.30039@resin.csoft.net>
X-Provags-ID: V03:K1:1XV85PtB+0zlNroLsO1MXO+eAnBueEfNghf8kopnsL5Oi+KtvdY
 InhFdFTK3S+aNK+f+5R9GJZZsknRGD+FW7dEM+xmZgJG3tGigtQEu7ZfsyfGd7kqpzswy8P
 xhs3AyPagg8/wa1G7EV0J3hulBclHghYTp1k8brdO2hcwIN0RyWI7pKRmzP5Op3oVIbpVSB
 2bSGm0eB78qdVZ80+v8dw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8ahdR6uHZTc=:lhOUO5wtMRkRW/8LOsKHqK
 pN08tCv74tKhTZpQEGKShAgCFKWQNIdcSMjupeeyWqFkdAfq3gZPzh0ZzhN1vaHWkf+hJYJWE
 lpxF944TTzxmEtmhE9V1YC4oFawUor5STLLlAwfLvjPAGyHyVCsATwABJWLDbY9SWUW+FjDZI
 QmbjuGcmxhbUFYhCl5F535nWlHkhoU1cNnOLJYcegeYh780k/eNjL7I27bP2ptUDI0lnP71vp
 a/KeN37RZWOIZOrlUfYTTqoCwbFmwOLewkI1uur47hwkBYP13qH0z8I+3V1h6VovuIp6loFNX
 uAjvqbkYNLqm0GT5NuMLBGrkAaC8BY/7ymBqAFqqnAUuIhAGulSSXAJldWdgv//mDcypYMYuq
 ARvHTieuvjpRyvHp26ZM3LRILDYI+oBMDFVGJ8yn6q9mnnBr3jfenICKsYccjOfxqweRjt1zM
 us9Gy9qxTQ9updMJK3VdRK0mLYnB0jQ8rMF3XKt+VAUFDrOYGaHmHEMOvfZyKjaFZuqe0Utd6
 DYMFCl8DVai5FnGMgdV868=
X-Spam-Status: No, score=-100.4 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
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
X-List-Received-Date: Mon, 31 May 2021 08:02:46 -0000

On May 30 12:58, Jeremy Drake via Cygwin-patches wrote:
> First, revert the handling of virtual drives as non-symlinks.  This is no
> longer necessary.

I'm all for it, because I like the idea that Cygwin can see virtual
drives as symlinks, but...

> The new GetFinalPathNameW handling for native symlinks in inner path
> components is disabled if caller doesn't want to follow symlinks, or
> doesn't want to follow reparse points.  Set flag to not follow reparse
> points in chdir, allowing native processes to see their cwd potentially
> including native symlinks, rather than dereferencing them.

So you're trying to keep the path length of the native CWD below
MAX_PATH?  I understand what you're trying to accomplish, but are
you sure this doesn't break Cygwin processes?  The idea of what
the native path of a directory is differs depending on calling
chdir and stuff like mkdir.

> For v2, I realized the PC_SYM_NOFOLLOW_REP flag was supposed to do this,
> and that lack of PC_SYM_FOLLOW was not being respected either.  With this,
> and patching `pwd -P` to `pwd` in makepkg, the long-named package builds
> successfully.  I did not re-indent the code for the addition of the if due
> to having learned from my patch to rebase, but it looks kind of ugly.

Formatting should try to stick to 80 chars max line length, if possible.
Kind of like this, just with TABs:

-	  for (unsigned pc_flags = opt & (PC_NO_ACCESS_CHECK | PC_KEEP_HANDLE);
+	  for (unsigned pc_flags = opt & (PC_NO_ACCESS_CHECK | PC_KEEP_HANDLE
					  | PC_SYM_FOLLOW | PC_SYM_NOFOLLOW_REP);


Thanks,
Corinna
