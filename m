Return-Path: <cygwin-patches-return-2581-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18500 invoked by alias); 2 Jul 2002 11:15:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18484 invoked from network); 2 Jul 2002 11:15:51 -0000
Message-ID: <085401c221ba$1915d4d0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <Pine.LNX.4.33.0207011735010.2716-100000@this> <06d801c2214d$f155ddd0$6132bc3e@BABEL> <20020702113716.K23555@cygbert.vinschen.de>
Subject: Re: Patch to pass file descriptors
Date: Tue, 02 Jul 2002 04:15:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00029.txt.bz2

"Corinna Vinschen" <cygwin-patches@cygwin.com> wrote:
> On Mon, Jul 01, 2002 at 11:23:35PM +0100, Conrad Scott wrote:
> > Unless anyone has any objection, if you send this to the list,
I'll
> > put it into the cygwin_daemon branch. It's not a complete or final
>
> I have objections.  This is neither fully discussed nor is it clear
> how to incorporate the call together with the cygserver-less
descriptor
> passing code into fhandler_socket.cc so far.

That's fair enough: I'll leave it for the time being.

// Conrad


