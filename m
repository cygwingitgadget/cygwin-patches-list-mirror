Return-Path: <cygwin-patches-return-2535-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17825 invoked by alias); 28 Jun 2002 11:07:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17769 invoked from network); 28 Jun 2002 11:07:32 -0000
From: "Robert Collins" <robert.collins@syncretize.net>
To: "'Conrad Scott'" <Conrad.Scott@dsl.pipex.com>,
	<cygwin-patches@cygwin.com>
Subject: RE: Patch to pass file descriptors
Date: Fri, 28 Jun 2002 12:58:00 -0000
Message-ID: <003601c21e94$064fc780$0200a8c0@lifelesswks>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <06a901c21e92$e3d4ae60$6132bc3e@BABEL>
Importance: Normal
X-SW-Source: 2002-q2/txt/msg00518.txt.bz2



> -----Original Message-----
> From: cygwin-patches-owner@cygwin.com 
> [mailto:cygwin-patches-owner@cygwin.com] On Behalf Of Conrad Scott
> Sent: Friday, 28 June 2002 9:00 PM
> To: cygwin-patches@cygwin.com
> Subject: Re: Patch to pass file descriptors
> 
> 
> "Corinna Vinschen" <cygwin-patches@cygwin.com> wrote:
> > More problematic is the approach to use cygserver for this.  I've
> talked
> > to Chris about passing descriptors and we agree in that we want to
> try
> > under all circumstances to find a solution which doesn't need
> cygserver.
> 
> Corinna,
> 
> I thought that the main reason to use cygserver for this is for
> security reasons. Your final paragraph mentions this issue but it's
> not clear whether it's a complete solution (and I'm not fully up to
> speed on the NT security model, so I've no idea). One issue tho' is
> that you'll have to create the shared memory segment with global read
> (and write) permissions since you've no idea of the security level of
> the receiving process. If the sender then puts its process handle,
> with the PROCESS_DUP_HANDLE privilege, into that shared memory, any
> process on the system can read the shared memory and now has access to
> *all* of the sender's handles (i.e., just run through all the small
> integers running DuplicateHandle on them). You could put some
> obfuscation into the system by generating random names for the shared
> memory segment but that's still not ideal.

Yes. I was just about to write up this problem. It's *exactly* the same
issue that exists with vty's and that Egor's original daemon
proof-of-concept was designed to correct.

Chris/Corinna, why do you want to avoid *new* functionality (especially
with security complications) using the cygserver?

Also, I think that the proposed approach will have performance issues as
the receiving process may not read from the socket for an indefinite
time period, and isn't known in advance, so cannot be alerted, and
finally the call has to block to prevent the process terminating and
closing the handles before they are received.

Rob
