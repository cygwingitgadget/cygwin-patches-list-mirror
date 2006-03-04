Return-Path: <cygwin-patches-return-5798-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5880 invoked by alias); 4 Mar 2006 14:49:25 -0000
Received: (qmail 5870 invoked by uid 22791); 4 Mar 2006 14:49:24 -0000
X-Spam-Check-By: sourceware.org
Received: from ACCESS1.CIMS.NYU.EDU (HELO access1.cims.nyu.edu) (128.122.81.155)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 04 Mar 2006 14:49:22 +0000
Received: from localhost (localhost [127.0.0.1]) 	by access1.cims.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id k24EnKfo008935; 	Sat, 4 Mar 2006 09:49:20 -0500 (EST)
Date: Sat, 04 Mar 2006 14:49:00 -0000
From: Igor Peshansky <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Christian Franke <Christian.Franke@t-online.de>
cc: cygwin-patches@cygwin.com
Subject: Re: [Patch] regtool: Add load/unload commands and --binary option
In-Reply-To: <4408C714.9060605@t-online.de>
Message-ID: <Pine.GSO.4.63.0603040944160.6620@access1.cims.nyu.edu>
References: <43D6876F.9080608@t-online.de> <20060125105240.GM8318@calimero.vinschen.de>  <43D7E666.8080803@t-online.de> <20060126091944.GT8318@calimero.vinschen.de>  <20060211103418.GM14219@calimero.vinschen.de> <43F0E145.6080109@t-online.de>  <20060215104302.GA13856@calimero.vinschen.de> <4405F274.6080009@t-online.de>  <20060301222502.GW3184@calimero.vinschen.de> <44075CAA.8030009@t-online.de>  <20060303094621.GP3184@calimero.vinschen.de> <4408B033.4050504@t-online.de>  <Pine.GSO.4.63.0603031711410.11990@access1.cims.nyu.edu> <4408C714.9060605@t-online.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00107.txt.bz2

On Fri, 3 Mar 2006, Christian Franke wrote:

> Igor Peshansky wrote:
> > What's wrong with using open() flags?
>
> Save/restore registry tree in/from file tree wont work.

If we also add flags for stat() to figure out the type of the registry key
(and we'd have to, for symmetry), copy within the registry would work just
fine.  However, you're right that once the file is copied to the regular
filesystem, all of those special flags are lost.  Hmm...

> > > Suggest to start a new thread for this discussion....
> >
> > Right, good idea, except not on this list (as Dave pointed out).
> > What would be a good place -- cygwin-developers?
>
> If you consider to accept my subscription request to this list ;-)

Did you send such a request? ;-)
I don't have the power to accept it, but, FWIW, I think the above intent
certainly deserves it.  Corinna or CGF?

BTW, Christian, when you're subscribed, read the welcome message carefully
for web archives access instructions.
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_	    pechtcha@cs.nyu.edu | igor@watson.ibm.com
ZZZzz /,`.-'`'    -.  ;-;;,_		Igor Peshansky, Ph.D. (name changed!)
     |,4-  ) )-,_. ,\ (  `'-'		old name: Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"Las! je suis sot... -Mais non, tu ne l'es pas, puisque tu t'en rends compte."
"But no -- you are no fool; you call yourself a fool, there's proof enough in
that!" -- Rostand, "Cyrano de Bergerac"
