Return-Path: <cygwin-patches-return-2539-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 22337 invoked by alias); 29 Jun 2002 08:44:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22303 invoked from network); 29 Jun 2002 08:44:41 -0000
Message-ID: <003201c21f49$30ba8900$1800a8c0@LAPTOP>
From: "Robert Collins" <robert.collins@syncretize.net>
To: "Corinna Vinschen" <cygwin-patches@cygwin.com>
References: <06a901c21e92$e3d4ae60$6132bc3e@BABEL> <003601c21e94$064fc780$0200a8c0@lifelesswks> <20020629093616.C1247@cygbert.vinschen.de>
Subject: Re: Patch to pass file descriptors
Date: Sat, 29 Jun 2002 01:59:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00522.txt.bz2


----- Original Message -----
From: "Corinna Vinschen" <cygwin-patches@cygwin.com>
To: <cygwin-patches@cygwin.com>
Sent: Saturday, June 29, 2002 5:36 PM
Subject: Re: Patch to pass file descriptors


> On Fri, Jun 28, 2002 at 09:07:42PM +1000, Robert Collins wrote:
> > Chris/Corinna, why do you want to avoid *new* functionality (especially
> > with security complications) using the cygserver?
>
> Basically, I don't like that sshd might depend on a running cygserver.
> If the implementation only works with a server process as for SysV shared
> memory, that's ok.  But if it's possible to get that working w/o the
> cygserver, I'd prefer that.

Ahh, well what about doing both, like we do with the tty handle passing
code. A secure version for when cygserver is running, and the insecure
version for when cygserver isn't running.

Rob
