Return-Path: <cygwin@jdrake.com>
Received: from mail231.csoft.net (mail231.csoft.net [96.47.74.235])
 by sourceware.org (Postfix) with ESMTPS id 9B9E63972C34
 for <cygwin-patches@cygwin.com>; Fri,  4 Dec 2020 18:35:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9B9E63972C34
Received: from mail231.csoft.net (localhost [127.0.0.1])
 by mail231.csoft.net (Postfix) with ESMTP id ED043CB86
 for <cygwin-patches@cygwin.com>; Fri,  4 Dec 2020 13:35:34 -0500 (EST)
Received: from mail231 (mail231 [96.47.74.235])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested) (Authenticated sender: jeremyd)
 by mail231.csoft.net (Postfix) with ESMTPSA id E850ECB82
 for <cygwin-patches@cygwin.com>; Fri,  4 Dec 2020 13:35:34 -0500 (EST)
Date: Fri, 4 Dec 2020 10:35:34 -0800 (PST)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Corinna Vinschen via Cygwin-patches <cygwin-patches@cygwin.com>
Subject: Re: [PATCH 1/1] cygwin: use CREATE_DEFAULT_ERROR_MODE in spawn
In-Reply-To: <20201204121043.GB5295@calimero.vinschen.de>
Message-ID: <alpine.BSO.2.21.2012041028060.9707@resin.csoft.net>
References: <alpine.BSO.2.21.2012031317260.9707@resin.csoft.net>
 <20201204121043.GB5295@calimero.vinschen.de>
User-Agent: Alpine 2.21 (BSO 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Fri, 04 Dec 2020 18:35:37 -0000

On Fri, 4 Dec 2020, Corinna Vinschen via Cygwin-patches wrote:

> I'm not happy about a new CYGWIN option.
>
> Wouldn't it make sense, perhaps, to switch to CREATE_DEFAULT_ERROR_MODE
> for all non-Cygwin processes by default instead?

In fact, my first iteration was to set that flag unconditionally (relying
on the fact that SetErrorMode is called extremely early in Cygwin process
startup rather than only setting it for non-Cygwin processes), but I
received feedback that it would be better to put it behind an option:

https://github.com/msys2/msys2-runtime/pull/18#issuecomment-723683606

