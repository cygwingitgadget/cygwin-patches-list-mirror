Return-Path: <cygwin@jdrake.com>
Received: from mail231.csoft.net (mail231.csoft.net [96.47.74.235])
 by sourceware.org (Postfix) with ESMTPS id 1E0FF3858027
 for <cygwin-patches@cygwin.com>; Wed, 29 Dec 2021 23:29:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 1E0FF3858027
Received: from mail231.csoft.net (localhost [127.0.0.1])
 by mail231.csoft.net (Postfix) with ESMTP id 68A4CCBA4;
 Wed, 29 Dec 2021 18:29:48 -0500 (EST)
Received: from mail231 (mail231 [96.47.74.235])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested) (Authenticated sender: jeremyd)
 by mail231.csoft.net (Postfix) with ESMTPSA id 63645CB59;
 Wed, 29 Dec 2021 18:29:48 -0500 (EST)
Date: Wed, 29 Dec 2021 15:29:48 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Ken Brown <kbrown@cornell.edu>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fhandler_pipe: add sanity limit to handle loops
In-Reply-To: <104c6a5c-a480-5087-89c5-d3737d8b7a2d@cornell.edu>
Message-ID: <alpine.BSO.2.21.2112291527470.11760@resin.csoft.net>
References: <alpine.BSO.2.21.2112231503400.11760@resin.csoft.net>
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
 <alpine.BSO.2.21.2112261432360.11760@resin.csoft.net>
 <7781155f-d4a1-2e9d-a5c7-2ecc2250a5cf@cornell.edu>
 <104c6a5c-a480-5087-89c5-d3737d8b7a2d@cornell.edu>
User-Agent: Alpine 2.21 (BSO 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Wed, 29 Dec 2021 23:29:52 -0000

On Wed, 29 Dec 2021, Ken Brown wrote:

> Takashi must be unavailable also, but it's a simple enough fix that I decided
> to go ahead and push it.

Thanks.  Regarding the other hang I'm seeing on ARM64, I tried gdb windbg
and lldb, and none of them seem able to read the 'context' of the main
thread when in this state so I can't get a stack trace.
