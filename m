Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C64F13856259; Thu, 17 Jul 2025 08:08:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C64F13856259
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1752739720;
	bh=I420tJjTvCQJSPjrAK5GH6rJ2YTD5qqBeYffArMU51o=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=YOAkfcQTW8Paoz8Z2klwub6grvEAKQHFmoab70aQQCwid5qXbuTYm0h/ECSW+jsYq
	 amvysXyuSb4wQ042wdcXC/M5UFMuryTBoAYoJXGg4kI7tIU81oWhqOukq0OPsYlg07
	 itaUOAc5RPtF9vqH0D7OYpo2E3HW8SShIb/4Se4o=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A61B1A809F3; Thu, 17 Jul 2025 10:08:38 +0200 (CEST)
Date: Thu, 17 Jul 2025 10:08:38 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/4] cygwin: faq-resources.xml add 3.4 reproduce local
 site
Message-ID: <aHivhiWyAm-a6NhG@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250713052913.2011-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250713052913.2011-1-johnhaugabook@gmail.com>
List-Id: <cygwin-patches.cygwin.com>

On Jul 13 01:29, johnhaugabook@gmail.com wrote:
> From: John Haugabook <johnhaugabook@gmail.com>
> 
> This patchset adds a section for reproducing a clone of the website locally. 
> It allows people who want to contribute to the website to be able to run the 
> site locally, allowing for rendering of the virtual includes e.g. 
> "<!--#include virtual="navbar.html" -->". The patches are:

Sorry, but isn't that going a step too far?  If you need a fully functional
clone of the website, then that's ok, but it doesn't really belong into the
FAQ for Cygwin, does it?  Setting up apache to serve local files and
virtual includes is a non-Cygwin problem...

I'm contributing to the website, too, but to see the result before pushing,
I just use file://local/path/to/cygwin-htdocs/file-of-interest.html.
The layout doesn't match exactly, but it's entirely sufficient to
re-read what I wrote and (if I'm lucky) to find typos in my new text.


Thanks,
Corinna


> 
>  1. General steps and overview of how to build local site.
>  2. An example httpd.conf file, which allows the virtual include elements to be rendered.
>  3. Instructions on building and extracting the html docs from newlib-cygwin.
>  4. The command to run to start the localhost, or note on using server software.
> 
> Also, I made a support repo that illustrates:
>  - The built faq.html.
>  - The process of reproducing a local site that uses a Windows Sandbox environment.
>  - And a working example of a locally built site that was built from the sandbox tool.
>  
> Visit https://github.com/jhauga/patch-newlib-cygwin-faq/tree/reproduce-local-site and see the README.md in the root, sandbox, and cygwin-htdocs folders for more details.
> 
> John Haugabook (4):
>   cygwin: faq-resources add 3.4 reproduce local site
>   cygwin: faq-resources-3.4 example httpd.conf
>   cygwin: faq-resources-3.4 reproduce site docs
>   cygwin: faq-resources-3.4 start local server
> 
>  winsup/doc/faq-resources.xml | 66 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> -- 
> 2.49.0.windows.1
