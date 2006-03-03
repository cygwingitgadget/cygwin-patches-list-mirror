Return-Path: <cygwin-patches-return-5783-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29374 invoked by alias); 3 Mar 2006 09:46:28 -0000
Received: (qmail 29364 invoked by uid 22791); 3 Mar 2006 09:46:27 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Fri, 03 Mar 2006 09:46:24 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id C6D0C544001; Fri,  3 Mar 2006 10:46:21 +0100 (CET)
Date: Fri, 03 Mar 2006 09:46:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] regtool: Add load/unload commands and --binary option
Message-ID: <20060303094621.GP3184@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <43D6876F.9080608@t-online.de> <20060125105240.GM8318@calimero.vinschen.de> <43D7E666.8080803@t-online.de> <20060126091944.GT8318@calimero.vinschen.de> <20060211103418.GM14219@calimero.vinschen.de> <43F0E145.6080109@t-online.de> <20060215104302.GA13856@calimero.vinschen.de> <4405F274.6080009@t-online.de> <20060301222502.GW3184@calimero.vinschen.de> <44075CAA.8030009@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44075CAA.8030009@t-online.de>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00092.txt.bz2

On Mar  2 21:59, Christian Franke wrote:
> Corinna Vinschen wrote:
> >...
> >  
> >>   //printf("key `%s' value `%s'\n", n, value);
> >>    
> >
> >Why is this printf commented out?  If it's not needed, please remove.
> >  
> 
> cvs annotate regtool.cc
> ...
> 1.1 (cgf      17-Feb-00):     }
> 1.1 (cgf      17-Feb-00):   //printf("key `%s' value `%s'\n", n, value);
> 1.1 (cgf      17-Feb-00): }
> 
> Doing code-janitor work on historic code was not the intent of my patch ;-)

Urgh, sorry about that.  While scanning your patch I missed that this
printf isn't new but already in the code.

> >>@@ -577,7 +647,14 @@
> >>   switch (vtype)
> >>     {
> >>     case REG_BINARY:
> >>-      fwrite (data, dsize, 1, stdout);
> >>+      if (key_type == KT_BINARY)	// hack
> >>    
> >
> >Hack?  Why hack?  Otherwise, please remove this comment.
> >  
> 
> Because {re|mis}using "set" key_type for as a "get" option has been 
> called a hack many years ago:
> 
> 1.1 (cgf      17-Feb-00):     case REG_EXPAND_SZ:
> 1.3 (cgf      10-Jan-01):       if (key_type == KT_EXPAND)    // hack
> 1.1 (cgf      17-Feb-00):     {

Well, I can't see a hack in what you're using KT_BINARY here.  I removed
the comment from your patch.

> Attached is a new version of the patch.
> Thanks to your help regarding SE_BACKUP_NAME, the "save" action is now 
> included.

Cool.

> 2006-03-02  Christian Franke <franke@computer.org>
> 
>       * regtool.cc (options): Add 'binary'.
>         (usage): Document 'load|unload|save' and '-b'.
>         (find_key): Add 'options' parameter, add load/unload.
>         (cmd_set): Add KT_BINARY case.
>         (cmd_get): Add hex output in KT_BINARY case.
>         (cmd_load): New function.
>         (cmd_unload): New function.
>         (set_privilege): New function.
>         (cmd_save): New function.
>         (commands): Add load, unload and save.
>         (main): Add '-b'
>       * utils.sgml (regtool): Document it.

I applied the patch.  I just had to reformat your ChangeLog slightly
(a TAB before all lines, no extra indentation for lines which don't
start with a '*').

Btw., since you seem to be interested in hacking the registry...  would
you also be interested to introduce registry write access below
/proc/registry inside of the Cygwin DLL?  That would be extra cool.
I'm not quite sure how to handle the mapping from file types to
registry key types, but there might be some simple way which I'm just
too blind to see.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
