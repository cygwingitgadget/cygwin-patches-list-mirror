Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C072C38505D4; Mon, 23 Jun 2025 13:40:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C072C38505D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750686003;
	bh=Z4eewsKwy+F5kDAxbST7yx5dxWwh2a0Xcm4xbFXMlFk=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=tRfZaxPr2dzucAP+K6F91xpZ7CVhywjjmH0yBuYt60qt7aulNCxjyk3FJA4zxK8Zc
	 8E5SuJJIgnvEGc7kDN2e6n7lG/mYaL5HLwk+dOPPM8Htugy66WsZ2mwsul5QzjNcfZ
	 L8Qy85fRgNK6ZgxqAJUgt/iuhO/rI0eM+xVXKfkM=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A44CEA80D72; Mon, 23 Jun 2025 15:40:01 +0200 (CEST)
Date: Mon, 23 Jun 2025 15:40:01 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/4] cygwin-htdocs: faq.html edits
Message-ID: <aFlZMXSJNlxeV-xJ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250622082003.1685-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250622082003.1685-1-johnhaugabook@gmail.com>
List-Id: <cygwin-patches.cygwin.com>

Guys, please help reviewing doc patches, too.


Thanks,
Corinna


On Jun 22 04:19, johnhaugabook@gmail.com wrote:
> From: jhauga <johnhaugabook@gmail.com>
> 
> This patch series contains several focused documentation edits to faq.html
> 
> Changes include:
> - In section 6.21 - added additional required packages for installation of newlib-cygwin. The packages added are build: libtool; dumper utility: libiconv, libiconv2; documentation: perl-XML-SAX-Expat, docbook-utils. Also ordered packages alphabetically as this makes it easier when using GUI of setup-x86_64.exe when selecting packages.
> - In section 6.21 - added example of calling setup-x86_64.exe to do a preliminary search when installing packages, as there are nearly a dozen packages, and because it can take over 30 minutes for the installation to complete; and if all the required packages are not downloaded, the install will fail at like minute 29.
> - In section 6.21 - added an additional paragraph and tips regarding the install process.
> - Added section 3.4 - instructions on how to build local version of site from "https://cygwin.com/git.html". Instructions mainly specify how to configure local server's httpd.conf file, and downloading a command line tool. In example used httpd install with "winget install ApacheLounge.httpd".
> 
> These patches were created against the latest upstream `master` branch.
> 
> Thanks for your review and feedback.
> 
> jhauga (4):
>   faq.html: add 5 required packages and sort packages
>   faq.html: add ready-made -P download commands
>   faq.html: section 6.21 tips and additions
>   faq.html: add 3.4 run cloned site locally
> 
>  faq/faq.html | 93 +++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 71 insertions(+), 22 deletions(-)
> 
> -- 
> 2.46.0.windows.1
> 
