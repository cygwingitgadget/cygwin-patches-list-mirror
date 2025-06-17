Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 17331385B538; Tue, 17 Jun 2025 09:55:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 17331385B538
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750154148;
	bh=L+AeKY4F+PmHGu8IR/UBJvYfhLcCWul76sa+TSzjV6E=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=OcS7vrWzo9dwHr9OdlClDtupmn1xX92RCV7mkkrLpV+Geemkrb8eWoy3nCA7ilHEl
	 5GBIN0F/osBZI0Lxf90VPm9Psye1K1WFpyFXG9Lar4fIr6QCwJp4ZzNcz/FI2Ir1+3
	 rcA0SK1LhuYA57bXsesjwd7oHjtOsxomUuD37x1Q=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id F348FA80961; Tue, 17 Jun 2025 11:55:45 +0200 (CEST)
Date: Tue, 17 Jun 2025 11:55:45 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: signal: Enable the signal mask earlier
Message-ID: <aFE7oWpMufKEKXy0@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250607091917.760-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250607091917.760-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Jun  7 18:19, Takashi Yano wrote:
> Currently, _cygtls::sigmask is set in call_signal_handler(), but this
> is too late to effectively prevent a masked signal from being armed.
> With this patch, deltamask, which is set in _cygtls::interrupt_setup()
> in advancem, is also checked as well as sigmask to determine that the
            ^
	    stray m

Otherwise, LGTM.

Thanks,
Corinna
