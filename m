Return-Path: <cygwin-patches-return-2390-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13537 invoked by alias); 11 Jun 2002 14:19:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13506 invoked from network); 11 Jun 2002 14:19:09 -0000
From: "Robert Collins" <robert.collins@syncretize.net>
To: "'Conrad Scott'" <Conrad.Scott@dsl.pipex.com>,
	<cygwin-patches@cygwin.com>
Subject: RE: cygserver debug output patch
Date: Tue, 11 Jun 2002 07:19:00 -0000
Message-ID: <00a901c21152$f82c52c0$0200a8c0@lifelesswks>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <008801c210b9$248538e0$6132bc3e@BABEL>
X-SW-Source: 2002-q2/txt/msg00373.txt.bz2



> -----Original Message-----
> From: cygwin-patches-owner@cygwin.com 
> [mailto:cygwin-patches-owner@cygwin.com] On Behalf Of Conrad Scott
> Sent: Tuesday, 11 June 2002 5:58 AM


> This defines the same set of XXX_printf macros as does 
> sys/strace.h: of
> these, system_printf maps to a printf on stderr and the 
> others ditto if the
> DEBUGGING flag is given (i.e. --enable-debugging) and no-ops 
> otherwise. They
> also use __PRETTY_FUNCTION__ to give more information about 
> the problem
> location.
> 
> I've also added more debugging calls into the code, whenever 
> I got really
> lost, basically :-)

All cool. I'll actually review this tomorrow night, I've used my hacking
time tonight already :[.
 
> Apart from that, just a couple of minor changes to a pthread_once_t
> initialisation and some pure virtual functions on the
> cygserver_transport_base class.
> 
> I hope this is all fine (Robert et al). I'll continue with 
> some more hacking
> around fun. Umm . . . sorry, make that "careful development" :-)

It's great. Welcome to the club. There's a grand total of three
contributors to the cygserver code - Egor, myself... and you.

One nit: your changelog doesn't say *what* from
cygserver_transport_pipes.cc you are moving to woutsup.h. 

> p.s. I've attached the new "woutsup.h" file separately as I couldn't
> convince cvs diff to put it into the patch file. I thought the -N flag
> should do it, but I had no luck. Could someone give me a hint? Thanks.

You need CVS access to make that work right... then you can CVS add, and
use the -N flag, and then cvs remove without ever committing. 

Rob
