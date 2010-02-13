Return-Path: <cygwin-patches-return-6957-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25862 invoked by alias); 13 Feb 2010 23:53:44 -0000
Received: (qmail 25844 invoked by uid 22791); 13 Feb 2010 23:53:43 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out2.smtp.messagingengine.com (HELO out2.smtp.messagingengine.com) (66.111.4.26)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 13 Feb 2010 23:53:34 +0000
Received: from compute1.internal (compute1 [10.202.2.41]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id BD968DFF45 	for <cygwin-patches@cygwin.com>; Sat, 13 Feb 2010 18:53:32 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])   by compute1.internal (MEProxy); Sat, 13 Feb 2010 18:53:32 -0500
Received: from [192.168.1.3] (user-0c6sbd2.cable.mindspring.com [24.110.45.162]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id 4A03A4AF786; 	Sat, 13 Feb 2010 18:53:32 -0500 (EST)
Message-ID: <4B773B70.8040208@cwilson.fastmail.fm>
Date: Sat, 13 Feb 2010 23:53:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Add xdr support
References: <4B764A1F.6060003@cwilson.fastmail.fm>  <20100213113509.GJ5683@calimero.vinschen.de>  <4B76C334.8080101@cwilson.fastmail.fm> <20100213210122.GA20649@ednor.casa.cgf.cx>
In-Reply-To: <20100213210122.GA20649@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00073.txt.bz2

Christopher Faylor wrote:
> On Sat, Feb 13, 2010 at 10:20:20AM -0500, Charles Wilson wrote:
>> Corinna Vinschen wrote:
>>> On Feb 13 01:43, Charles Wilson wrote:
>>>> The attached patch(es) add XDR support to cygwin
>>> Cool.
> 
> I didn't get Corinna's response in email and it isn't in the archive.
> I assume that was unintentional?

I didn't notice that her original response was private, until after I'd
already sent the reply.  I'm so used to having to mess with the To/From
fields when I deal with the cygwin lists -- since I use gmane for
reading -- that it has become automatic for me.  I must have done my
rote set-the-To-field-to-cygwin-patches thing 'in my sleep'.

I don't reckon it was a problem tho; I imagine Corinna actually intended
that message to be public. There's certainly nothing private about
critiquing patch submissions.

> The benefit of putting this in init.cc, or something called from
> init.cc, is that it will work better if cygwin is dynamically loaded.  I
> don't really care too much if that case works though.  If that was the
> intent then the function should be called from dll_crt0_0 rather than
> init.cc.
> 
> However, I probably agree with Corinna that it should go in dll_crt0_1.

I'm not concerned about that either. So, I can revise and put it into
dll_crt0_N (which: _0? _1?) -- but the disposition of the actual core
code: cygwin, newlib, or external lib -- needs to be resolved first.

> I have to wonder if these really belong in newlib.  I have an anti-newlib
> bias (not to be confused with the ficitious other biases that I've been
> accused of) so maybe it's that talking but it seems like you've gone to
> some effort to ensure that things work for the non-cygwin case.  Would
> it have been easier if you just imported everything into Cygwin?

Not /that/ much easier. I may have been able to avoid the whole
EXFUN()/DEFUN() thing, but that was rather mindless.  It's just a bunch
of C code that was already pretty thoroughly debugged and operational on
cygwin.

You may have missed the discussion -- you were on vacation at the time
-- but I raised this possibility as an aside last fall.  It was
definitely overkill for the problem under consideration at that time:

http://cygwin.com/ml/cygwin-developers/2009-10/msg00242.html
Re: Avoid collisions between parallel installations of Cygwin

[as part of the discussion on how to record "resource" information in
the DLL, or a separate file, or in the registry, controlling whether to
activate the "allow multiple cygwin1.dll" behavior]:
> I hesitate to suggest Yet Another Addition before 1.7.1 -- and cgf is
> gonna kill me when he gets back and reads this, whether we take action
> on it or not -- but there is a solution.  Cygwin will never directly
> support RPC, but there's no reason it can't implement the XDR primitives
> -- especially now that SUN has changed the license from (open but
> non-copyleft and arguably GPL-incompatible) to BSD.

IIRC at that time Corinna suggested that newlib was the appropriate
place for this, if I wanted to contribute it post-1.7.1. I asked how to
go about adding something to newlib that might not work for all targets,
and she said:
   > Sure.  Use a define to enable XDR in sys/config.h, e.g.
   >   #ifdef __CYGWIN__
   >   [...]
   >   #define _ENABLE_XDR_ 1
   >   #endif
Unfortunately, my google-foo is not strong enough to find that message
in the cygwin archives, and it doesn't appear anywhere in my own email
archives. The snippet above was taken from my porting notes file...  I
ultimately ended up using a different mechanism, one used elsewhere in
newlib, for enabling/disabling the XDR component, though.


Anyway, I can imagine that XDR support would be useful for other newlib
targets that might want to support data interchange. It would at least
simplify /some/ of the effort in writing RPC or NFS clients for those
platforms. Support for XDR encoding/decoding is part of glibc, after all...

Now, I didn't actually TEST this code on (e.g. RTEMS) targets. I figure
if the code is accepted by newlib, then other interested parties can
later activate it when they put in whatever minimal effort may be
required to get it to compile for them. (It's pretty dirt-simple C code;
build system integration and header file prereqs are actually the hard
part.  They might need to #ifdef out support for e.g. long longs or
doubles; maybe add some intelligence to optionally exclude those parts
of the XDR code that require stdio to work...but this would get them 90%
of the way there.  As submitted though, XDR is completely "turned off"
for all but $host cygwin).

> Also, follow-up question: Should this go into a different library
> entirely?  Is it time to think about not just making cygwin1.dll the
> monolithic one-stop-for-all-of-your-posix-api shared library?

Well...if it's in glibc or the *nix/bsd kernels, it probably belongs in
the cygwin DLL and not someplace else.  Packages which depend on the
functionality are unlikely to want to add -lfoo for cygwin, when they
can just use the "automatic" support provided by the system runtime
library on other platforms.

OTOH, we had -lminires for years, and adding "-lxdr" to LIBS is not THAT
hard for a cygwin maintainer of some client to do.  "bsd-xdr" is ready
to be ITP'ed as it is, if we'd rather go that way. (There's also
"PortableXDR" http://people.redhat.com/~rjones/portablexdr/, but that's
a from-scratch reimplementation under the LGPL and the whole reason to
use a non-copyleft source was so that it could go into newlib and/or
cygwin.  Unless Red Hat has some ownership over rjones' code?)

My *original* thought -- again, obvious overkill -- was that cygwin
itself could use XDR to store binary resource data.  Obviously (a)
that's not possible if the XDR support is in a separate DLL, and (b) I
don't think we have any intention of doing any such thing, so that is a
non-issue when considering where this XDR support should be located.


Either way, however, the new xdr functionality in cygwin1.dll or in
-lxdr may conflict with the (orphaned) sunrpc package, and may also
interfere with the (orphaned) nfs-server package.  I just realized this,
but it's something to consider. Personally, I'm not too fussed about
"breaking" orphaned packages; and they probably wouldn't "break" -- the
newer package's .h files in /usr/include/rpc/* will conflict but that's
about it.

--
Chuck
