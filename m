Return-Path: <cygwin-patches-return-7023-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9008 invoked by alias); 5 May 2010 18:39:07 -0000
Received: (qmail 8981 invoked by uid 22791); 5 May 2010 18:39:04 -0000
X-SWARE-Spam-Status: No, hits=-2.2 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-fx0-f43.google.com (HELO mail-fx0-f43.google.com) (209.85.161.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 05 May 2010 18:38:59 +0000
Received: by fxm14 with SMTP id 14so9295149fxm.2        for <cygwin-patches@cygwin.com>; Wed, 05 May 2010 11:38:57 -0700 (PDT)
Received: by 10.223.47.130 with SMTP id n2mr5712085faf.55.1273084736941;        Wed, 05 May 2010 11:38:56 -0700 (PDT)
Received: from [192.168.2.99] (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])        by mx.google.com with ESMTPS id z12sm45126fah.21.2010.05.05.11.38.54        (version=SSLv3 cipher=RC4-MD5);        Wed, 05 May 2010 11:38:55 -0700 (PDT)
Message-ID: <4BE1BFCC.6060703@gmail.com>
Date: Wed, 05 May 2010 18:39:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: CFA: pseudo-reloc v2
References: <4AC7910E.1010900@cwilson.fastmail.fm> <4AC82056.7060308@cwilson.fastmail.fm> <4BE1A2C5.4090604@gmail.com> <20100505175614.GA6651@ednor.casa.cgf.cx>
In-Reply-To: <20100505175614.GA6651@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q2/txt/msg00006.txt.bz2

On 05/05/2010 18:56, Christopher Faylor wrote:

> I like the idea but I have a few problems with this, some stylistic and
> some implementation.
> 
> Stylistic:

  Those all make sense to me, but I won't rework it yet until we've seen your
PoC/discussed further.

> Implementation:
> 
> I don't like keeping a list of "places we know we need to ignore" separate from
> the Cygwin DLL.  That means that if there is something new added besides data/bss
> this function becomes obsolete.
> 
> I think this argues for most of this functionality being moved to the
> Cygwin DLL itself so that an application gets improvements for free.  I
> should have suggested that when this function first made its way into
> the libcygwin.a (or maybe I did and someone will enlighten me about why that
> won't work).
> 
> I'll see I can come up with a proof-of-concept of what I'm talking about soon.
> 
> Btw, don't we have to worry about data/bss for DLLs too?  Is that
> handled by this change or is that not an issue?

  We do have to worry and it is handled.  This code gets linked statically
into each DLL and EXE, each instance referring just to its own pseudo-reloc
tables.  The Cygwin DLL copies all the data and bss for both DLLs and EXEs (at
process attach time), then they all run their own pseudo-relocs (at first
thread attach time).

  This only works /because/ the module is linked into each executable image
(i.e., DLL or EXE, and henceforth 'EI') separately.  While we could move the
core code into the Cygwin DLL, we'd still have to have a statically linked
object in each EI to capture the module's definitions of
__RUNTIME_PSEUDO_RELOC_LIST__ and __RUNTIME_PSEUDO_RELOC_LIST_END__, and so
it's also a valid place to capture the local module's __data/bss_start/end_
definitions (as indeed is already done in _cygwin_crt0_common where it sets up
the per_process userdata structure).

  So we could move the core __write_memory and do_pseudo_relocs routines into
the DLL, and adjust the code in _cygwin_crt0_common to pass the per_process
struct to _pei386_runtime_relocator which could pass it and the reloc list
start/end pointers through to the code in the DLL, and it could then be code
in the DLL that knows which memory ranges it copied and should avoid
re-relocating.

  Is that the kind of structure you were thinking of?  The problem I saw with
any kind of approach based on actually knowing which ranges were actually
copied (as opposed to simply inferring that it was the data and bss sections
between their start and end labels) is that that all takes place in the parent
rather than the child, so how to communicate it to the child where the
relocating is taking place would be pretty tricky, I thought.

    cheers,
      DaveK
