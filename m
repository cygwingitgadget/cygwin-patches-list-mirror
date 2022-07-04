Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id 43F563858C52
 for <cygwin-patches@cygwin.com>; Mon,  4 Jul 2022 08:37:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 43F563858C52
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MRTIx-1nwXbR2QSr-00NS9U for <cygwin-patches@cygwin.com>; Mon, 04 Jul 2022
 10:37:52 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 25785A80B74; Mon,  4 Jul 2022 10:37:52 +0200 (CEST)
Date: Mon, 4 Jul 2022 10:37:52 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: spawn: Treat empty path as the current directory.
Message-ID: <YsKm4GDa5Zi3VHjK@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220627124427.184-1-takashi.yano@nifty.ne.jp>
 <c4a8d150-4d16-2af5-a7ac-26e42f9befb8@cornell.edu>
 <376762b9-6ef2-4415-b3e6-fbc9be48f183@cornell.edu>
 <20220702083107.8aa64b1046484ab41911d8dc@nifty.ne.jp>
 <ab1226ff-1236-67a0-a140-0f6826fd1778@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab1226ff-1236-67a0-a140-0f6826fd1778@cornell.edu>
X-Provags-ID: V03:K1:z6Vhqf8EKLH3CALeO8KXrNs3A4UzzQvLk7eSey1Opd+51G5ULAm
 wOBLVJYd9faNFVNmlm6r/smL2G3cEmhp2NIfuqBKIDYmLtnLHwizHTOfJhzHZlRcatHEXQH
 DKliwNj1CHpse1lei9rjsbtM0unyS7aFAZO4EP9RB0xnp8MyfdFk6OnztH+tc2t2zHxD522
 fzzgBhyoYQSZKnp2Hz27g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FbQEfg5pTLU=:Q90MZyoEmSutkFw8V25FVJ
 27ROSYvlHXaUNGrkKbY23zwI2XEJLgdU7wsBTYmRo8DSigtvr+LzilTcaMgEcaDLPGx60v5cN
 h9/Lw2jnM+Hdcgclb+JRTzH0ptQhkcoRBq2pFRa7y9k6d0VHERmYGcGZms141L9jsIdiZ0VV4
 VbOEDV1/gl9itxCCZz5fZ3VlflL5uQtU/LQOM5KL7bsSC2uO9zPDttv3ISy9pV/Hxh7ux4PjT
 xJnuWbQYkM3u+tRDN+KOQZwIULAsH9A+7nTsfxFGzd0bOe3T20aejtdOlgf0KlhfSOwiXxmeP
 fWMJeXRO2rpTPnO49fnLis2Y/XGi9Yns6bmgz3eL97x4hc/kDiuZiT/3IO3mUJex7DywfPTp3
 A8Nl+5lFuC5+umjA+WYFaS7139609AGLRkJnhp0yrGYanMJINbhEZPVUoEVWjwrdQd3VJEuFl
 W1gYIu/M33z+I5T3lwd/XH3/oz77EaJGOKNmay6MAe7g1myN7tQKtpBqWWEYs4O+nlaaHfTuZ
 0uXViUJG1XUXRKad1cU8IVcg622cfQ0Zl9yKTtuobEmo3Rde1OYON4KLGmcymA1jkrGekyVM6
 SdbnAi8pP0oWOfZ3BTtk9mVFJnIT6Dk5nGjfsOhPunvt9BI0c0U3lqNyOizZpdrDweua2ZMNl
 HuwmJj/eugOHTT3FcpdvI/AEbrzywU+3nC1Hsw4zUsKYD2JKdRrCwTMoewA/HB8B9JNQX0vwJ
 QIFDUXs5UbIE6BxeEzzV63uZpeZMPH6Q3XtO5OOmqVjgDNCb1K6NY4QGhXM=
X-Spam-Status: No, score=-93.4 required=5.0 tests=BAYES_00, BODY_8BITS,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, KAM_SHORT,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_FAIL, SPF_HELO_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Mon, 04 Jul 2022 08:38:00 -0000

On Jul  1 21:32, Ken Brown wrote:
> On 7/1/2022 7:31 PM, Takashi Yano wrote:
> > On Thu, 30 Jun 2022 21:16:35 -0400
> > Ken Brown wrote:
> > > On 6/30/2022 11:45 AM, Ken Brown wrote:
> > > > On 6/27/2022 8:44 AM, Takashi Yano wrote:
> > > > > - With this patch, the empty path (empty element in PATH or PATH is
> > > > >     absent) is treated as the current directory as Linux does.
> > > > > Addresses: https://cygwin.com/pipermail/cygwin/2022-June/251730.html
> > > > 
> > > > It might be a good idea to include a comment in the code and the commit message
> > > > that this feature is being added for Linux compatibility but that it is
> > > > deprecated.  According to https://man7.org/linux/man-pages/man7/environ.7.html,
> > > > 
> > > >                 As a legacy feature, a zero-length prefix (specified as
> > > >                 two adjacent colons, or an initial or terminating colon)
> > > >                 is interpreted to mean the current working directory.
> > > >                 However, use of this feature is deprecated, and POSIX
> > > >                 notes that a conforming application shall use an explicit
> > > >                 pathname (e.g., .)  to specify the current working
> > > >                 directory.
> > > > 
> > > > Alternatively, maybe this is a case where we should prefer POSIX compliance to
> > > > Linux compatibility.  Corinna, WDYT?
> > > 
> > > I withdraw my suggestion.  There's already a comment in the code saying, "An
> > > empty path or '.' means the current directory", so it's clear that the intention
> > > was to support that feature, and the code was simply buggy.
> > > 
> > > I've now read through the patch, and it looks good to me.  This was pretty
> > > tricky to get right.
> > 
> > We still need to discuss whether it is better to align Linux
> > behavior or just keeping POSIX compliance, don't we?
> 
> I interpreted the existing comment as meaning that a decision was already
> made at some point to align with Linux.  But it can't hurt to wait for
> Corinna to weigh in.

Personally I don't like this old crufty feature and I would rather keep
this POSIX compatible, but in fact it was meant to work as on Linux, so,
please go ahead, Takashi.

However, maybe this should go into the master branch only? WDYT?


Corinna
