Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id 997FD382D83C
 for <cygwin-patches@cygwin.com>; Fri, 22 Jan 2021 12:20:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 997FD382D83C
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M7auJ-1l6Ws03V2z-007zI0 for <cygwin-patches@cygwin.com>; Fri, 22 Jan 2021
 13:20:57 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 5B374A80D50; Fri, 22 Jan 2021 13:20:57 +0100 (CET)
Date: Fri, 22 Jan 2021 13:20:57 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/4] Improve pseudo console support.
Message-ID: <20210122122057.GE810271@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210121205852.536-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210121205852.536-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:wK2ONlJeTaIeZS8noAPCn5eDfZ0DLSKxgHCF9Rm9OmnoI63WFdZ
 Sv0RXkZZkQnNeYs5Y0V0PGQkfqXn0cy4nNJRFiS8uoSUtp83lHwL+Nm4g2WUcQ6xGu4Hb3b
 bDcqWNOO1Pwec7rrsxzkeHjntox/wXiyaryw0Un/SFa885tCP9tTVsC2gtfJvFDsXPItm+n
 gptzyMdmJNYGGiUWIVP1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KXUnzvWrnuQ=:rTDwJvYsCGXO+GcyZ1zZmq
 EIN5lYVwXwmRjwep3elRC0kxD5RYrx4n3i3I+yQMsBI6JQwF5rUOJ7fBGZZG2e5DVsnuiQj5s
 XxeMwgCcU37HeFNcZh+xtUHBpCMOCzWHtIsL7G6viXJCHjGWOw9r/yXPuFwTolpceHOws81Jn
 zNKtm1lzpfOuTwQORG80ATvzMiSwvb6E9X1EtpnRL4WLUQ1+EY8dcWdw5gZp4pV5d8W8iIvkP
 Lemb6rG+LapHDWqWEtE/sY3SJfyTRsdxqfHGDD6BnFeuo/9oJMEOTfUngVuxAtCd39wAgNf1T
 hAQ4Ok09j9sMfnceqgXD2g/jG7FCCitLa3cRcB2Ax2rC+6hcbkrHMJkLDDkGfMJHxcCAw/G+U
 GR53iVAGOm2eCF/MHzxSuHkcm2+o+M5i+Oqx/HdHJjEQ8eSSqGrsdWwmWHp4jkY17qv1vkqRF
 GH/aij5dxg==
X-Spam-Status: No, score=-100.9 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Fri, 22 Jan 2021 12:21:01 -0000

Hi Takashi,

On Jan 22 05:58, Takashi Yano via Cygwin-patches wrote:
> The new implementation of pseudo console support by commit bb428520
> provides the important advantages, while there also has been several
> disadvantages compared to the previous implementation.
> 
> These patches overturn some of them.
> 
> The disadvantage:
>  1) The cygwin program which calls console API directly does not work.
> is supposed to be able to be overcome as well, however, I am not sure
> it is worth enough. This will need a lot of hooks for console APIs.
> 
> Takashi Yano (4):
>   Cygwin: pty: Inherit typeahead data between two input pipes.
>   Cygwin: pty: Keep code page between non-cygwin apps.
>   Cygwin: pty: Make apps using console APIs be able to debug with gdb.
>   Cygwin: pty: Allow multiple apps to enable pseudo console
>     simultaneously.
> 
>  winsup/cygwin/fhandler.h      |  15 +-
>  winsup/cygwin/fhandler_tty.cc | 805 ++++++++++++++++++++++++++--------
>  winsup/cygwin/spawn.cc        | 102 +++--
>  winsup/cygwin/tty.cc          |  11 +-
>  winsup/cygwin/tty.h           |  18 +-
>  5 files changed, 730 insertions(+), 221 deletions(-)
> 
> -- 
> 2.30.0

I found a problem with this patchset.

Try this:

  Start mintty

  $ touch foo
  $ attrib +r foo
  $ gdb /bin/rm
  $ start foo

  At this point, starting rm will take a few seconds.  While GDB is
  still working on this, *before* GDB returns to the prompt, type some
  keys on keyboard, e. g., "1234".

Without this patchset, you'll see the keys being echoed in mintty, and
as soon as GDB returns to the prompt, the keys are copied to GDBs input
buffer and the keys you typed show up after the prompt.  This is the
expected behaviour.

  (gdb) 1234

With this patchset, the keys are *not* echoed in mintty, and as soon
as the GDB prompt returns, the keys are still not visible.

Now continue the execution of rm:

  (gdb) c
  /usr/bin/rm: remove write-protected regular file 'foo'? 

Without this patchset, I get

  /usr/bin/rm: error closing file
  [...]
  [Inferior 1 (process 1224) exited with code 01]
  (gdb)

That's not optimal, apparently.  With this patchset:

  (gdb) c
  /usr/bin/rm: remove write-protected regular file 'foo'? 1234

so the keys typed while gdb was starting rm have been saved up and then
used as input for rm.  That's not quite right either, is it?


Thanks,
Corinna
