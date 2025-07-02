Return-Path: <SRS0=Hj8f=ZP=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 91B2A385782C
	for <cygwin-patches@cygwin.com>; Wed,  2 Jul 2025 17:37:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 91B2A385782C
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 91B2A385782C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751477832; cv=none;
	b=tHePz+19o1evY3ED7Nv+KeVMtMPsSERovHXk6BITa16kkSrgysNOX7kq1V7dolPe4S4iy5RT66k1cK9tiBvn0ohDSvjoREuKzwuPJxlWp/qpuxE/3ItochILslc7pmakM+68dne0T8pyQt6R1G4tXntnZ8RbnMhdbITeJgbNe00=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751477832; c=relaxed/simple;
	bh=eDxu9tKP3LnmZ+F5NgY7Ovx4ulEtFttxkF2iOyaw5KI=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=K46kErag3k08LJi3mrJUkv9IOdHXKxo1WRpc7bZQY/VVBkBPRzUbltlBK5ZeHTO7JQMtrvoJBlJoEYWweEtieyOPJnaPF5CZ9SO5/LjH+Jhxt/RcriTSlxV3wv6it4xSjOOb2WPYmPutvL/KD6ltsZqT03iu6A5FxmzhfHcvgcw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 91B2A385782C
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=eT8Jbgm1
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 6BAE645CA9
	for <cygwin-patches@cygwin.com>; Wed, 02 Jul 2025 13:37:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=pBxmtI0W4byjhKYlIQ1i/4kuuYA=; b=eT8Jb
	gm15RybpSm74Qylo6yFVDPL+i2UIFIsBMyLp1Dm0lsvhH+izHbcJ3cV8oh29fZPN
	V5kwaeSNb8hj0OVgTDahAtsjSksIAjcWY41xqsYnzhafqPXeC+HIsT2VvneULbP5
	sRCgCaSQnrQqWfK/NI/TdLe4G7yUuga2LUmzM8=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 640EB45CA8
	for <cygwin-patches@cygwin.com>; Wed, 02 Jul 2025 13:37:12 -0400 (EDT)
Date: Wed, 2 Jul 2025 10:37:12 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3] Cygwin: testsuite: add a mingw test program to
 spawn
In-Reply-To: <aGUMafwtImU7wGrZ@calimero.vinschen.de>
Message-ID: <1fd4e2b5-bbcc-4f5f-0085-c3138bdc914c@jdrake.com>
References: <a2f0eb68-cc70-c6c3-0d45-5c50f90494d0@jdrake.com> <aF6OibgUJ3IUvmLN@calimero.vinschen.de> <9555bc63-d6ae-e1ad-6b94-82712e1e9f2b@jdrake.com> <aGJeJH1rLCeitrqo@calimero.vinschen.de> <8d3b0ebf-4766-cf94-13c0-8176a8ac3da7@jdrake.com>
 <aGUMafwtImU7wGrZ@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,KAM_ASCII_DIVIDERS,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 2 Jul 2025, Corinna Vinschen wrote:

> On Jun 30 10:11, Jeremy Drake via Cygwin-patches wrote:
> > On Mon, 30 Jun 2025, Corinna Vinschen wrote:
> >
> > > On Jun 27 10:34, Jeremy Drake via Cygwin-patches wrote:
> > > > On Fri, 27 Jun 2025, Corinna Vinschen wrote:
> > > >
> > > > > On Jun 26 13:31, Jeremy Drake via Cygwin-patches wrote:
> > > > > > BTW, I noticed while editing mingw/Makefile.am, shouldn't cygload have
> > > > > > -Wl,--disable-high-entropy-va in LDFLAGS?
> > > > >
> > > > > Why?
> > > >
> > > > With high-entropy-va, it has been observed that the PEB, TEB and stack can
> > > > happen to overlap with the cygheap
> > > > https://cygwin.com/pipermail/cygwin/2024-May/256000.html
> > >
> > > Yeah, but HEVA simply breaks fork.  We don't have to test this, because
> > > it won't work and we don't do it.  You can set the PE flag, but than
> > > you're on your own.
> >
> > Outside of fork, is cygheap able to "relocate" in case the memory it would
> > like to occupy is already used?
>
> I don't think so, without checking and, well, fixing every pointer usage
> potentially pointing into the cygheap.  Even fhandlers have pointers to
> fhandlers...
>

So shouldn't any user of the cygwin dll then need
-Wl,--disable-high-entropy-va to avoid the chance that Windows places its
structures where cygheap wants to be?

#define CYGHEAP_STORAGE_LOW    0x800000000UL
#define CYGHEAP_STORAGE_HIGH   0xa00000000UL

  cygheap = (init_cygheap *) VirtualAlloc ((LPVOID) CYGHEAP_STORAGE_LOW,
                                           CYGHEAP_STORAGE_HIGH
                                           - CYGHEAP_STORAGE_LOW,
                                           MEM_RESERVE, PAGE_NOACCESS);


0:000> !gle
LastErrorValue: (Win32) 0x1e7 (487) - Attempt to access invalid address.
LastStatusValue: (NTSTATUS) 0xc0000018 - {Conflicting Address Range}  The
specified address range conflicts with the address space.

From the linked email, the failing memory layout with high entropy va set
was:

        BaseAddress      EndAddress+1        RegionSize     Type
State                 Protect             Usage
--------------------------------------------------------------------------------------------------------------------------
+        5`e8181000        8`05a00000        2`1d87f000             MEM_FREE    PAGE_NOACCESS                      Free
+        8`05a00000        8`05b57000        0`00157000 MEM_PRIVATE MEM_RESERVE                                    <unknown>
         8`05b57000        8`05b58000        0`00001000 MEM_PRIVATE MEM_COMMIT  PAGE_READWRITE                     PEB        [4628]
         8`05b58000        8`05b5a000        0`00002000 MEM_PRIVATE MEM_COMMIT  PAGE_READWRITE                     TEB        [~0; 4628.31ac]
         8`05b5a000        8`05b5c000        0`00002000 MEM_PRIVATE MEM_COMMIT  PAGE_READWRITE                     TEB        [~1; 4628.4aac]
         8`05b5c000        8`05b5e000        0`00002000 MEM_PRIVATE MEM_COMMIT  PAGE_READWRITE                     TEB        [~2; 4628.5840]
         8`05b5e000        8`05b60000        0`00002000 MEM_PRIVATE MEM_COMMIT  PAGE_READWRITE                     TEB        [~3; 4628.6b9c]
         8`05b60000        8`05c00000        0`000a0000 MEM_PRIVATE MEM_RESERVE                                    <unknown>
+        8`05c00000        8`05df6000        0`001f6000 MEM_PRIVATE MEM_RESERVE                                    Stack      [~0; 4628.31ac]
         8`05df6000        8`05df9000        0`00003000 MEM_PRIVATE MEM_COMMIT  PAGE_READWRITE | PAGE_GUARD        Stack      [~0; 4628.31ac]
         8`05df9000        8`05e00000        0`00007000 MEM_PRIVATE MEM_COMMIT  PAGE_READWRITE                     Stack      [~0; 4628.31ac]
+        8`05e00000        8`05ffb000        0`001fb000 MEM_PRIVATE MEM_RESERVE                                    Stack      [~1; 4628.4aac]
         8`05ffb000        8`05ffe000        0`00003000 MEM_PRIVATE MEM_COMMIT  PAGE_READWRITE | PAGE_GUARD        Stack      [~1; 4628.4aac]
         8`05ffe000        8`06000000        0`00002000 MEM_PRIVATE MEM_COMMIT  PAGE_READWRITE                     Stack      [~1; 4628.4aac]
+        8`06000000        8`061fb000        0`001fb000 MEM_PRIVATE MEM_RESERVE                                    Stack      [~2; 4628.5840]
         8`061fb000        8`061fe000        0`00003000 MEM_PRIVATE MEM_COMMIT  PAGE_READWRITE | PAGE_GUARD        Stack      [~2; 4628.5840]
         8`061fe000        8`06200000        0`00002000 MEM_PRIVATE MEM_COMMIT  PAGE_READWRITE                     Stack      [~2; 4628.5840]
+        8`06200000        8`063fb000        0`001fb000 MEM_PRIVATE MEM_RESERVE                                    Stack      [~3; 4628.6b9c]
         8`063fb000        8`063fe000        0`00003000 MEM_PRIVATE MEM_COMMIT  PAGE_READWRITE | PAGE_GUARD        Stack      [~3; 4628.6b9c]
         8`063fe000        8`06400000        0`00002000 MEM_PRIVATE MEM_COMMIT  PAGE_READWRITE                     Stack      [~3; 4628.6b9c]
+        8`06400000      19e`64400000      196`5e000000             MEM_FREE    PAGE_NOACCESS                      Free
