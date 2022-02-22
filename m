Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id 8BD82385841B
 for <cygwin-patches@cygwin.com>; Tue, 22 Feb 2022 12:34:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 8BD82385841B
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MPGJh-1nayQa099B-00PclD for <cygwin-patches@cygwin.com>; Tue, 22 Feb 2022
 13:34:53 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 7ADA4A80BC1; Tue, 22 Feb 2022 13:34:51 +0100 (CET)
Date: Tue, 22 Feb 2022 13:34:51 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Provide virtual /dev/fd and
 /dev/{stdin,stdout,stderr} symlinks
Message-ID: <YhTYazKXC+2X2TbU@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1645450518.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1645450518.git.johannes.schindelin@gmx.de>
X-Provags-ID: V03:K1:RdNyrPoSNmkw1AsiTkC8Fic8Qtp4TnO5Dy+AjwCNyBz+9aXbr9/
 hoK8MlVhRv0vAaZmjQJqRGahrIio6mTwxyTxT5FTL/c2RsjCSqX5cW2UL+7wUg9JDfXa14X
 1M1G7f4j07SQrU8qTt8+qnQc7U44U0eJ+xP26tfmQC/0fDrMhx+Nsiu23f9uRrU+zDPrkhl
 A0gaaKevcyLXB+OZ9xoww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:goeH6+Ms1eU=:dwzclnzfJ3ibVXH95sxRMp
 uoRzZCY+kI/ZEZv4jeDExE8+hEX2MrIRUgnXM2PDrK29E+bPu4q1Lt5VZXnc/zOlsalzHr8Na
 PwJWy6x6PvRmhmUQT41+Y+bpOpx8PR2als1eiNHfC7SMBfKIJJ6hcu5LL0L+Rd82gjJAnuiDg
 4kOzMHr/ItQCC8NpneZ2ztvuzaJ29f5iCldg0xrY6QFY6nQLrYkJfuJi06XHxSN7eEp7HGKD3
 dwvqb2xkiX3A2x2xyTdGqlgu2y9L/6i1yl+OGSPGAs605rsdS6pWGaCyKA2i/a/zozd9nXL1z
 IKlAKFHfZVl5XDcw7AiHN7zmqVfZoRrKwBW84FhxbxhYJmTM9YYCBDOQB+41402Qp1NFq+nSk
 +TGkS8VkOOGScLSIZBG27a7t7puB83WzZwqfEzUzO+/f+Fv8YL4Cc/iowSnhL03INarVuu1tP
 hX/3fhwcgCX+3ikCYXdxZ9pn4Scf7gSzDVVzMX2V05lTVAS7NEMOhobKEWvGt7ZvsTnxHh2uL
 bLk90fWsYVJEP2BGSOUKGxm+juPe3tZefXnKgUA2dsfgSaeuYxf8LLim9Odbr4YXPCbJs7eym
 zVogXOQ+yNd3bvDqcpzSug5dim110EkjvQygfwqydkgUjYex7wIE48UatwvU9ANRw8YPBiraK
 DxhMyz3oR+jXKMJNNpKCL4XMa7SIKz52q5U8nDRYBzwNeINAG+5CC2ObXrpwl+iWnGHO6TTP4
 yRbJuF7yg31l9dqv
X-Spam-Status: No, score=-96.4 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H5, RCVD_IN_MSPIKE_WL, SPF_FAIL, SPF_HELO_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Tue, 22 Feb 2022 12:34:57 -0000

Hi Johannes,

On Feb 21 14:36, Johannes Schindelin wrote:
> These symbolic links are crucial e.g. to support process substitution (Bash's
> very nice `<(SOME-COMMAND)` feature).
> 
> For various reasons, it is a bit cumbersome (or impossible) to generate these
> symbolic links in all circumstances where Git for Windows wants to use its
> close fork of the Cygwin runtime.
> 
> Therefore, let's just handle these symbolic links as implicit, virtual ones.
> 
> If there is appetite for it, I wonder whether we should do something similar
> for `/dev/shm` and `/dev/mqueue`? Are these even still used in Cygwin?

"still used"?  These are the dirs to store POSIX semaphors, message
queues and shared mem objects.  These have to be real on-disk dirs.

> Johannes Schindelin (2):
>   Implicitly support the /dev/fd symlink and friends
>   Regenerate devices.cc
> 
>  winsup/cygwin/Makefile.am        |    1 +
>  winsup/cygwin/devices.cc         | 1494 ++++++++++++++++--------------
>  winsup/cygwin/devices.h          |    3 +-
>  winsup/cygwin/devices.in         |    4 +
>  winsup/cygwin/dtable.cc          |    3 +
>  winsup/cygwin/fhandler.h         |   28 +
>  winsup/cygwin/fhandler_dev_fd.cc |   53 ++
>  7 files changed, 879 insertions(+), 707 deletions(-)
>  create mode 100644 winsup/cygwin/fhandler_dev_fd.cc

Pushed.


Thanks,
Corinna
