Return-Path: <cygwin@jdrake.com>
Received: from mail231.csoft.net (mail231.csoft.net [96.47.74.235])
 by sourceware.org (Postfix) with ESMTPS id 64C313858C27
 for <cygwin-patches@cygwin.com>; Fri, 24 Dec 2021 19:42:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 64C313858C27
Received: from mail231.csoft.net (localhost [127.0.0.1])
 by mail231.csoft.net (Postfix) with ESMTP id ECB14CB24;
 Fri, 24 Dec 2021 14:42:45 -0500 (EST)
Received: from mail231 (mail231 [96.47.74.235])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested) (Authenticated sender: jeremyd)
 by mail231.csoft.net (Postfix) with ESMTPSA id DC136CB1B;
 Fri, 24 Dec 2021 14:42:45 -0500 (EST)
Date: Fri, 24 Dec 2021 11:42:45 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Ken Brown <kbrown@cornell.edu>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fhandler_pipe: add sanity limit to handle loops
In-Reply-To: <c5115e9b-6475-d30e-04d3-cb84cfa92b3a@cornell.edu>
Message-ID: <alpine.BSO.2.21.2112241136160.11760@resin.csoft.net>
References: <alpine.BSO.2.21.2112231503400.11760@resin.csoft.net>
 <f97bba17-16ab-d7be-01f6-1c057fb5f1a5@cornell.edu>
 <alpine.BSO.2.21.2112231623490.11760@resin.csoft.net>
 <c5115e9b-6475-d30e-04d3-cb84cfa92b3a@cornell.edu>
User-Agent: Alpine 2.21 (BSO 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Fri, 24 Dec 2021 19:42:47 -0000

On Fri, 24 Dec 2021, Ken Brown wrote:

> I agree that it's hard to see how the line you quoted could cause an
> exception.  But you were using an optimized build, so I'm not sure how
> reliable the line-number information is.
>
> Is it feasible to run your test under strace?  If so, you could add some
> debug_printf statements to examine the values of n_handle and
> phi->NumberOfHandles.  Or what about simply adding an assertion that
> phi->NumberOfHandles <= n_handle?
>
> Ken

This issue is not consistent, I was able to reproduce once on x64 by
running commands in a loop overnight, but the next time I tried to
reproduce I ran for over 24 hours without hitting it.

It does seem to happen much more often on Windows on ARM64 (so much so
that at first I thought it was an issue with their emulation).  With this
patch I have not seen the issue again.

Also, it seems to have started cropping up in msys2's CI when the GHA
runner was switched from "windows-2019" to "windows-2022".

I forgot to give a full link to the MSYS2 issue where I have been
investigating this:
https://github.com/msys2/MSYS2-packages/issues/2752

