Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id BBD3A385DDE3; Wed,  2 Jul 2025 13:31:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BBD3A385DDE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751463106;
	bh=8EHqLxrGxRb/hXiRg4mL03+skO29l0NsoPPFqifkEkw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=OxcLcidAmtFwBwMcZwzzF47MZ/ydMKGu+JTyDE0QphppCeFQ8VHtT+EvEIwctHIs7
	 kp0LfKL0nhVMoKZwwdZOHEyCGeN/NaLF2QnFhers+5pRFPucoWhBKU1Qw6+G6XnBtr
	 SkxM6jFUbsgOw3xNjHMBcNsBQ5KGMmmih1vZiUTk=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 8227DA80CFD; Wed, 02 Jul 2025 15:31:44 +0200 (CEST)
Date: Wed, 2 Jul 2025 15:31:44 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: johnhaugabook@gmail.com
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/4] cygwin: 6.21 faq-programming.xml edits
Message-ID: <aGU0wPpBMULD3N6p@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: johnhaugabook@gmail.com, cygwin-patches@cygwin.com
References: <20250630213205.988-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630213205.988-1-johnhaugabook@gmail.com>
List-Id: <cygwin-patches.cygwin.com>

Hi John,

On Jun 30 17:32, johnhaugabook@gmail.com wrote:
> From: John Haugabook <johnhaugabook@gmail.com>
> 
> Removed "[PATCH 4/5] cygwin: faq-programming-6.21 install tips" from prior patchset, 
> which included unecessary tip for the install process.
> 
> This set of patches applies changes to faq-programming.xml at section 6.21 
> "How do I build Cygwin on my own?". The changes include:
>   1. Adding 5 additional required packages
>   2. Add ready-made commands to run setup-x86_64.exe to install required packages relevant to the use case
>   3. Additional paragraph about the build process and an estimate of install time
>   4. And a typo fix.
>   
> The details for each patch are expanded further in the commit message included in 
> the patch. Also, you can visit the support repo that illustrates the rendered html
> and doc build changes:
> -  https://github.com/jhauga/patch-newlib-cygwin-faq
> 
> John Haugabook (4):
>   cygwin: faq-programming-6.21 add 5 required packages
>   cygwin: faq-programming-6.21 ready-made download commands
>   cygwin: faq-programming-6.21 para about process and time
>   cygwin: faq-programming-6.21 unmatched parenthesis

I pushed patches 1, 2, and 4.  I'm not sure about patch 3.  I don't
think it's necessary for people who are willing to build Cygwin itself.
To the contrary, I think it's rather puzzeling in a FAQ about building
Cygwin to talk about a two-step installation, which is only preliminary
for the actual Cygwin build process.


Thanks,
Corinna
