Return-Path: <cygwin-patches-return-3315-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28240 invoked by alias); 13 Dec 2002 15:23:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28208 invoked from network); 13 Dec 2002 15:23:17 -0000
Date: Fri, 13 Dec 2002 07:23:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Small security patches
Message-ID: <20021213152437.GA29208@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3DF76981.86674258@ieee.org> <20021211192211.GD29798@redhat.com> <3DF7A670.E7BA1862@ieee.org> <20021211210349.GB31049@redhat.com> <3DF8BA7A.37C82FE5@ieee.org> <20021213133801.A17831@cygbert.vinschen.de> <3DF9F40E.8DE0673B@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF9F40E.8DE0673B@ieee.org>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00266.txt.bz2

On Fri, Dec 13, 2002 at 09:51:58AM -0500, Pierre A. Humblet wrote:
>Corinna Vinschen wrote:
>> 
>> On Thu, Dec 12, 2002 at 11:34:02AM -0500, Pierre A. Humblet wrote:
>> > Christopher Faylor wrote:
>> > >
>> > > Actually, if you can get away without using a
>> > > constructor that would be best.  Constructors are a noticeable part of
>> > > cygwin's startup cost.
>
>> What about this idea:
>> 
>> Add a static method init() called from .  Init() checks if it has been
>> called already before and returns immendiately if so.  Otherwise it
>> initializes the external objects.
>> 
>> Shouldn't that be sufficient?
>
>That looks great. Can that be generalized? There must be other
>modules inside Cygwin that also need to initialize constant structures.
>Could all of these initializers be called from some central place, if needed,
>rather than having everybody maintain a separate "isinitialized" variable and
>add lines in the middle of dll_crt0_1 ()?

That's what dll_crt0_1 is for.  You're going to have to call the functions
from someplace and dll_crt0_1 is designed for that.

To answer your question, yes, you can tell if you've been either forked
or execed.  Rather than maintain an initialized variable, you can always
check that.

cgf
