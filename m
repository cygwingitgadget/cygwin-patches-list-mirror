Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	by sourceware.org (Postfix) with ESMTPS id 63DCD3830B15
	for <cygwin-patches@cygwin.com>; Mon, 28 Nov 2022 14:41:30 +0000 (GMT)
Authentication-Results: sourceware.org; dmarc=permerror header.from=cygwin.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MNwXA-1pNnuK1zIG-00OGbR for <cygwin-patches@cygwin.com>; Mon, 28 Nov 2022
 15:41:28 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 0A555A80771; Mon, 28 Nov 2022 15:41:28 +0100 (CET)
Date: Mon, 28 Nov 2022 15:41:28 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Improve FAQ on early breakpoint for ASLR
Message-ID: <Y4TImGsIsHnJya3W@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20221103170430.4448-1-jon.turney@dronecode.org.uk>
 <alpine.BSO.2.21.2211031120540.30152@resin.csoft.net>
 <Y2TqvPTB7Hui2jmJ@calimero.vinschen.de>
 <4ccbb5e1-ee4f-8944-ed44-4af7fa79f048@dronecode.org.uk>
 <f2942e0e-ea5e-7ba9-8770-b422628dafad@gmail.com>
 <a2e01953-f6ef-cf08-f6e1-0c7632391ede@dronecode.org.uk>
 <Y3NuGWbczdW5f+rC@calimero.vinschen.de>
 <8a0287ed-6f20-4a05-b584-966bfded6833@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8a0287ed-6f20-4a05-b584-966bfded6833@dronecode.org.uk>
X-Provags-ID: V03:K1:OR9a3ZV2gaRtttqRV1QgNvxQk9KSZQRHNnE4PQjCWm5Gs5bwPrz
 vvxMOIuQIjD1mK8lcOWEMMebI3ynYftT2Dd2glwUYkV2c2XJKBu9Ptn2J2ohjWrN3fylY0/
 jjywKKzIfpLTB4PPCjP0zB/Rra574C/XyVZBMXC93jU+c7QJrlgblg9txduX4nbiUOOqEk1
 znqNM9Nyt9OeuCkRI3aBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LQsda2hjzn0=:PHQ7wySiZXFdU4hANUYYr9
 vL/AnGFxrYJSd4hmYNdE9yFXhEsKRLYqBOC+wWkA7qKlQQO9ln8TmtVlZGY57Wf5E44RPnXeH
 2EwKvc3hUkE1TKtqOcwaMRumYiz2wwz9IY9Duem97iL/8f9VDkvrO5cXDzJmznM7ZW8yNBtmD
 0PRdwk7QChRR0POzVQzwKKA4mZbkQF+VBfCsCwADpVXPZXE64O8D6Ls6BQIsPswPYHlQu88vo
 2OFZF/6omFw30ixjacQ4y8ow9fY4h9nErMciT8f7n79HqMVXmlUQ/KnpBIxE0tUsCvKNmhS/w
 Jn3FoI2wBQFNu+sPL10zhYRE/cqa1qvrnzTsEJ6HaS1zvOES7u+VKSlZzekSiPMAP6qZ50dT/
 ds3iHw8+aJr40vWec6s60VArGnNFNeqKCuLoweElB2KR+2MKI3scffIJdPQRXhhDgvIXKSppN
 Wie7BUrl/XORDxnOE+W41S9VkPY+a9XF7V2n/Jg2Du0e8bdcFjWJdLpGlHonHodf/aqMeBCRQ
 8q8t4Jgj1cmKUbCD8HgKJ7DgUFyoW/N9Sl0MRv04a3hbuhg3dvWEyjRUdOZAKa3en1NveWA/c
 eCg62GzbtE3HrMOIJqkHOUZR4g+gDd6D+aZrvObbJOCbfFz6gHGFd5IOpGe0qCYmcBaNp5kQP
 aMlST89EGZF9S7jlk+Ff0JqGZ5w32sa6tofE5XT+bZHfD2HkgG/qyJJJS9i7LUea80i6V65Vk
 vgTfWIrSutUtzpADkwpK1/sPEPE+GS4zbX7puUiZ4nl3HUsCq8TZObtdtlJb9V93mIpFQ+1xy
 HFxffTXaFMSHkMyal/ElDDHJEp+LA==
X-Spam-Status: No, score=-95.3 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Nov 28 13:00, Jon Turney wrote:
> On 15/11/2022 10:46, Corinna Vinschen wrote:
> > 
> > It would be great if we could get used to using the same syntax as the
> > Linux kernel project to document stuff.  I'm trying to follow their lead
> > for a while.  For fixes to former commits, it looks like this in the
> > kernel, at the end of the commit message:
> > 
> > Fixes: 123456789012 ("title of commit 123456789012")
> > 
> > Yeah, core.abbrev is 12 digits.  I'm using this setting for quite some
> > time locally.
> 
> Sounds good.  Is there some script to automate generating this kind of
> comment from a commit-id?

I don't think so, at least I don't see anything like that in git docs...


Corinna
