Return-Path: <cygwin-patches-return-5395-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19165 invoked by alias); 29 Mar 2005 23:34:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18690 invoked from network); 29 Mar 2005 23:33:51 -0000
Received: from unknown (HELO CLEMSON.EDU) (130.127.28.87)
  by sourceware.org with SMTP; 29 Mar 2005 23:33:51 -0000
Received: from [130.127.121.232] (130-127-121-232.generic.clemson.edu [130.127.121.232])
	(authenticated bits=0)
	by CLEMSON.EDU (8.13.1/8.13.1) with ESMTP id j2TNXhcg019159
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <cygwin-patches@cygwin.com>; Tue, 29 Mar 2005 18:33:44 -0500 (EST)
Message-ID: <4249E5D0.1000201@gawab.com>
Date: Tue, 29 Mar 2005 23:34:00 -0000
From: Nicholas Wourms <nwourms@gawab.com>
Reply-To: nwourms@gawab.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 MultiZilla/1.7.0.2b (ax) Mnenhy/0.7.2.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: "decorate" gcc extensions with __extension__
References: <20050327065657.21624.qmail@gawab.com> <20050329104322.GB28534@cygbert.vinschen.de> <4249A3F0.6020007@gawab.com> <20050329203032.GB32369@trixie.casa.cgf.cx>
In-Reply-To: <20050329203032.GB32369@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Level: x
X-SW-Source: 2005-q1/txt/msg00098.txt.bz2

Christopher Faylor wrote:
> On Tue, Mar 29, 2005 at 01:52:32PM -0500, Nicholas Wourms wrote:
>
> You have correctly surmised that both Corinna and I understand what
> pedantic mode is.  You have to take that thought a step further,
> however, and realize that the fact that there is no -pedantic in CFLAGS
> is because we both want to use the full expressive power of gcc without
> worrying if we are complying with ISO C or ISO C++.  This is a conscious
> choice, not an oversight.

I understand that, not many projects do compile at -pedantic by default.
However, you are assuming I am asking you to change huge amounts of code to
conform to ISO standards, which is not what I'm saying.  While I did make some
suggestions regarding variable sized arrays, that was about the limit of the
iso-correctness on my part.  I am not suggesting, in any way, that -pedantic be
added to the default CFLAGS.  And any other changes are going to be trivial,
like nixing a trailing comma in the last member of an enum.

> I thought Corinna's intent was clear in that sentence.  Apparently you
> didn't.
>
> What she was saying is, for this to be done right, both of us would have
> to be rigorous in the future about making sure that we add decorate
> every extension we use, or, worse, avoid using gcc extensions which
> we've come to rely on.  That would be annoying.

I hear you loud and clear.  I am not suggesting you stop using gcc extensions,
nor would I.  It is true that I made a minor off-the-cuff suggestion regarding
variable sized arrays, but it was intended to be an opinion.

As for the "done right" part, I would point to the other __attribute__ tags
which are used to explicitly mark intentions to the compiler (e.g. unused &&
noreturn).  Looking at the ChangeLog, many of these were added long after the
"offending" initial code was added, mostly likely during a code cleanliness
sweep.  Of course there is no *requirement* for the tags, as code will compile
just fine without them.  The point, however, of using them is to separate the
true-positive warnings from the false-positive warnings.  My intention is no
different.  So why should adding __extension__ be any different?  Just add when
it is noticed/needed, like the other __attribute__ tags are.

> However, if I am correctly interpreting your intent, it sounds like you
> are saying that no one but you would have to worry about sprinkling
> __extension__'s throughout the code and that we could just write code as
> we always do.

Again, I'm not suggesting I be the "point man" on this.  Like other
__attribute__ tags, they can be added as needed/noticed.  It's rather trivial
and I don't see the implied expenditure of labor involved.  You can add them or
not, it won't change the way the code is compiled.  Just think of it like
Rusty's Janitorial patches on LKML.

> If that is the case, then I don't see how it matters if
> we check in your code or not.  You'll constantly be updating things to
> match the latest checkins one way or the other.

Constantly?  I'm afraid I would disagree.  As was stated before, my changes
touch a very small portion of code.  While Cygwin development is lively, it
doesn't come close to most other projects out there.  Frankly, I find the pace
here rather laid-back, which is quite fine IMHO.

> However, if your patches are not going to be checked in,

Well, I had hoped to further discuss this...

> then you don't have to worry about packaging up your changes for cygwin-patches, > which is less work for you.

I know that, I'm not sending patches that I don't want committed.

> Btw, the use of a ?: c is a conscious decision.

Maybe I'm just old fashion and do not like "a ? : c", but I don't understand
why you use it, other than saving a few keystrokes.  Look, aside from the fact
it keeps -pedantic from producing an error, explicitly expanding to "a ? a : c"
makes the code easier to read and the intent more clear.  Just like you could
write:

if (a) b; else c;

but...

if (a)
  b;
else
  c;

is more readable.  Wouldn't you agree?  I'm not trying to tell you what to do,
I just think it would be better IMHO.

Look, I understand that you and Corinna see my changes as making extra work for
you.  That isn't my intention and I've tried very hard to make my footprint
minimal.

Cheers,
Nicholas
