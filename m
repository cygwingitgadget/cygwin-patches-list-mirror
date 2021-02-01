Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id 8465B385802A
 for <cygwin-patches@cygwin.com>; Mon,  1 Feb 2021 10:46:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 8465B385802A
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M7auJ-1l2vIL0jtN-007zKO for <cygwin-patches@cygwin.com>; Mon, 01 Feb 2021
 11:46:32 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id C880BA80D7F; Mon,  1 Feb 2021 11:46:31 +0100 (CET)
Date: Mon, 1 Feb 2021 11:46:31 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/4] getdtablesize, OPEN_MAX, etc.
Message-ID: <20210201104631.GM375565@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210129192421.1651-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210129192421.1651-1-kbrown@cornell.edu>
X-Provags-ID: V03:K1:SUhTihkkYXdj/XVyqYwIlJrw9j///iXANpJ9g94U/0Ae2RDKlHE
 zZOSJuj2FfQpMz7h0T1yUTiWVYIymtpcBEzpVwicofjbkccJ7wQ6Jzu6dBZ8EWS86a40Eax
 lj4NyHNL4ouoqz7YgL0TSp3Wz/Tg6TNdAIpnCNF9lOEJ3j2S1D3RaHAP4A0i5omc0w0P0s1
 +3yD1MaC3eCEYUGH6+ooQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d8/CufGN+wU=:3Yq+7+vnFCIpYJntPpyVt/
 efBJaHsePQLYllQZFV6PisS09wDuohCvbDGo41weJJ4zxfuMRrGdw1Z45rpke/C1dLigsxyrs
 hEjHlSSRyfJYptHVbG3wZkaXVRwzb2t+W7nk7+lbpYHg6sWJZE47mQJ/CGdbW/KVAWhnJmT05
 cY5itLo2jgLmTXS2ztkH+JJ586xdhB1u+v+z3uClJB0NDk17PRN0mxNtlOt6V4EZqns/ox5lk
 u0QCmlTdjDhdE+QEtsXyivUE+mT0oefBPF9a/IbYV9TznnKlqeGkdqVVGAgEZRed+1pDxjeFG
 3asotLwTw3X5HUdXBiuXBsdGVIFsEUGT9xdtmS+laplRxu4IG0O6vGbEvFbZ3wqGH+yavbKF+
 3sqaoox9K53/eYvBQohdM/SKLrGCdPYtHt73ptO90laowDvVIjVh/HnNtUObxkaDcf3AukMBr
 S059pcEAJQ==
X-Spam-Status: No, score=-101.0 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 01 Feb 2021 10:46:35 -0000

On Jan 29 14:24, Ken Brown via Cygwin-patches wrote:
> This patchset is an extension of the patch submitted here:
> 
>   https://cygwin.com/pipermail/cygwin-patches/2021q1/011060.html
> 
> That patch is included as the first patch in this set.  The change to
> OPEN_MAX still needs testing to see if it has too much impact on the
> performance of tcsh.
> 
> I've make a first attempt to implement the suggestion of adding a new
> <cygwin/limits.h> header.  At this writing I'm not completely sure
> that I fully understand the purpose of that.  My choice of which
> macros to define in it might need to be changed.
> 
> Ken Brown (4):
>   Cygwin: getdtablesize: always return OPEN_MAX_MAX
>   Cygwin: sysconf, getrlimit: don't call getdtablesize
>   Cygwin: remove the OPEN_MAX_MAX macro
>   Cygwin: include/cygwin/limits.h: new header
> 
>  winsup/cygwin/dtable.cc               |  8 +--
>  winsup/cygwin/dtable.h                |  2 -
>  winsup/cygwin/fcntl.cc                |  2 +-
>  winsup/cygwin/include/cygwin/limits.h | 65 ++++++++++++++++++++
>  winsup/cygwin/include/limits.h        | 85 +++++++++++----------------
>  winsup/cygwin/resource.cc             |  5 +-
>  winsup/cygwin/syscalls.cc             |  8 +--
>  winsup/cygwin/sysconf.cc              | 11 +---
>  8 files changed, 111 insertions(+), 75 deletions(-)
>  create mode 100644 winsup/cygwin/include/cygwin/limits.h
> 
> -- 
> 2.30.0

Looks great, please push.


Corinna
