Return-Path: <cygwin-patches-return-2543-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 11194 invoked by alias); 29 Jun 2002 18:22:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11180 invoked from network); 29 Jun 2002 18:22:51 -0000
Message-ID: <003e01c21f9a$3f324940$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <06a901c21e92$e3d4ae60$6132bc3e@BABEL> <003601c21e94$064fc780$0200a8c0@lifelesswks> <20020629093616.C1247@cygbert.vinschen.de> <003201c21f49$30ba8900$1800a8c0@LAPTOP> <037501c21f4b$8de441f0$6132bc3e@BABEL> <20020629173324.GA29874@redhat.com>
Subject: Re: Patch to pass file descriptors
Date: Sat, 29 Jun 2002 14:15:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00526.txt.bz2

"Christopher Faylor" <cgf@redhat.com> wrote:
> You may be able to find cygserver discussion in the
cygwin-developers
> archive.

Good hint :-) I'll go look.

> The bottom line is that I don't want to have to tell Red Hat's
customers
> to install a server component if they want to use cygwin.  I also
don't
> want to have to tell every person who wants to release a standalone
> cygwin program that they have to copy around cygwin1.dll and
> cygserver.exe, finding some way to start cygserver automatically.

Got you: basically customers shouldn't be forced to use the setup
program but should be able to treat cygwin like any other DLL their
program might use. That wasn't a scenario I was considering and it's a
good point.

Thanks for the orientation. Now off to the archives.

// Conrad


