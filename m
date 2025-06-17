Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id D3A3638290BF; Tue, 17 Jun 2025 11:15:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D3A3638290BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750158953;
	bh=3gEYi91aI22bEqmD84KIVUzsm338zUzVLKD+YMnnNlY=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=kAeZBhyQryuSe+6hoL/RzIDmhOPQiS261QtW6sko8ZNF4uqcpaOqLwkBttR4lDHPb
	 Syn8SAtQTIh04z3nyGMwvVB5XrOntHpkzrY1wRb98xfBuqTT0xP9MbGvb8GOKsVvWR
	 3yXxS39qY3QpydTJdXQdQMnmQfOyt6Lu/qRnQny4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id B77F4A80961; Tue, 17 Jun 2025 13:15:51 +0200 (CEST)
Date: Tue, 17 Jun 2025 13:15:51 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com, cygwin@cygwin.com
Subject: Re: [PATCH][API-CONFORMAANCE] Increase SYMLOOP_MAX to 63
Message-ID: <aFFOZ0-JHbJKs1Fc@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com, cygwin@cygwin.com
References: <CAHnbEG+-vkWb3F9HJFNdtMt1wAtm90kz81p8H=0Y7QrGHn50ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHnbEG+-vkWb3F9HJFNdtMt1wAtm90kz81p8H=0Y7QrGHn50ag@mail.gmail.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Sebastian,

On Jun 17 09:48, Sebastian Feld wrote:
> The following patch increases from 10 to 63, per Windows spec
> https://learn.microsoft.com/en-us/windows/win32/fileio/reparse-points
> 
> Security impact is minor, SYMLOOP_MAX is just an artificial limiter to
> prevent endless loops.

In case of Cygwin (Cygwin is slow, we all know that), the rather low
SYMLOOP_MAX was chosen so the path handling didn't get even slower in
some circumstances I don't remember anymore.  Maybe the times when this
was relevant are over, so we can try this.

However, please send a real git patch created with `git format-patch'
and don't forget your Signed-off-by:".


Thanks,
Corinna
