Return-Path: <cygwin-patches-return-7570-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14743 invoked by alias); 20 Dec 2011 15:34:48 -0000
Received: (qmail 5354 invoked by uid 22791); 20 Dec 2011 15:34:22 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 20 Dec 2011 15:34:07 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id EA0962C01DE; Tue, 20 Dec 2011 16:34:04 +0100 (CET)
Date: Tue, 20 Dec 2011 15:34:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add support for creating native windows symlinks
Message-ID: <20111220153404.GF23547@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAL-4N9uVjoqNTXPQGvsjnT+q=KJx9_QNzT-m8U_K=46+zOyheQ@mail.gmail.com> <20111205101715.GA13067@calimero.vinschen.de> <CAL-4N9sx=asy0r3fcD65=WfvW0VHByv-Hn0CAJgaAFK3C8Vw_Q@mail.gmail.com> <CAL-4N9v8QU-mZfE-4gtpjtybD8A1BYt8QJNGAHOOHv25fkF0Mg@mail.gmail.com> <20111219155948.GA7148@calimero.vinschen.de> <CAL-4N9tALgoad1K+BKH3UoC4_viooeyt9KNHAxm1kwHWw8KcEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL-4N9tALgoad1K+BKH3UoC4_viooeyt9KNHAxm1kwHWw8KcEw@mail.gmail.com>
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
X-SW-Source: 2011-q4/txt/msg00060.txt.bz2

On Dec 19 11:31, Russell Davis wrote:
> > I don't think it's the right approach to let Cygwin create symlinks
> > which are only partially usable in the POSIX environment...
> 
> Huh? I think you're not fully understanding my suggested approach. As
> I pointed out in my previous message, it should be 100%, fully usable
> in the POSIX environment. Again: any path that might be problematic as
> a Win32 path can just be stored as a POSIX path, and would fall into
> the bucket of "works inside cygwin but not outside".

How are you going to check the difference?

Btw., you can write the Win32 and the POSIX path into the reparse point
since the reparse data buffer contains two strings, the so called
SubstituteName and the so called PrintName.  SubstituteName is the
native NT path which is used internally to resolve the path, the
PrintName is used by CMD or Explorer for printing purposes.  If you put
the POSIX path into PrintName, CMD shows the POSIX path and Explorer
shows an empty string as target location.  Of course you can't do that
using the CreateSymbolicLink call.

However, how do you make sure that the file vs directory flag is set
correctly, given that the file or directory doesn't have to exist at the
time the symlink gets created?  Neither CMD nor Explorer handle this
situation gracefully.

How do you handle the fact that remote symlinks only work if certain
settings are made (fsutil)?  And how do you handle the situation that
native symlinks don't work on pre-Vista machines, which also makes them
unsuitable for remote shares?  Some symlinks on a share are created this
way and some symlinks are created that way and depending on the machine
from where you try to access them they are usable or not.

As I said, I experimented a lot with native symlinks in the past and one
way or the other they don't quite work as expected.  I'm not overly keen
to support writing them.  The hassle with the required
SE_CREATE_SYMBOLIC_LINK_NAME privilege, the extra hassle that they don't
work on remote drives without explicitely enabling them via fsutil, the
fact that remote pre-Vista machines don't get them transparently
translated at all, the nonsense with the file/directory flag...  I'm
quite content to read them in Cygwin on a local drive but otherwise
leave them alone.  for those who really want them there are tools out
there to create them, but in these cases the tool provider has to take
the support burden.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
