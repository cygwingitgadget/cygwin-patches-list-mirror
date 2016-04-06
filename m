Return-Path: <cygwin-patches-return-8557-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 40713 invoked by alias); 6 Apr 2016 12:23:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 40694 invoked by uid 89); 6 Apr 2016 12:23:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=HX-Envelope-From:sk:Johanne, H*Ad:U*cygwin-patches
X-HELO: mout.gmx.net
Received: from mout.gmx.net (HELO mout.gmx.net) (212.227.17.20) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Wed, 06 Apr 2016 12:23:00 +0000
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0M4CB5-1bfC1624Nn-00rqZD; Wed, 06 Apr 2016 14:22:55 +0200
Date: Wed, 06 Apr 2016 12:23:00 -0000
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Thomas Wolff <towo@towo.net>
cc: cygwin-patches@cygwin.com
Subject: Re: Fwd: Re: [PATCH] Be truthful about reporting whether readahead is available
In-Reply-To: <5703ECD7.1080502@towo.net>
Message-ID: <alpine.DEB.2.20.1604061422140.3371@virtualbox>
References: <4b19a1f32862208db6121371bd7ef395f6699535.1459846294.git.johannes.schindelin@gmx.de> <20160405135549.GE26281@calimero.vinschen.de> <748397985.175721.a41cd152-02d9-4741-9845-0d01439e7852.open-xchange@email.1und1.de> <5703ECD7.1080502@towo.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-UI-Out-Filterresults: notjunk:1;V01:K0:OrUifCy/jKs=:faJAtgoLIyntbKtmeWz7Wl yWC+MaN6tLROjULbASbZRdhR45MK3V0/Ka/Du2lIciBSpmjz3NpU1q4cWJ8GpZKAMJ6MA3ZYI q7VFjkHMeGhMuKeLRVO2KClzsXZLf9KSGvwSKq3XQMOyGlrSe/s19ey6A1RWNVNFRdokNSR9i PYvzD/LLcYGsSQQkl0ZJ5kKcLrCKgXJHhWFJKl5QxJpC3zBchA6KTw6N0RovWNe/elRNyTnZx s1pJtPeC5aZFbqNngmHCziYwoHA6reybCIAaW581a7YaZ+jgzIB2pYUfNOBlBtd57TnRf0Mi4 JYbdzuhR/sjNYwS71LF+Zj2PIxvqCqeuZ3dwEch8n2PzPnL1onGPjtEks3Xx1iwWzCccqftsa tmIc2kduWJLvwZmZtAPI6apA08aDCnHQl0BB+N0AmhvzP5P+X1+8XkLg7QQopeHVJLFWxEGTa Bi7o0vnrPx7t0/f3EDimJ06Xdjj28CV+UVxMr5gQY7UbtEmuzO+rYSRRyeL04wb4bLAxJHRyC f7veZDbh1UeEULC3I1aSZYhPmptlcg5OKxB4lDRXWNZUdt0fwKaXh1FxXVJF4lX0cvKZmnDJe 8rUytwDAE/8DBrMOv+33GYrztukB9t4And7c/WYIz2g9Jhrll6SfEbIYmWZBtUMy9ljMSJ1FA uL4oOcbwTrhsB+sSci33Tv5LsWbSrFOxbSckdhzKQSPiMKk2DbSdx3zaNykfqbCShTsIVpYbr lZ0whxngPSPrSnoVJsvwRchLCorEOoW6I9Ww8bwOszsVUdcG6o6hvZ2WdUFZR+NGv/XyGlVir ZAkjQwS
X-IsSubscribed: yes
X-SW-Source: 2016-q2/txt/msg00032.txt.bz2

Hi Thomas,

On Tue, 5 Apr 2016, Thomas Wolff wrote:

> > > Betreff: Re: [PATCH] Be truthful about reporting whether readahead is
> > > available
> > >
> > > Thomas?
> > >
> > > Any input?
> > >
> Yes, let's fix the patch so. Sorry for the flaw.

No big deal, thanks for the ACK!

Ciao,
Johannes
