Return-Path: <cygwin-patches-return-2492-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27624 invoked by alias); 23 Jun 2002 07:58:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27576 invoked from network); 23 Jun 2002 07:58:21 -0000
From: "Robert Collins" <robert.collins@syncretize.net>
To: "'Conrad Scott'" <Conrad.Scott@dsl.pipex.com>,
	<cygwin-patches@cygwin.com>
Subject: RE: Resubmission of cygwin_daemon patch.
Date: Sun, 23 Jun 2002 02:33:00 -0000
Message-ID: <000601c21a8b$bd8324e0$0200a8c0@lifelesswks>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <077501c21929$e6e84350$6132bc3e@BABEL>
X-SW-Source: 2002-q2/txt/msg00475.txt.bz2

Ok, I've got some feedback for you...

I need to have a good think about some of what's being presented.

The following things are unconditionally good:
The pure virtual transport changes
The recoverable approach, and instance detection changes. (actually, I'd
like to suggest a global mutex be owned and tested against rather than
checking for the socket being present. But that's orthogonal).
Command line help

I'll be extracting the above and committing to head sometime shortly
after 1.3.11 gets released. Or if that doesn't happen within a week,
then soon anyway :}.

On the thoughtful side:
There seems to be a lot of code duplication - definitions copied to make
private versions, that sort of thing. Can you elaborate on why? I
strongly prefer to only have one instance of such things to prevent skew
occuring.
Why have you removed the __OUTSIDE_CYGWIN__ for cygserver_shm.cc ?

That's all for now, gotta run - sorry.

Rob
