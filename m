Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id 3FB84385780C
 for <cygwin-patches@cygwin.com>; Thu, 15 Oct 2020 08:16:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3FB84385780C
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MBlpC-1kaiCf1YNQ-00CBRQ for <cygwin-patches@cygwin.com>; Thu, 15 Oct 2020
 10:16:13 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id BBC51A82BC2; Thu, 15 Oct 2020 10:16:12 +0200 (CEST)
Date: Thu, 15 Oct 2020 10:16:12 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/6] Some AF_UNIX fixes
Message-ID: <20201015081612.GD26704@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201004164948.48649-1-kbrown@cornell.edu>
 <87bd83c6-5333-6287-01ce-d91ffec83244@cornell.edu>
 <20201013114933.GJ26704@calimero.vinschen.de>
 <ea3b1e6a-8857-cd1f-349d-6fc64c2d1b77@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ea3b1e6a-8857-cd1f-349d-6fc64c2d1b77@cornell.edu>
X-Provags-ID: V03:K1:V/B0JW/fwKiuuhoaH36xYFm+t3uYNzZOpUz9RGdOTLAbfQBSM/E
 fCdvbxUYTQJJVIlE60ov9c+8Z+xB0s2Yd6m2RW7tPaYvmALx0KPEHVPjPkhkO2QE4uuXqdN
 M0ODS/WyLCFSKPRwWIllGh4e3mtkF4ZXVaxhAG1/P1a+u5TO5LzZOzp/Z9QrgmHQumZOV04
 dtp/uvX+qdY48xRpLnXEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4nWPv8t6UiY=:7EFLEmmFpoz0TOmCyky87v
 8r5pWmX5ygMBTnn4x8FqhDO3K3YGdoBLAnl0yAGTckBLMbETuLz6DowjWtN22JSOU8nZcysPx
 oD7kLYlFQP9k4k1UPwCBpWSd9U+YQx1M4cICtMso164JLDsVSIjLiSs4bWPQ7paWuhQSJcE6o
 slHn2a3y765agOQV9h9PQEXMUXaw9PqR2QlAUZ5OJ1uwDbVPcu2WTL+0q7cV/V4RkNzr9TXpE
 8smh72Ie+X3R0q7OBGlQAEaegQwWpAO/3h+x1oJSkmo8wCwmfrBUPh2diF3xXZz78ilIkM4ha
 DzRZpB/8+38StIVzbxLlE+0kOA0kUZlZjj+DAOiSY6qEE46LomN1EQnQJ/9t3/uBCBtB0k5l2
 FVPYvvkRUiigw71cRKvA/e7UWa/ijb/SJRwFVkkuR9AeNbTq1Z2yZLVNV7v6N+SkGyYtx7a+n
 BTvFyUXH6A==
X-Spam-Status: No, score=-100.4 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
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
X-List-Received-Date: Thu, 15 Oct 2020 08:16:17 -0000

On Oct 14 12:39, Ken Brown via Cygwin-patches wrote:
> On 10/13/2020 7:49 AM, Corinna Vinschen wrote:
> > On Oct  8 17:36, Ken Brown via Cygwin-patches wrote:
> > > On 10/4/2020 12:49 PM, Ken Brown via Cygwin-patches wrote:
> > > > I'm about to push these.  Corinna, please check them when you return.
> > > > The only difference between v2 and v1 is that there are a few more
> > > > fixes.
> > > > 
> > > > I'm trying to help get the AF_UNIX development going again.  I'm
> > > > mostly working on the topic/af_unix branch.  But when I find bugs that
> > > > exist on master, I'll push those to master and then merge master to
> > > > topic/af_unix.
> > > 
> > > FYI to Corinna and anyone else interested in AF_UNIX development.  After
> > > pushing a few patches to the topic/af_unix branch I did some cleanup
> > > (locally) and merged master into the topic branch.  I don't want to do a
> > > forced push and risk messing up the branch, so I've created a new branch,
> > > topic/af_unix_new, and will do all further work there until Corinna returns
> > > and decides how we should proceed.
> > 
> > No, that's ok, just force push.
> 
> OK, I've done that now.  The branch contains a few sendmsg fixes, a first
> cut of a recvmsg implementation, and a merge from master.  I've done some
> testing of recvmsg, but many things are not yet tested.  I'll work on
> continued testing next.

This is sooo great!

> from Kerrisk's book, because that's what I read to learn the basics of
> sockets.  But those are just examples and are not meant to be comprehensive.

What Mark and Brian said, Stevens' book is quite nice, and there's
code available.  I downloaded the tar file with all code examples
way back when, but apparently the code is on github now, as Brian
pointed out.


Thanks,
Corinna
