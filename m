Return-Path: <cygwin-patches-return-4410-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14100 invoked by alias); 17 Nov 2003 12:02:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14090 invoked from network); 17 Nov 2003 12:02:30 -0000
Date: Mon, 17 Nov 2003 12:02:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: thunking, the next step
Message-ID: <20031117120229.GH18706@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3FB4C443.2040301@cygwin.com> <20031114155716.GA16485@redhat.com> <1068832363.1109.101.camel@localhost> <20031114191010.GA22870@redhat.com> <20031117112126.GE18706@cygbert.vinschen.de> <1069068688.2287.219.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1069068688.2287.219.camel@localhost>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00129.txt.bz2

On Mon, Nov 17, 2003 at 10:31:29PM +1100, Robert Collins wrote:
> On Mon, 2003-11-17 at 22:21, Corinna Vinschen wrote:
> > This would require a decision only on the first time
> > a function is called. 
> 
> There's more to it than that. you MUST NOT hand the A series call longer
> paths than MAX_PATH, they /really/ don't like it.

That's easily straightened out in path_conv.

>  And, structures like
> the FindNext* details change in definition when UNICODE is defined. I
> was trying to avoid all that complexity, which is significant, by
> staying in a thunk approach.

Yep, I agree, that's an extra problem.  But it doesn't invalidate the
general idea of putting the work into autoload and path_conv.  The
FindFile example might be something which justifies the use of wrapper
functions for these very cases.

> I decided against redefining the 'real' calls because I figured some
> areas may want to use the 'real' calls directly, and only the
> auto-adjusting parts of cygwin should have the ansi/wide dichotomy.

I don't know if I understand you right.  I was only talking about
calls which are affecting the file system.  Other calls like
CreateSemaphore or what not should still work as before.  The autoload
part would define some new LoadDLLfuncBLURB which is used only for
the affected functions.  I (and I assume cgf) was not talking about
using that approach for all functions with an ascii and a wide char
implementation.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
