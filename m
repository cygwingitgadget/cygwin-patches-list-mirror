Return-Path: <cygwin-patches-return-1753-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24410 invoked by alias); 19 Jan 2002 16:19:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24395 invoked from network); 19 Jan 2002 16:19:10 -0000
Date: Sat, 19 Jan 2002 08:19:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: New addition to cygwin: recvmsg and sendmsg
Message-ID: <20020119171908.S11608@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <911C684A29ACD311921800508B7293BA037D2A87@cnmail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <911C684A29ACD311921800508B7293BA037D2A87@cnmail>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q1/txt/msg00110.txt.bz2

On Sat, Jan 19, 2002 at 12:21:47AM -0500, Mark Bradshaw wrote:
> Changelog:
> 2002-01-19  Mark Bradshaw  <bradshaw@staff.crosswalk.com>
> 
> 	* cygwin.din: added recvmsg and sendmsg
> 	* net.cc: added cygwin_recvmsg and cygwin_sendmsg
> 	* /usr/include/sys/socket.h: added recvmsg and sendmsg

Thanks, Mark!  I applied it with *just* a few changes to the
ChangeLog:

        * cygwin.din: Add recvmsg and sendmsg.
	* net.cc: Add cygwin_recvmsg and cygwin_sendmsg.
	* /usr/include/sys/socket.h: Add recvmsg and sendmsg.

Do you see the differences? Present tense, upper case after the
colon, full stop at the end of a sentence.

And there's something else important.  Adding new functions
to the API requires us to bump CYGWIN_VERSION_API_MINOR in
include/cygwin/version.h.  I did that now but it would be
nice(tm) if you could do that by yourself when you add a
new function to the API next time (e.g strptime :-)).

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
