Return-Path: <cygwin@jdrake.com>
Received: from mail231.csoft.net (mail231.csoft.net [96.47.74.235])
 by sourceware.org (Postfix) with ESMTPS id B38613857422
 for <cygwin-patches@cygwin.com>; Wed,  7 Jul 2021 06:50:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org B38613857422
Received: from mail231.csoft.net (localhost [127.0.0.1])
 by mail231.csoft.net (Postfix) with ESMTP id B7327CB59
 for <cygwin-patches@cygwin.com>; Wed,  7 Jul 2021 02:50:28 -0400 (EDT)
Received: from mail231 (mail231 [96.47.74.235])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested) (Authenticated sender: jeremyd)
 by mail231.csoft.net (Postfix) with ESMTPSA id A6393CB57
 for <cygwin-patches@cygwin.com>; Wed,  7 Jul 2021 02:50:28 -0400 (EDT)
Date: Tue, 6 Jul 2021 23:50:28 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: respect PC_SYM_FOLLOW and PC_SYM_NOFOLLOW_REP
 with inner links
In-Reply-To: <YORvS4cn1fQX3O70@calimero.vinschen.de>
Message-ID: <alpine.BSO.2.21.2107062345380.56404@resin.csoft.net>
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
X-List-Received-Date: Wed, 07 Jul 2021 06:50:33 -0000

On Tue, 6 Jul 2021, Corinna Vinschen wrote:

> This looks like here be dragons.  A good solution would change the
> used native tools to allow paths > MAX_PATH finally, or to use other,
> equivalent tools already allowing that.

BTW, this seems pretty unlikely.  Portable tools are most likely using C
or C++ standard library file IO, not native Windows APIs, and while MS did
add an option to remove MAX_PATH limits from normal Win32 file/directory
APIs without the '\\?\' passthrough to NT trick [1], there are a lot of
hoops to jump through, and it would be hard to guarantee a whole stack of
libraries that might be linked in would be able to handle it.

[1]:
https://docs.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation#enable-long-paths-in-windows-10-version-1607-and-later
