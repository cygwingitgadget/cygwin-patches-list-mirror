Return-Path: <cygwin-patches-return-2478-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18355 invoked by alias); 21 Jun 2002 02:47:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18299 invoked from network); 21 Jun 2002 02:47:26 -0000
Date: Thu, 20 Jun 2002 19:47:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: YACP
Message-ID: <20020621024807.GA16786@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20020621003543.GG7913@redhat.com> <20020621005707.27244.qmail@web20004.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020621005707.27244.qmail@web20004.mail.yahoo.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00461.txt.bz2

On Thu, Jun 20, 2002 at 05:57:07PM -0700, Joshua Daniel Franklin wrote:
>So is the UNC type coming back at some point? 

No.  I meant the alternate way of specifying a file in Windows:

"\\?\C:\myworld\private"

http://msdn.microsoft.com/library/default.asp?url=/library/en-us/fileio/storage_7mn9.asp

>It would be fine with me to leave the '--type TYPE' syntax as an 
>alternative to --unix, --windows, --mixed, but having the --type mixed
>as the only way to get a forward-slash Windows path seemed counter-
>intuitive to me. Also --type dos to me should mean short-name as well.
>So should I put together another patch to do this as well?

Actually, I think that specifying the output via --type makes things a
little more structured.  We can't go back now, though, because users
would complain.  It looks like I should have added a '--type unix' if
I was going to be consistent, though.

I dunno.  I don't feel really strongly about this, though.  If no one
agrees then I don't mind changing it.

>And BTW, is the UNIXy default OK?

IMO, yes.  I'd like more opinions, though.

cgf
