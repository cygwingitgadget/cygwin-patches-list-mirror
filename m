Return-Path: <cygwin-patches-return-2493-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 10146 invoked by alias); 23 Jun 2002 09:33:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10111 invoked from network); 23 Jun 2002 09:33:38 -0000
Message-ID: <062501c21a99$47da4300$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: "Robert Collins" <robert.collins@syncretize.net>
Cc: <cygwin-patches@cygwin.com>
References: <000601c21a8b$bd8324e0$0200a8c0@lifelesswks>
Subject: Re: Resubmission of cygwin_daemon patch.
Date: Sun, 23 Jun 2002 02:54:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00476.txt.bz2

"Robert Collins" <robert.collins@syncretize.net> wrote:
> Ok, I've got some feedback for you...
>
> I need to have a good think about some of what's being presented.
>
> The following things are unconditionally good:
> The pure virtual transport changes
> The recoverable approach, and instance detection changes. (actually,
I'd
> like to suggest a global mutex be owned and tested against rather
than
> checking for the socket being present. But that's orthogonal).
> Command line help
>
> I'll be extracting the above and committing to head sometime shortly
> after 1.3.11 gets released. Or if that doesn't happen within a week,
> then soon anyway :}.

Thanks.

About instance detection: you're right that something better could be
done here. What I've ended up with is really a security patch: it's
possible for another process to create an instance of a named pipe,
wait for clients to connect and then impersonate them. Oops. So, the
trick is to check the new flag on creating the named pipe and also to
create it with permission such that no more instances can be created
by other processes either. (Of this, I've done the first part and not
the second.) This is also why, except for the shutdown message, I took
out the bit where the server sent a version message to check for the
existence of another server as that would also be a security risk.
It's a bit of a mess, given that it started out as instance detection
and partially mutated into security fixes on the way, as I read more
advisory notices on the web. But, it's probably all code that'll be
needed in the end for one reason or another. A global mutex is a much
more plausible solution for the actual instance detection issue, as
you say.

> On the thoughtful side:
> There seems to be a lot of code duplication - definitions copied to
make
> private versions, that sort of thing. Can you elaborate on why? I
> strongly prefer to only have one instance of such things to prevent
skew
> occuring.

What are you referring to here? I can't think of any such duplication
(as I'd have removed it if there was, for the reasons you mention). Of
course, the fact that I can't think of any such duplication doesn't
mean a whole lot. I'll go have a look again at what I've done.

> Why have you removed the __OUTSIDE_CYGWIN__ for cygserver_shm.cc ?

Because cygserver_shm.cc is only ever compiled into the server, unlike
the various transport files and the cygserver_client.cc file. So
there's no need for it to be passed an __OUTSIDE_CYGWIN__ flag, as it
can depend on the lack of a __INSIDE_CYGWIN__ flag just like all the
other files that are unconditionally compiled into the server (like
cygserver.cc et al).

> That's all for now, gotta run - sorry.

Thanks for the feedback. It's always nice to know that it's not all
dropping into thin air :-)

Cheers,

// Conrad


