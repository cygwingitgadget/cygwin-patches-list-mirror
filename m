Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id D66EC385783B; Mon, 13 Jan 2025 13:39:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D66EC385783B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1736775571;
	bh=yIhW0UpLbywRCOGDju6x3lVn7xZTk8ZI84tDdrSCqVE=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=qDyExliv2HTj0hWIcv7CsvNLEvc00wuSkGHvLLGlw8OPNFsa9CgDPJjnpkyqdCsFG
	 MipEwx704UouOjfaWcNHHnEhd2vCEkNxK9JTLb8wgkluf+q5TJrOsBjz5J9ZUYQdZn
	 /Ahp3+d1KI1Ja+JJQsRKOzm43UZ7BbtH5ktAGtPo=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 40885A80A67; Mon, 13 Jan 2025 14:39:30 +0100 (CET)
Date: Mon, 13 Jan 2025 14:39:30 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 8/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 abbrev variants of base function
Message-ID: <Z4UXksHySN12NP1H@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <6f43c54d894bc7b6e2a75596cf07d47ffb881d51.1736552566.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6f43c54d894bc7b6e2a75596cf07d47ffb881d51.1736552566.git.Brian.Inglis@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

On Jan 10 17:01, Brian Inglis wrote:
> Abbreviate circular F/Ff/Fl and similar function variants to /f/l dropping base name.

No, please no.  Abbreviating in this manner breaks searches too
easily.


Corinna
