Return-Path: <cygwin-patches-return-4012-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6943 invoked by alias); 14 Jul 2003 19:20:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6921 invoked from network); 14 Jul 2003 19:20:17 -0000
Message-ID: <3F1302A9.85728D65@ieee.org>
Date: Mon, 14 Jul 2003 19:20:00 -0000
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: Problems on accessing Windows network resources
References: <3.0.5.32.20030711200253.00807190@mail.attbi.com> <20030714170539.GE12368@cygbert.vinschen.de> <3F12E948.82BBB05C@ieee.org> <20030714180316.GI12368@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q3/txt/msg00028.txt.bz2

Corinna Vinschen wrote:
> 
> On Mon, Jul 14, 2003 at 01:32:56PM -0400, Pierre A. Humblet wrote:
> > After researching the issue, all cygwin routines I could find (not
> > only those ntsec related) initialize their handles to NULL, except
> > subauth() and create_token(). Those exceptions make sense because
> > those two must return INVALID_HANDLE_VALUE on error.
> >
> > The patch itself avoids initializing any handle (avoiding ambiguity),
> > except the usual automatic initialization to 0 of the cygheap stuff.
> >
> > Do you want my patch anyway (reverting what you have just applied),
> > or do we leave things as they are?
> 
> INVALID_HANDLE_VALUE is also used to initialize local variables.
> I'd like to keep that value if you don't mind.

Turns out you are doing just the opposite of what I would have done, 
but it's arbitrary anyway.

There is one slight problem, in seteuid32
/* Set process def dacl to allow access to impersonated token */ 
     if (cygheap->user.current_token != new_token) 
If the current_token is INVALID_.. (i.e. no impersonation), and there
is no change, new_token will be ptok (temporarily). Thus the test
will succeed when it should fail.

One way out is to:
- not initialize the local variable new_token
- set new_token to INVALID_.. if verifying ptok succeeds
- add a final else clause to the verify chain
     else
       new_token = NULL;
- call create_token (and? subauth) if new_token == NULL

That also allows to remove the test in
cygheap->user.current_token = new_token == ptok ? INVALID_HANDLE_VALUE 
                                                     : new_token; 

Now that I have done it anyway, I will send you a cleaned up version
of verify_token (unrelated to token initialization).

Pierre
