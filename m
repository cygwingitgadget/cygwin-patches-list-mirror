Return-Path: <cygwin@jdrake.com>
Received: from mail231.csoft.net (mail231.csoft.net [96.47.74.235])
 by sourceware.org (Postfix) with ESMTPS id B5C093858416
 for <cygwin-patches@cygwin.com>; Sun, 26 Dec 2021 22:43:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org B5C093858416
Received: from mail231.csoft.net (localhost [127.0.0.1])
 by mail231.csoft.net (Postfix) with ESMTP id 69916CB50;
 Sun, 26 Dec 2021 17:43:58 -0500 (EST)
Received: from mail231 (mail231 [96.47.74.235])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested) (Authenticated sender: jeremyd)
 by mail231.csoft.net (Postfix) with ESMTPSA id 65EEFCB1B;
 Sun, 26 Dec 2021 17:43:58 -0500 (EST)
Date: Sun, 26 Dec 2021 14:43:58 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Ken Brown <kbrown@cornell.edu>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fhandler_pipe: add sanity limit to handle loops
In-Reply-To: <b278775d-03d9-6683-ec43-62729bb0054c@cornell.edu>
Message-ID: <alpine.BSO.2.21.2112261432360.11760@resin.csoft.net>
References: <alpine.BSO.2.21.2112231503400.11760@resin.csoft.net>
 <alpine.BSO.2.21.2112241136160.11760@resin.csoft.net>
 <622d3ac6-fa5d-965c-52da-db7a4463fffd@cornell.edu>
 <alpine.BSO.2.21.2112241638280.11760@resin.csoft.net>
 <20211225121902.54b82f1bb0d4f958d34a8bb7@nifty.ne.jp>
 <alpine.BSO.2.21.2112241945060.11760@resin.csoft.net>
 <20211225131242.adef568db53d561a6b134612@nifty.ne.jp>
 <alpine.BSO.2.21.2112242101520.11760@resin.csoft.net>
 <20211226021010.a2b2ad28f12df9ffb25b6584@nifty.ne.jp>
 <alpine.BSO.2.21.2112251111580.11760@resin.csoft.net>
 <alpine.BSO.2.21.2112251457480.11760@resin.csoft.net>
 <8172019c-e048-4fe2-79c9-0b3262057d3e@cornell.edu>
 <alpine.BSO.2.21.2112252054310.11760@resin.csoft.net>
 <c7664703-0ec2-388f-64e3-8c46d4590b3e@cornell.edu>
 <d2af0b22-666a-b820-acb0-afc835836372@cornell.edu>
 <317dc73a-fb9d-3937-7354-c79492c1c64c@cornell.edu>
 <alpine.BSO.2.21.2112261331090.11760@resin.csoft.net>
 <b278775d-03d9-6683-ec43-62729bb0054c@cornell.edu>
User-Agent: Alpine 2.21 (BSO 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sun, 26 Dec 2021 22:44:01 -0000

On Sun, 26 Dec 2021, Ken Brown wrote:

> +	  /* NtQueryInformationProcess can return STATUS_SUCCESS with
> +	     invalid handle data for certain processes.  See
> +	     https://github.com/processhacker/processhacker/blob/master/phlib/native.c#L5754.

I would recommend using the "permalink" to the line, since future
commits could change both the line number and even the comment you are
referring to.

https://github.com/processhacker/processhacker/blob/05f5e9fa477dcaa1709d9518170d18e1b3b8330d/phlib/native.c#L5754


> +	     We need to ensure that NumberOfHandles is zero in this
> +	     case to avoid a crash in the loop below. */
> +	  phi->NumberOfHandles = 0;
>  	  status = NtQueryInformationProcess (proc, ProcessHandleInformation,
>  					      phi, nbytes, &len);
>  	  if (NT_SUCCESS (status))

Would it make sense to leave an assert (phi->NumberOfHandles <= n_handle)
before the for loop too just in case something odd happens in the
future?  That made it a lot easier to know what was going on.

My loops are still going after an hour.  I know that ARM64 would have hit
the assert before now.

Would this also be pushed to the 3.3 branch?  Or are there plans to make a
3.3.4 at some point?  I saw a pipe-related hang reported to MSYS2 (that I
didn't see this issue in the stack traces), but I am not sure if there are
any more pipe fixes pending post 3.3.3.
