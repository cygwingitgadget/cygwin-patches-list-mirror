Return-Path: <cygwin-patches-return-4408-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 444 invoked by alias); 17 Nov 2003 11:21:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 434 invoked from network); 17 Nov 2003 11:21:28 -0000
Date: Mon, 17 Nov 2003 11:21:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: thunking, the next step
Message-ID: <20031117112126.GE18706@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3FB4C443.2040301@cygwin.com> <20031114155716.GA16485@redhat.com> <1068832363.1109.101.camel@localhost> <20031114191010.GA22870@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031114191010.GA22870@redhat.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00127.txt.bz2

On Fri, Nov 14, 2003 at 02:10:10PM -0500, Christopher Faylor wrote:
> On Sat, Nov 15, 2003 at 04:52:43AM +1100, Robert Collins wrote:
> >On Sat, 2003-11-15 at 02:57, Christopher Faylor wrote:
> >> On Fri, Nov 14, 2003 at 11:02:11PM +1100, Robert Collins wrote:
> >> >Ok, I've now integrated and generalised Ron's unicode support mini-patch.
> >> >
> >> >So, here tis a version that, well the changelog explains the overview, 
> >> >and io.h the detail.
> >> >
> >> >Overhead wise, this is reasonably low:
> >> >1 strlen() per IO call minimum.
> >> >1 unicode conversion, only if needed.
> >> 
> >> And a couple of tests for "do we do unicode" for every call.
> >
> >Which are all inline aren't they? I guess I don't see the overhead as
> >significant compared to the strlen generation.
> 
> I'd rather just make the decision at initialization time if we can.
> Possibly we could extend the function loader to either call FooW or
> FooA as appropriate when Foo is specified.

Given that we know on which system we run, we can use the wincap
information to load the correct function through the autoloader
functionality.  This would require a decision only on the first time
a function is called. 

There's just a problem with the header files.  Let's say, all the other
Cygwin code uses the non-explicit name (e. g. "CreateFile", not
"CreateFileA" or "CreateFileW").  The decision which function actually
to use is done in the autoload part.  The problem is this:  The Win32
header files decide by themselves, which of the functions to use:

  #ifdef UNICODE
  #define CreateFile CreateFileW
  #else
  #define CreateFile CreateFileA
  #endif

To workaround this, we must care for undefining all affected function
names before using them, probably best in an autoload.h header or so.

Also we would need a fairly big change to path_conv.  It would have to
create the POSIX path in ascii on 9x and in wide char on NT.  If the
path name creation is done in wide char directly, we neither need a
strlen, nor an explicit conversion from ascii to wide char.

I think this method is preferable over the IOThunkState technique since
it will have more or less no speed impact.  It also has the advantage,
that the Cygwin code doesn't have to use all new function calls like
"create_file" instead of using the "real" Win32 function calls directly.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
