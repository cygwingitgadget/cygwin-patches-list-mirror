From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: Re: Patch to make setrlimit() more forgiving
Date: Fri, 05 Jan 2001 01:03:00 -0000
Message-id: <20010105100335.B8117@cobold.vinschen.de>
References: <30E7BC40E838D211B3DB00104B09EFB77953DE@delorean.optimation.co.nz> <20010104214112.A32564@redhat.com>
X-SW-Source: 2001-q1/msg00006.html

On Thu, Jan 04, 2001 at 09:41:12PM -0500, Christopher Faylor wrote:
> It looks good but I need a ChangeLog.
> 
> cgf
> 
> On Fri, Jan 05, 2001 at 03:38:43PM +1300, David Sainty wrote:
> >Attached is a simple patch that prevents setrlimit() failing with an error
> >when the operation would not have changed anything.  This allows all
> >resource types to be set, so long as the setting is identical to the current
> >pseudo-settings.

I have created a ChangeLog entry for now and applied the patch. So
I could apply my own patch to return correct values in case of EFAULT.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
