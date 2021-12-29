Return-Path: <cygwin@jdrake.com>
Received: from mail231.csoft.net (mail231.csoft.net [96.47.74.235])
 by sourceware.org (Postfix) with ESMTPS id EA14F3858D3C
 for <cygwin-patches@cygwin.com>; Wed, 29 Dec 2021 05:45:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org EA14F3858D3C
Received: from mail231.csoft.net (localhost [127.0.0.1])
 by mail231.csoft.net (Postfix) with ESMTP id 77616CBAD;
 Wed, 29 Dec 2021 00:45:50 -0500 (EST)
Received: from mail231 (mail231 [96.47.74.235])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested) (Authenticated sender: jeremyd)
 by mail231.csoft.net (Postfix) with ESMTPSA id 660ACCBAB;
 Wed, 29 Dec 2021 00:45:50 -0500 (EST)
Date: Tue, 28 Dec 2021 21:45:50 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Jon Turney <jon.turney@dronecode.org.uk>
cc: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] fhandler_pipe: add sanity limit to handle loops
In-Reply-To: <90dd8b13-8e7f-97b8-b480-299a9d64836e@dronecode.org.uk>
Message-ID: <alpine.BSO.2.21.2112282143180.11760@resin.csoft.net>
References: <alpine.BSO.2.21.2112231503400.11760@resin.csoft.net>
 <f97bba17-16ab-d7be-01f6-1c057fb5f1a5@cornell.edu>
 <alpine.BSO.2.21.2112231623490.11760@resin.csoft.net>
 <90dd8b13-8e7f-97b8-b480-299a9d64836e@dronecode.org.uk>
User-Agent: Alpine 2.21 (BSO 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, SPF_HELO_PASS, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Wed, 29 Dec 2021 05:45:52 -0000

On Mon, 27 Dec 2021, Jon Turney wrote:

> On 24/12/2021 00:29, Jeremy Drake via Cygwin-patches wrote:
> > again, so I can't confirm this.  I took a core with 'dumper' but gdb
> > doesn't want to load it (it says Core file format not supported, maybe
> > something with msys2's gdb?).
>
> I think you need gdb 11 (for this patch set [1], which is also in cygwin's
> gdb 10 package) to read x86_64 cygwin core dumps.
>
> [1] https://sourceware.org/pipermail/gdb-patches/2020-August/171232.html

Thanks, this was the problem.  But the core dump wasn't much help anyway,
the stuff I was interested in was pre-exception, and the backtrace
seemed to stop at the exception handling (unlike when 'live' debugging
when the stack trace continued).
