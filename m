Return-Path: <cygwin-patches-return-2437-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 29480 invoked by alias); 15 Jun 2002 11:26:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29445 invoked from network); 15 Jun 2002 11:26:10 -0000
From: "Robert Collins" <robert.collins@syncretize.net>
To: "'Conrad Scott'" <Conrad.Scott@dsl.pipex.com>
Cc: <cygwin-patches@cygwin.com>
Subject: RE: cygserver debug output patch
Date: Sat, 15 Jun 2002 04:26:00 -0000
Message-ID: <002001c2145f$7ca741e0$0200a8c0@lifelesswks>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
In-Reply-To: <017a01c2135d$64f74c50$6132bc3e@BABEL>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00420.txt.bz2



> -----Original Message-----
> From: cygwin-patches-owner@cygwin.com 
> [mailto:cygwin-patches-owner@cygwin.com] On Behalf Of Conrad Scott
> Sent: Friday, 14 June 2002 2:39 PM

> The SVID and the Linux/NetBSD implementations also provide an 
> errno (EIDRM),
> which is returned by shmat(2) when attempting to attach to a 
> deleted segment
> (i.e. "identifier removed"). This presumably can only be 
> returned during
> this pending period, as otherwise you would get EINVAL, which 
> supports this
> interpretation.
> 
> So, it seems we're back where we started, which is lucky 'cos 
> it's probably
> easier to implement on win32 :-)

Good.
 
> So unless there is something in Posix / Open Group / Single 
> Unix / ... that
> explicitly changes this behaviour, I guess we should go with 
> the traditional
> interpretation of the SVID definition. Seem okay?

Please do, it looks like that's what I had done :}.

Rob
