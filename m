Return-Path: <cygwin-patches-return-2540-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 26612 invoked by alias); 29 Jun 2002 08:59:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26598 invoked from network); 29 Jun 2002 08:59:32 -0000
Message-ID: <037501c21f4b$8de441f0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <06a901c21e92$e3d4ae60$6132bc3e@BABEL> <003601c21e94$064fc780$0200a8c0@lifelesswks> <20020629093616.C1247@cygbert.vinschen.de> <003201c21f49$30ba8900$1800a8c0@LAPTOP>
Subject: Re: Patch to pass file descriptors
Date: Sat, 29 Jun 2002 09:25:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00523.txt.bz2

> "Corinna Vinschen" <cygwin-patches@cygwin.com> wrote:
> > Basically, I don't like that sshd might depend on a running
cygserver.
> > If the implementation only works with a server process as for SysV
shared
> > memory, that's ok.  But if it's possible to get that working w/o
the
> > cygserver, I'd prefer that.


"Robert Collins" <robert.collins@syncretize.net> wrote:
> Ahh, well what about doing both, like we do with the tty handle
passing
> code. A secure version for when cygserver is running, and the
insecure
> version for when cygserver isn't running.

Corinna's point raises the issue of what the future of cygserver is
expected to be in Cygwin. Is it going to be installed by default, with
programs being able to rely on it without question? or, as seems to be
the attitude at the moment, is it going to remain an optional add-on,
only run by those who need its "special" services?

I can see that it might well raise the complexity level of the setup
program (apart from anything else) if Cygwin installs a service as
part of the default installation (i.e. setup then has to stop the
service before updating the DLL and then has to re-start the service
or prompt the user to re-start their machine). But are there any other
reasons why we wouldn't want cygserver to be a standard part of every
Cygwin installation?

// Conrad


