Return-Path: <cygwin-patches-return-3884-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21172 invoked by alias); 24 May 2003 17:45:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21054 invoked from network); 24 May 2003 17:45:07 -0000
X-Originating-IP: [62.21.237.84]
X-Originating-Email: [mdvpost@hotmail.com]
From: "Micha Nelissen" <mdvpost@hotmail.com>
To: cygwin-patches@cygwin.com
Bcc: 
Subject: Re: Escape sequence for codepage switch
Date: Sat, 24 May 2003 17:45:00 -0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F65cX7MkQbS0zk000371dd@hotmail.com>
X-OriginalArrivalTime: 24 May 2003 17:45:03.0148 (UTC) FILETIME=[347C0EC0:01C3221C]
X-SW-Source: 2003-q2/txt/msg00111.txt.bz2




>From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
>
>On Sat, 24 May 2003, Micha Nelissen wrote:
>
> > Hi,
> >
> > Added escape sequence to let programs switch the current codepage to 
>enable
> > linedrawing characters. These work only if the termcap entry is changed,
> > adding 'ae=\E[z' and 'as=\E[y' capabilities. For use of cygwin in 
>Command
> > Prompt.
> >
> > Micha.
>
>Micha,
>
>How does this interact with the 'codepage:' setting in the CYGWIN
>environment variable?  Does the above make this setting obsolete?

The setting in the CYGWIN environment variabele is the startup setting, 
until a program uses the termcap entry escape sequence to change it. When 
the program has ended the alternate charset it is as if the user specified 
codepage:ansi in the CYGWIN variabele.

Regards,

Micha.

_________________________________________________________________
The new MSN 8: smart spam protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail
