Return-Path: <cygwin-patches-return-2534-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7606 invoked by alias); 28 Jun 2002 10:57:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7544 invoked from network); 28 Jun 2002 10:57:43 -0000
Message-ID: <06a901c21e92$e3d4ae60$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <Pine.GSO.4.30L.0206261539550.20345-600000@biohazard-cafe.mit.edu> <20020628115118.Z1188@cygbert.vinschen.de>
Subject: Re: Patch to pass file descriptors
Date: Fri, 28 Jun 2002 04:07:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00517.txt.bz2

"Corinna Vinschen" <cygwin-patches@cygwin.com> wrote:
> More problematic is the approach to use cygserver for this.  I've
talked
> to Chris about passing descriptors and we agree in that we want to
try
> under all circumstances to find a solution which doesn't need
cygserver.

Corinna,

I thought that the main reason to use cygserver for this is for
security reasons. Your final paragraph mentions this issue but it's
not clear whether it's a complete solution (and I'm not fully up to
speed on the NT security model, so I've no idea). One issue tho' is
that you'll have to create the shared memory segment with global read
(and write) permissions since you've no idea of the security level of
the receiving process. If the sender then puts its process handle,
with the PROCESS_DUP_HANDLE privilege, into that shared memory, any
process on the system can read the shared memory and now has access to
*all* of the sender's handles (i.e., just run through all the small
integers running DuplicateHandle on them). You could put some
obfuscation into the system by generating random names for the shared
memory segment but that's still not ideal.

It's also not clear to me how secure cygwin is intended to be: I
assume it should be no less secure than the underlying NT system, but
perhaps I've the wrong end of the stick here. But if such security is
the aim, it can't be achieved through this approach (AFAICS etc.).

In general, I thought that cygserver was intended for all such
inter-process communication to get around just these sort of problems.
(Not that I can see how to get file descriptor passing to work
properly via cygserver either, but I've not thought too much about it
yet.)

I'd be interested to see a good solution to this sort of problem.

// Conrad


