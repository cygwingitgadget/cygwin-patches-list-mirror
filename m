Return-Path: <cygwin-patches-return-3426-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24810 invoked by alias); 20 Jan 2003 02:38:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24754 invoked from network); 20 Jan 2003 02:38:46 -0000
Date: Mon, 20 Jan 2003 02:38:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: etc_changed, passwd & group
Message-ID: <20030120024000.GA452@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030117233612.007ed390@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030117233612.007ed390@mail.attbi.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00075.txt.bz2

Ok.  I took another stab at this, cleaning up some more stuff and moving
(almost) everything into the pwdgrp class.  Hardly anything is marked
NO_COPY now.

I moved etc out of uinfo since, as I mentioned, I plan on using it for
more than just passwd/group stuff someday.  I renamed sawchange to
change_possible and made change_possible a tri-state where -1 means
definitely changed.

I think that I worked around the potential for a race by explicitly testing
any registered files prior to checking if the directory had changed.

And, I explicitly closed the file even in the error condition.

For the "Novell case", I explicitly check the creation time of the file
every time.  It may be slower but at least it makes cygwin behavior consistent
regardless of whether the FS.

I also a debug_printf showing how many lines were read in in pwdgrp::load
(I made all of the functions in pwdgrp into non-inline, hope Corinna doesn't
mind but I got tired of watching six files recompile every time I made a
change).

I've got some more checks to run and then I'll checkin the current
sources and make YA snapshot -- the first to be deployed on the new
sources.redhat.com.

Once again, these are not trivial changes, but I think they are zeroing in
on something.  I am still not sure if the handle concept for the etc class
makes sense.  I may end up just going with a linked list of etc elements
eventually.

Thanks,
cgf

On Fri, Jan 17, 2003 at 11:36:12PM -0500, Pierre A. Humblet wrote:
>I like your code, just made a few changes. The explanations below
>are detailed and longer that the changes!
>
>In load(), CloseFile wasn't called on read error, and it was called
>before GetFileTime. 
