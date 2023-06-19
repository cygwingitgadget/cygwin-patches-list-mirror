Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 97A993858D28; Mon, 19 Jun 2023 08:53:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 97A993858D28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1687164785;
	bh=ixj1lhRvIJOhNYeejodKuv4vVMlyxCCgcLRU2gwPz/E=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=At4c7ycQKBBrizgJneTeA4IL2RRWnqEGkGAt0cajLUUX5x+mMeVnYxgZ13mteRXWS
	 3xF0o8ULSowm5cohBQtPcoAdzSztsHJSPTK1x6L0HUuiyxeyGGa8DEndA4UhUng+d8
	 f0z8JzzZdqVK141fgCNith4BYOI8AUQyl0/AQzVs=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 64083A80C7B; Mon, 19 Jun 2023 10:53:03 +0200 (CEST)
Date: Mon, 19 Jun 2023 10:53:03 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Philippe Cerfon <philcerf@gmail.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] include/cygwin/limits.h: add XATTR_{NAME,SIZE,LIST}_MAX
Message-ID: <ZJAXbyh183leZSwM@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Philippe Cerfon <philcerf@gmail.com>,
	cygwin-patches@cygwin.com
References: <ZH4yDkPXLU9cYsrn@calimero.vinschen.de>
 <CAN+za=MTBHNWV+-4rMoBb_zefPO7OG2grySUFdV-Eoa2aQg_uw@mail.gmail.com>
 <ZH80lgpsfWwCZp+R@calimero.vinschen.de>
 <CAN+za=NXXrn_atWyWi4zUgELkhvm5qecB-hQYFJ7Q4bdFHopFA@mail.gmail.com>
 <ZIBWqTEkn9c9GWfF@calimero.vinschen.de>
 <CAN+za=NjpooX1JrwbgDgX8yzHkn6AwtYH8yCOjzkUspMZd1W6g@mail.gmail.com>
 <ZIx55su+P5zInrqa@calimero.vinschen.de>
 <CAN+za=P4Ra6-4Hc6P1HVODT3B5JtrJvV7bFWt-PkOeiawr=4NQ@mail.gmail.com>
 <ZIy8x7cxIQhTmO9U@calimero.vinschen.de>
 <CAN+za=M_UHnv4HTSNFL1sFESgBnoR_3omoj_-VH6jrRvp_7Lyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN+za=M_UHnv4HTSNFL1sFESgBnoR_3omoj_-VH6jrRvp_7Lyw@mail.gmail.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 16 21:52, Philippe Cerfon wrote:
> On Fri, Jun 16, 2023 at 9:49 PM Corinna Vinschen
> <corinna-cygwin@cygwin.com> wrote:
> > Even a SSD has "disk" in it's name :)
> 
> That actually stands for drive :-)

Huh, ok.  To me it always was "solid state disk", but it's certainly
not the first time I'm wrong :)))

> > Let's keep it at that.  I pushed your patchset.
> 
> Thanks for merging! :-)
> 
> Any rough estimate when this will be in a live release?

End of this year. That's the plan for 3.5.0.


Greets,
Corinna
