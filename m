Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id 1F051385783A
 for <cygwin-patches@cygwin.com>; Wed, 27 Jan 2021 12:40:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 1F051385783A
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MOiPx-1lLPlQ1jqR-00QDVF for <cygwin-patches@cygwin.com>; Wed, 27 Jan 2021
 13:40:55 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id DA168A80D33; Wed, 27 Jan 2021 13:40:54 +0100 (CET)
Date: Wed, 27 Jan 2021 13:40:54 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fchmodat: add limited support for
 AT_SYMLINK_NOFOLLOW
Message-ID: <20210127124054.GT4393@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210126213050.41241-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210126213050.41241-1-kbrown@cornell.edu>
X-Provags-ID: V03:K1:2N7qfeScr7AoK9Yoo4VuahxodXaGTGHyeTgH+j/yhwYyiAs8EbG
 Un9CdpUn/2NIlycoZCRZE/fY8vVkrqpPbfgQGTU39zmfK+WKEQsiq6KIOQd6NPCzTd1mYRz
 vmWV9YcpkvUiTKH5FM0Qm77G8oeZ//6+Lgzu6IDDI7t9aBnW+KLtyJRAfidheDdVgCtREnm
 osv0pkJIG9YvzwbOBEr7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fVda63Yk5MY=:7JEeL/FxdxdSuI42jrCTQa
 aUnPCkn1oF+mrHoxm50mtLekeYekWUpiyFKSZcKMCteCNB1aanJSSqPvj4XimNrtPpzd7t+iI
 NWlklrft5mpcxmgMiknIqXvQThucFdWdifXSkn8jgL+0nN5gM4FBUEZsH7h6sSm3Hh7YKldbb
 HoLuFpfeYczVnx80i8wa79j5Vqthn+/9P3DHhmMN08cOyruYp6nTvZCIxonAT4NKteGs+2gtU
 jE1BwF+ZTSFzHRGbEcYalnxxg6s4Py3BboICdCtdyB8DTpQaxj/gSZS5QNbsMueAmoX2ShahI
 DohoxcGSpN75f7Exwkbzq3AbLBc9B3KvrWIieS2J356PXZwejQRTQWkqcs3RxF0xTAXcwFUPa
 oyGR0kgDFr0/ccJA4kxPRg2e86s+7iobQAM9bAeRqlPMaMbEXSlY+H7TZABlNUGtQAH8bQVmE
 5KU9hgQWrg==
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
X-List-Received-Date: Wed, 27 Jan 2021 12:40:58 -0000

On Jan 26 16:30, Ken Brown via Cygwin-patches wrote:
> Allow fchmodat with the AT_SYMLINK_NOFOLLOW flag to succeed on
> non-symlinks.  Previously it always failed, as it does on Linux.  But
> POSIX permits it to succeed on non-symlinks even if it fails on
> symlinks.
> 
> The reason for following POSIX rather than Linux is to make gnulib
> report that fchmodat works on Cygwin.  This improves the efficiency of
> packages like GNU tar that use gnulib's fchmodat module.  Previously
> such packages would use a gnulib replacement for fchmodat on Cygwin.

Wait, what?  So if Cygwin behaves like Linux, gnulib treats fchmodat
as non-working?  So what does gnulib do on a Linux system?  Does it
use its own fchmodat there, too?

Puzzled,
Corinna
