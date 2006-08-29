Return-Path: <cygwin-patches-return-5972-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29514 invoked by alias); 29 Aug 2006 17:01:41 -0000
Received: (qmail 29483 invoked by uid 22791); 29 Aug 2006 17:01:40 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-229.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.229)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 29 Aug 2006 17:01:37 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 8004613C042; Tue, 29 Aug 2006 13:01:35 -0400 (EDT)
Date: Tue, 29 Aug 2006 17:01:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@sourceware.org>
To: cygwin-patches@cygwin.com, gdb-patches@sourceware.org, 	mingw-patches@lists.sourceforge.net, binutils@sourceware.org, 	gcc-patches@gcc.gnu.org
Subject: Re: [RFC] Simplify MinGW canadian crosses
Message-ID: <20060829170135.GC17552@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com, gdb-patches@sourceware.org, 	mingw-patches@lists.sourceforge.net, binutils@sourceware.org, 	gcc-patches@gcc.gnu.org
References: <20060829114107.GA17951@calimero.vinschen.de> <20060829124525.GA13245@nevyn.them.org> <200608291459.k7TExRDT026512@greed.delorie.com> <20060829150948.GA18308@nevyn.them.org> <20060829153540.GA20893@calimero.vinschen.de> <20060829154718.GB17552@trixie.casa.cgf.cx> <20060829160406.GB21260@calimero.vinschen.de> <20060829160923.GB20830@nevyn.them.org> <20060829164906.GC21260@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060829164906.GC21260@calimero.vinschen.de>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00067.txt.bz2

On Tue, Aug 29, 2006 at 06:49:06PM +0200, Corinna Vinschen wrote:
>On Aug 29 12:09, Daniel Jacobowitz wrote:
>> On Tue, Aug 29, 2006 at 06:04:06PM +0200, Corinna Vinschen wrote:
>> > On Aug 29 11:47, Christopher Faylor wrote:
>> > > Btw, I agree with Daniel's suggestion of using
>> > > ../config/no-executables.m4 if that's possible.
>> > 
>> > I did that first, but the argument against this is that the
>> > mingw-runtime package, does not contain a top-level config directory.
>> > The source tree is supposed to be built stand-alone.  Therefore it's
>> > required to have a stand-alone aclocal.m4 file.
>> > 
>> > [time passes]
>> > 
>> > Or do you mean I should just add an include(../config/no-executables.m4)
>> > to winsup/acinclude.m4 and create the aclocal.m4 files from there?
>> 
>> If you do that it'll just emit a sinclude into aclocal.m4 anyway, won't
>> it?
>
>Hm, yes, I guess so.
>
>But the problem is clear I hope.  If we refer to ../config/foo, the
>mingw/aclocal.m4 file isn't self-sufficient anymore.  That's actually
>the only reason I didn't refer to ../config/no-executables.m4, but
>copied it instead.

As long as there's a valid aclocal.m4 in the mingw directory, I wouldn't
think it would matter but that's a decision for the mingw folks, I think.

The mingw-patches and cygwin-patches mailing lists are in the To: above.
I apologize for posting to a closed list but I thought that this was also
something that needed to be seen there.

Daniel, FWIW, I added you to the allow list in cygwin-patches so your
email shouldn't bounce there anymore.

cgf
