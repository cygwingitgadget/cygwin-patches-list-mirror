Return-Path: <cygwin-patches-return-6150-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7743 invoked by alias); 4 Nov 2007 02:20:33 -0000
Received: (qmail 7686 invoked by uid 22791); 4 Nov 2007 02:20:32 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-70-20-17-24.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (70.20.17.24)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 04 Nov 2007 02:20:30 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id D27092B353; Sat,  3 Nov 2007 22:20:28 -0400 (EDT)
Date: Sun, 04 Nov 2007 02:20:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Rewrite/fix cygwin1.dbg generation
Message-ID: <20071104022028.GA6236@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <472CB021.5040806@portugalmail.pt> <472CB37A.407FAE34@dessent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <472CB37A.407FAE34@dessent.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00002.txt.bz2

On Sat, Nov 03, 2007 at 10:44:26AM -0700, Brian Dessent wrote:
>Pedro Alves wrote:
>
>> The dllfixdbg hunk looks hard to read.  Here's what is looks
>> like after patching:
>
>I think that if whatever bugs used to exist in older binutils PE support
>that necessitated this hackery are now gone, we can just do away with
>dllfixdbg alltogether and just put this:
>
>> ${STRIP} --strip-debug ${DLL} -o stripped-${DLL}
>> ${STRIP} --only-keep-debug ${DLL} -o ${DBG}
>> ${OBJCOPY} --add-gnu-debuglink=${DBG} stripped-${DLL} ${DLL}
>> rm -f stripped-${DLL}
>
>...in the Makefile.

If that is the case, then this is a welcome change but I'm wondering if
it really is true.  Since the debug stripping is linked to the way that
cygwin manages the cygwin heap, it is possible that things only appear
to work until you allocate more space in the heap.  Has anyone tried the
above with a program that, say, opens a lot of file handles?

cgf
