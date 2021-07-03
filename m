Return-Path: <cygwin@jdrake.com>
Received: from mail231.csoft.net (mail231.csoft.net [96.47.74.235])
 by sourceware.org (Postfix) with ESMTPS id C9DD53858C2C
 for <cygwin-patches@cygwin.com>; Sat,  3 Jul 2021 21:01:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org C9DD53858C2C
Received: from mail231.csoft.net (localhost [127.0.0.1])
 by mail231.csoft.net (Postfix) with ESMTP id 3DAB4CB50
 for <cygwin-patches@cygwin.com>; Sat,  3 Jul 2021 17:01:41 -0400 (EDT)
Received: from mail231 (mail231 [96.47.74.235])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested) (Authenticated sender: jeremyd)
 by mail231.csoft.net (Postfix) with ESMTPSA id 34738CB42
 for <cygwin-patches@cygwin.com>; Sat,  3 Jul 2021 17:01:41 -0400 (EDT)
Date: Sat, 3 Jul 2021 14:01:40 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: respect PC_SYM_FOLLOW and PC_SYM_NOFOLLOW_REP
 with inner links
In-Reply-To: <YLSbqEipANVY8KSZ@calimero.vinschen.de>
Message-ID: <alpine.BSO.2.21.2107031356250.56404@resin.csoft.net>
References: <alpine.BSO.2.21.2105291322180.30039@resin.csoft.net>
 <alpine.BSO.2.21.2105291600460.30039@resin.csoft.net>
 <alpine.BSO.2.21.2105292259570.30039@resin.csoft.net>
 <alpine.BSO.2.21.2105301213380.30039@resin.csoft.net>
 <YLSYIC/yYFz2IdMS@calimero.vinschen.de>
 <YLSbqEipANVY8KSZ@calimero.vinschen.de>
User-Agent: Alpine 2.21 (BSO 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, RCVD_IN_DNSWL_LOW, SPF_HELO_PASS,
 SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Sat, 03 Jul 2021 21:01:45 -0000

On Mon, 31 May 2021, Corinna Vinschen wrote:

> What bugs me here is that there's no guarantee that you can keep your
> path below MAX_PATH, independently of what you do here.  This is all
> a bit like patching up left and right just to keep dumb native tools
> running even in scenarios where they just fail otherwise.
>
> So we have two contradict problems, one which is solved by following
> inner symlinks, one which is solved by not doing that... I'm not overly
> keen to support this scenario.
>
> Wouldn't that be something more suited for an MSYS2-local patch?

I discussed this with the MSYS2 maintainers, and while they are open to
disabling this code in the short term, they would like to minimize the
patches against upstream Cygwin they carry.

For now I've proposed https://github.com/msys2/msys2-runtime/pull/54
there, and will test that is indeed the 'fix' for this (and a couple of
apparently related issues with mapped-network-drives turning into UNC for
Windows processes)

> Corinna

