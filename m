Return-Path: <cygwin-patches-return-5850-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28707 invoked by alias); 10 May 2006 16:16:24 -0000
Received: (qmail 28693 invoked by uid 22791); 10 May 2006 16:16:23 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-19.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.19)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 10 May 2006 16:16:21 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id D92E513C01F; Wed, 10 May 2006 12:16:18 -0400 (EDT)
Date: Wed, 10 May 2006 16:16:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] make clean
Message-ID: <20060510161618.GC13351@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4461ACBB.DC6BA1BB@dessent.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4461ACBB.DC6BA1BB@dessent.net>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00038.txt.bz2

On Wed, May 10, 2006 at 02:04:59AM -0700, Brian Dessent wrote:
>
>Doing a "make clean" inside winsup/cygwin leaves behind a stale
>cygwin1.dbg file.

Go ahead and check this in, Brian.

Thanks.

cgf

>2006-05-10  Brian Dessent  <brian@dessent.net>
>
>	* Makefile.in (clean): Also delete *.dbg.
>Index: Makefile.in
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v
>retrieving revision 1.186
>diff -u -p -u -p -r1.186 Makefile.in
>--- Makefile.in	12 Apr 2006 15:53:22 -0000	1.186
>+++ Makefile.in	10 May 2006 09:01:17 -0000
>@@ -365,7 +365,7 @@ uninstall-man:
> 	done
> 
> clean:
>-	-rm -f *.o *.dll *.a *.exp junk *.base version.cc regexp/*.o winver_stamp *.exe *.d *stamp* *_magic.h sigfe.s cygwin.def
>+	-rm -f *.o *.dll *.dbg *.a *.exp junk *.base version.cc regexp/*.o winver_stamp *.exe *.d *stamp* *_magic.h sigfe.s cygwin.def
> 	-@$(MAKE) -C $(bupdir)/cygserver libclean
> 
> maintainer-clean realclean: clean
