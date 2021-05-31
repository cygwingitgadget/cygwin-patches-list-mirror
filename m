Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id 9B67B38515D5
 for <cygwin-patches@cygwin.com>; Mon, 31 May 2021 08:17:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9B67B38515D5
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MjSLi-1l8Gg636JG-00l047 for <cygwin-patches@cygwin.com>; Mon, 31 May 2021
 10:17:44 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 1C741A80705; Mon, 31 May 2021 10:17:44 +0200 (CEST)
Date: Mon, 31 May 2021 10:17:44 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: respect PC_SYM_FOLLOW and PC_SYM_NOFOLLOW_REP
 with inner links
Message-ID: <YLSbqEipANVY8KSZ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <alpine.BSO.2.21.2105291322180.30039@resin.csoft.net>
 <alpine.BSO.2.21.2105291600460.30039@resin.csoft.net>
 <alpine.BSO.2.21.2105292259570.30039@resin.csoft.net>
 <alpine.BSO.2.21.2105301213380.30039@resin.csoft.net>
 <YLSYIC/yYFz2IdMS@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YLSYIC/yYFz2IdMS@calimero.vinschen.de>
X-Provags-ID: V03:K1:rf4r4FNwN7xTwVBD2BC7s7TTyWymrTytaINDoALa+QZaC5ZeDFK
 EAcvMWXPBsh64fEhBlrBtfn0FCHC52BwJjP0lx4pzXrON0zYrqBHGrGTvsRAZdFnBDvpxDM
 B6kur3vOzjy2tahN8KE0yD6mF7Ri16AjKSJSq9tv5OYQRhU+X6HtvTJrkyBlPq/5IKVgE8Z
 swY4GCYffKqACl+h8ENug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tUK7QBIu1XI=:Vnbae4+kWQNmJnfsK/+8s2
 rJVSb2Q0CdDwfvpxA1p5RzuCzrMwljuFr8+A70EhFjZ6+Z8M3fUK5YOvv4aDgE54v1XmOANV7
 vQzKk7nt7lPwJlJljbyBPdcbFK2Nuc17YzUlpbycGc154Yw1bvoRndKqx9QpQtEf3dR9cPik9
 6m6Rq8LSDL4O4eSodDrlw5RXBvJEzA5aVy+61Pq4jD8iw+P2UPUBDcZCU8Ql680BBgoeuOYv1
 7FJnztCYGXvU1LKQbspc5uKOUmtejtFUp+2XmGHr4xUdnXd6WaKj8Y2nw/SJVKuWpATlE3GA7
 VDp+U5RX/YHpC8Csn7ZV7bT7rvjm8UzloKVj4jFi39IcuLn+tWlcnenlsLO84AMH1ai9EzPHk
 IS9SUleGJIGcVdGNoi4dqJdvSa2yQhfM4q0cNQV6QkczkT5j12/oP752PX3u5r9qodoVzAOa6
 xRkm2P7uvFaL+diCSGQ2MyH5mN5VCiyPb00d5lr1izOkQvmwx6AtPsrcsi9hDHCR/u7S04xwb
 RC6YPPzswgHHAvOZLGs2oo=
X-Spam-Status: No, score=-100.4 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 31 May 2021 08:17:50 -0000

On May 31 10:02, Corinna Vinschen wrote:
> On May 30 12:58, Jeremy Drake via Cygwin-patches wrote:
> > First, revert the handling of virtual drives as non-symlinks.  This is no
> > longer necessary.
> 
> I'm all for it, because I like the idea that Cygwin can see virtual
> drives as symlinks, but...
> 
> > The new GetFinalPathNameW handling for native symlinks in inner path
> > components is disabled if caller doesn't want to follow symlinks, or
> > doesn't want to follow reparse points.  Set flag to not follow reparse
> > points in chdir, allowing native processes to see their cwd potentially
> > including native symlinks, rather than dereferencing them.
> 
> So you're trying to keep the path length of the native CWD below
> MAX_PATH?  I understand what you're trying to accomplish, but are
> you sure this doesn't break Cygwin processes?  The idea of what
> the native path of a directory is differs depending on calling
> chdir and stuff like mkdir.

What bugs me here is that there's no guarantee that you can keep your
path below MAX_PATH, independently of what you do here.  This is all
a bit like patching up left and right just to keep dumb native tools
running even in scenarios where they just fail otherwise.

So we have two contradict problems, one which is solved by following
inner symlinks, one which is solved by not doing that... I'm not overly
keen to support this scenario.

Wouldn't that be something more suited for an MSYS2-local patch?


Corinna
