Return-Path: <cygwin-patches-return-4744-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17268 invoked by alias); 13 May 2004 19:34:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17258 invoked from network); 13 May 2004 19:34:50 -0000
Date: Thu, 13 May 2004 19:34:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Strange problem with Cygwin from CVS
Message-ID: <20040513193449.GY12030@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <BAY9-F14904H3Nztw4500030904@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY9-F14904H3Nztw4500030904@hotmail.com>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q2/txt/msg00096.txt.bz2

On May 13 14:09, Stephen Cleary wrote:
> So, I backed out my patch, and was just compiling the Cygwin CVS, and got 
> the same thing. I tried it again at lunch today (thinking that someone may 
> have committed something incorrectly and it would soon be fixed) - same 
> problem. Is anyone else seeing this?
> 
> Here's what I'm doing:
> [from /cygdrive/c/cygwin-cvs] cvs update -C
> [from /cygdrive/c/cygwin-cvs/obj] make
> [using a .cmd file] move the new-cygwin1.dll over 
> c:\cygwin\bin\cygwin1.dll, also delete the generated cygwin0.dll
> 
> After this procedure, starting bash will display the following in the 
> console:
>      4 [main] bash 320 handle_exceptions: Exception: 
> STATUS_ACCESS_VIOLATION
>   1059 [main] bash 320 open_stackdumpfile: Dumping stack trace to 
> bash.exe.stackdump
> 
> I'm attaching the stackdump file if that's any help.
> 
> So, my main question is: is anyone else seeing this, or has something on my 
> machine gotten screwed up?

WFM.  Try "make clean; make".

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Co-Project Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
