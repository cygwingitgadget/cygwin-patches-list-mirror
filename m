Return-Path: <cygwin-patches-return-2724-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 22861 invoked by alias); 26 Jul 2002 00:31:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22846 invoked from network); 26 Jul 2002 00:31:43 -0000
Subject: Re: qt patch for winnt.h
From: Robert Collins <robert.collins@syncretize.net>
To: Chris January <chris@atomice.net>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <00e701c23426$c1f1dc10$0100a8c0@atomice.net>
References: <015301c23413$8551d1b0$cd6007d5@BRAMSCHE> 
	<00e701c23426$c1f1dc10$0100a8c0@atomice.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 25 Jul 2002 17:31:00 -0000
Message-Id: <1027643501.18923.16.camel@lifelesswks>
Mime-Version: 1.0
X-SW-Source: 2002-q3/txt/msg00172.txt.bz2

On Fri, 2002-07-26 at 08:00, Chris January wrote:
> > > >Perhaps you would prefer this better.  I changed the ifdef to be


> I would suggest adding the patch for winnt.h to the source distribution for
> qt and let the user apply it themselves if they wish to compile KDE on their
> systems. If necessary we can add a configure check to ensure the patch has
> been applied (and remind the user to do it if it hasn't been). This step
> should be documented in the appropriate README, of course. There is
> currently a similar check in place to ensure the user is using  a compatible
> version of libtool.

I think I've seen most of the thread now... and I think that this
approach will cause headaches for the QT guys, if sizeof (NT HANDLE) !=
size(uint) - which is the case IIRC on itanium.
 
I understand the problem you have, and would like to suggest a different
approach to solving it.

Create a compatability source file that contains *all* the native WIN32
calls (and as much of the surrounding logic as makes sense). Expose
those calls with API's that match the u int HANDLE type you are passing
around. Inside that one source file and it's header you can use
something like:

typedef uint QTHANDLE;
extern QTHANDLE myfunc1 (....);

and gcc will consider the function to be the same as
extern HANDLE myfunc1(...); 
in a 'pure' source file.

Just a thought.

Rob
