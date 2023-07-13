Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 041053858C62; Thu, 13 Jul 2023 18:18:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 041053858C62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1689272291;
	bh=1neIbgGCaQg4zSQoKNoBm3ri7w8jYOxv3x+1BS+Go7I=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=mBK2CWFovvv2tp/DectU9zGVDsOx1nvmaLrHQNqtrQYdQiymKmzGYIrC/fY4UpZHP
	 5J1wj0T255eVGVhKMHPHZksMBpI7Bn4ioyvMr7j2pjyStHwvY+xVRXWB3cu+pv79ds
	 OcP2PhNuJizhbGtkbPem6ONXqt51eLSOET2lWuRg=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 2106BA80B9C; Thu, 13 Jul 2023 20:18:09 +0200 (CEST)
Date: Thu, 13 Jul 2023 20:18:09 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 10/11] Cygwin: testsuite: Minor fixes to umask03
Message-ID: <ZLA/4dOPApNSWJ1x@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
 <20230713113904.1752-11-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230713113904.1752-11-jon.turney@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jul 13 12:39, Jon Turney wrote:
> See ltp commits f32691e7, 923b23ff and b846e7bb

Ditto?


Corinna
