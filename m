Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id EE1873858D3C; Thu, 23 Jan 2025 15:59:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org EE1873858D3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1737647980;
	bh=M0OG9JOzx61ZvIx/1Sy4KkXO8+d2ZGJfj42SYGZn1I4=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=mtKYXXSaxLnteOYUxr7TttSztJnbsezCNR4S5FN+RpYw24dvu/OHSreWw4/HCVM4u
	 kpjclPT7YLo1WmRKc9fGpnep94GbOhSIGb8SccnFrnW1yJHE3SmPh4zVXPvPos0oaz
	 +aMLyU0FdxlXdKwtQnrJo3RMhHufLPbDTYIqwjiQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 465FCA80D1D; Thu, 23 Jan 2025 16:59:38 +0100 (CET)
Date: Thu, 23 Jan 2025 16:59:38 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v7 3/5] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 not implemented new additions
Message-ID: <Z5JnasMZoXWJR5JU@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
 <342fdec23f175f816177ac73945ed7fbf5538b90.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <342fdec23f175f816177ac73945ed7fbf5538b90.1737132501.git.Brian.Inglis@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

On Jan 17 10:01, Brian Inglis wrote:
> Add unavailable POSIX additions to Not Implemented section.
> [...]
> +    tcgetwinsize		
> +    tcsetwinsize		

Takashio is going to pushing a patch implementing both functions
as implemented.  You can drop them here.


Thanks,
Corinna
