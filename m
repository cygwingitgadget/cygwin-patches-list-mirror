Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 961BE3858D20; Fri, 27 Jun 2025 08:40:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 961BE3858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751013646;
	bh=kBzYDZMrqzU+MOVIVChi+D31I4o60sH6pKc3QzBsOw8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=L7OVJcbMSTl+55UGq9bU6mNLI+6z5ngd4uDSENX0CsXLrtog9TeW9qMjzwCJe8Coy
	 s8zmI8RzUHYm1+SNQD+5rPwLqX4PwWc92E9fnM1o6NnjAZ5rWwM5SJ27KzDtdyVWI9
	 PXIOGM2kIlcOTAI3SK53ugAr3s/DBL0y3aAQsm8M=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 8169EA806FF; Fri, 27 Jun 2025 10:40:44 +0200 (CEST)
Date: Fri, 27 Jun 2025 10:40:44 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: John Haugabook <johnhaugabook@gmail.com>
Cc: cygwin-patches@cygwin.com, Achim Gratz <Stromeko@nexgo.de>
Subject: Re: [PATCH 4/5] cygwin: faq-programming-6.21 install tips
Message-ID: <aF5ZDMBwxl6NWUWv@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: John Haugabook <johnhaugabook@gmail.com>,
	cygwin-patches@cygwin.com, Achim Gratz <Stromeko@nexgo.de>
References: <20250625013908.628-1-johnhaugabook@gmail.com>
 <20250625013908.628-5-johnhaugabook@gmail.com>
 <aFuoBviRzyYIHLbU@calimero.vinschen.de>
 <CAKrZaUu6EvGiCwD3-RrfVrFrZ39r5_5c-JSmaa3TCWsEWeHwzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKrZaUu6EvGiCwD3-RrfVrFrZ39r5_5c-JSmaa3TCWsEWeHwzw@mail.gmail.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 25 22:11, John Haugabook wrote:
> Hi Corinna and Achim,
> 
> > This shouldn't be necessary.  On Fedora the ParserDetails.ini file is
> > part of the perl-XML-SAX package but apparently it isn't in the
> > Cygwin package.  Is there a reason for that?  The user shouldn't
> > have to create the file manually...
> 
> Two things:
> 1. The error appears on both builds, but is slightly different in the
> cygwin install
> 2. Sorry, but out of ignorance I didn't mention that the error was
> from the "src" install
> (hoping this makes for good new user feedback regarding build section).
> 
> The error output (with context before and after) from the cygwin install was:
> """""""""""""""
> make[3]: Entering directory
> '/oss/src/newlib-cygwin/build/x86_64-pc-cygwin/winsup/doc'
>   GEN      Makefile.dep
>   GEN      cygwin-ug-net/cygwin-ug-net.pdf
>   GEN      cygwin-api/cygwin-api.pdf
>   GEN      cygwin-api/cygwin-api.html
>   GEN      cygwin-ug-net/cygwin-ug-net.html
>   GEN      faq/faq.html
> Element listitem in namespace '' encountered in answer, but no template matches.
>   GEN      faq/faq.body
>   GEN      cygwin-ug-net/cygwin-ug-net-nochunks.html.gz
>   GEN      api2man.stamp
>   GEN      intro2man.stamp
>   GEN      utils2man.stamp
>   GEN      charmap
>   GEN      cygwin-api.info
> #HERE
> could not find ParserDetails.ini in /usr/share/perl5/vendor_perl/5.40/XML/SAX
> warning : xmlAddEntity: invalid redeclaration of predefined entity 'lt'
>   GEN      cygwin-ug-net.info
> # HERE
> could not find ParserDetails.ini in /usr/share/perl5/vendor_perl/5.40/XML/SAX
> warning : xmlAddEntity: invalid redeclaration of predefined entity 'lt'
> docbook2texi://refentry[@id='proc']/refnamediv: section is too deep
> docbook2texi://refsect1[@id='proc-desc']: section is too deep
> # ect....
> """""""""""""""
> The remaining install did not end with an error code (2 usually)
> though, and completed successfully.

So do I understand you right that the manual ParserDetails.ini
generation isn't really required for the doc build to run through?

If so, we shouldn't really care to document it as a requirement.


Corinna
