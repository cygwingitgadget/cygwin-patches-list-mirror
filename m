Return-Path: <cygwin-patches-return-7031-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21917 invoked by alias); 6 May 2010 18:24:49 -0000
Received: (qmail 21906 invoked by uid 22791); 6 May 2010 18:24:48 -0000
X-SWARE-Spam-Status: No, hits=-2.8 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from out1.smtp.messagingengine.com (HELO out1.smtp.messagingengine.com) (66.111.4.25)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 06 May 2010 18:24:37 +0000
Received: from compute2.internal (compute2.internal [10.202.2.42])	by gateway1.messagingengine.com (Postfix) with ESMTP id 27401F51C3	for <cygwin-patches@cygwin.com>; Thu,  6 May 2010 14:24:15 -0400 (EDT)
Received: from web6.messagingengine.com ([10.202.2.215])  by compute2.internal (MEProxy); Thu, 06 May 2010 14:24:16 -0400
Received: by web6.messagingengine.com (Postfix, from userid 99)	id 9334619CCAF; Thu,  6 May 2010 14:24:15 -0400 (EDT)
Message-Id: <1273170255.10571.1373764557@webmail.messagingengine.com>
From: "Charles Wilson" <cygwin@cwilson.fastmail.fm>
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: CFA: pseudo-reloc v2
Date: Thu, 06 May 2010 18:24:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q2/txt/msg00014.txt.bz2

Christopher Faylor wrote:
> On Wed, May 05, 2010 at 11:07:33PM -0400, Charles Wilson wrote:
>>I spent a lot of effort trying to synchronize our version of
>>pseudo_reloc.c with the mingw and mingw64 versions -- specifically so
>>that we could leverage Kai's v2 efforts.
>>
>>If we -- meaning cygwin -- move most of the guts into the cygwin DLL,
>>then ... we either
>>  (1) fork our version from the mingw[32|64] version permanently, and
>>lose the possibility of "easy" code sharing between the three projects, or
>>  (2) this portion of the code lives in both places (pseudo_reloc.c and
>>some-other-cygwin-dll-source-file), but is #ifdef'ed in pseudo_reloc.c
>>when compiled on cygwin, because there's this other identical copy over
>>in some-other-cygwin-dll-source-file.
>
> I kept the ifdef __CYGWIN__ stuff.  Moving the code into the DLL
> actually simplifies the Cygwin part quite a bit since you can use things
> like "winsup.h" and "small_printf".

Right...I have no argument that moving "stuff" into the DLL can simplify
the cygwin code, both the parts that end up "inside" the DLL and the
stuff that's left "outside" in pseudo_reloc.c.

But...if I understand correctly, doing this moves the "fix" for the
problem Dave identified into that internal code -- which means that the
mingw guys won't benefit from it, unless they re-implement it in the
"outside" code.  Hence: duplication of code -- and that's assuming we
continue to try and keep the various copies of pseudo_reloc in sync.

If we don't...well, then, there's no duplication of code between
winsup/cygwin/lib/pseudo_reloc.c and winsup/cygwin/some_file.cpp, but
there IS duplication (or would be, if the bug is to be fixed for mingw)
between winsup/cygwin/some_file.cpp and winsup/mingw/pseudo_reloc.c ==
mingw64/pseudo_reloc.c.  Plus, the three copies of pseudo_reloc.c would
diverge, complicating any future sharing.

>  And, my changes don't permute
> things as much as Dave's.

Wouldn't know. AFAICT, you haven't posted your patch yet. <g>

>  Dave's changes were not really MinGW
> friendly.

Right -- I don't believe Dave was thinking about MinGW at all.  I was
going to chime in about that just once in the thread...your message won
the raffle.

>>Yuck.  (I don't mind "losing" the effort I put in, because whatever
>>happens we now have v2 support.  But...why make it harder if somebody
>>in mingw-land invents v3?  Or make it harder on them, if WE do?)
> 
> And, why not make it so that potentially all that is required for v3
> support is a DLL upgrade rather than a rebuild?

Well, remember: if any given client is going to use v3 relocs, then it
must be compiled/linked with --enable-pseudo-relocs-v3 so that the image
actually /contains/ those kinds of pseudo relocation records.  So, you
can only "slipstream" improvements in an *existing* pseudo-reloc scheme
(e.g. v1 or v2) without recompiling the client; you can't magically
convert existing clients to a brand new scheme -- that always will
require recompilation.

In contrast, the current "everything lives in pseudo_reloc.c" system
means you can't even deliver improvements in an existing pseudo-reloc
scheme without recompiling the client.  And that will always be true for
mingw/mingw64.

--
Chuck
