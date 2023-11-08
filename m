Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id A4AF43858C41; Wed,  8 Nov 2023 19:42:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A4AF43858C41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1699472545;
	bh=nx9kamdCZTAGkIWj9lg3S5Ozg4OS1hQpfBWcOHx8z3s=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ZI2inMr6kMVs65FiqLTHxP44z2uYl7OaBlpsjfaieBtRC7pVcQA3ePUJx0CTP+LPP
	 8GgyIZmHNOgycv6G+C8ZW8PMNcMbSpwMX6gpsQZVZk6TwTZyJW+oLY9oG8LMVqSOda
	 T9Et9kM/54vnhTlJ2a/G8fknFRcNrNxdAcw8O1aM=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id F21C4A807D0; Wed,  8 Nov 2023 20:42:23 +0100 (CET)
Date: Wed, 8 Nov 2023 20:42:23 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Christian Franke <Christian.Franke@t-online.de>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: /dev/disk/by-id: Remove leading spaces from
 identify fields
Message-ID: <ZUvknxmaKZX8s4EI@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Christian Franke <Christian.Franke@t-online.de>,
	cygwin-patches@cygwin.com
References: <52791a04-ceb6-7b88-fb41-21d971e69b44@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <52791a04-ceb6-7b88-fb41-21d971e69b44@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Nov  8 17:40, Christian Franke wrote:
> Minor improvement, avoids "/dev/disk/by-id/sata-VENDOR_MODEL_______SERIAL".

Pushed.

Thanks,
Corinna
