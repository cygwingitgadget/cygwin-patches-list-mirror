Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 63D44385842C; Wed,  7 Jun 2023 10:06:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 63D44385842C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1686132395;
	bh=T5cISKmInkjJUvBsdOMCSlSNov6WS42RcAhe8d+46QI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=TkgrjhejNAU1rudmPJu/a3iJCiRgeVY6YcLtva9tl+04q9N9B7innVF655bvJxSHG
	 fJuf4DmRJu0J2h3dXm4CKyq1tt5shn350d1meDN2rOJHbogkOCSMY0xUps4EREEk+j
	 qIT7yt/EgPeaTr3sVqREqS4nBjdLbmdnYkuj4Sm0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6E411A807B4; Wed,  7 Jun 2023 12:06:33 +0200 (CEST)
Date: Wed, 7 Jun 2023 12:06:33 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Philippe Cerfon <philcerf@gmail.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] include/cygwin/limits.h: add XATTR_{NAME,SIZE,LIST}_MAX
Message-ID: <ZIBWqTEkn9c9GWfF@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Philippe Cerfon <philcerf@gmail.com>,
	cygwin-patches@cygwin.com
References: <CAN+za=MhQdD2mzYxqVAm9ZwBUBKsyPiH+9T5xfGXtgxq1X1LAA@mail.gmail.com>
 <f4106af5-ed7a-0df5-a870-b87bb729f862@Shaw.ca>
 <ZH4yDkPXLU9cYsrn@calimero.vinschen.de>
 <CAN+za=MTBHNWV+-4rMoBb_zefPO7OG2grySUFdV-Eoa2aQg_uw@mail.gmail.com>
 <ZH80lgpsfWwCZp+R@calimero.vinschen.de>
 <CAN+za=NXXrn_atWyWi4zUgELkhvm5qecB-hQYFJ7Q4bdFHopFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN+za=NXXrn_atWyWi4zUgELkhvm5qecB-hQYFJ7Q4bdFHopFA@mail.gmail.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun  6 17:17, Philippe Cerfon wrote:
> On Tue, Jun 6, 2023 at 3:28 PM Corinna Vinschen
> <corinna-cygwin@cygwin.com> wrote:
> > Yes, it is wrong, because the value of MAX_EA_NAME_LEN / XATTR_NAME_MAX
> > is used for array size definitions as well as comparisons.
> 
> Do you prefer to keep MAX_EA_NAME_LEN and just have that set like,
> perhaps with an additional comment that explains it:
>    #define MAX_EA_NAME_LEN    (XATTR_NAME_MAX + 1 - strlen("user."))
> or rather inline all that without any MAX_EA_NAME_LEN?

Hmm, the comparisons would have to check for XATTR_NAME_MAX anyway,
so maybe inlining is cleaner in this case.


Greets,
Corinna
