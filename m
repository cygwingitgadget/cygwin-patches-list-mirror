Return-Path: <cygwin@jdrake.com>
Received: from mail231.csoft.net (mail231.csoft.net [96.47.74.235])
 by sourceware.org (Postfix) with ESMTPS id C8EBC383D81F
 for <cygwin-patches@cygwin.com>; Tue,  6 Jul 2021 17:38:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org C8EBC383D81F
Received: from mail231.csoft.net (localhost [127.0.0.1])
 by mail231.csoft.net (Postfix) with ESMTP id 2F2A4CB61
 for <cygwin-patches@cygwin.com>; Tue,  6 Jul 2021 13:38:02 -0400 (EDT)
Received: from mail231 (mail231 [96.47.74.235])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested) (Authenticated sender: jeremyd)
 by mail231.csoft.net (Postfix) with ESMTPSA id 1C515CB5D
 for <cygwin-patches@cygwin.com>; Tue,  6 Jul 2021 13:38:02 -0400 (EDT)
Date: Tue, 6 Jul 2021 10:38:02 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: respect PC_SYM_FOLLOW and PC_SYM_NOFOLLOW_REP
 with inner links
In-Reply-To: <YORvS4cn1fQX3O70@calimero.vinschen.de>
Message-ID: <alpine.BSO.2.21.2107061031580.56404@resin.csoft.net>
References: <alpine.BSO.2.21.2105291322180.30039@resin.csoft.net>
 <alpine.BSO.2.21.2105291600460.30039@resin.csoft.net>
 <alpine.BSO.2.21.2105292259570.30039@resin.csoft.net>
 <alpine.BSO.2.21.2105301213380.30039@resin.csoft.net>
 <YLSYIC/yYFz2IdMS@calimero.vinschen.de>
 <alpine.BSO.2.21.2106031321380.30039@resin.csoft.net>
 <alpine.BSO.2.21.2106031355540.30039@resin.csoft.net>
 <YORvS4cn1fQX3O70@calimero.vinschen.de>
User-Agent: Alpine 2.21 (BSO 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Tue, 06 Jul 2021 17:38:03 -0000

On Tue, 6 Jul 2021, Corinna Vinschen wrote:

> This formatting is just ugly.  I suggest to move the PC_SYM_* test
> to the block after the 32 bit code and reuse the existing braces,
> just with adapted indentation, i. e.:

+1.  I was trying to avoid reformatting otherwise unchanged lines to
reduce patch size.

> > @@ -3704,7 +3708,8 @@ chdir (const char *in_dir)
> >
> >        /* Convert path.  PC_NONULLEMPTY ensures that we don't check for
> >          NULL/empty/invalid again. */
> > -      path_conv path (in_dir, PC_SYM_FOLLOW | PC_POSIX | PC_NONULLEMPTY);
> > +      path_conv path (in_dir, PC_SYM_FOLLOW | PC_POSIX | PC_NONULLEMPTY
> > +                             | PC_SYM_NOFOLLOW_REP);
> >        if (path.error)
> >         {
> >           set_errno (path.error);
>
> I'm still not convinced that we should do this.  I'm pretty certain this
> will result in problems in Cygwin processes when you least expect them.
>
> Consider that the output of getcwd and realpath/readlink on the same
> path may differ after this patch.  Using PC_SYM_NOFOLLOW_REP like this
> also changes the normal sym follow handling for the last path component
> in path_copnv::check, potentially.
>
> This looks like here be dragons.  A good solution would change the
> used native tools to allow paths > MAX_PATH finally, or to use other,
> equivalent tools already allowing that.

I am not convinced that this even completely solved the issues I was
seeing, or some of the reports of issues with unc paths suddenly showing
up instead of mapped drives in native tools that weren't expecting them.

But, I do think respecting the PC_SYM_NOFOLLOW_REP flag for inner links is
correct, and I am sending a new version.
