From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fixes incorrect exit status to windows process
Date: Mon, 12 Mar 2001 06:50:00 -0000
Message-id: <20010312095043.A19646@redhat.com>
References: <001101c0a52c$6f506e20$250ddb18@fision> <20010304235848.D8103@redhat.com> <001101c0a865$ce21f8b0$250ddb18@fision>
X-SW-Source: 2001-q1/msg00169.html

On Thu, Mar 08, 2001 at 10:54:03PM -0800, Jason Gouger wrote:
>Here's another patch which fixes the problem in spawn_guts...

Thanks for the patch.  You tracked it down nicely.

I chose to use the ppid_handle test that I mentioned below but I have
checked something in which should fix the problem.

Thanks again.

cgf

>----- Original Message -----
>From: "Christopher Faylor" <cgf@redhat.com>
>To: <cygwin-patches@cygwin.com>
>Sent: Sunday, March 04, 2001 8:58 PM
>Subject: Re: [PATCH] fixes incorrect exit status to windows process
>
>
>> It looks like you're on the right track, but I think it would
>> make sense to put this in spawn_guts somewhere where EXIT_REPARENTING
>> is being set.  Possibly you can avoid setting the EXIT_REPARENTING
>> bit entirely when !myself->ppid_handle (this is the best way to
>> find out if a cygwin application has been invoked from a non-cygwin
>> application).
