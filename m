Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id B819F3858D21; Mon, 13 Jan 2025 13:38:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B819F3858D21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1736775530;
	bh=Yk4lR+9oz6wN3elp/U6i/lHZpRZmuQf+Q6pPfLkW6ZA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ZOjWIQr9czPTN4TJ4H38BNM6sfBIYYU9Q6BNA2n49cUm+hHCK3dDN04IhcnfuKdyY
	 5sUAiEHb4sn0oCKe1SEXUZg2+5pr9VmqFREX36DhgSGAS4KxXUBChIB+AztVvJ6vAI
	 QcSeSUYFBiW5jIDPYNk91KvnoaX0m3wfLESMplto=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id B4AC8A80A67; Mon, 13 Jan 2025 14:38:48 +0100 (CET)
Date: Mon, 13 Jan 2025 14:38:48 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: Re: [PATCH v5 7/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 merge function variants on one line
Message-ID: <Z4UXaKQmj2s22H3B@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,
	Jon Turney <jon.turney@dronecode.org.uk>
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <39517f2a7fdd36a043c2029e0a24e16e8e7f3bee.1736552566.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <39517f2a7fdd36a043c2029e0a24e16e8e7f3bee.1736552566.git.Brian.Inglis@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

On Jan 10 17:01, Brian Inglis wrote:
> Move circular F/Ff/Fl and similar functions to put
> base entries and -f -l variants on the same line.
> 
> Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
> ---
>  winsup/doc/posix.xml | 336 +++++++++++--------------------------------
>  1 file changed, 84 insertions(+), 252 deletions(-)

Hmm.  This makes more sense than the previous patch.

However, it doesn't make sense if only the math functions are affected
If you want to do this systematically, you'd have to group them
following the Open Group Base Spec Issue 8.

That would also imply merging stuff like

  iswalnum/iswalnum_l		-- page 1280
  le16toh/le32toh/le64toh	-- page 1327
  localtime/localtime_r		-- page 1354
  mlock/munlock			-- pages 1433, 1488
  sig2str/str2sig		-- page 2040

etc. etc.

Nevertheless, while this has a certain charm and I don't see
a disadvantage, I'd like to get Jon's input to this as well.


Corinna
