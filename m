Return-Path: <cygwin-patches-return-2643-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 1296 invoked by alias); 12 Jul 2002 21:58:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1282 invoked from network); 12 Jul 2002 21:58:39 -0000
Message-ID: <07d501c229ef$940ba970$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <002901c229e9$3ec34aa0$6132bc3e@BABEL> <20020712213532.GB12262@redhat.com>
Subject: Re: cygwin.din
Date: Fri, 12 Jul 2002 14:58:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q3/txt/msg00091.txt.bz2

"Christopher Faylor" <cgf@redhat.com> wrote:
> >iii) How should I go about adding the new SysV IPC entry
points?
> >Rob added some as `shmat' etc. (i.e. just one entry, no
> >underscore) but should these instead follow the `read' pattern
> >above (i.e. as two entries, one with a leading underscore)?
>
> No underscore for these.  The underscores are to be
> MSVC compliant.  I think that MSVC added the underscore
> versions to be POSIX compliant or something.
> I wish cygwin had never exported them.

Thanks Chris, this means that my simple-minded following of Rob's
example was correct then.

> I went through a while ago and got rid of the newlib
> wrappers that just have write() call _write() since
> I didn't understand the point of having a wrapper
> doing something that the linker could do for
> you automatically.  The above typos are fallout from that.

BTW your changelog entry for the typo-correction has a typo in it
:-)  There's probably a law about how many times it takes to get a
change right: small changes and typos seem to be up in the double
figures some days.

// Conrad


