Return-Path: <cygwin@jdrake.com>
Received: from mail231.csoft.net (mail231.csoft.net [96.47.74.235])
 by sourceware.org (Postfix) with ESMTPS id A122A3858C39
 for <cygwin-patches@cygwin.com>; Sat, 25 Dec 2021 05:40:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org A122A3858C39
Received: from mail231.csoft.net (localhost [127.0.0.1])
 by mail231.csoft.net (Postfix) with ESMTP id 68713CB24
 for <cygwin-patches@cygwin.com>; Sat, 25 Dec 2021 00:40:24 -0500 (EST)
Received: from mail231 (mail231 [96.47.74.235])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested) (Authenticated sender: jeremyd)
 by mail231.csoft.net (Postfix) with ESMTPSA id 6399DCB1B
 for <cygwin-patches@cygwin.com>; Sat, 25 Dec 2021 00:40:24 -0500 (EST)
Date: Fri, 24 Dec 2021 21:40:24 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fhandler_pipe: add sanity limit to handle loops
In-Reply-To: <20211225131242.adef568db53d561a6b134612@nifty.ne.jp>
Message-ID: <alpine.BSO.2.21.2112242101520.11760@resin.csoft.net>
References: <alpine.BSO.2.21.2112231503400.11760@resin.csoft.net>
 <f97bba17-16ab-d7be-01f6-1c057fb5f1a5@cornell.edu>
 <alpine.BSO.2.21.2112231623490.11760@resin.csoft.net>
 <c5115e9b-6475-d30e-04d3-cb84cfa92b3a@cornell.edu>
 <alpine.BSO.2.21.2112241136160.11760@resin.csoft.net>
 <622d3ac6-fa5d-965c-52da-db7a4463fffd@cornell.edu>
 <alpine.BSO.2.21.2112241638280.11760@resin.csoft.net>
 <20211225121902.54b82f1bb0d4f958d34a8bb7@nifty.ne.jp>
 <alpine.BSO.2.21.2112241945060.11760@resin.csoft.net>
 <20211225131242.adef568db53d561a6b134612@nifty.ne.jp>
User-Agent: Alpine 2.21 (BSO 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sat, 25 Dec 2021 05:40:26 -0000

On Sat, 25 Dec 2021, Takashi Yano wrote:

> On Fri, 24 Dec 2021 19:47:46 -0800 (PST)
> Jeremy Drake wrote:
> > phi->NumberOfHandles = 7999168, n_handle = 256
> > assertion "phi->NumberOfHandles <= n_handle" failed: file
> > "../../.././winsup/cygwin/fhandler_pipe.cc", line 1280, function: void*
> > fhandler_pipe::get_query_hdl_per_process(WCHAR*, OBJECT_NAME_INFORMATION*)
> > Aborted
>
> What!? Could you please check value of the "status" ?

status = 0x00000000, phi->NumberOfHandles = 7286688, n_handle = 256
assertion "phi->NumberOfHandles <= n_handle" failed: file
"../../.././winsup/cygwin/fhandler_pipe.cc", line 1281, function: void*
fhandler_pipe::get_query_hdl_per_process(WCHAR*, OBJECT_NAME_INFORMATION*)
Aborted

> What version of windows do you use?

This was on Windows 11 (22000.376) on ARM64, but msys2 has started seeing
similar hangs on Github's "windows-2022" runner.  I don't have one of
those locally to test against however.  But if push came to shove, I think
I downloaded a Server 2022 evaluation ISO, I could set up a VM and see
what happens.
