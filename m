Return-Path: <cygwin@jdrake.com>
Received: from mail231.csoft.net (mail231.csoft.net [96.47.74.235])
 by sourceware.org (Postfix) with ESMTPS id 262A53858022
 for <cygwin-patches@cygwin.com>; Sun, 30 May 2021 06:05:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 262A53858022
Received: from mail231.csoft.net (localhost [127.0.0.1])
 by mail231.csoft.net (Postfix) with ESMTP id CAEBECB51
 for <cygwin-patches@cygwin.com>; Sun, 30 May 2021 02:05:46 -0400 (EDT)
Received: from mail231 (mail231 [96.47.74.235])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested) (Authenticated sender: jeremyd)
 by mail231.csoft.net (Postfix) with ESMTPSA id B8052CB2F
 for <cygwin-patches@cygwin.com>; Sun, 30 May 2021 02:05:46 -0400 (EDT)
Date: Sat, 29 May 2021 23:05:46 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: tweak handling of native symlinks from chdir
In-Reply-To: <alpine.BSO.2.21.2105291600460.30039@resin.csoft.net>
Message-ID: <alpine.BSO.2.21.2105292259570.30039@resin.csoft.net>
References: <alpine.BSO.2.21.2105291322180.30039@resin.csoft.net>
 <alpine.BSO.2.21.2105291600460.30039@resin.csoft.net>
User-Agent: Alpine 2.21 (BSO 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, RCVD_IN_DNSWL_LOW, SPF_HELO_PASS,
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
X-List-Received-Date: Sun, 30 May 2021 06:05:49 -0000

On Sat, 29 May 2021, Jeremy Drake via Cygwin-patches wrote:

> On Sat, 29 May 2021, Jeremy Drake wrote:
>
> > First, revert the handling of virtual drives as non-symlinks.  This is no
> > longer necessary.
> >
>
> Spoke too soon, it seems that `makepkg` uses `pwd -P` and that still
> dereferences symlinks, as does `pwd -W` and `cygpath -w .`  :(

With the two patches from the OP, plus patching `makepkg` to change all
`pwd -P` to straight `pwd`, AND patching msys2's msys2_path_conv.cc
`posix_to_win32_path` to use the new flag to path_conv, I was finally able
to build the problematic package with the long name...  I imagine
`cygwin_conv_path` should have that flag too, for cygpath and `pwd -W`.

Hopefully there's a better (less invasive) approach that I'm not seeing.
