Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id B48013857C62; Sat,  3 Feb 2024 15:16:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B48013857C62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1706973362;
	bh=38Ug2F0DYiC9jd6fItDEAVsQNgKyi5/XHT6bUV8u6g4=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=jQDfO/1RZMk+jFMpUQwglwl2hjGqDL70tfv1DuDXeZ4LtYOJRyDnjSXDegPTF74rb
	 t5RedZ6PY3V8bfFOpEDFXmPGg6arZo1EM3QrrxZSVubrPPXJwJRcm8q84hK5Z3SgNe
	 inbBvhGHRy18GexuQRROmsoCr7WSt2wevHfmBw+Q=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E4016A80C45; Sat,  3 Feb 2024 16:15:59 +0100 (CET)
Date: Sat, 3 Feb 2024 16:15:59 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix exit code for non-cygwin process.
Message-ID: <Zb5Yr-jfdqyl6nF3@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240202052923.881-1-takashi.yano@nifty.ne.jp>
 <23727ea4-229b-cf13-057d-e9f0e2790b61@gmx.de>
 <9d19f0fe-b547-0ec7-146b-fbaf12baa986@gmx.de>
 <20240204000430.4e0373736deaec9e72a87a0d@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240204000430.4e0373736deaec9e72a87a0d@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Feb  4 00:04, Takashi Yano wrote:
> On Sat, 3 Feb 2024 15:27:06 +0100 (CET)
> Johannes Schindelin wrote:
> > On IRC, you reported that the thread would crash if `cons` was not fixed
> > up. The symptom was that that crash would apparently prevent the exit code
> > from being read, and it would be left at 0, indicating potentially
> > incorrectly that the non-Cygwin process succeeded.
> > 
> > I wonder: What would it take to change this logic so that the crash would
> > be detected (and not be misinterpreted as exit code 0)?
> 
> I am not sure, but I think it is necessary to modify:
> pinfo::exit()
> pinfo::meybe_set_exit_code_from_windows()
> pinfo::set_exit_code()
> 
> I guess detecting crash of sbub process needs modification of
> spawn.cc.

Dumb question: If, as Johannes said, the error code cannot be fetched,
can't we set the error code to a POSIX return code indicating a signal?

I.e., checking for WIFSIGNALED() returns 1 and WTERMSIG() returns, say,
SIGKILL or something?


Corinna
