Return-Path: <cygwin-patches-return-2931-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18566 invoked by alias); 4 Sep 2002 09:01:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18552 invoked from network); 4 Sep 2002 09:01:08 -0000
Message-ID: <20020904090107.50748.qmail@web14505.mail.yahoo.com>
Date: Wed, 04 Sep 2002 02:01:00 -0000
From: =?iso-8859-1?q?Danny=20Smith?= <danny_r_smith_2001@yahoo.co.nz>
Subject: Fwd: Re: mingw - free_osfhnd
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SW-Source: 2002-q3/txt/msg00379.txt.bz2

Forgot to include cygwin-patches in reply to Rob

 --- Danny Smith <danny_r_smith_2001@yahoo.co.nz> wrote: > Date: Wed, 4 Sep
2002 18:56:29 +1000 (EST)
> From: Danny Smith <danny_r_smith_2001@yahoo.co.nz>
> Subject: Re: mingw - free_osfhnd
> To: Robert Collins <rbcollins@cygwin.com>
> 
>  --- Robert Collins <rbcollins@cygwin.com> wrote: > On Wed, 2002-09-04 at
> 13:29, Danny Smith wrote:
> > >  --- Robert Collins <rbcollins@cygwin.com> wrote: > Changelog:
> > > > 
> > > > 2002-09-04  Robert Collins  <robertc@cygwin.com>
> > > > 
> > > > 	* msvcrt.def: Export _free_osfhnd.
> > > > 
> > > > Is this ok Earnie/Danny?
> > > 
> > > I can't see this in my msvcrt.dll.  Where do you see it?
> > > Danny
> > 
> > Its one of the undocumented internals... along with _get_osfhnd and
> > _set_osfhnd. (I think that _get_osfhnd is there already).
>  
> No, only the *_osfhandle functions that are documented. 
> 
> > 
> > The NT Native port of squid, build with Visual C uses this when linking
> > to MSVCRT. As a reference in 1999 XEmacs started using this call, but
> > they defined it locally rather than patching mingw from what I can tell.
> > 
> > Rob
> > 
> 
> Okay, but do you see it in mscvrt.dll?  I can't see it in the export table
> anywhere.  I would accept that the internals may be available from the static
> libc but not from dll (ms doesn't do the --export-all, for good reason, I
> suspect)
> 
> Danny
> 
>  
> 
> 
> 
> http://mobile.yahoo.com.au - Yahoo! Messenger for SMS
> - Now send & receive IMs on your mobile via SMS
>  

http://mobile.yahoo.com.au - Yahoo! Messenger for SMS
- Now send & receive IMs on your mobile via SMS
