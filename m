Return-Path: <cygwin-patches-return-7839-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5695 invoked by alias); 22 Feb 2013 15:47:46 -0000
Received: (qmail 5671 invoked by uid 22791); 22 Feb 2013 15:47:37 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 22 Feb 2013 15:47:32 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A2B2452030D; Fri, 22 Feb 2013 16:47:29 +0100 (CET)
Date: Fri, 22 Feb 2013 15:47:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] Export <io.h> symbols with underscore
Message-ID: <20130222154729.GI22106@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20130222001848.7049805a@YAAKOV04> <20130222065110.GA7834@ednor.casa.cgf.cx> <20130222080025.GI28458@calimero.vinschen.de> <20130222084951.GJ28458@calimero.vinschen.de> <20130222034047.778e1e12@YAAKOV04> <20130222095128.GF21700@calimero.vinschen.de> <20130222100255.GA32597@calimero.vinschen.de> <20130222143206.GC8104@ednor.casa.cgf.cx> <20130222144448.GD22106@calimero.vinschen.de> <20130222152746.GA3507@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20130222152746.GA3507@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2013-q1/txt/msg00050.txt.bz2

On Feb 22 10:27, Christopher Faylor wrote:
> On Fri, Feb 22, 2013 at 03:44:48PM +0100, Corinna Vinschen wrote:
> >On Feb 22 09:32, Christopher Faylor wrote:
> >> On Fri, Feb 22, 2013 at 11:02:55AM +0100, Corinna Vinschen wrote:
> >> >On Feb 22 10:51, Corinna Vinschen wrote:
> >> >> On Feb 22 03:40, Yaakov wrote:
> >> >> > On Fri, 22 Feb 2013 09:49:51 +0100, Corinna Vinschen wrote:
> >> >> > > > access should go, no doubt about it.
> >> >> > > > 
> >> >> > > > For get_osfhandle and setmode I would prefer maintaining backward
> >> >> > > > compatibility with existing applications.  Both variations, with and
> >> >> > > > without underscore are definitely in use.
> >> >> > > > 
> >> >> > > > What about exporting the underscored variants only, but define the
> >> >> > > > non-underscored ones:
> >> >> > > > 
> >> >> > > >   extern long _get_osfhandle(int);
> >> >> > > >   #define get_osfhandle(i) _get_osfhandle(i)
> >> >> > > > 
> >> >> > > >   extern int _setmode (int __fd, int __mode);
> >> >> > > >   #define setmode(f,m) _setmode((f),(m))
> >> >> > > 
> >> >> > > Just to be clear:  On 32 bit we should keep the exported symbols, too.
> >> >> > > On 64 bit we can drop the non-underscored ones (which just requires
> >> >> > > to rebuild gawk for me) and only keep the defines for backward
> >> >> > > compatibility.
> >> >> > 
> >> >> > Like this?
> >> >> 
> >> >> Almost.  The _setmode needs a tweak, too.  I also think it makes
> >> >> sense to rename the functions inside of syscalls.cc:
> >> >> [...]
> >> >
> >> >I applied this patch to the 64 bit branch for now.
> >> 
> >> I was actually expecting that we'd break the compilation of existing
> >> applications which incorrectly referenced get_osfhandle and setmode (I
> >> have a couple of those).  It's a simple fix if someone recompiles and
> >> it wouldn't be the first time that you'd have to make a source code
> >> change when upreving to a new "OS".  For 32-bit we would need to keep
> >> both in cygwin.din though, of course.
> >
> >I'm trying to keep up with backward compatibility on the source level
> >as far as it makes sense (for a given value of "sense").
> 
> Yeah, but I worry about carrying cruft like this around forever.  I know
> it's a mile pain for the person who copmiles programs but it shouldn't
> be that big a deal to add an underscore.

Alternatively, we We keep exporting the unloved symbols and add an
__attribute__ ((deprecated)) in the header, as we did for
cygwin_conv_to_win32_path and friends.  

> >> But, if you're going to use defines, why not just simplify them as:
> >> 
> >> #define get_osfhandle _get_osfhandle
> >> #define setmode _setmode
> >
> >I can do that, but I thought error messages would be more meaningful
> >when using macros with arguments.  Dunno, I was just trying to do
> >it right.  Shall I still simplify them?
> 
> I don't know.  If you use your method and say, for example setmode(x)
> you'll get an error about a macro lacking arguments.  If you said
> setmode ((char *) foo) you'd get an error about the '_setmode' function.
> If you defined the macro without arguments you'd get a compiler error
> referencing '_setmode' in both cases.  I guess I'd want this to be
> consistent but I don't really care that much.

Me neither.  I can define them just by name, but that depends on the
above decision.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat
