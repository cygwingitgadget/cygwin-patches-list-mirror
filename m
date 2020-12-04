Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id 70A98397301C
 for <cygwin-patches@cygwin.com>; Fri,  4 Dec 2020 12:10:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 70A98397301C
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N3sRi-1k3KmC0jTc-00zlSQ for <cygwin-patches@cygwin.com>; Fri, 04 Dec 2020
 13:10:44 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 5105BA805B9; Fri,  4 Dec 2020 13:10:43 +0100 (CET)
Date: Fri, 4 Dec 2020 13:10:43 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/1] cygwin: use CREATE_DEFAULT_ERROR_MODE in spawn
Message-ID: <20201204121043.GB5295@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <alpine.BSO.2.21.2012031317260.9707@resin.csoft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.BSO.2.21.2012031317260.9707@resin.csoft.net>
X-Provags-ID: V03:K1:e3sUuaMcMbO+UPgSQaSLPMj8/dYVTe6qVBOWMPu6WS0VLU8h9Kg
 ElXX5JEyqNK3kPEh3LF8DHcKX2080wE3x00L0kALIrvNdwmpXWghN/SiTZT30uKQzelm+Ll
 vNB8GjUXm2TEQIec5ODTqdqBaYqx/PvBo9oheERHr5/HD7uemqH4tNehOXZRB1y0dIN4vAQ
 Dtk34QqI7EmGNBG3+BSQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:16ehSUaPC+Q=:fvhkjo2EPD8vi05RL/pUbO
 ydCSmlAncag4/o+FVOJGYwjku7Fd3asZGiz3hNwP2mvMmVsjVplhGSBUl/eIeeJXz6E+vB22n
 Th3oWa2KfKq/1DZaNP8UyBPqNZmfQiycFhGQ20AgNGS2UTDicxWGBKQKP2rXaV2oDndx6Sz2D
 7QlKaPSAzeTyOLviZjV2YZfmSlZJzA3Q+doDQ1M2By+djzcc5cp7MNjRHUDORH+vokFCvSm2s
 I/Uovl8lqxrPRWzGseIqqHWkkc7TnSEXt0BW7r/42NEoYZSKWkveJPz8tJGW6C3hNP7+0oJMe
 efH7mve8mvbw8srNLc3u33tDDo0VgX4B4rEGHlFNXvrd1sJe5+q4he+nZH+1VSLZUSQ0RvBDr
 Y+hgmCvbUy9ShglknPklw2QdZvyw0wMUEGa6aGKidAUvG6mFxyo6tej7Uy28s3rUUoq/grqqb
 e/0yG4PF5w==
X-Spam-Status: No, score=-100.7 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Fri, 04 Dec 2020 12:10:47 -0000

Hi Jeremy,

On Dec  3 13:21, Jeremy Drake via Cygwin-patches wrote:
> if a new CYGWIN/MSYS environment option `winjitdebug` is true, allowing
> native subprocesses to get Windows-default error handling behavior (such
> as invoking the registered JIT debugger).  Cygwin processes will quickly
> set their error mode on start, so getting JIT debugging for them will
> still require setting `error_start`.

I'm not happy about a new CYGWIN option.

Wouldn't it make sense, perhaps, to switch to CREATE_DEFAULT_ERROR_MODE
for all non-Cygwin processes by default instead?


Corinna
