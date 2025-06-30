Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id E4BFE385213A; Mon, 30 Jun 2025 09:49:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E4BFE385213A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751276965;
	bh=oIxySh79IcpveqaRAKyIFA/znnJQoEuZF9fV2i30Qz4=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=RqabX7iWP2JfKbVDYVBbCITs3NxxO5OO0aTBhJ9lEzO2HarWuWeIZbPmi0wccKEc2
	 gtcX3H9cwSnnN/w1mvmpTWlpO4zaL9nC8ZKzr0Ovs+MFxWFqH+wfqcTUlF4Mk/toQJ
	 Ie+NFKZFl4RW5CRTp+9wvZu1OAhWSw6TeWpj2yAk=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 079C3A80B7A; Mon, 30 Jun 2025 11:49:23 +0200 (CEST)
Date: Mon, 30 Jun 2025 11:49:22 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 4/5] cygwin: faq-programming-6.21 install tips
Message-ID: <aGJdop567kV46sBG@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250625013908.628-1-johnhaugabook@gmail.com>
 <20250625013908.628-5-johnhaugabook@gmail.com>
 <aFuoBviRzyYIHLbU@calimero.vinschen.de>
 <CAKrZaUu6EvGiCwD3-RrfVrFrZ39r5_5c-JSmaa3TCWsEWeHwzw@mail.gmail.com>
 <aF5ZDMBwxl6NWUWv@calimero.vinschen.de>
 <CAKrZaUvLoZ+Tr7JtaVTpssXF90JWTsonraKuz0wp9YJNsXRBZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKrZaUvLoZ+Tr7JtaVTpssXF90JWTsonraKuz0wp9YJNsXRBZA@mail.gmail.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 27 14:41, John Haugabook wrote:
> Take Care,
> 
> John Haugabook
> 
> 
> > So do I understand you right that the manual ParserDetails.ini
> > generation isn't really required for the doc build to run through?
> 
> I wasn't sure about this one, so thought it could be put in as a tip. I ran
> another sandbox, installing perl-XML-SAX-Expat from src. The terminal
> threw the "missing ParserDetails.ini message", but it did not end the
> install with an error code. All files built, and make install - good.
> 
> > If so, we shouldn't really care to document it as a requirement.
> 
> Getting no error code now with both cygwin and src install, then yes -
> leave out.

Can you please tweak your patchset accordingly?

Thanks,
Corinna
