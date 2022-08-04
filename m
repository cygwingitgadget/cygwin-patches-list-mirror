Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id 761D938582AE
 for <cygwin-patches@cygwin.com>; Thu,  4 Aug 2022 18:37:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 761D938582AE
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1McGp2-1nhKAL0NkC-00cgFr for <cygwin-patches@cygwin.com>; Thu, 04 Aug 2022
 20:37:25 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 228E0A8075F; Thu,  4 Aug 2022 20:37:24 +0200 (CEST)
Date: Thu, 4 Aug 2022 20:37:24 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: syscalls.cc: remove ".dll" from,
 blessed_executable_suffixes
Message-ID: <YuwR5KZs5lsiqe+j@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <59f6be7b-73ee-4b96-64c5-f31e0bd475a0@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <59f6be7b-73ee-4b96-64c5-f31e0bd475a0@cornell.edu>
X-Provags-ID: V03:K1:97mw8Qg5TWWBKTgvJiiZBiGbTbkcFVce8dFiSWXHikYNbNK1RH8
 XBO53Jrhdmms0pGDgxyJGG5M83WGph0+qyBkb9+/jCiz0r6B/QcodVI9Zgj40mzeONzvgQd
 fy8iJsJcOTB3Ubz2jtOapRrQgnEKioH7Krsm02Q6B0pkF9ciSlAQxTwTcvHcwI2sc1CjLh8
 cdV2yA3WrUF89Wop8v4Gw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HNQYAdBiEKc=:W1QYa/bXmyf0yC6wfMBx6f
 bv9+gfcGyI2H1ZpeLWsR4b5cXARmEvn/iou5kMH/szKEjKL14rSHU6qE1RYvOLP4IZPG2xiRz
 QohvdDm/gRzyjiuwnZUUdzm3p6/Guxm0zAz5vGeVqs1uuH/+NZqoQtmUM6LPJzavmVYyC6uV2
 P+JJFzuXKhCwq0iRJxzQlj99hhjWuSW6mwSrnKvLRFW/2hXOFB+NvUhdM6Zy627w0Xwkwp2Tn
 i/5ftEP+QUTxrAgnitDVDELa2WdD+GeQ5o/SpmJk3dKuEIUAywK3qnSEyQkERxTNLKvPxLge3
 kGkvY2+X27nVyA0jkjLGEG43g6fnmogZrP0swjbKizSJ7dcqgpEP/eitHGS06XnUoa/7DPDkH
 h82lLZ8mHkXQgTE6hvX8ooOiRRKvykRU/P2KU0nLJu4tIpBgSxcS338Z94YrqENqU6VAOYfC+
 c0kE9BzYqiBDdfmLuLe8E80/EqPgGYhuPM81O0VxUrSFF9dIyMhLb8ke0qudAXuFWrQMnv7UW
 QdkH4BZ+lOzjBu8YSN7FrNifS+8ipgvZgB9ddhJXe8GY6kHMqUDkbo3cbQYeQJLUqP2BoZ0OW
 ji1IWyoSRxg6eAczZve8G4zz3f3a8YXHlQBcbL0S0DON/F8bsB15LV71UEX4nqHOfXS+07iLC
 /+E01kn+Ie4MK0eqHpGkFb/PvhOYHuXWOiKcyr+7KYAe/CvX3w4LX3S4HGJJn2fjkBp0uVfyU
 hONGZqFfy3r2tJ8dcRDvuUSwO5xqt9wrXaZEJ981NII5k1YgGAlJpmyBVwI=
X-Spam-Status: No, score=-95.7 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_FAIL, SPF_HELO_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.6
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
X-List-Received-Date: Thu, 04 Aug 2022 18:37:28 -0000

On Aug  4 08:00, Ken Brown wrote:
> Patch attached.  I'm not 100% sure of this since it does change behavior
> (but in a weird case).
> 
> Ken

> From 97a2fc0d07c8f9045b73716ac5a05f972d5bd75c Mon Sep 17 00:00:00 2001
> From: Ken Brown <kbrown@cornell.edu>
> Date: Wed, 3 Aug 2022 16:45:23 -0400
> Subject: [PATCH] Cygwin: syscalls.cc: remove ".dll" from
>  blessed_executable_suffixes
> 
> This reverts commit d9e9c7b5a7.  The latter added ".dll" to the
> blessed_executable_suffixes array because on 32-bit Windows, the
> GetBinaryType function would report that a 64-bit DLL is an
> executable, contrary to the documentation of that function.
> 
> That anomaly does not exist on 64-bit Windows, so we can remove ".dll"
> from the list.  Reverting the commit does, however, change the
> behavior of the rename(2) syscall in the following unlikely situation:
> Suppose we have an executable foo.exe and we make the call
> 
>   rename ("foo", "bar.dll");
> 
> Previously, foo.exe would be renamed to bar.dll.  So bar.dll would
> then be an executable without the .exe extension.  The new behavior is
> that foo.exe will be renamed to bar.dll.exe.  [Exception: If there
> already existed an executable (not a DLL!) with the name bar.dll, then
> .exe will not be appended.]
> ---
>  winsup/cygwin/globals.cc  | 1 -
>  winsup/cygwin/syscalls.cc | 6 ------
>  2 files changed, 7 deletions(-)

LGTM.


Thanks,
Corinna
