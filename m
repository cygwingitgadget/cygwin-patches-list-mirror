Return-Path: <cygwin@jdrake.com>
Received: from mail231.csoft.net (mail231.csoft.net [96.47.74.235])
 by sourceware.org (Postfix) with ESMTPS id 5D4BE3857C5F
 for <cygwin-patches@cygwin.com>; Mon, 31 May 2021 17:55:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5D4BE3857C5F
Received: from mail231.csoft.net (localhost [127.0.0.1])
 by mail231.csoft.net (Postfix) with ESMTP id 32064CB4B
 for <cygwin-patches@cygwin.com>; Mon, 31 May 2021 13:55:24 -0400 (EDT)
Received: from mail231 (mail231 [96.47.74.235])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested) (Authenticated sender: jeremyd)
 by mail231.csoft.net (Postfix) with ESMTPSA id 305D1CB36
 for <cygwin-patches@cygwin.com>; Mon, 31 May 2021 13:55:24 -0400 (EDT)
Date: Mon, 31 May 2021 10:55:24 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: respect PC_SYM_FOLLOW and PC_SYM_NOFOLLOW_REP
 with inner links
In-Reply-To: <YLSbqEipANVY8KSZ@calimero.vinschen.de>
Message-ID: <alpine.BSO.2.21.2105311039080.30039@resin.csoft.net>
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
X-List-Received-Date: Mon, 31 May 2021 17:55:26 -0000

On Mon, 31 May 2021, Corinna Vinschen wrote:

> > So you're trying to keep the path length of the native CWD below
> > MAX_PATH?  I understand what you're trying to accomplish, but are
> > you sure this doesn't break Cygwin processes?  The idea of what
> > the native path of a directory is differs depending on calling
> > chdir and stuff like mkdir.

I'm not sure.  I've been running builds with this patch for a bit, and
haven't seen any issue, but MSYS2 doesn't use native symlinks so that
aspect of it hasn't been exercised.

>
> What bugs me here is that there's no guarantee that you can keep your
> path below MAX_PATH, independently of what you do here.  This is all
> a bit like patching up left and right just to keep dumb native tools
> running even in scenarios where they just fail otherwise.

Basically.  I wish there was a viable alternative (requiring everyone
trying to use them to set a registry value/policy, manifesting them for
long paths, and potentially patching them to be safe with long paths isn't
very viable).

> So we have two contradict problems, one which is solved by following
> inner symlinks, one which is solved by not doing that... I'm not overly
> keen to support this scenario.
>
> Wouldn't that be something more suited for an MSYS2-local patch?

Just the changing of the flag in chdir?  Because it seems like not
respecting the symlink-related PC flags for native inner links is a
bona-fide issue.

