Return-Path: <cygwin-patches-return-2948-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 12987 invoked by alias); 7 Sep 2002 04:27:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12973 invoked from network); 7 Sep 2002 04:27:25 -0000
Date: Fri, 06 Sep 2002 21:27:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Cc: mingw-users@lists.sourceforge.net
Subject: _WIN32_WINNT redux
Message-ID: <20020907042715.GA29247@redhat.com>
Reply-To: cygwin-patches@cygwin.com,
	mingw-users@lists.sourceforge.net
Mail-Followup-To: cygwin-patches@cygwin.com,
	mingw-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-SW-Source: 2002-q3/txt/msg00396.txt.bz2

Before I actually said "I was wrong not to protect the definition of
GetConsoleHandle with a _WIN32_WINNT ifdef" I wanted to actually check
for myself how the Platform SDK does it.

Since it has been several years since I downloaded the Platform SDK,
I had to download it today, which due to its size, and other actual
revenue-producing activities on my part, took most of the day.

On finally checking I did find that this declaration should have been
protected by this guard and I was, indeed, wrong to check it in without
it.

I did find one disturbing thing however.  The declaration for
GetConsoleProcessList is surrounded by a

#ifdef (_WIN32_WINNT >= 0x0501)
.
.
.
#endif

but guess what _WIN32_WINNT is set to?

AFAICT, it's set to 0x0500.

So, even in the Microsoft case, they are not setting the define to the
latest version.  This invalidates my adopted position that w32api should
"emulate Microsoft" by setting this value to the highest possible legal
value.  It appears that even Microsoft doesn't do that.

WINVER, OTOH, is set to 0x0501 in one header and is set to 0x0500 in
most others.

To me, that sounds like a confusing mess, but maybe there is some rhyme
and reason to it that is not immediately obvious.

Regardless, I retract my position.  I think w32api should just try to be
reasonable and consistent and not worry about how Microsoft does things.

cgf
