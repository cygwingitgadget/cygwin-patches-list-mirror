Return-Path: <cygwin-patches-return-3869-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 555 invoked by alias); 21 May 2003 16:24:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 514 invoked from network); 21 May 2003 16:24:51 -0000
Date: Wed, 21 May 2003 16:24:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: Micha Nelissen <mdvpost@hotmail.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: Patch for line draw characters problem & screen scrolling
Message-ID: <20030521162449.GA18620@cygbert.vinschen.de>
Mail-Followup-To: Micha Nelissen <mdvpost@hotmail.com>,
	cygwin-patches@cygwin.com
References: <BAY1-DAV24HHGNZ4mF100020af2@hotmail.com> <20030521154842.GA1865@cygbert.vinschen.de> <BAY1-DAV29JOMyQlmLF00020bf3@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY1-DAV29JOMyQlmLF00020bf3@hotmail.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00096.txt.bz2

On Wed, May 21, 2003 at 06:00:05PM +0200, Micha Nelissen wrote:
> Hi,
> 
> > First of all, this is a big patch which requires an assignment
> > which copies over the copyright ownership to RedHat.
> 
> Ok, but where to send this assignment form?

The address is given on the form (just click the appropriate link):

  Rose Naftaly
  Red Hat, Inc.
  444 Castro Street
  Suite 1200
  Mountain View, California 94041 USA

This will take some time but it's required, sorry.

> > Second, the ChangeLog doesn't adhere to the ChangeLog standards.
> 
> I have taken a look at http://www.gnu.org/prep/standards_42.html. On what
> ground(s) does it not comply?

Well, it should adhere to the other ChangeLog entries in the same file
at least :-)  Just looking into the existing ChangeLog file should give a
clue.  It consists of a specifc set of tabs, colons and other characters
at the right spot.  Just an examples:

Not

* foo.c (bar): blah blah
* foo.c (baz): more blah
* foobar.c (fooy): even more blah

but

	* foo.c (bar): Blah blah.
	(baz): More blah.
	* foobar.c (fooy): Even more blah.

And there's e.g. no need to rationalize the patch in the ChangeLog.
Just write *what* you did, not *why* you did it.  If it's not clear
from the code, add comments there.

It's actually not really hard, just a process to get used to it.
No worries.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
