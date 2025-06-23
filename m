Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id CB0243846E67; Mon, 23 Jun 2025 19:52:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CB0243846E67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750708369;
	bh=eldQdNOe/mM1wjrtfjqVCfg1ZaBvWfaYkSS7Wv5YBGo=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=sB2bNP0tPpxN4DyabihefEYyp1Binw5UM2rVHNZ/0MLB2r967gvuapjhbXwubiXDO
	 P6mjg9OTR4KekC0wWGa2x+PvbxFhZU1eI22b7SCQQPjBuSse1frfBPP/Hvw1iTp1YT
	 Hb/nyVsaUcUzjg33Ty+X969FOdM5JSm9PeBhyRIg=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id AA77BA80D72; Mon, 23 Jun 2025 21:52:47 +0200 (CEST)
Date: Mon, 23 Jun 2025 21:52:47 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: symlink_native() bug with case-sensitive file-systems Re:
 [PATCH] symlink_native: allow linking to `..`
Message-ID: <aFmwj0DVKJeVvUr9@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <6058889e2ae8c9c827a8d6678f09b3b1741e2fcf.1750413578.git.johannes.schindelin@gmx.de>
 <CAHnbEGLjsy4MZD+oqjGbd=JrX+q8an3mhT38xndEgjmTpWyOnw@mail.gmail.com>
 <aFkPUI22HlYnYhZh@calimero.vinschen.de>
 <CAHnbEG+7T8K50WkDN4=xBA_ir8N3M32=ZGJnYvCFSpH7UquZ=Q@mail.gmail.com>
 <aFmvF9cWsr8UCqQ6@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aFmvF9cWsr8UCqQ6@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Jun 23 21:46, Corinna Vinschen wrote:
> On Jun 23 20:22, Sebastian Feld wrote:
> > On Mon, Jun 23, 2025 at 10:52 AM Corinna Vinschen
> > <corinna-cygwin@cygwin.com> wrote:
> > > To add the sensitive dirs to the picture, path_conv() would have to
> > > check every directory on NTFS for
> > > NtQueryInformationFile(FileCaseSensitiveInformation). It would then
> > > set the path_conv::caseinsensitive flag accordingly.
> > 
> > Yikes. Does Windows cache this per-dir info somewhere?
> 
> I honestly don't know.

Actually, another problem is that a case-sensitive dir can change
it's sensitivity flag at any given time (restrictions apply).
Caching is questionable.


Corinna
