From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Corinna Vinschen" <cygwin-patches@cygwin.com>
Subject: Re: Cygwin half of pthread update
Date: Thu, 12 Apr 2001 15:47:00 -0000
Message-id: <00ee01c0c3a2$921f3190$0200a8c0@lifelesswks>
References: <03f001c0c2ed$3b89acd0$0200a8c0@lifelesswks> <20010411232520.C32524@redhat.com> <05df01c0c305$d4bef0f0$0200a8c0@lifelesswks> <20010412113539.A5879@redhat.com> <20010412180758.A30816@cygbert.vinschen.de>
X-SW-Source: 2001-q2/msg00046.html

Ouch ouch ouch sorry that slipped in. I thought I'd trimmed everything
else out of cygwin.din

Please remove the mkfifo export - it's part of my alpha mkfifo
development.

I'm very sorry about that

Rob
----- Original Message -----
From: "Corinna Vinschen" <cygwin-patches@cygwin.com>
To: <cygwin-patches@cygwin.com>
Sent: Friday, April 13, 2001 2:07 AM
Subject: Re: Cygwin half of pthread update


> On Thu, Apr 12, 2001 at 11:35:39AM -0400, Christopher Faylor wrote:
> > On Thu, Apr 12, 2001 at 02:05:30PM +1000, Robert Collins wrote:
> > >Committed.
> >
> > What happened to the ChangeLog?  You shouldn't check in stuff
without
> > a ChangeLog entry.
>
> Why is there a symbol `mkfifo' in cygwin.din but nowhere is the
function?
> I can't link the dll anymore. Sure I can but I have to patch
cygwin.din
> then.
>
> Corinna
>
> --
> Corinna Vinschen                  Please, send mails regarding Cygwin
to
> Cygwin Developer
mailto:cygwin@cygwin.com
> Red Hat, Inc.
>
