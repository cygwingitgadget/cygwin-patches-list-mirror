Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id 64DEA3858D35
 for <cygwin-patches@cygwin.com>; Mon,  6 Jul 2020 08:12:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 64DEA3858D35
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MYNS0-1kMYXC3xNC-00VNRF for <cygwin-patches@cygwin.com>; Mon, 06 Jul 2020
 10:12:00 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 70173A80B98; Mon,  6 Jul 2020 10:12:00 +0200 (CEST)
Date: Mon, 6 Jul 2020 10:12:00 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/8] Fix dumper for x86_64
Message-ID: <20200706081200.GA514059@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200701212529.13998-1-jon.turney@dronecode.org.uk>
 <e058a12f-97b2-d237-a97f-4a691bf5c6e3@dronecode.org.uk>
 <20200702074444.GN3499@calimero.vinschen.de>
 <b2a72bb3-1852-46fe-81d2-0107c0076564@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b2a72bb3-1852-46fe-81d2-0107c0076564@dronecode.org.uk>
X-Provags-ID: V03:K1:OHjMSzwcZZJVmAj4WRevDeG3SWPa0are3bb3/R/JACXRyaZu/F3
 bhanpmNZX+BqqHVTX8QfYKT3k9P5rdXOHLr9C71uPGbT71eRxuwptFtjYxX5xxMNOhnVvSZ
 ycp+zv7by7YHPAD17LQTCgnnOAGIKaipkwj0wS2cGEdDp1UjNV67ZwDn9vcA3jRTxeA2w3m
 dMbn2aw0cyvJ/LcsKZhfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DOqo1RXckKA=:cVfhazlwquh+bI+ph0Nyqy
 6EhLGu9e/yEtKfsUK1pEHFt0ZOOiYhBeNl2CNniE9E1Lr9SvBraJ/6heAYOHBVv9KSOmmfs3K
 vB5F236bcWLlq5/pow1OtLwucID+ohd2uJjZZgd2FhrKs84d7OY43Dxp/7RhaHBRRC82PjnTe
 k9P1Te4E18otFzfinro5vLIFgRgYlKGBrwojZt/HL1hLLBWIXDjA+iZnYmNdAlzeTFJhA0vDp
 u8U5Q9N8vg9qcy+DmQJKS2v5MUT+rO71dinjxcbjaNv5GbEDD7uetHU+TXKFy3STbISfn/HCA
 BYJGivfz2VTw8huR7f/BRxzi1tkurGrx6dxdMlZBzxKfcItGozDKcLkVzq/PS5O4agx13sKXm
 1KmE9XXeAzetKQaw86DTDSxxfMksLpKC0K9c7FDLEexkZQgShhPQqFBODKfsc0yyrKc9eUz7T
 +jzv3a9BRlgY2b4YX7zn2ZFzJR82oq2DFXMCJmMqPfcBvrOJtViU4pC3PxHWTicHTC3NpYWFY
 g52OPx+R403SQBq3Uv6soR2mXHZdEOiZMVN2UoCUdyOLjCfwm9XcyOGD9V/CtTwaYOKgP+J1A
 ajbP1nowdyo5wEImBYLok44EQSNqFJx5MBrtUuFXiv5kYkccfAjy2Y/Ka7JLroOQBb1ZWletS
 W30VB6zOmi44RNxkDnjIscUF6A5qSK2/xEECp90gOWKRYUSBGIvaQrGGX43F5y3qF+B7Ywfla
 jPkrJ/vibI21X//0M8OTeQAXM4NcwOaSb7bvHYdvs/7FKyXGx1ljUrZDqSrOAXB0+faGj4Zoz
 umBGODOuTiPD+OZMue9N6igyVwjhke/jg72iL4yT8wFFHioIy06mBdcxLryKXJX9Uv3zd25
X-Spam-Status: No, score=-97.4 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS, KAM_NUMSUBJECT,
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
X-List-Received-Date: Mon, 06 Jul 2020 08:12:04 -0000

On Jul  5 17:49, Jon Turney wrote:
> On 02/07/2020 08:44, Corinna Vinschen wrote:
> > On Jul  1 22:29, Jon Turney wrote:
> > > 
> > > This needs to be aligned with some changes to gdb to consume the dumps it
> > > produces, so it's probably best to hold off applying this until it's more
> > > obvious what's going to happen with those.
> > > 
> > > Random notes:
> > > 
> > > - objdump identifies the output of dumper on x86_64 as
> > > 'elf64-x86-64-cloudabi' (perhaps due to some over-eager sniffer).
> > > 
> > > - regions excluded from the dump aren't rounded up to page size, so we may
> > > end up writing the excess into the dump.
> > > 
> > > - looking at the loaded modules and inspecting them to determine what memory
> > > regions don't need to appear in the dump seems odd.  I'm not sure we don't
> > > just exclude MEMORY_BASIC_INFORMATION.Type == MEM_IMAGE regions (assuming
> > > they get converted to MEM_PRIVATE regions if written when copy-on-write).
> 
> Unfortunately, that doesn't happen, and the region appears to stay
> MEM_IMAGE, even if it's been modified.
> 
> I'm inclined to just dump MEM_IMAGE regions if they are writable (although
> using the current protection isn't 100% correct, because it may have been
> changed using VirtualProtect())
> 
> I suspect there's probably some undocumented MemoryInformationClass for
> NtQueryVirtualMemory() that would let us determine if a region is sharable
> or not, but ...

Surprisingly, there's nothing undocumented in NtQueryVirtualMemory and
the API is fully exposed by VirtualQuery(Ex).

What about the two protection fields in MEMORY_BASIC_INFORMATION?  If
something changed, Protect != AllocationProtect.  Is that insufficient
to handle your case?


Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
