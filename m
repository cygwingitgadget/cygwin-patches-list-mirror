Return-Path: <cygwin-patches-return-2542-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27533 invoked by alias); 29 Jun 2002 17:33:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27519 invoked from network); 29 Jun 2002 17:33:20 -0000
Date: Sat, 29 Jun 2002 11:22:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to pass file descriptors
Message-ID: <20020629173324.GA29874@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <06a901c21e92$e3d4ae60$6132bc3e@BABEL> <003601c21e94$064fc780$0200a8c0@lifelesswks> <20020629093616.C1247@cygbert.vinschen.de> <003201c21f49$30ba8900$1800a8c0@LAPTOP> <037501c21f4b$8de441f0$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <037501c21f4b$8de441f0$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00525.txt.bz2

On Sat, Jun 29, 2002 at 10:01:28AM +0100, Conrad Scott wrote:
>Corinna's point raises the issue of what the future of cygserver is
>expected to be in Cygwin. Is it going to be installed by default, with
>programs being able to rely on it without question? or, as seems to be
>the attitude at the moment, is it going to remain an optional add-on,
>only run by those who need its "special" services?

You may be able to find cygserver discussion in the cygwin-developers
archive.

The bottom line is that I don't want to have to tell Red Hat's customers
to install a server component if they want to use cygwin.  I also don't
want to have to tell every person who wants to release a standalone
cygwin program that they have to copy around cygwin1.dll and
cygserver.exe, finding some way to start cygserver automatically.

So, cygserver will always be optional on my watch.

>I can see that it might well raise the complexity level of the setup
>program (apart from anything else) if Cygwin installs a service as
>part of the default installation (i.e. setup then has to stop the
>service before updating the DLL and then has to re-start the service
>or prompt the user to re-start their machine). But are there any other
>reasons why we wouldn't want cygserver to be a standard part of every
>Cygwin installation?

It should certainly be installed, and maybe we can add a question about
whether it should be started but I don't want to make it mandatory.

cgf
