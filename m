Return-Path: <cygwin-patches-return-2381-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 16007 invoked by alias); 10 Jun 2002 15:09:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15991 invoked from network); 10 Jun 2002 15:09:53 -0000
Date: Mon, 10 Jun 2002 08:09:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Reorganizing internal_getlogin()
Message-ID: <20020610151016.GG6201@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20020609231253.008044d0@mail.attbi.com> <20020610035228.GC6201@redhat.com> <20020610111359.R30892@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020610111359.R30892@cygbert.vinschen.de>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00364.txt.bz2

On Mon, Jun 10, 2002 at 11:13:59AM +0200, Corinna Vinschen wrote:
>On Sun, Jun 09, 2002 at 11:52:28PM -0400, Chris Faylor wrote:
>> On Sun, Jun 09, 2002 at 11:12:53PM -0400, Pierre A. Humblet wrote:
>> >2002-06-09  Pierre Humblet <pierre.humblet@ieee.org>
>> >
>> >	* environ.cc (addWinDefEnv): New.
>> >	(inWinDefEnv): New.
>> >	(writeWinDefEnv): New.
>> >	* spawn.cc (spawn_guts): Call functions above to set
>> >	traditional Windows environment variables when copying the
>> >	environment to the cygheap, before CreateProcessAsUser().
>> >	Define sec_attribs and call sec_user_nih() only once.
>> >	* environ.h: Declare inWinDefEnv() and addWinDefEnv(), and 
>> >	define WINDEFENVC.
>> 
>> I don't know about the sexec question.  Anyone know if there are (or
>> were) any actual applications out there which use sexecve?  Isn't this
>> just a cygwin invention?  I wonder if we should just nuke it from cygwin
>> and see if anyone complains.  It would certainly simplify spawn.cc.
>
>AFAICS, there should only be old applications left using sexec,
>perhaps the original SSH.com port from Sergey, years ago.  I'm
>even not sure if it still works with current Cygwin.  login(1)
>was originally ported by using sexec but neither login(1) nor
>any other application in the distro are using any sexecXX call.
>I'd guess it's existance is in limbo.  We *would* obviously 
>break backward compatibility by removing that functionality
>but it's a backward compatibility to applications build at least
>two years ago.

Ok.  I'm in favor of getting rid of sexec in 1.3.11, then.

I'll do that sometime today.

cgf
