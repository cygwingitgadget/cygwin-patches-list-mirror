Return-Path: <cygwin@jdrake.com>
Received: from mail231.csoft.net (mail231.csoft.net [96.47.74.235])
 by sourceware.org (Postfix) with ESMTPS id 953BE385802D
 for <cygwin-patches@cygwin.com>; Sat, 29 May 2021 23:15:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 953BE385802D
Received: from mail231.csoft.net (localhost [127.0.0.1])
 by mail231.csoft.net (Postfix) with ESMTP id 0D343CB4E
 for <cygwin-patches@cygwin.com>; Sat, 29 May 2021 19:15:31 -0400 (EDT)
Received: from mail231 (mail231 [96.47.74.235])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested) (Authenticated sender: jeremyd)
 by mail231.csoft.net (Postfix) with ESMTPSA id 09EBECB4B
 for <cygwin-patches@cygwin.com>; Sat, 29 May 2021 19:15:31 -0400 (EDT)
Date: Sat, 29 May 2021 16:15:30 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: tweak handling of native symlinks from chdir
In-Reply-To: <alpine.BSO.2.21.2105291322180.30039@resin.csoft.net>
Message-ID: <alpine.BSO.2.21.2105291600460.30039@resin.csoft.net>
References: <alpine.BSO.2.21.2105291322180.30039@resin.csoft.net>
User-Agent: Alpine 2.21 (BSO 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sat, 29 May 2021 23:15:33 -0000

On Sat, 29 May 2021, Jeremy Drake wrote:

> First, revert the handling of virtual drives as non-symlinks.  This is no
> longer necessary.
>

Spoke too soon, it seems that `makepkg` uses `pwd -P` and that still
dereferences symlinks, as does `pwd -W` and `cygpath -w .`  :(
