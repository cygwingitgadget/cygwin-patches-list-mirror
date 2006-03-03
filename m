Return-Path: <cygwin-patches-return-5787-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5558 invoked by alias); 3 Mar 2006 16:02:20 -0000
Received: (qmail 5541 invoked by uid 22791); 3 Mar 2006 16:02:19 -0000
X-Spam-Check-By: sourceware.org
Received: from ACCESS1.CIMS.NYU.EDU (HELO access1.cims.nyu.edu) (128.122.81.155)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 03 Mar 2006 16:02:11 +0000
Received: from localhost (localhost [127.0.0.1]) 	by access1.cims.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id k23G27fo009959 	for <cygwin-patches@cygwin.com>; Fri, 3 Mar 2006 11:02:07 -0500 (EST)
Date: Fri, 03 Mar 2006 16:02:00 -0000
From: Igor Peshansky <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] regtool: Add load/unload commands and --binary option
In-Reply-To: <20060303094621.GP3184@calimero.vinschen.de>
Message-ID: <Pine.GSO.4.63.0603031058150.9494@access1.cims.nyu.edu>
References: <43D6876F.9080608@t-online.de> <20060125105240.GM8318@calimero.vinschen.de>  <43D7E666.8080803@t-online.de> <20060126091944.GT8318@calimero.vinschen.de>  <20060211103418.GM14219@calimero.vinschen.de> <43F0E145.6080109@t-online.de>  <20060215104302.GA13856@calimero.vinschen.de> <4405F274.6080009@t-online.de>  <20060301222502.GW3184@calimero.vinschen.de> <44075CAA.8030009@t-online.de>  <20060303094621.GP3184@calimero.vinschen.de>
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
X-SW-Source: 2006-q1/txt/msg00096.txt.bz2

On Fri, 3 Mar 2006, Corinna Vinschen wrote:

> Btw., since you seem to be interested in hacking the registry...  would
> you also be interested to introduce registry write access below
> /proc/registry inside of the Cygwin DLL?  That would be extra cool.
> I'm not quite sure how to handle the mapping from file types to
> registry key types, but there might be some simple way which I'm just
> too blind to see.

Hmm, there is currently no way for the programs to find out the registry
key type, unless we introduce new functionality into stat() or something.

As it is, why would the programs need to know the key type, anyway?  They
just write the data, and fhandler_registry takes care of converting it to
the right format (using arbirtary conventions of some sort).  The only
potential problems are REG_MULTI_SZ and REG_EXPAND_SZ (in the former case
it's a question of picking a string delimiter, and in the latter it's
about annotating expandable values).

Am I missing something?
	Igor
P.S. Thanks a lot to Christian for this cool functionality.
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_	    pechtcha@cs.nyu.edu | igor@watson.ibm.com
ZZZzz /,`.-'`'    -.  ;-;;,_		Igor Peshansky, Ph.D. (name changed!)
     |,4-  ) )-,_. ,\ (  `'-'		old name: Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"Las! je suis sot... -Mais non, tu ne l'es pas, puisque tu t'en rends compte."
"But no -- you are no fool; you call yourself a fool, there's proof enough in
that!" -- Rostand, "Cyrano de Bergerac"
