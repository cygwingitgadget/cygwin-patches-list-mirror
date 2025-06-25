Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 745983858039; Wed, 25 Jun 2025 07:40:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 745983858039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750837257;
	bh=A745UUfvX6HervlJBoiOdel07UsizbL0lJhxFWEGTH0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Z9vX0EfQtTrGzRiIyyxbMsZc1BoEp4RxXtfXZjV5qKJEXzlDhZszWhzdo+/dzg1mG
	 6ELTz/kGAx+uNXKj5HLG3bMcO6KGnTNFPaIsbhMB0eNYctrxfSyRC6RyDSxAlI2cjh
	 SFBW9bueUOQ443stxjiV9WllREsJMli082s/fZ1o=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id B9FA7A80B69; Wed, 25 Jun 2025 09:40:54 +0200 (CEST)
Date: Wed, 25 Jun 2025 09:40:54 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Achim Gratz <Stromeko@nexgo.de>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/5] cygwin: faq-programming-6.21 install tips
Message-ID: <aFuoBviRzyYIHLbU@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Achim Gratz <Stromeko@nexgo.de>,
	cygwin-patches@cygwin.com
References: <20250625013908.628-1-johnhaugabook@gmail.com>
 <20250625013908.628-5-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250625013908.628-5-johnhaugabook@gmail.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Achim,

On Jun 24 21:39, johnhaugabook@gmail.com wrote:
> From: John Haugabook <johnhaugabook@gmail.com>
> 
> One of the tips was mentioned in "[PATCH 1/4] cygwin: faq-programming-6.21 add 5 required packages", which is the error:
> """""""""""""""
> could not find ParserDetails.ini in /usr/share/perl5/vendor_perl/5.40/XML/SAX
> Can't locate XML/SAX/Expat.pm in @INC (you may need to install the XML::SAX::Expat module) (@INC entries checked: /usr/local/lib/perl5/site_perl/5.40/x86_64-cygwin-threads /usr/local/share/perl5/site_perl/5.40 /usr/lib/perl5/vendor_perl/5.40/x86_64-cygwin-threads /usr/share/perl5/vendor_perl/5.40 /usr/lib/perl5/5.40/x86_64-cygwin-threads /usr/share/perl5/5.40) at /usr/share/perl5/vendor_perl/5.40/XML/SAX.pm line 147.
> """""""""""""""
> 
> and running:
> > perl -MXML::SAX -e 'XML::SAX-&gt;add_parser(q(XML::SAX::Expat)); XML::SAX-&gt;save_parsers()'
> 
> will resolve this error. But note - out of the several times I've gone through the installation, I have had to run this command twice. All all but one of the installs it did not throw the error for some reason.

This shouldn't be necessary.  On Fedora the ParserDetails.ini file is
part of the perl-XML-SAX package but apparently it isn't in the
Cygwin package.  Is there a reason for that?  The user shouldn't
have to create the file manually...


Thanks,
Corinna
