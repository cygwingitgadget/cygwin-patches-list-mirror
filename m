Return-Path: <cygwin-patches-return-4189-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24806 invoked by alias); 9 Sep 2003 14:01:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24783 invoked from network); 9 Sep 2003 14:01:48 -0000
Message-ID: <3F5DDD4A.BDB5F412@phumblet.no-ip.org>
Date: Tue, 09 Sep 2003 14:01:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: Pierre.Humblet@ieee.org
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Fixing a security hole in mount table.
References: <3.0.5.32.20030908204606.00816d10@incoming.verizon.net> <3.0.5.32.20030908204606.00816d10@incoming.verizon.net> <3.0.5.32.20030909001211.00825720@incoming.verizon.net> <20030909052830.GA25647@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q3/txt/msg00205.txt.bz2

Christopher Faylor wrote:
> 
> On Tue, Sep 09, 2003 at 12:12:11AM -0400, Pierre A. Humblet wrote:
> >At 09:11 PM 9/8/2003 -0400, you wrote:
> >>On Mon, Sep 08, 2003 at 08:46:06PM -0400, Pierre A. Humblet wrote:
> >>>This is the first in a series of patches fixing security holes
> >>>associated with the file mappings in the core of Cygwin.
> >>>I hope the explanations below are clear!
> >>
> >>Yes they are, thanks.  I can't comment on the security stuff but
> >>everything else looks good to me.  I'll let Corinna have the final say
> >>on this.
> >>
> >>I wonder if it is time to bite the bullet and get rid of user-mode
> >>mounts entirely.  Or maybe disallow them in suid'ed sessions?  They are
> >>always going to be a security hole AFAICT.
> >
> >Yep, the same thought has crossed my mind.  However I now believe that
> >with the patch the user mounts do not pose a security issue.
> 
> I can't see how a feature which allows any user to redefine what /etc or
> / is could not be a security issue.

We live in an open source environment and there is nothing to prevent a user
from modifying all her programs to use a different / or /etc, or to use a 
peculiar way to access internal Cygwin structures (if accessible).
There only is a security issue when a user can change the behavior of a 
program running as another user. Doing that through the mount table (system 
or user) should now be impossible (assuming Windows ntsec is secure).

It would seem reasonable to prevent user mounts from preempting system mounts.
However when I started thinking about it I realized I was unable to define
what the previous sentence really meant. For example if / is a system mount,
we might not want a user mount to redefine it. But it should be OK to have
a user mount for subdirectories of /, e.g. for /home/pierre.
Similarly we might not want to allow a user mount for /etc. However if we
allow to remount /home/pierre, why would be disallow a user mount for the
file /etc/passwd ?

Pierre
