Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id B9CB856B6486; Tue,  9 Dec 2025 10:16:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B9CB856B6486
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1765275415;
	bh=rJvquX/g/zPsyXOckXY6Dmw3TTdoOk/FV8IKqU2Oz3I=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=ZQ5igZ+QQbvNU0jCcOVu4VUC7M5mL39z/f5i8MvjuDrz+XBUeYCoEJES3x0tiUHfN
	 SpknkhgHLhRYIu8srX7sMhxJvBCNE3tmt0Un5X6pYKrKWJUAgca3qFGa3LzYI07T5k
	 0vtNpZ60EcdoHBewjHtwB0rTgB2njHtjUveHIQNE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id EE6C5A80BA1; Tue, 09 Dec 2025 11:16:53 +0100 (CET)
Date: Tue, 9 Dec 2025 11:16:53 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/3] Cygwin: doc: utils.xml: improve newgrp(1)
 documentation
Message-ID: <aTf3FTRQSed4iqht@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20251205194200.4011206-1-corinna-cygwin@cygwin.com>
 <20251205194200.4011206-3-corinna-cygwin@cygwin.com>
 <3206c23d-4701-4145-9ac1-2b6f74d33f05@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3206c23d-4701-4145-9ac1-2b6f74d33f05@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Dec  6 11:53, Jon Turney wrote:
> On 05/12/2025 19:41, Corinna Vinschen wrote:
> >   	in, otherwise the current environment, including current working
> > -	directory, remains unchanged.</para>
> > +	directory, remains unchanged.  For Linux compatibility, the flag
> > +	<option>-</option> is allowed as well.</para>
> >         <para><command>newgrp</command> changes the current primary group to the
> >           named group, or to the default group listed in /etc/passwd if no group
> > -	name is given.</para>
> > +	name is given.  The user's standard shell is started, called as login
> > +        shell if the <option>-l</option> or <option>-</option> flag has been
> > +	specified.</para>
> 
> Maybe this should mention somewhere that a numeric group id is also
> accepted?

Yeah, you're right.  I'll send a v2 in a bit.


Thanks,
Corinna
