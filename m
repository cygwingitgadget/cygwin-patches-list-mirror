Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id 7C6F1384C005
 for <cygwin-patches@cygwin.com>; Mon,  1 Feb 2021 10:34:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 7C6F1384C005
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M9nEJ-1l0jeV3ZJ7-005mzd; Mon, 01 Feb 2021 11:34:46 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id B2F8AA80D7F; Mon,  1 Feb 2021 11:34:45 +0100 (CET)
Date: Mon, 1 Feb 2021 11:34:45 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Pierre Humblet <phumblet@phumblet.no-ip.org>
Subject: Re: [PATCH] CYGWIN:  Fix resolver debugging output
Message-ID: <20210201103445.GK375565@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,
 Pierre Humblet <phumblet@phumblet.no-ip.org>
References: <20210129192903.939-1-lavr@ncbi.nlm.nih.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210129192903.939-1-lavr@ncbi.nlm.nih.gov>
X-Provags-ID: V03:K1:1wkpNKZZT7tbGhb31ZVMe6HGXBK1vT2PTKhixHejIm3Eg5yEiEV
 AeNrC3DVw2lgXvcGOu42MC5X1zX4ljJxINFKFsWXItzKB4aBGgiaIzK+4ieQAciBLXWk67/
 qJiqEYdCZ5xoQ9yFhH6IDB8BbYvJPwDn87p0/yaQ2ueTu21mXaJwjRy179gkkCE08wuTaTl
 Dr7TIhEmMAYq0753JniZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MNAv/bxmGEs=:NveHjnIbzIHSUN/C3ggHrc
 EmvWVnFWRKAI7BRxkCXBNL4iO5K54ho5QJwE2WNhMZZsgHLqoxN5+8207EbW/gGfVL06bNyqW
 HStc6I/hHF51PelWs4eEvIwLcEXsfF6OEvlWK0MmezO+K2080BKiIfEQjGfVrLrTBYPVeSzgY
 6KptLxI+oyyJDx20A4qiVHlTSd112HvU54MW6iQn2DLMnWL2qTfOBiVJTLnwG0AgSOHa2FGxh
 A7sfJEHIqHzwbWRfTHlE68oMRk2yl4ic+dpUMS4rpQOA+Hmub6dLtrGJ87UXmfFWCTNAivwjs
 65te5uoZkKwA/iC5CHJrqauW0H83s/ezqdCt8eya9mfjmW0mtAOb4kFbZAvqfmed8+qWYJH9T
 sstGLB8/pXKk4LxXKpf8ShurM+d+kJPdWrXMZ85Ir8z4VMdwCjy3893dOVM9ZoVJpMfzpqL+P
 D0UKheHhSA==
X-Spam-Status: No, score=-101.3 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Mon, 01 Feb 2021 10:34:59 -0000

Hi Anton,

On Jan 29 14:29, Anton Lavrentiev via Cygwin-patches wrote:
> - Use %S (instead of %s) when a wide-character output is due;

Please use %ls, %S is non-standard.

> - Use native byte order for host and add port when doing I/O with DNS server;

This puzzeled me a bit so I took another look into the original code.
Do I see this right that we have only limited IPv6 support in the
resolver code?  For instance, write_record appears to handle DNS_TYPE_A,
but not DNS_TYPE_AAAA.

CCing Pierre, hopefully he's still around.  Pierre, can you please
have a look and suggest how to go forward here?

> - Use forward way for resolv.conf's "options" processing, so listing "debug" as a
>   first option, will show all following option(s) as they are read;
> - Re-evaluate debug output flag after each "options" processing as it may chance.

Would you mind to split this into a patchset with patches for different
tasks?  ATM I'm a bit concerned about the ntoh{sl} calls, given the
noticable absence of IPv6 support...


Thanks,
Corinna
