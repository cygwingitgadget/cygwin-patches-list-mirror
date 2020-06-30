Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id B1ACB3858D37
 for <cygwin-patches@cygwin.com>; Tue, 30 Jun 2020 10:30:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B1ACB3858D37
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M1HqM-1jnTiL1xfu-002lda; Tue, 30 Jun 2020 12:30:43 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 9CD17A80864; Tue, 30 Jun 2020 12:30:40 +0200 (CEST)
Date: Tue, 30 Jun 2020 12:30:40 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Mingye Wang <arthur2e5@aosc.io>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: rewrite cmdline parser
Message-ID: <20200630103040.GC3499@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Mingye Wang <arthur2e5@aosc.io>,
	cygwin-patches@cygwin.com
References: <20200624223553.8892-1-arthur2e5@aosc.io>
 <20200625144315.12388-1-arthur2e5@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200625144315.12388-1-arthur2e5@aosc.io>
X-Provags-ID: V03:K1:9xV6tySD5LFULToOSOBMhFin6PaEwOKWCZlJJc7ag8YQivo6aiw
 vjhq8QQ5BORoPtoR83xpJPs1okU0oYnTv9K2Thdg8PkhD/1Q0UlSPPcOZZrl7a6woklhrp5
 +5pwnvdyFXOc8t2qTxAFuruMqinDmsxIgj9Efqyq3pR+QexUC+hU9fHauJCz/suT0LXY1Da
 1XxhQ8pAoXndwq1W5rTeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3+c5dqfH8eA=:cKEbiOUW5l3HqesGLvwhHn
 gSiCSdtY6qR8Rtf7C+YxdsLfzzdheJv4GOKAyFKwGZL8MyHbUr5t7f/pdak1iUSq2J4BxG4l2
 UOWqtYi8ji02lsD2Yz8+KQhXVoIfi3ilWCyosKRF/DuK4HHCSdvkaak6cggcJMHfQm9LHK7wA
 fAZWOizmY9PATa4+zfYAIhPSjUMhM47E25z3NuNE74+BHNcmb+Wh9P7bdjLMyaPNTd3vbKHgz
 KEghg98LgTjKORrjYESVPy5OUp/mFg/78qD7PYp4ZURIbQcfqaXkuZ5CW5u6kxLz18/9NKu6R
 /WUuQLTeeBowGuQGMlZLl4Lob1oO4Ni4dtY/wWAj9VXpxmanTGpxCDYkZ/SEs/vfd54Zxuv11
 nqB8AGI4Drt64HOiG6r02MV0JqHpwvdxsHxvhCSUG9yofNxtGS8R8qs9aCFBocqQXk/izr1GE
 AHxQ3iZv9tThGsKjZ06QaXNjKGCuc6BQeQCF53xYl4e131QgYndpgluCgnDt2mwevmJ0yC/1M
 IO0xijC/N4vWrljveqVR45sHtHLNoe8E1duD6g0SbPKaOXPhx8e/FRdsam1JVF2To9xhfqZfK
 qm16OXCATYM3aEFmtc4f2vjZcYbI0obDA6oFMtlB7F3B00kt/bVoSorSnsMu0YvriT/Zc4vsC
 rFp8JrgoDB2y2MjzK1iRqVS+AAfqbiJQoDEWn+bhW4E2j15AiwelSBgY0yth67UyFqhABouC8
 pq1UlFNq3rSdGBqo//Jo8qK1xOZsOZ8wb/wHWxjJHEolcfP+4XMhJWyKtw/O98nzZZdnOfB36
 DNptAe4P0nOWjnLjPdxx1Y5JDLGhWasdliAiWsIzzL04dLeKJYaLa2mGL2LdK7OvaLdpUff
X-Spam-Status: No, score=-99.2 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 30 Jun 2020 10:30:48 -0000

Hi Mingye,

On Jun 25 22:43, Mingye Wang wrote:
> This commit rewrites the cmdline parser to achieve the following:
> * MSVCRT compatibility. Except for the single-quote handling (an
>   extension for compatibility with old Cygwin), the parser now
>   interprets option boundaries exactly like MSVCR since 2008. This fixes
>   the issue where our escaping does not work with our own parsing.
> * Clarity. Since globify() is no longer responsible for handling the
>   opening and closing of quotes, the code is much simpler.
> * Sanity. The GLOB_NOCHECK flag is removed, so a failed glob correctly
>   returns the literal value. Without the change, anything path-like
>   would be garbled by globify's escaping.
> 
> Some clarifications are made in the documentation for when globs are not
> expanded.  A minor change was made to insert_file to remove the memory
> leak with multiple files.
> 
> The change fixes two complaints of mine:
> * That cygwin is incompatible with its own escape.[1]
> * That there is no way to echo `C:\"` from win32.[2]
>   [1]: https://cygwin.com/pipermail/cygwin/2020-June/245162.html
>   [2]: https://cygwin.com/pipermail/cygwin/2019-October/242790.html
> 
> (It's never the point to spawn cygwin32 from cygwin64. Consistency
> matters: with yourself always, and with the outside world when you are
> supposed to.)

Apart from the small free() problem, you mention in your reply to self,
this patch looks great at first glance.

Three questions/requests if you don't mind:

- Would you mind to send the corrected version yet?

- A contribution like this still(*) requires the 2-clause BSD waiver per
  the winsup/CONTRIBUTORS file, see the chapter "Before you get started"
  on https://cygwin.com/contrib.html

- Can you please take a bit of time and try to outline in how far this
  change introduces backward compatibility problems with the old code?
  I don't mean the obvious bug like the backslash problem, but rather
  the question is, what input did something useful before which doesn't
  work the same way now?  I'd like to get a feeling how much this may
  affect existing scripts.


Thanks,
Corinna


(*) IIRC, 2020 is the last year requiring this...

-- 
Corinna Vinschen
Cygwin Maintainer
