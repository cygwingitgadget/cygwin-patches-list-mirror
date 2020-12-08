Return-Path: <cygwin@jdrake.com>
Received: from mail231.csoft.net (mail231.csoft.net [96.47.74.235])
 by sourceware.org (Postfix) with ESMTPS id 7768F3854805
 for <cygwin-patches@cygwin.com>; Tue,  8 Dec 2020 19:58:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 7768F3854805
Received: from mail231.csoft.net (localhost [127.0.0.1])
 by mail231.csoft.net (Postfix) with ESMTP id 7FB31CB51
 for <cygwin-patches@cygwin.com>; Tue,  8 Dec 2020 14:58:18 -0500 (EST)
Received: from mail231 (mail231 [96.47.74.235])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested) (Authenticated sender: jeremyd)
 by mail231.csoft.net (Postfix) with ESMTPSA id 7AB52CB4E
 for <cygwin-patches@cygwin.com>; Tue,  8 Dec 2020 14:58:18 -0500 (EST)
Date: Tue, 8 Dec 2020 11:58:18 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/1] cygwin: use CREATE_DEFAULT_ERROR_MODE in spawn
In-Reply-To: <26ef013a-d3ff-7389-c022-1b10568faf79@dronecode.org.uk>
Message-ID: <alpine.BSO.2.21.2012081142000.9707@resin.csoft.net>
References: <alpine.BSO.2.21.2012031317260.9707@resin.csoft.net>
 <20201204121043.GB5295@calimero.vinschen.de>
 <alpine.BSO.2.21.2012041028060.9707@resin.csoft.net>
 <20201207094317.GI5295@calimero.vinschen.de>
 <26ef013a-d3ff-7389-c022-1b10568faf79@dronecode.org.uk>
User-Agent: Alpine 2.21 (BSO 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-12.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_LOW,
 SPF_HELO_PASS, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 08 Dec 2020 19:58:21 -0000

On Tue, 8 Dec 2020, Jon Turney wrote:
> On 07/12/2020 09:43, Corinna Vinschen wrote:
> > On Dec  4 10:35, Jeremy Drake via Cygwin-patches wrote:
> > > On Fri, 4 Dec 2020, Corinna Vinschen via Cygwin-patches wrote:
> > >
> > > > I'm not happy about a new CYGWIN option.
> > > >
> > > > Wouldn't it make sense, perhaps, to switch to CREATE_DEFAULT_ERROR_MODE
> > > > for all non-Cygwin processes by default instead?
>
> I agree.
>
> Cygwin calls SetErrorMode(), so we need to use this flag to prevent that
> non-default behaviour being inherited by processes started with
> CreateProcess().
>

In that case, here's my initial, much simpler patch

-- >8 --
Subject: [PATCH] cygwin: use CREATE_DEFAULT_ERROR_MODE in spawn

This allows native processes to get Windows-default error handling
behavior (such as invoking the registered JIT debugger), while cygwin
processes would quickly set their error mode back to what they expect.
---
 winsup/cygwin/spawn.cc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index c77d62984..f5952d53b 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -429,7 +429,8 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
       c_flags = GetPriorityClass (GetCurrentProcess ());
       sigproc_printf ("priority class %d", c_flags);

-      c_flags |= CREATE_SEPARATE_WOW_VDM | CREATE_UNICODE_ENVIRONMENT;
+      c_flags |= CREATE_SEPARATE_WOW_VDM | CREATE_UNICODE_ENVIRONMENT
+	      | CREATE_DEFAULT_ERROR_MODE;

       /* We're adding the CREATE_BREAKAWAY_FROM_JOB flag here to workaround
 	 issues with the "Program Compatibility Assistant (PCA) Service".
