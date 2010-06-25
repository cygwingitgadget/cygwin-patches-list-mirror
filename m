Return-Path: <cygwin-patches-return-7037-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8596 invoked by alias); 25 Jun 2010 21:14:25 -0000
Received: (qmail 8573 invoked by uid 22791); 25 Jun 2010 21:14:22 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 25 Jun 2010 21:14:16 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C4B866D435C; Fri, 25 Jun 2010 23:14:13 +0200 (CEST)
Date: Fri, 25 Jun 2010 21:14:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: doc: use xmlto pdf
Message-ID: <20100625211413.GA2341@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1277494710.9108.37.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1277494710.9108.37.camel@YAAKOV04>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q2/txt/msg00020.txt.bz2

On Jun 25 14:38, Yaakov S wrote:
> As reported recently on the list[1], openjade cannot handle the ISO
> encodings shipped with docbook-xml45.  While I need to look into a fix,
> in this case there is a simple workaround.  Since we already use xmlto
> to build the HTML, we can also use it to build the PDFs.
> 
> Note that this does require the appropriate backend to be installed.  On
> Linux, xmlto has used PassiveTeX as a DVI/PDF/PS backend since at least
> 0.0.18; later versions also support dblatex and fop.  On Cygwin, I just
> adopted xmlto[2] and updated it to use dblatex as the DVI/PDF/PS
> backend, as that is the only backend currently in the distro.  (fop is
> in Ports but requires its GNU Classpath environment plus a bunch of Java
> libraries, and neither passivetex nor its dependency xmltex are
> currently available.)
> 
> Patch attached; please test.

The reason that I changed that to docbook2pdf at one point was that
creating a PDF from the docs never worked for me before.

And with your patch it also doesn't work for me on two different Linux
systems with different xmlto versions (0.0.18 and 0.0.23).  Here's what
happens on Fedora 13, the result is practically the same on the older
system.  Maybe you know a solution?

  xmlto --skip-validation pdf -o cygwin-ug-net/ cygwin-ug-net.sgml
  Making portrait pages on a4 paper (210mmx297mm)
  This is pdfTeXk, Version 3.141592-1.40.3 (Web2C 7.5.6)
   %&-line parsing enabled.
  entering extended mode
  (./tmp.fo
  LaTeX2e <2005/12/01>
  Babel <v3.8h> and hyphenation patterns for english, usenglishmax, dumylang, noh
  yphenation, arabic, basque, bulgarian, coptic, welsh, czech, slovak, german, ng
  erman, danish, esperanto, spanish, catalan, galician, estonian, farsi, finnish,
   french, greek, monogreek, ancientgreek, croatian, hungarian, interlingua, ibyc
  us, indonesian, icelandic, italian, latin, mongolian, dutch, norsk, polish, por
  tuguese, pinyin, romanian, russian, slovenian, uppersorbian, serbian, swedish, 
  turkish, ukenglish, ukrainian, loaded.
  xmltex version: 2002/06/25 v1.9 (Exp):
  (/usr/share/texmf/tex/xmltex/xmltex.cfg) 
  No File: tmp.cfg (/usr/share/texmf/tex/xmltex/passivetex/fotex.xmt)
  (/usr/share/texmf/tex/latex/base/article.cls
  Document Class: article 2005/09/16 v1.4f Standard LaTeX document class
  (/usr/share/texmf/tex/latex/base/size10.clo))
  (/usr/share/texmf/tex/xmltex/passivetex/fotex.sty
  )
  No file tmp.aux.
  (/usr/share/texmf/tex/latex/cyrillic/t2acmr.fd)
  (/usr/share/texmf/tex/latex/base/ts1cmr.fd)
  (/usr/share/texmf/tex/latex/psnfss/t1ptm.fd)
  No file tmp.out.
  No file tmp.out.
  INFO: Using normal, i.e. nonfrench-spacing in document
  (/usr/share/texmf/tex/latex/psnfss/t1phv.fd) [1{/usr/share/texmf/fonts/map/pdft
  ex/updmap/pdftex.map}] (/usr/share/texmf/tex/latex/psnfss/ts1ptm.fd) [2]
  (/usr/share/texmf/tex/latex/amsfonts/umsa.fd)
  (/usr/share/texmf/tex/latex/amsfonts/umsb.fd)
  (/usr/share/texmf/tex/latex/wasysym/uwasy.fd)
  (/usr/share/texmf/tex/latex/stmaryrd/Ustmry.fd)
  Underfull \hbox (badness 10000) has occurred while \output is active
  [][][] [] 

  Underfull \hbox (badness 10000) has occurred while \output is active
  [][] [] 
  [3] (/usr/share/texmf/tex/latex/psnfss/t1pcr.fd)
  Underfull \hbox (badness 10000) has occurred while \output is active
  []\T1/ptm/m/n/10 Cygwin User's

  Underfull \hbox (badness 10000) has occurred while \output is active
  []\T1/ptm/m/n/10 Cygwin User's

  Underfull \hbox (badness 10000) has occurred while \output is active
  [][][] [] 

  Underfull \hbox (badness 10000) has occurred while \output is active
  [][] [] 
  [4] [5] [6]

  LaTeX Font Warning: Font shape `OT1/cmr/m/n' in size <12.44159> not available
  (Font)              size <12> substituted on input line 1082.


  LaTeX Font Warning: Font shape `OML/cmm/m/it' in size <12.44159> not available
  (Font)              size <12> substituted on input line 1082.


  LaTeX Font Warning: Font shape `OMS/cmsy/m/n' in size <12.44159> not available
  (Font)              size <12> substituted on input line 1082.


  LaTeX Font Warning: Font shape `OMX/cmex/m/n' in size <12.44159> not available
  (Font)              size <12> substituted on input line 1082.


  LaTeX Font Warning: Font shape `U/msa/m/n' in size <12.44159> not available
  (Font)              size <12> substituted on input line 1082.


  LaTeX Font Warning: Font shape `U/msb/m/n' in size <12.44159> not available
  (Font)              size <12> substituted on input line 1082.


  LaTeX Font Warning: Font shape `U/wasy/m/n' in size <12.44159> not available
  (Font)              size <12> substituted on input line 1082.


  LaTeX Font Warning: Font shape `U/stmry/m/n' in size <12.44159> not available
  (Font)              size <12> substituted on input line 1082.

  [1]
  Underfull \hbox (badness 6675) in paragraph at lines 1261--1265
   []\T1/ptm/m/n/10 A his-tor-i-cal look into the first years of Cyg-win de-vel-o
  p-ment is Ge-of-frey J. Noer's

  Underfull \hbox (badness 10000) in paragraph at lines 1261--1265
   \T1/ptm/m/n/10 can be found at the [] 2nd USENIX Win-dows NT Sym-po-sium On-li
  ne Pro-ceed-ings[][]
  [2] [3] [4] [5] [6] [7] [8] [9] [10] [11]
  Underfull \hbox (badness 4927) in paragraph at lines 2579--2581
  []\T1/ptm/m/n/10 New API: cf-mak-eraw, get_avphys_pages, get_nprocs, get_nprocs
  _conf, get_phys_pages,
  [12] [13] [14]
  ! Missing \endcsname inserted.
  <to be read again> 
		     &
  l.3036 .../README?cvsroot=cygwin-apps&amp;rev=2)">
						    CVS <fo:inline font-family...

  ? 
  ! Emergency stop.
  <to be read again> 
		     &
  l.3036 .../README?cvsroot=cygwin-apps&amp;rev=2)">
						    CVS <fo:inline font-family...

  !  ==> Fatal error occurred, no output PDF file produced!
  Transcript written on tmp.log.
  make: *** [cygwin-ug-net/cygwin-ug-net.pdf] Error 1



Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
