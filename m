Return-Path: <cygwin-patches-return-1988-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 670 invoked by alias); 14 Mar 2002 14:24:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 627 invoked from network); 14 Mar 2002 14:24:01 -0000
Message-ID: <20020314142401.5504.qmail@web20002.mail.yahoo.com>
Date: Thu, 14 Mar 2002 15:54:00 -0000
From: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
Subject: Re: mkgroup usage/version patch
To: Corinna Vinschen <cygwin-patches@cygwin.com>
In-Reply-To: <20020314134312.R29574@cygbert.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SW-Source: 2002-q1/txt/msg00345.txt.bz2

--- Corinna Vinschen <cygwin-patches@cygwin.com> wrote:
> While I'm going with the decision to add a version information
> I don't understand why you changed 
> 
> - the usage output method.  I don't like to have a big multiline format
>   string in fprintf.
Well, I could just as easily changed all the lines to 
fprintf(stream, "...
I just used :s/foo/bar/12 anyway. I did it with the multiline since 
1. That's how cygcheck, cygpath, etc. do it now
2. I find it easier to read, personally. (It looks a lot like the 
   CLI output that way)
 
> - the function usage() to exit instead of returning the exitcode.
Again, no reason. That's just the way some of the other utils work.
I was going for consitency in all the code in /winsup/utils

Looking at the patch on the website at
http://cygwin.com/ml/cygwin-patches/2002-q1/msg00342.html
I'm seeing something else weird:
+	        print_version ();
+                exit (0);
                ^
What's this extra space? That's not in my code. Do other people see it
in their attachments, or is it just in the HTML? I already deleted the
message from myself.

__________________________________________________
Do You Yahoo!?
Yahoo! Sports - live college hoops coverage
http://sports.yahoo.com/
